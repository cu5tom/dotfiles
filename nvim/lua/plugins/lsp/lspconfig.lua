return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      --diagnostics = {
      --  underline = true,
      --  virtual_text = false,
      --  float = {
      --    format = function(diagnostic)
      --      return trim(diagnostic.message)
      --    end,
      --    prefix = function(diagnostic, i, total)
      --      local h1 = "Comment"
      --      local prefix = total > 1 and ("%d. "):format(i) or ""

      --      if diagnostic.source then
      --        prefix = ("%s%s: "):format(prefix, trim(diagnostic.source))
      --      end

      --      return prefix, h1
      --    end,
      --  },
      --},
      inlay_hints = { enabled = true },
      servers = {
        biome = {},
        cssls = {},
        emmet_language_server = {},
        --eslint = {
        --  root_dir = require("lspconfig.util").root_pattern(
        --    ".eslintrc",
        --    ".eslintrc.js",
        --    ".eslintrc.cjs",
        --    ".eslintrc.yaml",
        --    ".eslintrc.yml",
        --    ".eslintrc.json"
        --  ),
        --  settings = {
        --    format = {
        --      enable = false,
        --    },
        --    workingDirectory = { mode = "auto" },
        --  },
        --},
        html = {},
        tailwindcss = {
          root_dir = require("lspconfig.util").root_pattern("tailwind.config.js", "taiwind.config.ts"),
        },
        tsserver = {
          on_attach = function(client)
            client.server_capabilities.documentFormattingProvider = false
          end,
        },
        volar = {
          filetypes = { "vue", "typescript" },
          root_dir = require("lspconfig.util").root_pattern("vite.config.js", "vite.config.ts"),
        },
        yamlls = {
          settings = {
            yaml = {
              keyOrdering = false,
            },
          },
        },
        lua_ls = {
          -- enabled = false,
          single_file_support = true,
          settings = {
            Lua = {
              workspace = {
                checkThirdParty = false,
              },
              completion = {
                workspaceWord = true,
                callSnippet = "Both",
              },
              misc = {
                parameters = {
                  -- "--log-level=trace",
                },
              },
              hint = {
                enable = true,
                setType = false,
                paramType = true,
                paramName = "Disable",
                semicolon = "Disable",
                arrayIndex = "Disable",
              },
              doc = {
                privateName = { "^_" },
              },
              type = {
                castNumberToInteger = true,
              },
              diagnostics = {
                disable = { "incomplete-signature-doc", "trailing-space" },
                -- enable = false,
                groupSeverity = {
                  strong = "Warning",
                  strict = "Warning",
                },
                groupFileStatus = {
                  ["ambiguity"] = "Opened",
                  ["await"] = "Opened",
                  ["codestyle"] = "None",
                  ["duplicate"] = "Opened",
                  ["global"] = "Opened",
                  ["luadoc"] = "Opened",
                  ["redefined"] = "Opened",
                  ["strict"] = "Opened",
                  ["strong"] = "Opened",
                  ["type-check"] = "Opened",
                  ["unbalanced"] = "Opened",
                  ["unused"] = "Opened",
                },
                unusedLocalExclude = { "_*" },
              },
              format = {
                enable = false,
                defaultConfig = {
                  indent_style = "space",
                  indent_size = "2",
                  continuation_indent_size = "2",
                },
              },
            },
          },
        },
      },
      setup = {},
    },
  },
}
