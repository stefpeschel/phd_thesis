# Chapter 2: Microbiome data as statistical objects

This folder contains small reproducible examples and generated figures for the thesis chapter introducing microbiome data as statistical objects. The scripts are used to create chapter illustrations and overview figures, rather than to perform a full cohort analysis.

The folder is part of the larger thesis repository and uses the project-level R environment defined by `renv.lock` in the repository root.

## Folder Structure

```text
.
├── README.md                     → Chapter overview (this file)
├── CLR_mini_example.Rmd          → CLR example shown in Chapter 2
├── overview_figure_example.Rmd   → Small example analysis for overview figures
├── data/                         → Inputs and intermediate files for the examples
└── figures/                      → Figures
```

Rendered `.html` and `.md` files are kept next to the corresponding R Markdown files when they document outputs used in the thesis.

## Workflow

The folder contains two main R Markdown files:

1.  `overview_figure_example.Rmd`
    A small example analysis that creates realistic numerical values for the overview figures used throughout the thesis. It generates a mini microbiome count matrix, group labels, alpha diversity summaries, total-sum-scaled relative abundances, multiplicative zero replacement, and CLR-transformed values.

2.  `CLR_mini_example.Rmd`
    Produces the CLR example shown in Chapter 2. The script illustrates zero replacement before CLR transformation and compares multiplicative replacement with a simple additive offset.

The scripts are independent illustrative examples. They do not need to be run in sequence.

## Rendering

From the repository root, source `projthis_code.R` and run the line for the file you want to render, for example:

```r
render_rmd("ch02_microbiome_data/overview_figure_example.Rmd")
render_rmd("ch02_microbiome_data/CLR_mini_example.Rmd")
```

The files can also be rendered directly with `rmarkdown::render()`, but using `render_rmd()` is recommended because it renders each file from its own folder and preserves the relative `data/` and `figures/` paths used by `projthis`.

## Notes

- The examples are designed to produce stable, interpretable numbers for schematic figures.
- The generated data are toy data and are not intended as a simulation study.
- Rendered reports and figure outputs are retained when they document material used in the thesis.
