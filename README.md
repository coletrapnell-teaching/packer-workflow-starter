# Genome 569 Project: Developmental Branching in the C. elegans Embryo

In this project you will analyze single-cell RNA-seq data from the paper:

**Packer et al. (2019)**  
*A lineage-resolved molecular atlas of C. elegans embryogenesis at single-cell resolution.*

The dataset contains thousands of cells from developing **C. elegans embryos**.  
Each cell is assigned to a lineage in the worm developmental tree.

Your goal is to investigate how a shared progenitor population diverges into two different neuronal fates:

**AWA vs ASG ciliated neurons**

By the end of the project you will reproduce an analysis similar in spirit to **Figure 3D of Packer et al.**, showing how transcription factors change as cells commit to different fates.

---

# Overview of the Project

The project has three phases.

Phase I focuses on **workflow mechanics**.  
Phase II focuses on **clustering and cell type identification**.  
Phase III focuses on **developmental trajectory analysis**.

Each phase builds toward answering the biological question.
Your main work product will be a single evolving notebook:

`notebooks/analysis.Rmd`

---

# Biological Question

How do cells from a shared progenitor state diverge into **AWA** and **ASG** neurons?

To answer this, you will:

1. Identify the AWA/ASG branch in the full dataset  
2. Separate the two daughter fates  
3. Examine transcription factor dynamics during the divergence  

---

# Phase I — Running a Single-Cell Workflow

In Phase I you will run a small version of the RNA-seq processing workflow.

The goal of this phase is **not biology yet**.  
Instead, you will learn how sequencing reads become a gene-by-cell count matrix.

The workflow uses **STARsolo**, a widely used tool for processing single-cell RNA-seq data.

You will run the workflow on a **small example dataset** so that it finishes quickly.

### What you will do

- examine the workflow structure  
- run the pipeline  
- generate a gene-by-cell count matrix  
- understand what each step of the workflow produces  

### Key output

A **count matrix** describing gene expression in individual cells.

---

# Phase II — Identifying the AWA/ASG Branch

In Phase II you will analyze the **full dataset** using counts that have already been generated.

Your task is to identify the region of the dataset corresponding to the **AWA/ASG developmental branch**.

### What you will do

You will perform a typical single-cell RNA-seq analysis:

- quality control  
- normalization  
- dimensionality reduction (PCA / UMAP)  
- clustering  
- marker gene analysis  

Your goal is to identify clusters corresponding to the **AWA** and **ASG** neuron lineages.

### Using Table S4

The paper provides lineage annotations and marker genes in the file:

reference/packer_table_s4.tsv

You should use this table to:

- identify marker genes  
- interpret clusters  
- justify your lineage assignments  

Some useful markers include:

AWA markers  
- odr-7  
- nhr-216  
- ocr-1  

ASG markers include genes such as  
- gcy-11  
- capa-1  

You should verify these markers in your analysis.

### Key result

By the end of Phase II you should be able to identify:

- the **AWA lineage**  
- the **ASG lineage**  
- the **shared progenitor region**

You should record this work in the same notebook that you will continue in Phase III:

`notebooks/analysis.Rmd`

---

# Phase III — Trajectory Analysis

In Phase III you will analyze how cells transition from the shared progenitor state to the two daughter fates.

You will examine how **transcription factor expression changes along this developmental trajectory**.

### What you will do

- focus on cells from the AWA/ASG branch  
- perform trajectory or pseudotime analysis  
- identify genes that change along the branch  
- focus on **transcription factors**

### Final figure

Your final result will be a **heatmap showing transcription factor dynamics** along the AWA vs ASG branch.

This figure should be conceptually similar to **Figure 3D from the Packer paper**, but applied to a different lineage.

This phase should extend the same notebook used in Phase II:

`notebooks/analysis.Rmd`

---

# Repository Structure

Keep the repository simple.

Main files and folders:

- `README.md`
- `reference/packer_table_s4.tsv`
- `provided/`
- `notebooks/analysis.Rmd`
- `results/`

Use `notebooks/analysis.Rmd` as your main electronic lab notebook.
If you save output files, keep them to a small number of plain files under `results/`,
such as TSV tables or PDF figures.

---

# What You Should Focus On

The goal of this project is **not to build software infrastructure**.

Instead, focus on:

- understanding the workflow  
- interpreting clusters  
- connecting gene expression to developmental biology  

By the end of the project you should be able to explain:

- where AWA and ASG neurons come from  
- how their transcriptional programs diverge  
- which transcription factors may control that divergence  
