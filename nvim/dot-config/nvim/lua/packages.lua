local M = {}

-- Package registry: maps plugin names to their configurations
M.registry = {}

-- Track loaded plugins
M.loaded = {}

-- Track pending plugins (added but not yet loaded)
M.pending = {}

-- Default error handling strategies
local ERROR_STRATEGIES = {
	["silent"] = function(plugin, err)
		-- Do nothing, silently fail
	end,
	["warn"] = function(plugin, err)
		vim.notify("Package " .. tostring(plugin) .. " failed to load: " .. tostring(err), vim.log.levels.WARN)
	end,
	["error"] = function(plugin, err)
		vim.notify("Package " .. tostring(plugin) .. " failed to load: " .. tostring(err), vim.log.levels.ERROR)
		error(err)
	end,
	["custom"] = function(plugin, err, handler)
		if handler then
			handler(plugin, err)
		end
	end,
}

-- Get plugin name from URL or return as-is
local function get_plugin_name(plugin_spec)
	if type(plugin_spec) == "string" then
		if plugin_spec:match("^https?://") then
			-- Extract name from URL like "https://github.com/user/repo"
			local match = plugin_spec:match("^.*/(.-)/(.+)$")
			return match or plugin_spec
		end
		return plugin_spec
	elseif type(plugin_spec) == "table" then
		if plugin_spec.name then
			return plugin_spec.name
		elseif plugin_spec.src then
			return get_plugin_name(plugin_spec.src)
		end
	end
	return tostring(plugin_spec)
end

-- Get plugin spec from URL
local function get_plugin_spec_from_url(url)
	local spec = {
		plugin = url,
	}
	-- Try to extract name
	local match = url:match("^.*/(.-)/(.+)$")
	if match then
		spec.name = match
	end
	return spec
end

-- Check if vim version matches constraint
local function check_version_constraint(version_spec)
	local current = vim.version()

	if type(version_spec) == "string" then
		-- Parse version string like "1.0.0", "1.*", ">=0.3.0"
		local m1, m2, m3 = version_spec:match("(%d+)%.(%d+)%.(%d+)")
		if m1 then
			local c_major, c_minor, c_patch = current.major, current.minor, current.patch

			-- Check for wildcards
			if m1:match("%*") then
				return true
			elseif m2:match("%*") then
				return c_major == tonumber(m1)
			elseif m3:match("%*") then
				return c_major == tonumber(m1) and c_minor == tonumber(m2)
			else
				return c_major == tonumber(m1) and c_minor == tonumber(m2) and c_patch == tonumber(m3)
			end
		end
	elseif type(version_spec) == "table" then
		-- Range like { "1.0.0", "2.0.0" } or { "1.*" }
		for _, constraint in ipairs(version_spec) do
			if check_version_constraint(constraint) then
				return true
			end
		end
	end

	return false
end

-- Check runtime condition
local function check_runtime_condition(condition)
	if type(condition) == "function" then
		return condition()
	end
	return false
end

-- Check if plugin should be loaded based on file type
local function should_load_on_ft(ft, plugin)
	local conditions = plugin.on_ft

	if not conditions then
		return false
	end

	if type(conditions) == "string" then
		conditions = { conditions }
	end

	for _, cond in ipairs(conditions) do
		if ft == cond then
			return true
		end
	end

	return false
end

-- Check if plugin should be loaded on event
local function should_load_on_event(event, plugin)
	local conditions = plugin.on_load

	if not conditions then
		return false
	end

	if type(conditions) == "string" then
		return conditions == event
	elseif type(conditions) == "function" then
		return conditions()
	end

	return false
end

-- Check version constraints
local function check_version_constraints(plugin)
	if not plugin.version then
		return true
	end

	return check_version_constraint(plugin.version)
end

-- Check runtime conditions
local function check_runtime_conditions(plugin)
	if not plugin.conditions then
		return true
	end

	for _, condition in ipairs(plugin.conditions) do
		if not check_runtime_condition(condition) then
			return false
		end
	end

	return true
end

-- Load a single plugin
local function load_plugin(plugin)
	local name = get_plugin_name(plugin.plugin)

	-- Check if already loaded
	if M.loaded[name] then
		return true
	end

	-- Check version constraints
	if not check_version_constraints(plugin) then
		return false
	end

	-- Check runtime conditions
	if not check_runtime_conditions(plugin) then
		return false
	end

	-- Add to registry
	M.registry[name] = plugin
	M.loaded[name] = true

	-- Load the package
	local success, err = pcall(function()
		if type(plugin.plugin) == "string" and plugin.plugin:match("^https?://") then
			-- URL format - use vim.pack.add
			vim.pack.add(plugin.plugin)
		elseif type(plugin.plugin) == "table" then
			if plugin.plugin.name then
				vim.pack.add(plugin.plugin.name)
			elseif plugin.plugin.src then
				vim.pack.add(plugin.plugin.src)
			end
		end
	end)

	if not success then
		local handler = ERROR_STRATEGIES[plugin.error_handling] or ERROR_STRATEGIES["warn"]
		handler(name, err)
		return false
	end

	-- Load dependencies first
	if plugin.dependencies then
		for _, dep in ipairs(plugin.dependencies) do
			local dep_plugin = M.registry[dep]
			if dep_plugin and not M.loaded[dep] then
				load_plugin(dep_plugin)
			end
		end
	end

	-- Call setup function if provided
	if plugin.setup then
		local setup_success, setup_err = pcall(plugin.setup)
		if not setup_success then
			local handler = ERROR_STRATEGIES[plugin.error_handling] or ERROR_STRATEGIES["warn"]
			handler(name, setup_err)
		end
	end

	return true
end

-- Add a plugin to the registry and schedule for loading
function M.add(plugin)
	local spec = type(plugin) == "string" and { plugin = plugin } or plugin

	if not spec.plugin then
		vim.notify("Package specification must include 'plugin' field", vim.log.levels.ERROR)
		return false
	end

	-- Convert string spec to table if needed
	if type(spec.plugin) == "string" and spec.plugin:match("^https?://") then
		spec = get_plugin_spec_from_url(spec.plugin)
	end

	M.pending[#M.pending + 1] = spec

	return true
end

-- Update all packages
function M.update()
	for _, plugin in pairs(M.registry) do
		local name = get_plugin_name(plugin.plugin)
		local success, err = pcall(function()
			vim.pack.update({ name })
		end)

		if not success then
			local handler = ERROR_STRATEGIES[plugin.error_handling] or ERROR_STRATEGIES["warn"]
			handler(name, err)
		end
	end
end

-- Remove a plugin
function M.remove(plugin_name)
	local success, err = pcall(function()
		vim.pack.del(plugin_name)
	end)

	if not success then
		vim.notify("Failed to remove package " .. tostring(plugin_name) .. ": " .. tostring(err), vim.log.levels.WARN)
	end

	if M.registry[plugin_name] then
		M.registry[plugin_name] = nil
		M.loaded[plugin_name] = nil
	end
	return true
end

-- Reload all plugins
function M.reload()
	for _, plugin in pairs(M.registry) do
		local success, err = pcall(function()
			require(plugin.plugin)
		end)

		if not success then
			local handler = ERROR_STRATEGIES[plugin.error_handling] or ERROR_STRATEGIES["warn"]
			handler(plugin.plugin, err)
		end
	end
end

-- Register a plugin for a specific vim event
function M.on_event(event, plugin)
	local spec = type(plugin) == "string" and { plugin = plugin } or plugin

	if type(spec.plugin) == "string" and spec.plugin:match("^https?://") then
		spec = get_plugin_spec_from_url(spec.plugin)
	end

	spec.on_load = event
	M.pending[#M.pending + 1] = spec
	return true
end

-- Register a plugin for a file type
function M.on_ft(filetypes, plugin)
	local spec = type(plugin) == "string" and { plugin = plugin } or plugin

	if type(spec.plugin) == "string" and spec.plugin:match("^https?://") then
		spec = get_plugin_spec_from_url(spec.plugin)
	end

	spec.on_ft = filetypes
	M.pending[#M.pending + 1] = spec
	return true
end

-- Register a plugin with both event and file type conditions
function M.on_event_ft(event, filetypes, plugin)
	return M.on_event(event, function()
		return M.on_ft(filetypes, plugin)
	end)
end

-- Load all pending plugins
function M.load_pending()
	for _, plugin in ipairs(M.pending) do
		if plugin.on_load then
			local should = should_load_on_event(plugin.on_load, plugin)
			if should then
				load_plugin(plugin)
			end
		elseif plugin.on_ft then
			local current_ft = vim.api.nvim_get_option_value("filetype", { scope = "local" }) or ""
			local should = should_load_on_ft(current_ft, plugin)
			if should then
				load_plugin(plugin)
			end
		end
	end

	-- Clear pending after loading
	M.pending = {}
end

-- Load all registered plugins (ignoring lazy loading)
function M.load_all()
	for _, plugin in ipairs(M.pending) do
		load_plugin(plugin)
	end
	M.pending = {}
end

-- Get all registered plugins
function M.get_registry()
	return vim.deepcopy(M.registry)
end

-- Get all loaded plugins
function M.get_loaded()
	return vim.deepcopy(M.loaded)
end

-- Get all pending plugins
function M.get_pending()
	return vim.deepcopy(M.pending)
end

-- Clear all loaded state (useful for testing)
function M.clear()
	M.loaded = {}
	M.pending = {}
end

-- Check if a plugin is loaded
function M.is_loaded(plugin_name)
	return M.loaded[plugin_name] ~= nil
end

-- Check if a plugin is in the registry
function M.has_plugin(plugin_name)
	return M.registry[plugin_name] ~= nil
end

return M
