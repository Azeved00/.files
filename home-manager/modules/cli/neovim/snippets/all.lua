local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local d = ls.dynamic_node
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local rep = require("luasnip.extras").rep

return {
-- Combining text and insert nodes to create basic LaTeX commands
s({trig="tt", dscr="Expands 'tt' into '\texttt{}'"},
  {
    t("\\texttt{"), 
    i(1),
    t("}"),
  }
),

s({trig="ff", dscr="Fraction'"},
    fmta(
        "\\frac{<>}{<>}",
        { i(1), i(2) }
    )
),

s({trig="eq", dscr="Equation environment"},
    fmta(
        [[
          \begin{equation}
              <>
          \end{equation}
        ]],
        { i(1) }
    )
),

s({trig="env", dsrcr="Environment"},
  fmta(
    [[
      \begin{<>}
          <>
      \end{<>}
    ]],
    {
      i(1),
      i(2),
      rep(1)
    }
  )
),

s({trig="hr", dscr="HRef"},
  fmta(
    [[\href{<>}{<>}]],
    {
      i(1, "url"),
      i(2, "display name"),
    }
  )
),
}
