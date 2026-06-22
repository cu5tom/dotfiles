---https://bennypowers.dev/cem/
---
---`cem lsp` provides editor features for custom-elements a.k.a. web components
---
---Install with go
---```sh
---go install bennypowers.dev/cem
---```
---Or with NPM
---```sh
---npm install -g @pwrs/cem
---```
---
---@type vim.lsp.ClientConfig
return {
  cmd = { 'cem', 'lsp' },
  root_markers = { 'custom-elements.json', 'package.json', '.git' },
  filetypes = {
    'html', 'twig', 'nunjucks', 'jinja2', 'handlebars',
    'liquid', 'eruby', 'ejs', 'php', 'blade',
    'typescript', 'javascript',
  },
  -- Control debug logging via LSP trace levels
  trace = 'verbose', -- 'off' | 'messages' | 'verbose'
}
