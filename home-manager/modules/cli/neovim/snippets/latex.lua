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
s({trig="tt", dscr="Expands 'tt' into '\texttt{}'"},
    fmta(
        "\\texttt{<>}",
        { i(1) }
    )
),

s({trig="ff", dscr="Fraction'"},
    fmta(
        "\\frac{<>}{<>}",
        { i(1), i(2) }
    )
),
s({trig="chp", dscr="Chapter'"},
    fmta(
        "\\chapter{<>}",
        { i(1) }
    )
),
s({trig="sec", dscr="Section'"},
    fmta(
        "\\section{<>}",
        { i(1) }
    )
),
s({trig="ssec", dscr="Sub Section'"},
    fmta(
        "\\subsection{<>}",
        { i(1) }
    )
),
s({trig="sssec", dscr="Sub Sub Section'"},
    fmta(
        "\\subsubsection{<>}",
        { i(1) }
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

s({trig="env", dscr="Environment"},
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

s({trig="fig", dscr="Figure Environment"},
  fmta(
    [[
        \begin{figure}
            \includegraphics{images/<>}
            \caption{<>}
            \label{fig:<>}
        \end{figure}
    ]],
    {
      i(1),
      i(2),
      i(3),
    }
  )
),

s({trig="svg", dscr="SVG Figure Environment"},
  fmta(
    [[
        \begin{figure}
            \includesvg{images/<>}
            \caption{<>}
            \label{fig:<>}
        \end{figure}
    ]],
    {
      i(1),
      i(2),
      i(3),
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
