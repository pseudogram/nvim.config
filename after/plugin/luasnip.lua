local ls = require 'luasnip'


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

local ruby_and_eruby_snips = {
    ls.parser.parse_snippet('debug', "require 'pry'\nbinding.pry\n"),
}

create_snippets('ruby', ruby_and_eruby_snips )
create_snippets('eruby', ruby_and_eruby_snips )
