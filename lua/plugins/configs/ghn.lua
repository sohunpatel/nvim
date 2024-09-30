local M = {}

M.formatter = function()
    local data = require('github-notifications').statusline_notifications()
    if data.count == 0 then
        return data.icon .. '0'
    end
    return data.icon .. tostring(data.count)
end

return M
