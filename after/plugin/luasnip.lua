-- Bail out if luasnip is not installed
if not pcall(require, "luasnip") then
  return
end

-- local make = R("tj.snips").make

local ls = require "luasnip"
local types = require "luasnip.util.types"

ls.config.set_config {
  -- This tells LuaSnip to remember to keep around the last snippet.
  -- You jcan jump back into it even if you move outside of the selection
  history = false,

  -- This one is cool cause if you have dynamic snippets, it updates as you type!
  updateevents = "TextChanged,TextChangedI",

  -- Autosnippets:
  enable_autosnippets = true,

  -- Crazy highlights!!
  -- #vid3
  -- ext_opts = nil,
  ext_opts = {
    [types.choiceNode] = {
      active = {
        virt_text = { { " « ", "NonTest" } },
      },
    },
  },
}


-- local ls = require("luasnip")
-- local s = ls.snippet
-- local sn = ls.snippet_node
-- local isn = ls.indent_snippet_node
-- local t = ls.text_node
-- local i = ls.insert_node
-- local f = ls.function_node
-- local c = ls.choice_node
-- local d = ls.dynamic_node
-- local r = ls.restore_node
-- local events = require("luasnip.util.events")
-- local ai = require("luasnip.nodes.absolute_indexer")
-- local extras = require("luasnip.extras")
-- local l = extras.lambda
-- local rep = extras.rep
-- local p = extras.partial
-- local m = extras.match
-- local n = extras.nonempty
-- local dl = extras.dynamic_lambda
-- local fmt = require("luasnip.extras.fmt").fmt
-- local fmta = require("luasnip.extras.fmt").fmta
-- local conds = require("luasnip.extras.conditions")
-- local conds_expand = require("luasnip.extras.conditions.expand")
-- local postfix = require("luasnip.extras.postfix").postfix
-- local types = require("luasnip.util.types")
-- local parse = require("luasnip.util.parser").parse_snippet
-- local ms = ls.multi_snippet
-- local k = require("luasnip.nodes.key_indexer").new_key

-- ls.add_snippets("all", {
-- 	-- trigger is `fn`, second argument to snippet-constructor are the nodes to insert into the buffer on expansion.
-- 	s("fn", {
-- 		-- Simple static text.
-- 		t("//Parameters: "),
-- 		-- function, first parameter is the function, second the Placeholders
-- 		-- whose text it gets as input.
-- 		f(copy, 2),
-- 		t({ "", "function " }),
-- 		-- Placeholder/Insert.
-- 		i(1),
-- 		t("("),
-- 		-- Placeholder with initial text.
-- 		i(2, "int foo"),
-- 		-- Linebreak
-- 		t({ ") {", "\t" }),
-- 		-- Last Placeholder, exit Point of the snippet.
-- 		i(0),
-- 		t({ "", "}" }),
-- 	}),
-- 	s("class", {
-- 		-- Choice: Switch between two different Nodes, first parameter is its position, second a list of nodes.
-- 		c(1, {
-- 			t("public "),
-- 			t("private "),
-- 		}),
-- 		t("class "),
-- 		i(2),
-- 		t(" "),
-- 		c(3, {
-- 			t("{"),
-- 			-- sn: Nested Snippet. Instead of a trigger, it has a position, just like insertNodes. !!! These don't expect a 0-node!!!!
-- 			-- Inside Choices, Nodes don't need a position as the choice node is the one being jumped to.
-- 			sn(nil, {
-- 				t("extends "),
-- 				-- restoreNode: stores and restores nodes.
-- 				-- pass position, store-key and nodes.
-- 				r(1, "other_class", i(1)),
-- 				t(" {"),
-- 			}),
-- 			sn(nil, {
-- 				t("implements "),
-- 				-- no need to define the nodes for a given key a second time.
-- 				r(1, "other_class"),
-- 				t(" {"),
-- 			}),
-- 		}),
-- 		t({ "", "\t" }),
-- 		i(0),
-- 		t({ "", "}" }),
-- 	}),
-- 	-- Alternative printf-like notation for defining snippets. It uses format
-- 	-- string with placeholders similar to the ones used with Python's .format().
-- 	s(
-- 		"fmt1",
-- 		fmt("To {title} {} {}.", {
-- 			i(2, "Name"),
-- 			i(3, "Surname"),
-- 			title = c(1, { t("Mr."), t("Ms.") }),
-- 		})
-- 	),
-- 	-- To escape delimiters use double them, e.g. `{}` -> `{{}}`.
-- 	-- Multi-line format strings by default have empty first/last line removed.
-- 	-- Indent common to all lines is also removed. Use the third `opts` argument
-- 	-- to control this behaviour.
-- 	s(
-- 		"fmt2",
-- 		fmt(
-- 			[[
-- 		foo({1}, {3}) {{
-- 			return {2} * {4}
-- 		}}
-- 		]],
-- 			{
-- 				i(1, "x"),
-- 				rep(1),
-- 				i(2, "y"),
-- 				rep(2),
-- 			}
-- 		)
-- 	),
-- 	-- Empty placeholders are numbered automatically starting from 1 or the last
-- 	-- value of a numbered placeholder. Named placeholders do not affect numbering.
-- 	s(
-- 		"fmt3",
-- 		fmt("{} {a} {} {1} {}", {
-- 			t("1"),
-- 			t("2"),
-- 			a = t("A"),
-- 		})
-- 	),
-- 	-- The delimiters can be changed from the default `{}` to something else.
-- 	s("fmt4", fmt("foo() { return []; }", i(1, "x"), { delimiters = "[]" })),
-- 	-- `fmta` is a convenient wrapper that uses `<>` instead of `{}`.
-- 	s("fmt5", fmta("foo() { return <>; }", i(1, "x"))),
-- 	-- By default all args must be used. Use strict=false to disable the check
-- 	s(
-- 		"fmt6",
-- 		fmt("use {} only", { t("this"), t("not this") }, { strict = false })
-- 	),
-- 	-- Use a dynamicNode to interpolate the output of a
-- 	-- function (see date_input above) into the initial
-- 	-- value of an insertNode.
-- 	s("novel", {
-- 		t("It was a dark and stormy night on "),
-- 		d(1, date_input, {}, { user_args = { "%A, %B %d of %Y" } }),
-- 		t(" and the clocks were striking thirteen."),
-- 	}),
-- 	-- Parsing snippets: First parameter: Snippet-Trigger, Second: Snippet body.
-- 	-- Placeholders are parsed into choices with 1. the placeholder text(as a snippet) and 2. an empty string.
-- 	-- This means they are not SELECTed like in other editors/Snippet engines.
-- 	ls.parser.parse_snippet(
-- 		"lspsyn",
-- 		"Wow! This ${1:Stuff} really ${2:works. ${3:Well, a bit.}}"
-- 	),

-- 	-- When wordTrig is set to false, snippets may also expand inside other words.
-- 	ls.parser.parse_snippet(
-- 		{ trig = "te", wordTrig = false },
-- 		"${1:cond} ? ${2:true} : ${3:false}"
-- 	),

-- 	-- When regTrig is set, trig is treated like a pattern, this snippet will expand after any number.
-- 	ls.parser.parse_snippet({ trig = "%d", regTrig = true }, "A Number!!"),
-- 	-- Using the condition, it's possible to allow expansion only in specific cases.
-- 	s("cond", {
-- 		t("will only expand in c-style comments"),
-- 	}, {
-- 		condition = function(line_to_cursor, matched_trigger, captures)
-- 			-- optional whitespace followed by //
-- 			return line_to_cursor:match("%s*//")
-- 		end,
-- 	}),
-- 	-- there's some built-in conditions in "luasnip.extras.conditions.expand" and "luasnip.extras.conditions.show".
-- 	s("cond2", {
-- 		t("will only expand at the beginning of the line"),
-- 	}, {
-- 		condition = conds_expand.line_begin,
-- 	}),
-- 	s("cond3", {
-- 		t("will only expand at the end of the line"),
-- 	}, {
-- 		condition = conds_expand.line_end,
-- 	}),
-- 	-- on conditions some logic operators are defined
-- 	s("cond4", {
-- 		t("will only expand at the end and the start of the line"),
-- 	}, {
-- 		-- last function is just an example how to make own function objects and apply operators on them
-- 		condition = conds_expand.line_end
-- 			+ conds_expand.line_begin
-- 				* conds.make_condition(function()
-- 					return true
-- 				end),
-- 	}),
-- 	-- The last entry of args passed to the user-function is the surrounding snippet.
-- 	s(
-- 		{ trig = "a%d", regTrig = true },
-- 		f(function(_, snip)
-- 			return "Triggered with " .. snip.trigger .. "."
-- 		end, {})
-- 	),
-- 	-- It's possible to use capture-groups inside regex-triggers.
-- 	s(
-- 		{ trig = "b(%d)", regTrig = true },
-- 		f(function(_, snip)
-- 			return "Captured Text: " .. snip.captures[1] .. "."
-- 		end, {})
-- 	),
-- 	s({ trig = "c(%d+)", regTrig = true }, {
-- 		t("will only expand for even numbers"),
-- 	}, {
-- 		condition = function(line_to_cursor, matched_trigger, captures)
-- 			return tonumber(captures[1]) % 2 == 0
-- 		end,
-- 	}),
-- 	-- Use a function to execute any shell command and print its text.
-- 	s("bash", f(bash, {}, { user_args = { "ls" } })),
-- 	-- Short version for applying String transformations using function nodes.
-- 	s("transform", {
-- 		i(1, "initial text"),
-- 		t({ "", "" }),
-- 		-- lambda nodes accept an l._1,2,3,4,5, which in turn accept any string transformations.
-- 		-- This list will be applied in order to the first node given in the second argument.
-- 		l(l._1:match("[^i]*$"):gsub("i", "o"):gsub(" ", "_"):upper(), 1),
-- 	}),

-- 	s("transform2", {
-- 		i(1, "initial text"),
-- 		t("::"),
-- 		i(2, "replacement for e"),
-- 		t({ "", "" }),
-- 		-- Lambdas can also apply transforms USING the text of other nodes:
-- 		l(l._1:gsub("e", l._2), { 1, 2 }),
-- 	}),
-- 	s({ trig = "trafo(%d+)", regTrig = true }, {
-- 		-- env-variables and captures can also be used:
-- 		l(l.CAPTURE1:gsub("1", l.TM_FILENAME), {}),
-- 	}),
-- 	-- Set store_selection_keys = "<Tab>" (for example) in your
-- 	-- luasnip.config.setup() call to populate
-- 	-- TM_SELECTED_TEXT/SELECT_RAW/SELECT_DEDENT.
-- 	-- In this case: select a URL, hit Tab, then expand this snippet.
-- 	s("link_url", {
-- 		t('<a href="'),
-- 		f(function(_, snip)
-- 			-- TM_SELECTED_TEXT is a table to account for multiline-selections.
-- 			-- In this case only the first line is inserted.
-- 			return snip.env.TM_SELECTED_TEXT[1] or {}
-- 		end, {}),
-- 		t('">'),
-- 		i(1),
-- 		t("</a>"),
-- 		i(0),
-- 	}),
-- 	-- Shorthand for repeating the text in a given node.
-- 	s("repeat", { i(1, "text"), t({ "", "" }), rep(1) }),
-- 	-- Directly insert the ouput from a function evaluated at runtime.
-- 	s("part", p(os.date, "%Y")),
-- 	-- use matchNodes (`m(argnode, condition, then, else)`) to insert text
-- 	-- based on a pattern/function/lambda-evaluation.
-- 	-- It's basically a shortcut for simple functionNodes:
-- 	s("mat", {
-- 		i(1, { "sample_text" }),
-- 		t(": "),
-- 		m(1, "%d", "contains a number", "no number :("),
-- 	}),
-- 	-- The `then`-text defaults to the first capture group/the entire
-- 	-- match if there are none.
-- 	s("mat2", {
-- 		i(1, { "sample_text" }),
-- 		t(": "),
-- 		m(1, "[abc][abc][abc]"),
-- 	}),
-- 	-- It is even possible to apply gsubs' or other transformations
-- 	-- before matching.
-- 	s("mat3", {
-- 		i(1, { "sample_text" }),
-- 		t(": "),
-- 		m(
-- 			1,
-- 			l._1:gsub("[123]", ""):match("%d"),
-- 			"contains a number that isn't 1, 2 or 3!"
-- 		),
-- 	}),
-- 	-- `match` also accepts a function in place of the condition, which in
-- 	-- turn accepts the usual functionNode-args.
-- 	-- The condition is considered true if the function returns any
-- 	-- non-nil/false-value.
-- 	-- If that value is a string, it is used as the `if`-text if no if is explicitly given.
-- 	s("mat4", {
-- 		i(1, { "sample_text" }),
-- 		t(": "),
-- 		m(1, function(args)
-- 			-- args is a table of multiline-strings (as usual).
-- 			return (#args[1][1] % 2 == 0 and args[1]) or nil
-- 		end),
-- 	}),
-- 	-- The nonempty-node inserts text depending on whether the arg-node is
-- 	-- empty.
-- 	s("nempty", {
-- 		i(1, "sample_text"),
-- 		n(1, "i(1) is not empty!"),
-- 	}),
-- 	-- dynamic lambdas work exactly like regular lambdas, except that they
-- 	-- don't return a textNode, but a dynamicNode containing one insertNode.
-- 	-- This makes it easier to dynamically set preset-text for insertNodes.
-- 	s("dl1", {
-- 		i(1, "sample_text"),
-- 		t({ ":", "" }),
-- 		dl(2, l._1, 1),
-- 	}),
-- 	-- Obviously, it's also possible to apply transformations, just like lambdas.
-- 	s("dl2", {
-- 		i(1, "sample_text"),
-- 		i(2, "sample_text_2"),
-- 		t({ "", "" }),
-- 		dl(3, l._1:gsub("\n", " linebreak ") .. l._2, { 1, 2 }),
-- 	}),
-- }, {
-- 	key = "all",
-- })

-- -- ls.config.set_config(
-- -- ls.add_snippets("all", {
-- -- 	ls.s("ternary", {
-- -- 		-- equivalent to "${1:cond} ? ${2:then} : ${3:else}"
-- -- 		i(1, "cond"), t(" ? "), i(2, "then"), t(" : "), i(3, "else")
-- -- 	})
-- -- })



-- -- 1s.config.set_config {J
-- -- - This tells LuaSnip to remember to keep around the last snippet .d
-- -- -- You can jump back into it even if you move outside of the selections
-- -- history = true, d
-- -- This one is cool cause if you have dynamic snippets, it updates as you type!d
-- -- updateevents = "TextChanged, TextChangedI"
-- -- -- Autosnippets: J
-- -- enable_autosnippets = true, d
-- -- Crazy highlights!! J #vid3J
-- -- -- ext_opts = nil,d
-- -- ext_opts = {d
-- -- [types .choiceNode] = {d
-- -- active = {J
-- -- virt_text

if not pcall(require, "luasnip") then
  return
end


local ls = require "luasnip"
local types = require "luasnip.util.types"

ls.config.set_config {
  -- This tells LuaSnip to remember to keep around the last snippet.
  -- You can jump back into it even if you move outside of the selection
  history = false,

  -- This one is cool cause if you have dynamic snippets, it updates as you type!
  updateevents = "TextChanged,TextChangedI",

  -- Autosnippets:
  enable_autosnippets = true,

  -- Crazy highlights!!
  -- #vid3
  -- ext_opts = nil,
  ext_opts = {
    [types.choiceNode] = {
      active = {
        virt_text = { { " « ", "NonTest" } },
      },
    },
  },
}

-- create snippet
-- s(context, nodes, condition, ...)
local snippet = ls.s

-- TODO: Write about this.
--  Useful for dynamic nodes and choice nodes
local snippet_from_nodes = ls.sn

-- This is the simplest node.
--  Creates a new text node. Places cursor after node by default.
--  t { "this will be inserted" }
--
--  Multiple lines are by passing a table of strings.
--  t { "line 1", "line 2" }
local t = ls.text_node

-- Insert Node
--  Creates a location for the cursor to jump to.
--      Possible options to jump to are 1 - N
--      If you use 0, that's the final place to jump to.
--
--  To create placeholder text, pass it as the second argument
--      i(2, "this is placeholder text")
local i = ls.insert_node

-- Function Node
--  Takes a function that returns text
local f = ls.function_node

-- This a choice snippet. You can move through with <c-l> (in my config)
--   c(1, { t {"hello"}, t {"world"}, }),
--
-- The first argument is the jump position
-- The second argument is a table of possible nodes.
--  Note, one thing that's nice is you don't have to include
--  the jump position for nodes that normally require one (can be nil)
local c = ls.choice_node

local d = ls.dynamic_node

-- TODO: Document what I've learned about lambda
local l = require("luasnip.extras").lambda

local events = require "luasnip.util.events"

-- local str_snip = function(trig, expanded)
--   return ls.parser.parse_snippet({ trig = trig }, expanded)
-- end

local same = function(index)
  return f(function(args)
    return args[1]
  end, { index })
end

local toexpand_count = 0

-- `all` key means for all filetypes.
-- Shared between all filetypes. Has lower priority than a particular ft tho
-- snippets.all = {
ls.add_snippets(nil, {
  -- basic, don't need to know anything else
  --    arg 1: string
  --    arg 2: a node
  snippet("simple", t "wow, you were right!"),

  -- callbacks table
  snippet("toexpand", c(1, { t "hello", t "world", t "last" }), {
    callbacks = {
      [1] = {
        [events.enter] = function(--[[ node ]])
          toexpand_count = toexpand_count + 1
          print("Number of times entered:", toexpand_count)
        end,
      },
    },
  }),

  -- regTrig
  --    snippet.captures
  -- snippet({ trig = "AbstractGenerator.*Factory", regTrig = true }, { t "yo" }),

  -- third arg,
  snippet("never_expands", t "this will never expand, condition is false", {
    condition = function()
      return false
    end,
  }),

  -- docTrig ??

  -- functions

  -- date -> Tue 16 Nov 2021 09:43:49 AM EST
  snippet({ trig = "date" }, {
    f(function()
      return string.format(string.gsub(vim.bo.commentstring, "%%s", " %%s"), os.date())
    end, {}),
  }),

  -- Simple snippet, basics
  snippet("for", {
    t "for ",
    i(1, "k, v"),
    t " in ",
    i(2, "ipairs()"),
    t { "do", "  " },
    i(0),
    t { "", "" },
    t "end",
  }),

  --[[
        -- Alternative printf-like notation for defining snippets. It uses format
        -- string with placeholders similar to the ones used with Python's .format().
        s(
            "fmt1",
            fmt("To {title} {} {}.", {
                i(2, "Name"),
                i(3, "Surname"),
                title = c(1, { t("Mr."), t("Ms.") }),
            })
        ),
  --]]

  -- LSP version (this allows for simple snippets / copy-paste from vs code things)

  -- function(args, snip) ... end

  -- Using captured text <-- think of a fun way to use this.
  -- s({trig = "b(%d)", regTrig = true},
  -- f(function(args, snip) return
  -- "Captured Text: " .. snip.captures[1] .. "." end, {})

  -- the first few letters of a commit hash -> expand to correct one
  -- type the first few words of a commit message -> expands to commit hash that matches
  -- commit:Fixes #

  -- tree sitter
  -- :func:x -> find all functions in the file with x in the name, and choice between them

  -- auto-insert markdown footer?
  -- footer:(hello world)
  -- ^link
  -- callbacks [event.leave]

  --
  -- ls.parser.parse_snippet({trig = "lsp"}, "$1 is ${2|hard,easy,challenging|}")
})

-- table.insert(
--   snippets.all,
--   snippet("cond", {
--     t "will only expand in c-style comments",
--   }, {
--     condition = function(
--       line_to_cursor --[[ , matched_trigger, captures ]]
--     )
--       local commentstring = "%s*" .. vim.bo.commentstring:gsub("%%s", "")
--       -- optional whitespace followed by //
--       return line_to_cursor:match(commentstring)
--     end,
--   })
-- )

-- Make sure to not pass an invalid command, as io.popen() may write over nvim-text.
ls.add_snippets(nil, {
  snippet(
    { trig = "$$ (.*)", regTrig = true },
    f(function(_, snip, command)
      if snip.captures[1] then
        command = snip.captures[1]
      end

      local file = io.popen(command, "r")
      local res = { "$ " .. snip.captures[1] }
      for line in file:lines() do
        table.insert(res, line)
      end
      return res
    end, {}, "ls"),
    {
      -- Don't show this one, because it's not useful as a general purpose snippet.
      show_condition = function()
        return false
      end,
    }
  ),
})

local js_attr_split = function(args)
  local val = args[1][1]
  local split = vim.split(val, ".", { plain = true })

  local choices = {}
  local thus_far = {}
  for index = 0, #split - 1 do
    table.insert(thus_far, 1, split[#split - index])
    table.insert(choices, t { table.concat(thus_far, ".") })
  end

  return snippet_from_nodes(nil, c(1, choices))
end

local fill_line = function(char)
  return function()
    local row = vim.api.nvim_win_get_cursor(0)[1]
    local lines = vim.api.nvim_buf_get_lines(0, row - 2, row, false)
    return string.rep(char, #lines[1])
  end
end


-- <c-k> is my expansion key
-- this will expand the current item or jump to the next item within the snippet.
vim.keymap.set({ "i", "s" }, "<c-k>", function()
  if ls.expand_or_jumpable() then
    ls.expand_or_jump()
  end
end, { silent = true })

-- <c-j> is my jump backwards key.
-- this always moves to the previous item within the snippet
vim.keymap.set({ "i", "s" }, "<c-j>", function()
  if ls.jumpable(-1) then
    ls.jump(-1)
  end
end, { silent = true })

-- <c-l> is selecting within a list of options.
-- This is useful for choice nodes (introduced in the forthcoming episode 2)
vim.keymap.set("i", "<c-l>", function()
  if ls.choice_active() then
    ls.change_choice(1)
  end
end)

vim.keymap.set("i", "<c-u>", require "luasnip.extras.select_choice")

-- shorcut to source my luasnips file again, which will reload my snippets
vim.keymap.set("n", "<leader><leader>s", "<cmd>source ~/.config/nvim/after/plugin/luasnip.lua<CR>")
