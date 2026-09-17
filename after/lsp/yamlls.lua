return {
  on_init = function(client) client:notify 'yaml/registerCustomSchemaRequest' end,
  handlers = {
    ['custom/schema/request'] = function(_, params)
      local path = vim.uri_to_fname(params[1]):lower()
      if path:find 'flatpak' and not path:find '/%.github/' then
        return 'https://raw.githubusercontent.com/flatpak/flatpak-builder/main/data/flatpak-manifest.schema.json'
      end
      return vim.NIL
    end,
  },
}
