//imports
#import "@preview/physica:0.9.7": *
//#import "@preview/equate:0.3.2": equate  //disabled: conflicts with ctheorems, see note_template
#import "prob_lib.typ": *
#import "@preview/frame-it:1.2.0": *
#import "@preview/ctheorems:2.0.0": *
#import thm-themes.ams: *

//shaded background for theorem-like environments
#let thm-shade = (fill: luma(240), stroke: 0.5pt + blue, inset: 8pt, radius: 3pt)
#let theorem = theorem.with(block-args: thm-shade)
#let lemma = lemma.with(block-args: thm-shade)
#let proposition = proposition.with(block-args: thm-shade)
#let corollary = corollary.with(block-args: thm-shade)
#let conjecture = conjecture.with(block-args: thm-shade)
#let definition = definition.with(block-args: thm-shade + (stroke: 0.5pt + red))

//heading spacing settings
//set heading-space to false to use Typst's default spacing above headings
#let heading-space = true
#let heading-space-amount = 2em

//template function
#let note_template(note_title: "Nothing",
                   author: "Edward Kim",
                   doc,) = {

    //math numbering custom rules: numbered by (section.eq_num), only labelled equations.
    //DISABLED: equate (0.3.2 and 0.3.3) loops forever ("maximum show rule depth exceeded")
    //together with ctheorems' thm-rules on any display equation containing lr(...) or
    //auto-sized brackets. Re-enable only after confirming the two packages work together.
    //show: equate.with(breakable: true, number-mode: "label")
    //show heading.where(level:1): it => {
    //  counter(math.equation).update(0)
    //  it
    //}
    //set math.equation(numbering: it => {
    //  let section_num = counter(heading.where(level: 1)).at(here()).first()
    //  if section_num > 0 {
    //    numbering("(1.1)", section_num - 1, it)
    //  } else {
    //    numbering("(1.1)", section_num, it)
    //  }
    //})
    show: thm-rules.with(qed-symbol: $square$)

    //document settings
    set document(title: note_title,
                 author: author)

    //set page fields
    set page(
        paper: "us-letter",
        header: align(right)[
            #context document.title
        ],
        numbering: "1",
    )

    let docu_info = [
          #set align(center + horizon)
          #set text(size: 15pt)

          #block(
            below: 2em,
          [ #author  

            Last Modified:  #strong[#datetime.today().display()]]
          )
    ]

    //set title fields
    show title: set align(center + horizon)
    show title: set text(size: 30pt)

    //heading settings
    set heading(numbering: "1.")
    show heading.where(level: 1): set align(center)
    show heading.where(level: 1): smallcaps
    show heading.where(level: 1): set block(below: 2em)
    show heading: set block(above: heading-space-amount) if heading-space

    show: frame-style(styles.boxy)

    title()
    docu_info

    pagebreak()
    outline()
    pagebreak()

    doc
}
