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
s({trig="az", dscr="Expands to az custom command"},
    fmta(
        "\\az{<>}",
        { i(1) }
    )
),
s({trig="it", dscr="Italic Text"},
    fmta(
        "\\textit{<>}",
        { i(1) }
    )
),
s({trig="bf", dscr="Bold Text"},
    fmta(
        "\\textbf{<>}",
        { i(1) }
    )
),



s({trig="ff", dscr="Fraction'"},
    fmta(
        "\\frac{<>}{<>}",
        { i(1), i(2) }
    )
),
s({trig="cha", dscr="Chapter'"},
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
s({trig="sf", dscr="mathsf"},
    fmta(
        "\\textsf{<>}",
        { i(1) }
    )
),
s({trig="msf", dscr="mathsf"},
    fmta(
        "\\mathsf{<>}",
        { i(1) }
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

s({trig="fig", dscr="Figure Environment"},
  fmta(
    [[
        \begin{figure}[ht!]
            \centering
            \includegraphics[width=0.5\linewidth]{images/<>}
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
        \begin{figure}[ht!]
            \centering
            \includesvg[width=0.5\linewidth]{Svgs/<>}
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


s({trig="tab", dscr="Table Environment"},
  fmta(
    [[
        \begin{table}
            \begin{tabular}{<>}
            <>
            \end{tabular}
            \caption{<>}
            \label{tab:<>}
        \end{table}
    ]],
    {
      i(1),
      i(2),
      i(3),
      i(4),
    }
  )
),


s({trig="alg", dscr="Algorithm Environment"},
  fmta(
    [[
        \begin{algorithm}[H]
            \caption{<>}
            \KwIn{<>}
            \KwOut{<>}
        
            <>

        \end{algorithm}
    ]],
    {
      i(1),
      i(2),
      i(3),
      i(4),
    }
  )
),

}
