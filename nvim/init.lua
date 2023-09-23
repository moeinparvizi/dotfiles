-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

require("colorizer").setup()

-- require("image_preview").setup({})
--
-- require("neo-tree").setup({
--   filesystem = {
--     window = {
--       mappings = {
--         ["p"] = "image_wezterm", -- " or another map
--       },
--     },
--     commands = {
--       image_wezterm = function(state)
--         local node = state.tree:get_node()
--         if node.type == "file" then
--           require("image_preview").PreviewImage(node.path)
--         end
--       end,
--     },
--   },
-- })
