local source = {}

function source.new()
    return setmetatable({}, { __index = source })
end

function source:enabled()
    return vim.bo.filetype == 'markdown'
end

function source:get_trigger_characters()
    return { '@' }
end

function source:get_completions(_, callback)
    local bib = vim.fs.find('references.bib', { upward = true, path = vim.fn.expand('%:p:h') })[1]
        or '/home/chris/projects/diss/bibliography/references.bib'
    local lines = vim.fn.filereadable(bib) == 1 and vim.fn.readfile(bib) or {}
    local items = {}

    for _, line in ipairs(lines) do
        local key = line:match('^@%w+%s*{%s*([^,]+),')
        if key then
            items[#items + 1] = {
                label = key,
                insertText = key,
                kind = require('blink.cmp.types').CompletionItemKind.Reference,
            }
        end
    end

    callback({ items = items, is_incomplete_backward = false, is_incomplete_forward = false })
end

return source
