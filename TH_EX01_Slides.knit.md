---
title: "Spanish Motor Insurance Portfolio"
subtitle: "Executive Summary: Profitability and Volatility, 2022 to 2024"
author: "ISSS608 Visual Analytics and Applications"
date: "May 23, 2026"
date-modified: "last-modified"
format:
  revealjs:
    theme: [default, exec.scss]
    slide-number: c/t
    show-slide-number: all
    transition: fade
    transition-speed: fast
    width: 1280
    height: 720
    margin: 0.08
    smaller: true
    code-fold: true
    code-overflow: wrap
    fig-align: center
execute:
  echo: false
  eval: true
  warning: false
  message: false
  freeze: false
  dev: ragg_png
editor: visual
---



#  {.title-slide background-color="#2C5282"}

::: title-block
[Spanish Motor Insurance Portfolio]{.title-main}

[Executive Summary]{.title-sub}

[Profitability and volatility, 2022 to 2024]{.title-tag}

[ISSS608 Visual Analytics and Applications]{.title-meta}

[← Technical Report](TH_EX01.html){.title-back-link}
:::

::: notes
The analysis covers a Spanish motor insurance portfolio of 352,338 policy years from 2022 to 2024. Two questions drive the investigation. The first is where profitability is falling, measured through the loss ratio, which is incurred claims divided by earned premium. The second is where volatility sits, measured through the coefficient of variation and the Gini coefficient on incurred losses. The deck moves through three sections: portfolio shape, profitability deterioration, and volatility. Each analytical slide pairs one chart with one conclusion.
:::

## Contents

**Section 1. Setting the scene**

1.  Dataset and the questions
2.  Portfolio composition

**Section 2. A profitability problem**

3.  Aggregate loss ratio is rising
4.  Deterioration by product line
5.  Diagnosing COMP_N
6.  Mispriced segments by bonus and age
7.  Coverage lines and bodily injury

**Section 3. A different kind of risk**

8.  Loss concentration in the tail
9.  The volatility paradox
10. Where capital and pricing converge

**Conclusion**

11. Five actions

::: notes
Section one establishes portfolio scale and composition. Section two traces the profitability story across aggregate, product, driver, and coverage dimensions. Section three examines volatility and capital risk, where the most counter intuitive findings sit. Orange marks concern throughout. Green marks acceptable territory. The dashed 70 percent line is the underwriting break even reference used consistently across all slides.
:::

## 1 · Dataset and the questions

::::: columns
::: {.column width="48%"}
**The data**

1.  Spanish non life motor insurer, [Mendeley Data](https://data.mendeley.com/datasets/sw4jmdb2sm/1)
2.  352,338 policy years after cleaning, which is 99.5 percent of raw
3.  2022 to 2024, growing from 67K to 168K records
4.  50 columns. 47 original plus `licence_tenure`, `age_band`, `value_quintile`

**Two questions**

1.  Where is **profitability** falling?\
    Loss ratio equals incurred divided by premium.
2.  Where does **volatility** sit?\
    Tail percentiles, CV, and Gini.
:::

::: {.column width="52%"}

::: {.cell}
::: {.cell-output-display}
![](TH_EX01_Slides_files/figure-html/fig-overview-1.png){#fig-overview width=576}
:::
:::

:::
:::::

::: {.callout-warning icon="false" appearance="minimal"}
The book is large and growing fast, doubling in volume from 2022 to 2024. The two analytical questions that follow are where profitability is falling and where volatility sits.
:::

::: notes
Policy volume more than doubled from 67K in 2022 to 168K in 2024. Four variables carried missing values, each affecting under one percent of rows. Dropping those rows retains 99.5 percent of the dataset without distorting any key distribution. The loss ratio measures average profitability. The coefficient of variation and Gini coefficient measure the spread and concentration of losses beyond the average.
:::

## 2 · Portfolio composition

::::: columns
::: {.column width="58%"}

::: {.cell}
::: {.cell-output-display}
![](TH_EX01_Slides_files/figure-html/fig-composition-1.png){#fig-composition width=672}
:::
:::

:::

::: {.column width="42%"}
**What dominates the book**

1.  CC is the workhorse product at 58 percent. COMP_E sits second at 26 percent.
2.  Good history drivers make up the bulk of the book.
3.  Almost everyone pays annually.
4.  The book is mostly renewals rather than new business.
:::
:::::

::: {.callout-warning icon="false" appearance="minimal"}
Composition is broadly stable year on year. This means the loss ratio movement examined next is a behavioural and pricing story inside the existing book, not a mix shift story.
:::

::: notes
The bar chart shows policy type share across the full three year portfolio. CC dominates at 58 percent, with COMP_E second at 26 percent. TP and COMP_N are both small. The chart shows three year aggregate shares, not a year by year breakdown. Good drivers make up the bulk of the book and almost everyone pays annually. The reason for deterioration will be further analysed in the following slides.
:::

## 3 · Loss ratio is rising because pricing softened

::::: columns
::: {.column width="62%"}

::: {.cell}
::: {.cell-output-display}
![](TH_EX01_Slides_files/figure-html/fig-aggregate-lr-1.png){#fig-aggregate-lr width=691.2}
:::
:::

:::

::: {.column width="38%"}
**Why loss ratio increased**

1.  Loss ratio rose from **66 percent to 75 percent** in two years. This is a 9 ppt absolute lift, or 14 percent relative.
2.  Claim frequency barely moves at 0.302 to 0.311.
3.  Premium per exposure falls 9 percent at €446 to €404.
:::
:::::

::: {.callout-warning icon="false" appearance="minimal"}
Claim cost held steady while pricing softened, naturally causing the loss ratio to increase.
:::

::: notes
The loss ratio rose from 66 percent in 2022 to 75 percent in 2024, a 9 percentage point lift. The middle panel shows claim frequency moved from 0.302 to 0.311, which is negligible. The right panel is where we understand why the loss ratio increases. Average premium per exposure fell from €446 to €404, a 9 percent decline. The loss ratio rose because the premium denominator shrank, not because claims worsened. This diagnosis directs attention toward pricing calibration rather than claims management.
:::

## 4 · Only COMP_N has crossed break even

::::: columns
::: {.column width="62%"}

::: {.cell}
::: {#fig-policytype-trajectory .cell-output-display}

```{=html}
<div class="girafe html-widget html-fill-item" id="htmlwidget-b1e72e9c65db6e820290" style="width:100%;height:397px;"></div>
<script type="application/json" data-for="htmlwidget-b1e72e9c65db6e820290">{"x":{"html":"<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n<svg xmlns='http://www.w3.org/2000/svg' xmlns:xlink='http://www.w3.org/1999/xlink' class='ggiraph-svg' role='graphics-document' id='svg_54e3e1cef77c8d8b' viewBox='0 0 540 309.6'>\n <defs id='svg_54e3e1cef77c8d8b_defs'>\n  <clipPath id='svg_54e3e1cef77c8d8b_c1'>\n   <rect x='0' y='0' width='540' height='309.6'/>\n  <\/clipPath>\n  <clipPath id='svg_54e3e1cef77c8d8b_c2'>\n   <rect x='49.63' y='41.57' width='396.2' height='248.09'/>\n  <\/clipPath>\n <\/defs>\n <g id='svg_54e3e1cef77c8d8b_rootg' class='ggiraph-svg-rootg'>\n  <g clip-path='url(#svg_54e3e1cef77c8d8b_c1)'>\n   <rect x='0' y='0' width='540' height='309.6' fill='#FFFFFF' fill-opacity='1' stroke='#FFFFFF' stroke-opacity='1' stroke-width='0.75' stroke-linejoin='round' stroke-linecap='round' class='ggiraph-svg-bg'/>\n   <rect x='0' y='0' width='540' height='309.6' fill='#FFFFFF' fill-opacity='1' stroke='none'/>\n  <\/g>\n  <g clip-path='url(#svg_54e3e1cef77c8d8b_c2)'>\n   <polyline points='49.63,247.06 445.82,247.06' fill='none' stroke='#EBEBEB' stroke-opacity='1' stroke-width='0.58' stroke-linejoin='round' stroke-linecap='butt'/>\n   <polyline points='49.63,184.41 445.82,184.41' fill='none' stroke='#EBEBEB' stroke-opacity='1' stroke-width='0.58' stroke-linejoin='round' stroke-linecap='butt'/>\n   <polyline points='49.63,121.76 445.82,121.76' fill='none' stroke='#EBEBEB' stroke-opacity='1' stroke-width='0.58' stroke-linejoin='round' stroke-linecap='butt'/>\n   <polyline points='49.63,59.11 445.82,59.11' fill='none' stroke='#EBEBEB' stroke-opacity='1' stroke-width='0.58' stroke-linejoin='round' stroke-linecap='butt'/>\n   <polyline points='49.63,278.38 445.82,278.38' fill='none' stroke='#EBEBEB' stroke-opacity='1' stroke-width='1.16' stroke-linejoin='round' stroke-linecap='butt'/>\n   <polyline points='49.63,215.73 445.82,215.73' fill='none' stroke='#EBEBEB' stroke-opacity='1' stroke-width='1.16' stroke-linejoin='round' stroke-linecap='butt'/>\n   <polyline points='49.63,153.09 445.82,153.09' fill='none' stroke='#EBEBEB' stroke-opacity='1' stroke-width='1.16' stroke-linejoin='round' stroke-linecap='butt'/>\n   <polyline points='49.63,90.44 445.82,90.44' fill='none' stroke='#EBEBEB' stroke-opacity='1' stroke-width='1.16' stroke-linejoin='round' stroke-linecap='butt'/>\n   <polyline points='123.91,289.66 123.91,41.57' fill='none' stroke='#EBEBEB' stroke-opacity='1' stroke-width='1.16' stroke-linejoin='round' stroke-linecap='butt'/>\n   <polyline points='247.72,289.66 247.72,41.57' fill='none' stroke='#EBEBEB' stroke-opacity='1' stroke-width='1.16' stroke-linejoin='round' stroke-linecap='butt'/>\n   <polyline points='371.54,289.66 371.54,41.57' fill='none' stroke='#EBEBEB' stroke-opacity='1' stroke-width='1.16' stroke-linejoin='round' stroke-linecap='butt'/>\n   <polyline id='svg_54e3e1cef77c8d8b_e1' points='123.91,264.10 247.72,216.95 371.54,179.22' fill='none' stroke='#E41A1C' stroke-opacity='1' stroke-width='2.13' stroke-linejoin='round' stroke-linecap='butt' data-id='TP' title='TP'/>\n   <polyline id='svg_54e3e1cef77c8d8b_e2' points='123.91,191.32 247.72,171.65 371.54,151.15' fill='none' stroke='#377EB8' stroke-opacity='1' stroke-width='2.13' stroke-linejoin='round' stroke-linecap='butt' data-id='TPG' title='TPG'/>\n   <polyline id='svg_54e3e1cef77c8d8b_e3' points='123.91,175.94 247.72,193.76 371.54,176.00' fill='none' stroke='#4DAF4A' stroke-opacity='1' stroke-width='2.13' stroke-linejoin='round' stroke-linecap='butt' data-id='CC' title='CC'/>\n   <polyline id='svg_54e3e1cef77c8d8b_e4' points='123.91,175.97 247.72,165.03 371.54,143.18' fill='none' stroke='#984EA3' stroke-opacity='1' stroke-width='2.13' stroke-linejoin='round' stroke-linecap='butt' data-id='COMP_E' title='COMP_E'/>\n   <polyline id='svg_54e3e1cef77c8d8b_e5' points='123.91,157.36 247.72,109.90 371.54,86.74' fill='none' stroke='#FF7F00' stroke-opacity='1' stroke-width='2.13' stroke-linejoin='round' stroke-linecap='butt' data-id='COMP_N' title='COMP_N'/>\n   <circle id='svg_54e3e1cef77c8d8b_e6' cx='123.91' cy='264.1' r='2.69pt' fill='#E41A1C' fill-opacity='1' stroke='#E41A1C' stroke-opacity='1' stroke-width='0.77' stroke-linejoin='round' stroke-linecap='round' data-id='TP' title='TP&amp;lt;br/&amp;gt;Year: 2022&amp;lt;br/&amp;gt;Loss ratio: 30.7%'/>\n   <circle id='svg_54e3e1cef77c8d8b_e7' cx='247.72' cy='216.95' r='2.69pt' fill='#E41A1C' fill-opacity='1' stroke='#E41A1C' stroke-opacity='1' stroke-width='0.77' stroke-linejoin='round' stroke-linecap='round' data-id='TP' title='TP&amp;lt;br/&amp;gt;Year: 2023&amp;lt;br/&amp;gt;Loss ratio: 49.5%'/>\n   <circle id='svg_54e3e1cef77c8d8b_e8' cx='371.54' cy='179.22' r='2.69pt' fill='#E41A1C' fill-opacity='1' stroke='#E41A1C' stroke-opacity='1' stroke-width='0.77' stroke-linejoin='round' stroke-linecap='round' data-id='TP' title='TP&amp;lt;br/&amp;gt;Year: 2024&amp;lt;br/&amp;gt;Loss ratio: 64.6%'/>\n   <circle id='svg_54e3e1cef77c8d8b_e9' cx='123.91' cy='191.32' r='2.69pt' fill='#377EB8' fill-opacity='1' stroke='#377EB8' stroke-opacity='1' stroke-width='0.77' stroke-linejoin='round' stroke-linecap='round' data-id='TPG' title='TPG&amp;lt;br/&amp;gt;Year: 2022&amp;lt;br/&amp;gt;Loss ratio: 59.7%'/>\n   <circle id='svg_54e3e1cef77c8d8b_e10' cx='247.72' cy='171.65' r='2.69pt' fill='#377EB8' fill-opacity='1' stroke='#377EB8' stroke-opacity='1' stroke-width='0.77' stroke-linejoin='round' stroke-linecap='round' data-id='TPG' title='TPG&amp;lt;br/&amp;gt;Year: 2023&amp;lt;br/&amp;gt;Loss ratio: 67.6%'/>\n   <circle id='svg_54e3e1cef77c8d8b_e11' cx='371.54' cy='151.15' r='2.69pt' fill='#377EB8' fill-opacity='1' stroke='#377EB8' stroke-opacity='1' stroke-width='0.77' stroke-linejoin='round' stroke-linecap='round' data-id='TPG' title='TPG&amp;lt;br/&amp;gt;Year: 2024&amp;lt;br/&amp;gt;Loss ratio: 75.8%'/>\n   <circle id='svg_54e3e1cef77c8d8b_e12' cx='123.91' cy='175.94' r='2.69pt' fill='#4DAF4A' fill-opacity='1' stroke='#4DAF4A' stroke-opacity='1' stroke-width='0.77' stroke-linejoin='round' stroke-linecap='round' data-id='CC' title='CC&amp;lt;br/&amp;gt;Year: 2022&amp;lt;br/&amp;gt;Loss ratio: 65.9%'/>\n   <circle id='svg_54e3e1cef77c8d8b_e13' cx='247.72' cy='193.76' r='2.69pt' fill='#4DAF4A' fill-opacity='1' stroke='#4DAF4A' stroke-opacity='1' stroke-width='0.77' stroke-linejoin='round' stroke-linecap='round' data-id='CC' title='CC&amp;lt;br/&amp;gt;Year: 2023&amp;lt;br/&amp;gt;Loss ratio: 58.8%'/>\n   <circle id='svg_54e3e1cef77c8d8b_e14' cx='371.54' cy='176' r='2.69pt' fill='#4DAF4A' fill-opacity='1' stroke='#4DAF4A' stroke-opacity='1' stroke-width='0.77' stroke-linejoin='round' stroke-linecap='round' data-id='CC' title='CC&amp;lt;br/&amp;gt;Year: 2024&amp;lt;br/&amp;gt;Loss ratio: 65.9%'/>\n   <circle id='svg_54e3e1cef77c8d8b_e15' cx='123.91' cy='175.97' r='2.69pt' fill='#984EA3' fill-opacity='1' stroke='#984EA3' stroke-opacity='1' stroke-width='0.77' stroke-linejoin='round' stroke-linecap='round' data-id='COMP_E' title='COMP_E&amp;lt;br/&amp;gt;Year: 2022&amp;lt;br/&amp;gt;Loss ratio: 65.9%'/>\n   <circle id='svg_54e3e1cef77c8d8b_e16' cx='247.72' cy='165.03' r='2.69pt' fill='#984EA3' fill-opacity='1' stroke='#984EA3' stroke-opacity='1' stroke-width='0.77' stroke-linejoin='round' stroke-linecap='round' data-id='COMP_E' title='COMP_E&amp;lt;br/&amp;gt;Year: 2023&amp;lt;br/&amp;gt;Loss ratio: 70.2%'/>\n   <circle id='svg_54e3e1cef77c8d8b_e17' cx='371.54' cy='143.18' r='2.69pt' fill='#984EA3' fill-opacity='1' stroke='#984EA3' stroke-opacity='1' stroke-width='0.77' stroke-linejoin='round' stroke-linecap='round' data-id='COMP_E' title='COMP_E&amp;lt;br/&amp;gt;Year: 2024&amp;lt;br/&amp;gt;Loss ratio: 79.0%'/>\n   <circle id='svg_54e3e1cef77c8d8b_e18' cx='123.91' cy='157.36' r='2.69pt' fill='#FF7F00' fill-opacity='1' stroke='#FF7F00' stroke-opacity='1' stroke-width='0.77' stroke-linejoin='round' stroke-linecap='round' data-id='COMP_N' title='COMP_N&amp;lt;br/&amp;gt;Year: 2022&amp;lt;br/&amp;gt;Loss ratio: 73.3%'/>\n   <circle id='svg_54e3e1cef77c8d8b_e19' cx='247.72' cy='109.9' r='2.69pt' fill='#FF7F00' fill-opacity='1' stroke='#FF7F00' stroke-opacity='1' stroke-width='0.77' stroke-linejoin='round' stroke-linecap='round' data-id='COMP_N' title='COMP_N&amp;lt;br/&amp;gt;Year: 2023&amp;lt;br/&amp;gt;Loss ratio: 92.2%'/>\n   <circle id='svg_54e3e1cef77c8d8b_e20' cx='371.54' cy='86.74' r='2.69pt' fill='#FF7F00' fill-opacity='1' stroke='#FF7F00' stroke-opacity='1' stroke-width='0.77' stroke-linejoin='round' stroke-linecap='round' data-id='COMP_N' title='COMP_N&amp;lt;br/&amp;gt;Year: 2024&amp;lt;br/&amp;gt;Loss ratio: 101.5%'/>\n   <line x1='49.63' y1='90.44' x2='445.82' y2='90.44' stroke='#999999' stroke-opacity='1' stroke-width='1.16' stroke-dasharray='4,4' stroke-linejoin='round' stroke-linecap='butt'/>\n   <line x1='49.63' y1='165.62' x2='445.82' y2='165.62' stroke='#B3B3B3' stroke-opacity='1' stroke-width='1.16' stroke-dasharray='1,3' stroke-linejoin='round' stroke-linecap='butt'/>\n  <\/g>\n  <g clip-path='url(#svg_54e3e1cef77c8d8b_c1)'>\n   <text x='25.05' y='281.68' font-size='7.2pt' font-family='Liberation Sans' fill='#4D4D4D' fill-opacity='1'>25%<\/text>\n   <text x='25.05' y='219.03' font-size='7.2pt' font-family='Liberation Sans' fill='#4D4D4D' fill-opacity='1'>50%<\/text>\n   <text x='25.05' y='156.38' font-size='7.2pt' font-family='Liberation Sans' fill='#4D4D4D' fill-opacity='1'>75%<\/text>\n   <text x='19.72' y='93.73' font-size='7.2pt' font-family='Liberation Sans' fill='#4D4D4D' fill-opacity='1'>100%<\/text>\n   <text x='113.24' y='301.64' font-size='7.2pt' font-family='Liberation Sans' fill='#4D4D4D' fill-opacity='1'>2022<\/text>\n   <text x='237.05' y='301.64' font-size='7.2pt' font-family='Liberation Sans' fill='#4D4D4D' fill-opacity='1'>2023<\/text>\n   <text x='360.86' y='301.64' font-size='7.2pt' font-family='Liberation Sans' fill='#4D4D4D' fill-opacity='1'>2024<\/text>\n   <text transform='translate(14.24,191.63) rotate(-90.00)' font-size='9pt' font-family='Liberation Sans'>Loss ratio<\/text>\n   <text x='463.75' y='123.56' font-size='9pt' font-family='Liberation Sans'>Policy type<\/text>\n   <line x1='465.48' y1='139.42' x2='479.31' y2='139.42' stroke='#E41A1C' stroke-opacity='1' stroke-width='2.13' stroke-linejoin='round' stroke-linecap='butt'/>\n   <circle cx='472.39' cy='139.42' r='2.69pt' fill='#E41A1C' fill-opacity='1' stroke='#E41A1C' stroke-opacity='1' stroke-width='0.77' stroke-linejoin='round' stroke-linecap='round'/>\n   <line x1='465.48' y1='156.7' x2='479.31' y2='156.7' stroke='#377EB8' stroke-opacity='1' stroke-width='2.13' stroke-linejoin='round' stroke-linecap='butt'/>\n   <circle cx='472.39' cy='156.7' r='2.69pt' fill='#377EB8' fill-opacity='1' stroke='#377EB8' stroke-opacity='1' stroke-width='0.77' stroke-linejoin='round' stroke-linecap='round'/>\n   <line x1='465.48' y1='173.98' x2='479.31' y2='173.98' stroke='#4DAF4A' stroke-opacity='1' stroke-width='2.13' stroke-linejoin='round' stroke-linecap='butt'/>\n   <circle cx='472.39' cy='173.98' r='2.69pt' fill='#4DAF4A' fill-opacity='1' stroke='#4DAF4A' stroke-opacity='1' stroke-width='0.77' stroke-linejoin='round' stroke-linecap='round'/>\n   <line x1='465.48' y1='191.26' x2='479.31' y2='191.26' stroke='#984EA3' stroke-opacity='1' stroke-width='2.13' stroke-linejoin='round' stroke-linecap='butt'/>\n   <circle cx='472.39' cy='191.26' r='2.69pt' fill='#984EA3' fill-opacity='1' stroke='#984EA3' stroke-opacity='1' stroke-width='0.77' stroke-linejoin='round' stroke-linecap='round'/>\n   <line x1='465.48' y1='208.54' x2='479.31' y2='208.54' stroke='#FF7F00' stroke-opacity='1' stroke-width='2.13' stroke-linejoin='round' stroke-linecap='butt'/>\n   <circle cx='472.39' cy='208.54' r='2.69pt' fill='#FF7F00' fill-opacity='1' stroke='#FF7F00' stroke-opacity='1' stroke-width='0.77' stroke-linejoin='round' stroke-linecap='round'/>\n   <text x='487.01' y='142.72' font-size='7.2pt' font-family='Liberation Sans'>TP<\/text>\n   <text x='487.01' y='160' font-size='7.2pt' font-family='Liberation Sans'>TPG<\/text>\n   <text x='487.01' y='177.28' font-size='7.2pt' font-family='Liberation Sans'>CC<\/text>\n   <text x='487.01' y='194.56' font-size='7.2pt' font-family='Liberation Sans'>COMP_E<\/text>\n   <text x='487.01' y='211.84' font-size='7.2pt' font-family='Liberation Sans'>COMP_N<\/text>\n   <text x='49.63' y='33.1' font-size='9pt' font-family='Liberation Sans' fill='#4D4D4D' fill-opacity='1'>Dashed line is break even at 100 percent. Dotted line is the 70 percent reference. Hover to highlight.<\/text>\n   <text x='49.63' y='15.88' font-size='10.8pt' font-weight='bold' font-family='Liberation Sans' fill='#2C5282' fill-opacity='1'>Loss ratio by policy type and year<\/text>\n  <\/g>\n <\/g>\n<\/svg>","js":null,"uid":"svg_54e3e1cef77c8d8b","ratio":1.744186046511628,"settings":{"tooltip":{"css":".tooltip_SVGID_ { padding:5px;background:black;color:white;border-radius:2px;text-align:left; ; position:absolute;pointer-events:none;z-index:9999;}","placement":"doc","opacity":0.9,"offx":10,"offy":10,"use_cursor_pos":true,"use_fill":false,"use_stroke":false,"delay_over":200,"delay_out":500},"hover":{"css":".hover_data_SVGID_ { stroke-width:2.5px;opacity:1; }","reactive":true,"nearest_distance":null,"linked":false},"hover_inv":{"css":".hover_inv_SVGID_ { opacity:0.2; }"},"hover_key":{"css":".hover_key_SVGID_ { fill:orange;stroke:black;cursor:pointer; }\ntext.hover_key_SVGID_ { stroke:none;fill:orange; }\ncircle.hover_key_SVGID_ { fill:orange;stroke:black; }\nline.hover_key_SVGID_, polyline.hover_key_SVGID_ { fill:none;stroke:orange; }\nrect.hover_key_SVGID_, polygon.hover_key_SVGID_, path.hover_key_SVGID_ { fill:orange;stroke:none; }\nimage.hover_key_SVGID_ { stroke:orange; }","reactive":true},"hover_theme":{"css":".hover_theme_SVGID_ { fill:orange;stroke:black;cursor:pointer; }\ntext.hover_theme_SVGID_ { stroke:none;fill:orange; }\ncircle.hover_theme_SVGID_ { fill:orange;stroke:black; }\nline.hover_theme_SVGID_, polyline.hover_theme_SVGID_ { fill:none;stroke:orange; }\nrect.hover_theme_SVGID_, polygon.hover_theme_SVGID_, path.hover_theme_SVGID_ { fill:orange;stroke:none; }\nimage.hover_theme_SVGID_ { stroke:orange; }","reactive":true},"select":{"css":".select_data_SVGID_ { fill:red;stroke:black;cursor:pointer; }\ntext.select_data_SVGID_ { stroke:none;fill:red; }\ncircle.select_data_SVGID_ { fill:red;stroke:black; }\nline.select_data_SVGID_, polyline.select_data_SVGID_ { fill:none;stroke:red; }\nrect.select_data_SVGID_, polygon.select_data_SVGID_, path.select_data_SVGID_ { fill:red;stroke:none; }\nimage.select_data_SVGID_ { stroke:red; }","type":"multiple","only_shiny":true,"selected":[],"linked":false},"select_inv":{"css":""},"select_key":{"css":".select_key_SVGID_ { fill:red;stroke:black;cursor:pointer; }\ntext.select_key_SVGID_ { stroke:none;fill:red; }\ncircle.select_key_SVGID_ { fill:red;stroke:black; }\nline.select_key_SVGID_, polyline.select_key_SVGID_ { fill:none;stroke:red; }\nrect.select_key_SVGID_, polygon.select_key_SVGID_, path.select_key_SVGID_ { fill:red;stroke:none; }\nimage.select_key_SVGID_ { stroke:red; }","type":"single","only_shiny":true,"selected":[]},"select_theme":{"css":".select_theme_SVGID_ { fill:red;stroke:black;cursor:pointer; }\ntext.select_theme_SVGID_ { stroke:none;fill:red; }\ncircle.select_theme_SVGID_ { fill:red;stroke:black; }\nline.select_theme_SVGID_, polyline.select_theme_SVGID_ { fill:none;stroke:red; }\nrect.select_theme_SVGID_, polygon.select_theme_SVGID_, path.select_theme_SVGID_ { fill:red;stroke:none; }\nimage.select_theme_SVGID_ { stroke:red; }","type":"single","only_shiny":true,"selected":[]},"zoom":{"min":1,"max":1,"duration":300,"default_on":false},"toolbar":{"position":"topright","pngname":"diagram","tooltips":null,"fixed":false,"hidden":[],"delay_over":200,"delay_out":500},"sizing":{"rescale":true,"width":1}}},"evals":[],"jsHooks":[]}</script>
```

:::
:::

:::

::: {.column width="38%"}
**Which policy to take note of**

1.  COMP_N rose from 73 percent to **102 percent**. This is the only product to cross break even.
2.  TP doubled from 30 percent to 65 percent. It is still safe.
3.  TPG rose from 60 percent to 80 percent.
4.  COMP_E rose from approximately 60 percent to 80 percent.
5.  CC held around 65 percent. It is the only product genuinely stable.
:::
:::::

::: {.callout-warning icon="false" appearance="minimal"}
Deterioration is broad based, however COMP_N is the only product paying out more in claims than it collects in premium. The next slide diagnoses why.
:::

::: notes
All five products deteriorated, however the scale differs sharply. COMP_N crossed the 100 percent break even line in 2024, meaning it now pays out more in claims than it collects in premium. TPG and COMP_E climbed from around 60 percent into the high seventies. TP doubled from 30 to 65 percent but remains profitable due to its low starting point. CC held around 65 percent throughout and is the only product maintaining stability. COMP_N is the immediate priority because it is the only product currently running at a loss.
:::

## 5 · COMP_N claims volume drives the loss, not severity

::::: columns
::: {.column width="62%"}

::: {.cell}
::: {.cell-output-display}
![](TH_EX01_Slides_files/figure-html/fig-comp-n-decomp-1.png){#fig-comp-n-decomp width=691.2}
:::
:::

:::

::: {.column width="38%"}
**Decomposing the loss ratio**

Loss ratio roughly equals frequency times severity divided by premium.

1.  Severity sits in a narrow €750 to €1,100 band across products.
2.  Frequency varies almost 8 times. This ranges from 0.13 for TP up to **1.04 for COMP_N**.
:::
:::::

::: {.callout-warning icon="false" appearance="minimal"}
The COMP_N product structure itself drives the loss. The ECDF analysis in the full report confirms the problem is a broad upward shift in mid sized claims, not catastrophic tail events.
:::

::: notes
Decomposing the loss ratio isolates whether COMP_N's problem is larger claims or more claims. The severity panel shows all five products sit in a tight band of €750 to €1,100 per claim, with COMP_N at the lower end. The frequency panel shows the divergence. COMP_N records 1.04 claims per exposure against 0.13 for TP, an eight fold difference. The mechanism is the absence of a customer excess. With no out of pocket cost for small claims, policyholders file every minor incident. The ECDF analysis in the full report confirms the distribution shift is concentrated in mid sized claims, not catastrophic events.
:::

## 6 · Bonus tier and senior loadings are under calibrated

::::: columns
::: {.column width="50%"}

::: {.cell}
::: {#fig-bonus-trend .cell-output-display}

```{=html}
<div class="girafe html-widget html-fill-item" id="htmlwidget-3bc3a6f507d5657eb146" style="width:100%;height:449px;"></div>
<script type="application/json" data-for="htmlwidget-3bc3a6f507d5657eb146">{"x":{"html":"<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n<svg xmlns='http://www.w3.org/2000/svg' xmlns:xlink='http://www.w3.org/1999/xlink' class='ggiraph-svg' role='graphics-document' id='svg_b1e72e9c65db6e82' viewBox='0 0 396 273.6'>\n <defs id='svg_b1e72e9c65db6e82_defs'>\n  <clipPath id='svg_b1e72e9c65db6e82_c1'>\n   <rect x='0' y='0' width='396' height='273.6'/>\n  <\/clipPath>\n  <clipPath id='svg_b1e72e9c65db6e82_c2'>\n   <rect x='45.51' y='38.1' width='345.01' height='178.01'/>\n  <\/clipPath>\n <\/defs>\n <g id='svg_b1e72e9c65db6e82_rootg' class='ggiraph-svg-rootg'>\n  <g clip-path='url(#svg_b1e72e9c65db6e82_c1)'>\n   <rect x='0' y='0' width='396' height='273.6' fill='#FFFFFF' fill-opacity='1' stroke='#FFFFFF' stroke-opacity='1' stroke-width='0.75' stroke-linejoin='round' stroke-linecap='round' class='ggiraph-svg-bg'/>\n   <rect x='0' y='-0' width='396' height='273.6' fill='#FFFFFF' fill-opacity='1' stroke='none'/>\n  <\/g>\n  <g clip-path='url(#svg_b1e72e9c65db6e82_c2)'>\n   <polyline points='45.51,203.70 390.52,203.70' fill='none' stroke='#EBEBEB' stroke-opacity='1' stroke-width='0.53' stroke-linejoin='round' stroke-linecap='butt'/>\n   <polyline points='45.51,170.35 390.52,170.35' fill='none' stroke='#EBEBEB' stroke-opacity='1' stroke-width='0.53' stroke-linejoin='round' stroke-linecap='butt'/>\n   <polyline points='45.51,137.00 390.52,137.00' fill='none' stroke='#EBEBEB' stroke-opacity='1' stroke-width='0.53' stroke-linejoin='round' stroke-linecap='butt'/>\n   <polyline points='45.51,103.65 390.52,103.65' fill='none' stroke='#EBEBEB' stroke-opacity='1' stroke-width='0.53' stroke-linejoin='round' stroke-linecap='butt'/>\n   <polyline points='45.51,70.29 390.52,70.29' fill='none' stroke='#EBEBEB' stroke-opacity='1' stroke-width='0.53' stroke-linejoin='round' stroke-linecap='butt'/>\n   <polyline points='45.51,187.03 390.52,187.03' fill='none' stroke='#EBEBEB' stroke-opacity='1' stroke-width='1.07' stroke-linejoin='round' stroke-linecap='butt'/>\n   <polyline points='45.51,153.67 390.52,153.67' fill='none' stroke='#EBEBEB' stroke-opacity='1' stroke-width='1.07' stroke-linejoin='round' stroke-linecap='butt'/>\n   <polyline points='45.51,120.32 390.52,120.32' fill='none' stroke='#EBEBEB' stroke-opacity='1' stroke-width='1.07' stroke-linejoin='round' stroke-linecap='butt'/>\n   <polyline points='45.51,86.97 390.52,86.97' fill='none' stroke='#EBEBEB' stroke-opacity='1' stroke-width='1.07' stroke-linejoin='round' stroke-linecap='butt'/>\n   <polyline points='45.51,53.62 390.52,53.62' fill='none' stroke='#EBEBEB' stroke-opacity='1' stroke-width='1.07' stroke-linejoin='round' stroke-linecap='butt'/>\n   <polyline points='110.20,216.11 110.20,38.10' fill='none' stroke='#EBEBEB' stroke-opacity='1' stroke-width='1.07' stroke-linejoin='round' stroke-linecap='butt'/>\n   <polyline points='218.02,216.11 218.02,38.10' fill='none' stroke='#EBEBEB' stroke-opacity='1' stroke-width='1.07' stroke-linejoin='round' stroke-linecap='butt'/>\n   <polyline points='325.83,216.11 325.83,38.10' fill='none' stroke='#EBEBEB' stroke-opacity='1' stroke-width='1.07' stroke-linejoin='round' stroke-linecap='butt'/>\n   <polyline id='svg_b1e72e9c65db6e82_e1' points='110.20,166.10 218.02,166.98 325.83,142.24' fill='none' stroke='#009E73' stroke-opacity='1' stroke-width='2.13' stroke-linejoin='round' stroke-linecap='butt' data-id='Good history' title='Good history'/>\n   <polyline id='svg_b1e72e9c65db6e82_e2' points='110.20,167.05 218.02,189.55 325.83,46.19' fill='none' stroke='#7F7F7F' stroke-opacity='1' stroke-width='2.13' stroke-linejoin='round' stroke-linecap='butt' data-id='Neutral' title='Neutral'/>\n   <polyline id='svg_b1e72e9c65db6e82_e3' points='110.20,208.02 218.02,91.20 325.83,76.40' fill='none' stroke='#D55E00' stroke-opacity='1' stroke-width='2.13' stroke-linejoin='round' stroke-linecap='butt' data-id='Bad history' title='Bad history'/>\n   <circle id='svg_b1e72e9c65db6e82_e4' cx='110.2' cy='166.1' r='2.67pt' fill='#009E73' fill-opacity='1' stroke='#009E73' stroke-opacity='1' stroke-width='0.71' stroke-linejoin='round' stroke-linecap='round' data-id='Good history' title='Good history&amp;lt;br/&amp;gt;Year: 2022&amp;lt;br/&amp;gt;Loss ratio: 66.3%'/>\n   <circle id='svg_b1e72e9c65db6e82_e5' cx='218.02' cy='166.98' r='2.67pt' fill='#009E73' fill-opacity='1' stroke='#009E73' stroke-opacity='1' stroke-width='0.71' stroke-linejoin='round' stroke-linecap='round' data-id='Good history' title='Good history&amp;lt;br/&amp;gt;Year: 2023&amp;lt;br/&amp;gt;Loss ratio: 66.0%'/>\n   <circle id='svg_b1e72e9c65db6e82_e6' cx='325.83' cy='142.24' r='2.67pt' fill='#009E73' fill-opacity='1' stroke='#009E73' stroke-opacity='1' stroke-width='0.71' stroke-linejoin='round' stroke-linecap='round' data-id='Good history' title='Good history&amp;lt;br/&amp;gt;Year: 2024&amp;lt;br/&amp;gt;Loss ratio: 73.4%'/>\n   <circle id='svg_b1e72e9c65db6e82_e7' cx='110.2' cy='167.05' r='2.67pt' fill='#7F7F7F' fill-opacity='1' stroke='#7F7F7F' stroke-opacity='1' stroke-width='0.71' stroke-linejoin='round' stroke-linecap='round' data-id='Neutral' title='Neutral&amp;lt;br/&amp;gt;Year: 2022&amp;lt;br/&amp;gt;Loss ratio: 66.0%'/>\n   <circle id='svg_b1e72e9c65db6e82_e8' cx='218.02' cy='189.55' r='2.67pt' fill='#7F7F7F' fill-opacity='1' stroke='#7F7F7F' stroke-opacity='1' stroke-width='0.71' stroke-linejoin='round' stroke-linecap='round' data-id='Neutral' title='Neutral&amp;lt;br/&amp;gt;Year: 2023&amp;lt;br/&amp;gt;Loss ratio: 59.2%'/>\n   <circle id='svg_b1e72e9c65db6e82_e9' cx='325.83' cy='46.19' r='2.67pt' fill='#7F7F7F' fill-opacity='1' stroke='#7F7F7F' stroke-opacity='1' stroke-width='0.71' stroke-linejoin='round' stroke-linecap='round' data-id='Neutral' title='Neutral&amp;lt;br/&amp;gt;Year: 2024&amp;lt;br/&amp;gt;Loss ratio: 102.2%'/>\n   <circle id='svg_b1e72e9c65db6e82_e10' cx='110.2' cy='208.02' r='2.67pt' fill='#D55E00' fill-opacity='1' stroke='#D55E00' stroke-opacity='1' stroke-width='0.71' stroke-linejoin='round' stroke-linecap='round' data-id='Bad history' title='Bad history&amp;lt;br/&amp;gt;Year: 2022&amp;lt;br/&amp;gt;Loss ratio: 53.7%'/>\n   <circle id='svg_b1e72e9c65db6e82_e11' cx='218.02' cy='91.2' r='2.67pt' fill='#D55E00' fill-opacity='1' stroke='#D55E00' stroke-opacity='1' stroke-width='0.71' stroke-linejoin='round' stroke-linecap='round' data-id='Bad history' title='Bad history&amp;lt;br/&amp;gt;Year: 2023&amp;lt;br/&amp;gt;Loss ratio: 88.7%'/>\n   <circle id='svg_b1e72e9c65db6e82_e12' cx='325.83' cy='76.4' r='2.67pt' fill='#D55E00' fill-opacity='1' stroke='#D55E00' stroke-opacity='1' stroke-width='0.71' stroke-linejoin='round' stroke-linecap='round' data-id='Bad history' title='Bad history&amp;lt;br/&amp;gt;Year: 2024&amp;lt;br/&amp;gt;Loss ratio: 93.2%'/>\n   <line x1='45.51' y1='53.62' x2='390.52' y2='53.62' stroke='#999999' stroke-opacity='1' stroke-width='1.07' stroke-dasharray='4,4' stroke-linejoin='round' stroke-linecap='butt'/>\n  <\/g>\n  <g clip-path='url(#svg_b1e72e9c65db6e82_c1)'>\n   <text x='22.96' y='190.05' font-size='6.6pt' font-family='Liberation Sans' fill='#4D4D4D' fill-opacity='1'>60%<\/text>\n   <text x='22.96' y='156.7' font-size='6.6pt' font-family='Liberation Sans' fill='#4D4D4D' fill-opacity='1'>70%<\/text>\n   <text x='22.96' y='123.35' font-size='6.6pt' font-family='Liberation Sans' fill='#4D4D4D' fill-opacity='1'>80%<\/text>\n   <text x='22.96' y='90' font-size='6.6pt' font-family='Liberation Sans' fill='#4D4D4D' fill-opacity='1'>90%<\/text>\n   <text x='18.07' y='56.65' font-size='6.6pt' font-family='Liberation Sans' fill='#4D4D4D' fill-opacity='1'>100%<\/text>\n   <text x='100.41' y='227.09' font-size='6.6pt' font-family='Liberation Sans' fill='#4D4D4D' fill-opacity='1'>2022<\/text>\n   <text x='208.23' y='227.09' font-size='6.6pt' font-family='Liberation Sans' fill='#4D4D4D' fill-opacity='1'>2023<\/text>\n   <text x='316.04' y='227.09' font-size='6.6pt' font-family='Liberation Sans' fill='#4D4D4D' fill-opacity='1'>2024<\/text>\n   <text transform='translate(13.05,150.96) rotate(-90.00)' font-size='8.25pt' font-family='Liberation Sans'>Loss ratio<\/text>\n   <text x='104.47' y='257.78' font-size='8.25pt' font-family='Liberation Sans'>Bonus<\/text>\n   <line x1='142.87' y1='254' x2='156.69' y2='254' stroke='#009E73' stroke-opacity='1' stroke-width='2.13' stroke-linejoin='round' stroke-linecap='butt'/>\n   <circle cx='149.78' cy='254' r='2.67pt' fill='#009E73' fill-opacity='1' stroke='#009E73' stroke-opacity='1' stroke-width='0.71' stroke-linejoin='round' stroke-linecap='round'/>\n   <line x1='216.48' y1='254' x2='230.3' y2='254' stroke='#7F7F7F' stroke-opacity='1' stroke-width='2.13' stroke-linejoin='round' stroke-linecap='butt'/>\n   <circle cx='223.39' cy='254' r='2.67pt' fill='#7F7F7F' fill-opacity='1' stroke='#7F7F7F' stroke-opacity='1' stroke-width='0.71' stroke-linejoin='round' stroke-linecap='round'/>\n   <line x1='270.51' y1='254' x2='284.33' y2='254' stroke='#D55E00' stroke-opacity='1' stroke-width='2.13' stroke-linejoin='round' stroke-linecap='butt'/>\n   <circle cx='277.42' cy='254' r='2.67pt' fill='#D55E00' fill-opacity='1' stroke='#D55E00' stroke-opacity='1' stroke-width='0.71' stroke-linejoin='round' stroke-linecap='round'/>\n   <text x='163.9' y='256.75' font-size='6pt' font-family='Liberation Sans'>Good history<\/text>\n   <text x='237.51' y='256.75' font-size='6pt' font-family='Liberation Sans'>Neutral<\/text>\n   <text x='291.54' y='256.75' font-size='6pt' font-family='Liberation Sans'>Bad history<\/text>\n   <text x='45.51' y='30.33' font-size='8.25pt' font-family='Liberation Sans' fill='#4D4D4D' fill-opacity='1'>Hover to highlight a tier<\/text>\n   <text x='45.51' y='14.55' font-size='9.9pt' font-weight='bold' font-family='Liberation Sans' fill='#2C5282' fill-opacity='1'>Bonus tier by year<\/text>\n  <\/g>\n <\/g>\n<\/svg>","js":null,"uid":"svg_b1e72e9c65db6e82","ratio":1.447368421052632,"settings":{"tooltip":{"css":".tooltip_SVGID_ { padding:5px;background:black;color:white;border-radius:2px;text-align:left; ; position:absolute;pointer-events:none;z-index:9999;}","placement":"doc","opacity":0.9,"offx":10,"offy":10,"use_cursor_pos":true,"use_fill":false,"use_stroke":false,"delay_over":200,"delay_out":500},"hover":{"css":".hover_data_SVGID_ { stroke-width:2.5px;opacity:1; }","reactive":true,"nearest_distance":null,"linked":false},"hover_inv":{"css":".hover_inv_SVGID_ { opacity:0.2; }"},"hover_key":{"css":".hover_key_SVGID_ { fill:orange;stroke:black;cursor:pointer; }\ntext.hover_key_SVGID_ { stroke:none;fill:orange; }\ncircle.hover_key_SVGID_ { fill:orange;stroke:black; }\nline.hover_key_SVGID_, polyline.hover_key_SVGID_ { fill:none;stroke:orange; }\nrect.hover_key_SVGID_, polygon.hover_key_SVGID_, path.hover_key_SVGID_ { fill:orange;stroke:none; }\nimage.hover_key_SVGID_ { stroke:orange; }","reactive":true},"hover_theme":{"css":".hover_theme_SVGID_ { fill:orange;stroke:black;cursor:pointer; }\ntext.hover_theme_SVGID_ { stroke:none;fill:orange; }\ncircle.hover_theme_SVGID_ { fill:orange;stroke:black; }\nline.hover_theme_SVGID_, polyline.hover_theme_SVGID_ { fill:none;stroke:orange; }\nrect.hover_theme_SVGID_, polygon.hover_theme_SVGID_, path.hover_theme_SVGID_ { fill:orange;stroke:none; }\nimage.hover_theme_SVGID_ { stroke:orange; }","reactive":true},"select":{"css":".select_data_SVGID_ { fill:red;stroke:black;cursor:pointer; }\ntext.select_data_SVGID_ { stroke:none;fill:red; }\ncircle.select_data_SVGID_ { fill:red;stroke:black; }\nline.select_data_SVGID_, polyline.select_data_SVGID_ { fill:none;stroke:red; }\nrect.select_data_SVGID_, polygon.select_data_SVGID_, path.select_data_SVGID_ { fill:red;stroke:none; }\nimage.select_data_SVGID_ { stroke:red; }","type":"multiple","only_shiny":true,"selected":[],"linked":false},"select_inv":{"css":""},"select_key":{"css":".select_key_SVGID_ { fill:red;stroke:black;cursor:pointer; }\ntext.select_key_SVGID_ { stroke:none;fill:red; }\ncircle.select_key_SVGID_ { fill:red;stroke:black; }\nline.select_key_SVGID_, polyline.select_key_SVGID_ { fill:none;stroke:red; }\nrect.select_key_SVGID_, polygon.select_key_SVGID_, path.select_key_SVGID_ { fill:red;stroke:none; }\nimage.select_key_SVGID_ { stroke:red; }","type":"single","only_shiny":true,"selected":[]},"select_theme":{"css":".select_theme_SVGID_ { fill:red;stroke:black;cursor:pointer; }\ntext.select_theme_SVGID_ { stroke:none;fill:red; }\ncircle.select_theme_SVGID_ { fill:red;stroke:black; }\nline.select_theme_SVGID_, polyline.select_theme_SVGID_ { fill:none;stroke:red; }\nrect.select_theme_SVGID_, polygon.select_theme_SVGID_, path.select_theme_SVGID_ { fill:red;stroke:none; }\nimage.select_theme_SVGID_ { stroke:red; }","type":"single","only_shiny":true,"selected":[]},"zoom":{"min":1,"max":1,"duration":300,"default_on":false},"toolbar":{"position":"topright","pngname":"diagram","tooltips":null,"fixed":false,"hidden":[],"delay_over":200,"delay_out":500},"sizing":{"rescale":true,"width":1}}},"evals":[],"jsHooks":[]}</script>
```

:::
:::

:::

::: {.column width="50%"}

::: {.cell}
::: {.cell-output-display}
![](TH_EX01_Slides_files/figure-html/fig-age-lr-1.png){#fig-age-lr width=528}
:::
:::

:::
:::::

The pricing model treats both risky history tiers and senior drivers as cheaper than what the data suggests. Bad history climbed from 53 percent to 93 percent in two years. The neutral tier overshot bad history in 2024 at 102 percent. Drivers aged 76 plus run at 102 percent while paying below average premium.

::: {.callout-warning icon="false" appearance="minimal"}
The loading structure across all three bonus tiers and the 76 plus age band needs review against recent claims data.
:::

::: notes
The left chart shows bad history climbed from 53 percent in 2022 to 93 percent in 2024. The neutral tier briefly overshot bad history in 2024 at 102 percent. In a well calibrated book, bad history should run a low loss ratio because its higher premium offsets elevated risk. The data shows loading have not kept pace with actual claims experience. The right charts reveals a second mis-calibration. The 76 plus age band runs a 102 percent loss ratio while paying below average premium. The segment is small at under one percent of the book, however the gap between price and risk is structural and requires correcting at the tariff level.
:::

## 7 · Bodily injury anchors the liability loss


::: {.cell}
::: {.cell-output-display}
![](TH_EX01_Slides_files/figure-html/fig-bodily-injury-1.png){#fig-bodily-injury width=1056}
:::
:::


Bodily injury averages approximately €4,940 per claim, which is roughly 4 times the next largest category. Although bodily injury represents only 9 percent of claims by count, its severity drives a disproportionate share of the liability loss.

::: {.callout-warning icon="false" appearance="minimal"}
The bodily injury sub tariff must track medical and legal inflation indicators independently.
:::

::: notes
Liability at €64M is the largest coverage line and runs a 74 percent loss ratio. Property damage at €26M runs 72 percent. These two lines together carry two thirds of total premium and both sit above the profitability threshold. The four smaller lines run between 40 and 52 percent and remain profitable. Within liability, a bodily injury claim averages €4,940, more than four times the next largest category. Bodily injury accounts for only 9 percent of claims by count, however its high individual cost drives a disproportionate share of the overall liability loss ratio. The sub tariff must be tracked against medical and legal cost inflation independently of the rest of liability.
:::

## 8 · The top 1 percent of policies drive half of losses

::::: columns
::: {.column width="56%"}

::: {.cell}
::: {.cell-output-display}
![](TH_EX01_Slides_files/figure-html/fig-lorenz-1.png){#fig-lorenz width=499.2}
:::
:::

:::

::: {.column width="44%"}
**Gini = 0.96**

A handful of policies drive virtually all of the loss.

| Slice                  | Share of total loss |
|------------------------|---------------------|
| Bottom 80% of policies | **\< 5%**           |
| Top 5% of policies     | **\> 80%**          |
| Top 1% of policies     | **\~ 50%**          |
:::
:::::

::: {.callout-warning icon="false" appearance="minimal"}
Reinsurance must be calibrated against the tail of the distribution, not the mean. A uniform rate increase would penalise the 80 percent of policies that contribute under 5 percent of losses while under loading the 1 percent driving half of them. Targeting is key.
:::

::: notes
The Gini coefficient of 0.96 is high even by motor insurance standards. The Lorenz curve hugs the floor for most of its length before climbing almost vertically at the right end. The bottom 80 percent of policies contribute under 5 percent of total incurred. The top 5 percent carry over 80 percent, and the top 1 percent alone carry roughly half. Reinsurance must be benchmarked against the top of the distribution, not the mean, because the tail generates the capital risk. Uniform rate increases are a poor response. They penalise the 80 percent of policyholders who contribute almost nothing to losses while leaving the loss driving tail under priced relative to actual cost.
:::

## 9 · The worst loss ratio is not the most volatile

::::: columns
::: {.column width="60%"}

::: {.cell}
::: {.cell-output-display}
![](TH_EX01_Slides_files/figure-html/fig-hop-1.gif){#fig-hop}
:::
:::

:::

::: {.column width="40%"}
**The volatility paradox**

Three segments are compared on incurred per claim (log scale).

1.  **COMP_N / Good history** — low CV at approximately 3.6. High claim volume averages out. The orange line barely moves.
2.  **CC / Good history** — moderate spread. The orange line shifts noticeably between frames.
3.  **CC / Neutral** — CV 18.6. The orange line swings widely. This is where reserve risk sits.
:::
:::::

::: {.callout-warning icon="false" appearance="minimal"}
Profitability and volatility are different problems demanding different tools. Pricing and excess design address profitability. Reinsurance and capital reserves address volatility. The CC and TPG segments warrant a reinsurance review against actual tail risk, separate from any pricing action on COMP_N.
:::

::: notes
Three segments are plotted: COMP_N good history, CC good history, and CC neutral. Blue points are individual policy incurred values on a log scale. The orange line is the sample mean for 25 randomly drawn policies per frame. COMP_N good history shows a tight point cloud and a nearly stationary orange line, confirming low CV. CC good history shows more spread. CC neutral shows the widest point cloud and the most erratic orange line, confirming CV of 18.6. The volatility is visible in how far the orange line moves between frames. COMP_N is a profitability problem. CC neutral is a capital reserve problem. They require different responses.
:::

## 10 · COMP_N and CC neutral together hold most loss making premium


::: {.cell}
::: {#fig-treemap .cell-output-display}

```{=html}
<div class="plotly html-widget html-fill-item" id="htmlwidget-af5041bb1e57ff1d4844" style="width:100%;height:460.8px;"></div>
<script type="application/json" data-for="htmlwidget-af5041bb1e57ff1d4844">{"x":{"visdat":{"90c813ed71af":["function () ","plotlyVisDat"]},"cur_data":"90c813ed71af","attrs":{"90c813ed71af":{"ids":{},"labels":{},"parents":{},"values":{},"branchvalues":"total","hovertext":{},"hoverinfo":"text","marker":{"colors":{},"colorscale":[[0,"#4393C3"],[0.5,"#FFFFBF"],[1,"#D6604D"]],"cmin":0.40000000000000002,"cmid":0.69999999999999996,"cmax":1.1000000000000001,"colorbar":{"title":"Loss ratio","tickformat":".0%"},"line":{"color":"white","width":2}},"textfont":{"color":"grey10","size":12},"alpha_stroke":1,"sizes":[10,100],"spans":[1,20],"type":"treemap"}},"layout":{"margin":{"b":5,"l":5,"t":25,"r":5},"hovermode":"closest","showlegend":false},"source":"A","config":{"modeBarButtonsToAdd":["hoverclosest","hovercompare"],"showSendToCloud":false},"data":[{"ids":["TP","TPG","CC","COMP_E","COMP_N","TP / Good history","TP / Neutral","TP / Bad history","TPG / Good history","TPG / Neutral","TPG / Bad history","CC / Good history","CC / Neutral","CC / Bad history","COMP_E / Good history","COMP_E / Neutral","COMP_E / Bad history","COMP_N / Good history","COMP_N / Neutral","COMP_N / Bad history"],"labels":["TP<br>55%","TPG<br>70%","CC<br>63%","COMP_E<br>74%","COMP_N<br>93%","Good history<br>57%","Neutral<br>34%","Bad history<br>18%","Good history<br>68%","Neutral<br>43%","Bad history<br>150%","Good history<br>63%","Neutral<br>87%","Bad history<br>61%","Good history<br>74%","Neutral<br>82%","Bad history<br>87%","Good history<br>95%","Neutral<br>93%","Bad history<br>77%"],"parents":["","","","","","TP","TP","TP","TPG","TPG","TPG","CC","CC","CC","COMP_E","COMP_E","COMP_E","COMP_N","COMP_N","COMP_N"],"values":[1009417.3272820208,8106185.6671268437,49715150.931117781,35335540.955570109,10212915.465813534,923095.88498725044,58521.118944203787,27800.323350566585,7516770.2806960447,300307.3314926654,289108.05493813351,47032743.274729356,1514864.5174689724,1167543.1389194487,33953077.382554136,774507.42820679757,607956.14480917272,8968076.3700695056,593403.29577038076,651435.79997364874],"branchvalues":"total","hovertext":["<b>TP<\/b><br>Premium: €1,009,417<br>Incurred: €551,123<br>Loss ratio: 54.6%","<b>TPG<\/b><br>Premium: €8,106,186<br>Incurred: €5,638,790<br>Loss ratio: 69.6%","<b>CC<\/b><br>Premium: €49,715,151<br>Incurred: €31,545,729<br>Loss ratio: 63.5%","<b>COMP_E<\/b><br>Premium: €35,335,541<br>Incurred: €26,128,628<br>Loss ratio: 73.9%","<b>COMP_N<\/b><br>Premium: €10,212,915<br>Incurred: €9,546,432<br>Loss ratio: 93.5%","<b>TP / Good history<\/b><br>Premium: €923,096<br>Incurred: €526,048<br>Loss ratio: 57.0%","<b>TP / Neutral<\/b><br>Premium: €58,521<br>Incurred: €20,142<br>Loss ratio: 34.4%","<b>TP / Bad history<\/b><br>Premium: €27,800<br>Incurred: €4,933<br>Loss ratio: 17.7%","<b>TPG / Good history<\/b><br>Premium: €7,516,770<br>Incurred: €5,076,331<br>Loss ratio: 67.5%","<b>TPG / Neutral<\/b><br>Premium: €300,307<br>Incurred: €129,867<br>Loss ratio: 43.2%","<b>TPG / Bad history<\/b><br>Premium: €289,108<br>Incurred: €432,592<br>Loss ratio: 149.6%","<b>CC / Good history<\/b><br>Premium: €47,032,743<br>Incurred: €29,524,158<br>Loss ratio: 62.8%","<b>CC / Neutral<\/b><br>Premium: €1,514,865<br>Incurred: €1,310,406<br>Loss ratio: 86.5%","<b>CC / Bad history<\/b><br>Premium: €1,167,543<br>Incurred: €711,164<br>Loss ratio: 60.9%","<b>COMP_E / Good history<\/b><br>Premium: €33,953,077<br>Incurred: €24,958,742<br>Loss ratio: 73.5%","<b>COMP_E / Neutral<\/b><br>Premium: €774,507<br>Incurred: €638,808<br>Loss ratio: 82.5%","<b>COMP_E / Bad history<\/b><br>Premium: €607,956<br>Incurred: €531,079<br>Loss ratio: 87.4%","<b>COMP_N / Good history<\/b><br>Premium: €8,968,076<br>Incurred: €8,488,668<br>Loss ratio: 94.7%","<b>COMP_N / Neutral<\/b><br>Premium: €593,403<br>Incurred: €554,332<br>Loss ratio: 93.4%","<b>COMP_N / Bad history<\/b><br>Premium: €651,436<br>Incurred: €503,431<br>Loss ratio: 77.3%"],"hoverinfo":["text","text","text","text","text","text","text","text","text","text","text","text","text","text","text","text","text","text","text","text"],"marker":{"color":"rgba(31,119,180,1)","colors":[0.54598143166807533,0.69561569282419522,0.63452947667216775,0.73944327795500242,0.93474107917131921,0.56987356899252739,0.34418398628372371,0.17744897920043295,0.6753340039586706,0.43244727777540731,1.496299716009541,0.62773626271473093,0.86503202457300921,0.60911144975608877,0.7350951228304381,0.82479206232923952,0.87354831271044531,0.94654280519181277,0.93415766638158437,0.77280251027094971],"colorscale":[[0,"#4393C3"],[0.5,"#FFFFBF"],[1,"#D6604D"]],"cmin":0.40000000000000002,"cmid":0.69999999999999996,"cmax":1.1000000000000001,"colorbar":{"title":"Loss ratio","tickformat":".0%"},"line":{"color":"white","width":2}},"textfont":{"color":"grey10","size":12},"type":"treemap","frame":null}],"highlight":{"on":"plotly_click","persistent":false,"dynamic":false,"selectize":false,"opacityDim":0.20000000000000001,"selected":{"opacity":1},"debounce":0},"shinyEvents":["plotly_hover","plotly_click","plotly_selected","plotly_relayout","plotly_brushed","plotly_brushing","plotly_clickannotation","plotly_doubleclick","plotly_deselect","plotly_afterplot","plotly_sunburstclick"],"base_url":"https://plot.ly"},"evals":[],"jsHooks":[]}</script>
```

:::
:::


::: {.callout-warning icon="false" appearance="minimal"}
The largest red tiles are CC neutral at 87 percent and the entire COMP_N block. Good history CC, which is the workhorse of the book, is the only large tile in blue. A rate correction touching only the bad history loading would miss most of the premium actually at risk. The neutral tier and COMP_N product structure both warrant equal attention.
:::

::: notes
The treemap encodes premium volume through tile area and loss ratio through colour. Blue sits below 70 percent. Red sits above. Two patterns stand out. The COMP_N block is uniformly red across all three bonus tiers, confirming the product structure drives the loss ratio regardless of customer segment. Within CC, the neutral bonus tile is the most prominent red region at 87 percent, while the good history tile is blue and is the largest single profitable region in the book. CC with bad history at 61 percent is actually one of the more profitable segments. A rate review touching only the bad history loading would miss the neutral tier and COMP_N, which together hold most of the loss making premium.
:::

## 11 · Five actions

:::::: columns
::: {.column width="60%"}
**1. Liability and property damage first.** These two coverage lines together hold two thirds of premium and both run above the 70 percent threshold. Any pricing review starts here.

**2. Bodily injury sub tariff.** Roughly 9 percent of claims by count but structurally 4 times the cost. Index against medical and legal inflation independently.

**3. Restructure COMP_N.** Reintroduce a customer excess or load the product by approximately 30 percent. This is the only product breaching break even.

**4. Recalibrate bonus loading at the cell level.** The neutral tier overshot bad history in 2024. Review by product crossed with tier, not by tier alone.

**5. Reinsurance against tail concentration.** Gini 0.96, top 1 percent of policies drive half of losses, CC neutral CV 18.6. Calibrate cover against the tail, not the mean.
:::

:::: {.column width="40%"}
::: {.callout-tip icon="false" title="What this avoids"}
A uniform rate increase would do three things:

1.  Penalise the 80 percent of policies that contribute under 5 percent of losses.
2.  Under load the 1 percent that drives half of total incurred.
3.  Miss the COMP_N structural issue entirely.

Targeting is key.
:::
::::
::::::

::: notes
The five actions follow from the evidence in priority order, matching Section 10.3 of the main report. Liability and property damage hold two thirds of premium and both exceed the threshold, so any pricing review starts there. The bodily injury sub tariff must track external inflation indicators independently. COMP_N is the only product breaching break even and the frequency decomposition points clearly to the missing excess as the mechanism. Bonus tier loadings need recalibration at the product by tier cell level, not by tier alone. Reinsurance cover should be reset against the tail concentration shown by the Gini coefficient and the HOP, not against the mean.
:::

# Thank you {.thank-you-slide background-color="#2C5282"}

::: thank-you-block
[Questions?]{.thank-you-title}

[Full report and code at ISSS608 Take home Exercise 1]{.thank-you-sub} [← Technical Report](TH_EX01.html){.title-back-link}
:::

::: notes
The full report carries the underlying statistical tests, the ECDF and violin diagnostics confirming where the COMP_N distribution shift sits, the parallel coordinates view of product profiles, and the claim cost drift chart by year and bonus tier. Three statistical checks anchor the recommendations. A Kruskal Wallis test confirms cost differences across policy types are real and not due to chance variation. A chi square test confirms quarterly payers claim significantly more often than annual payers. The Gini computation quantifies the tail concentration driving the reinsurance recommendation. Thanks you.
:::

