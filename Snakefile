configfile: "config.yaml"

import csv

MODE = config["mode"]
RESULTS_DIR = config["results_dir"]
SAMPLE_SHEET = config["sample_sheet"]


def load_samples():
    with open(SAMPLE_SHEET) as handle:
        return list(csv.DictReader(handle, delimiter="\t"))


SAMPLES = load_samples()
PHASE1_SAMPLES = [
    row["sample_id"]
    for row in SAMPLES
    if row.get("include", "").strip().lower() == "yes"
]


# This file shows the basic project flow.
# Phase I uses the configured sample sheet to decide which sample(s) to run.
# Phase II and Phase III mainly continue in notebooks/analysis.Rmd.

rule all:
    input:
        phase_target()


def phase_target():
    if MODE == "phase1":
        return expand(
            f"{RESULTS_DIR}/{{sample}}/Solo.out/Gene/filtered/matrix.mtx",
            sample=PHASE1_SAMPLES,
        )
    if MODE == "phase2":
        return f"{RESULTS_DIR}/phase2_ready.txt"
    if MODE == "phase3":
        return f"{RESULTS_DIR}/phase3_ready.txt"
    raise ValueError(f"Unknown mode: {MODE}")


# Phase I:
# Add rules here for the small STARsolo workflow.
# The default Phase I run uses provided/mini_samples.tsv.
# You are not expected to process the full dataset in this project.
# Read the FASTQ paths from the sample sheet instead of hard-coding file names.

rule check_phase1_inputs:
    output:
        f"{RESULTS_DIR}/phase1_inputs_checked.txt"
    shell:
        "mkdir -p {RESULTS_DIR} && echo 'TODO: check mini data and references' > {output}"


rule run_starsolo_mini:
    input:
        f"{RESULTS_DIR}/phase1_inputs_checked.txt"
    output:
        expand(
            f"{RESULTS_DIR}/{{sample}}/Solo.out/Gene/filtered/matrix.mtx",
            sample=PHASE1_SAMPLES,
        )
    shell:
        "echo 'TODO: run STARsolo and write the filtered matrix files listed in rule all'"


# Phase II:
# Start from instructor-provided counts.
# The main work in this phase happens in notebooks/analysis.Rmd.

rule phase2_start:
    output:
        f"{RESULTS_DIR}/phase2_ready.txt"
    shell:
        "mkdir -p {RESULTS_DIR} && echo 'Open notebooks/analysis.Rmd for Phase II' > {output}"


# Phase III:
# Continue the same notebook for trajectory and transcription factor analysis.

rule phase3_start:
    output:
        f"{RESULTS_DIR}/phase3_ready.txt"
    shell:
        "mkdir -p {RESULTS_DIR} && echo 'Continue notebooks/analysis.Rmd for Phase III' > {output}"
