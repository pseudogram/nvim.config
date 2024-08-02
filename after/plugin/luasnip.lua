local ls = require 'luasnip'

require("luasnip.loaders.from_snipmate").lazy_load()

local function create_snippets(key, table)
    ls.add_snippets(
        key, table, {
            key = key,
        }
    )
end

-- create_snippets('all', {
--     ls.parser.parse_snippet('expand', "-- this is what was expanded!"),
-- })

local ruby = {
    ls.parser.parse_snippet('debug', "require 'pry'\nbinding.pry\n"),
}

local eruby = {
    ls.parser.parse_snippet('<%', "<% $1 %>"),
    ls.parser.parse_snippet('<%=', "<%= $1 %>"),
}

local typescript = {
    ls.parser.parse_snippet('const', "const $1 = $2"),
}

create_snippets('ruby', ruby )
create_snippets('eruby', eruby )
create_snippets('typescript', typescript)
