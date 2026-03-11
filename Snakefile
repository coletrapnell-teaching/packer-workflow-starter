configfile: "config.yaml"

MODE = config["mode"]
RESULTS_DIR = config["results_dir"]


# This file shows the basic project flow.
# Phase I uses workflow rules here.
# Phase II and Phase III mainly continue in notebooks/analysis.Rmd.

rule all:
    input:
        phase_target()


def phase_target():
    if MODE == "phase1":
        return f"{RESULTS_DIR}/phase1_counts_done.txt"
    if MODE == "phase2":
        return f"{RESULTS_DIR}/phase2_ready.txt"
    if MODE == "phase3":
        return f"{RESULTS_DIR}/phase3_ready.txt"
    raise ValueError(f"Unknown mode: {MODE}")


# Phase I:
# Add rules here for the small STARsolo workflow on the provided example data.
# A simple Phase I layout is:
# - check that the mini data and references exist
# - run STARsolo on the mini dataset
# - write one small file in results/ when the phase is done

rule check_phase1_inputs:
    output:
        f"{RESULTS_DIR}/phase1_inputs_checked.txt"
    shell:
        "mkdir -p {RESULTS_DIR} && echo 'TODO: check mini data and references' > {output}"


rule run_starsolo_mini:
    input:
        f"{RESULTS_DIR}/phase1_inputs_checked.txt"
    output:
        f"{RESULTS_DIR}/phase1_counts_done.txt"
    shell:
        "echo 'TODO: run STARsolo on the mini dataset' > {output}"


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
