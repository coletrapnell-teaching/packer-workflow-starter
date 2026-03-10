# GENOME569A Project

## Introduction

This repository is the starter codebase for your term project in **GENOME569A**. Over the course of the quarter, you will construct a **Snakemake pipeline** that downloads, processes, and analyzes real single-cell RNA-seq data from the paper:

> *Packer et al., Science, 2019 – "A lineage-resolved molecular atlas of C. elegans embryogenesis"*

Your final goal is to **reproduce Figure 1A** from this paper: a **UMAP projection of ~85,000 C. elegans embryonic cells**, generated using **Monocle 3** from the single-cell RNA-seq data.

You’ll build this project in **three core phases**, each aligned with classroom topics and designed to deepen your computational skills. By the end, you’ll have built a **fully reproducible workflow**, version-controlled with Git, documented in RMarkdown, and guided (not dictated!) by AI tools like **GitHub Copilot**.

---

## Project Plan

### ✅ Phase I: Obtaining Raw Sequence Data

In this phase, we’ll use a **custom Python command-line tool**, `fetch_fastqs.py`, to download raw sequencing data from the **Sequence Read Archive (SRA)** based on a **GEO accession number**. The tool uses `GEOparse` to retrieve metadata and `fasterq-dump` from the **SRA Toolkit** to fetch and extract FASTQ files.

You will also begin integrating this tool into your broader **Snakemake workflow**, preparing for downstream analysis.

#### What the tool does
- Accepts a **GEO accession** (e.g. `GSE126954`) via CLI.
- Queries metadata using `GEOparse`.
- Extracts **SRR run IDs**.
- Downloads reads using `prefetch`.
- Converts `.sra` to `.fastq.gz` using `fasterq-dump`.
- Saves all results under a structured directory (one subfolder per SRR).

#### Example usage
```bash
python fetch_fastqs.py \
    --geo GSE126954 \
    --output_dir data/raw \
    --prefetch_dir /path/to/cache
```

#### Important Tips!
- Downloading SRA files can take a long time and extra copies take up a lot of space. You can find the files already available at: `/net/trapnell/vol1/home/coletrap/tmp/srafiles/`. You should use this directory as your `prefetch_dir` to avoid downloading additional copies.
- Extracting FASTQ files from SRA files can take a long time. While you are building and testing your workflow, consider adding options that limit the number of samples that your workflow processes, so you can test the whole thing on a smaller amount of data before scaling up.

#### 📁 Recommended Directory Structure
```
data/
└── raw/
    ├── SRR12345678/
    │   ├── SRR12345678_1.fastq.gz
    │   └── SRR12345678_2.fastq.gz
    └── SRR12345679/
        ├── ...
```

#### ✅ Snakemake Integration (Optional in Phase I)
To integrate this script with Snakemake, wrap it in a rule like:

```yaml
rule fetch_fastqs:
    output:
        "data/raw/{srr}/{srr}_1.fastq.gz",
        "data/raw/{srr}/{srr}_2.fastq.gz"
    params:
        geo="GSE126954"
    shell:
        "python scripts/fetch_fastqs.py --geo {params.geo} --output_dir data/raw"
```

Then define your SRR IDs in `config.yaml` or load them dynamically.

#### 🔧 Recommended Tools
- [`GEOparse`](https://geoparse.readthedocs.io/en/latest/)
- [`sra-tools`](https://github.com/ncbi/sra-tools) (`prefetch`, `fasterq-dump`)
- `argparse` and `subprocess` for building robust CLI tools
- GitHub Copilot to scaffold functions, write docstrings, or debug subprocess calls

#### 🧠 Learning Goals
- Automating data acquisition from public repositories
- Writing reusable CLI tools
- Structuring raw data for reproducibility
- Working with metadata programmatically
- Beginning pipeline integration via Snakemake

---

### ✅ Phase II: Aligning Reads

Next, you'll write a **Snakemake workflow** that aligns your downloaded reads using **STARsolo**, generating a **cell-by-gene expression matrix** in the style of 10X Genomics data.

This will include quality control steps (e.g., FastQC), optional read trimming, and genome indexing.

#### Tips
- STARsolo requires a pre-built **C. elegans genome index**.
- You'll need to set `--soloType CB_UMI_Simple` and pass barcode/UMI lengths.
- Keep your pipeline modular and parameterized via `config.yaml`.

#### Recommended Steps & Tools
- `STAR` (version ≥ 2.7)
- `Snakemake` for pipeline management
- Organize output by sample: `results/{sample}/Solo.out/Gene/filtered/`
- Use Copilot to scaffold Snakemake rules and shell commands

---

### ✅ Phase III: Exploratory Data Analysis

We will use **Monocle 3** in R to load the expression matrices, preprocess the data, perform dimensionality reduction and clustering, and generate a **UMAP plot** similar to **Figure 1A** from the paper.

The goal is to explore how cell identity and developmental time are represented in the data, and to understand Monocle’s methods for trajectory inference.

#### Tips
- Use the `load_cellranger_data()` function to load STARsolo output.
- Focus on `preprocess_cds()`, `reduce_dimension()`, `cluster_cells()`, and `plot_cells()`.
- Compare your results to Figure 1A in terms of structure and number of clusters.

#### Recommended Steps & Tools
- R packages: `monocle3`, `ggplot2`
- Use `RMarkdown` to document your analysis in a reproducible way
- Store your analysis in `notebooks/figure1a_analysis.Rmd`
- Use Copilot to scaffold R code, then compare against Monocle documentation

---

## General Tips for Success

- **Use Git early and often.** Commit small changes and push regularly.
- **Write modular code.** Break tasks into small scripts or rules that are easy to test.
- **Use GitHub Copilot as a collaborator**, not a crutch. Ask it for help, but verify everything.
- **Keep your config files organized** — they'll make your workflow more scalable.
- **Don't skip documentation.** Use `README`s, comments, and RMarkdown to explain your work.
- **Ask questions in Slack.** We’re here to help.

---

This project will serve as a real-world example of how to build, debug, and scale a full analysis pipeline. You’ll walk away with a **reproducible, AI-augmented bioinformatics project** that you can use as a template in future work.

Happy hacking! 🧬💻✨


# Reference Materials

This directory contains reference material from:

Packer et al. 2019  
"A lineage-resolved molecular atlas of C. elegans embryogenesis"

Students will primarily use **Table_S4.tsv** in Phase II and Phase III.

## packer_table_s4.tsv

This table contains lineage annotations and marker genes used in the paper.

In this project you will use Table S4 to:

- identify clusters corresponding to specific cell types
- locate the IL1/IL2 lineage branch
- verify marker genes during cluster annotation

This file is provided as reference material and should **not be modified**.