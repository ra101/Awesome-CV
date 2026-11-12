.PHONY: all clean help version resume coverletter

CRI ?= $(shell which docker 2>/dev/null || which podman 2>/dev/null)
TEX = $(CRI) run --rm -v .:/data -w "/data" thomasweise/docker-texlive-full xelatex
GS = $(CRI) run --rm -v .:/data -w "/data" minidocks/ghostscript gs -dSAFER -dBATCH -dNOPAUSE -sDEVICE=pngalpha -r180
SOURCE_DIR = src
OUTPUT_DIR = output
RESUME_DIR = src/resume
RESUME_SRCS = $(shell find $(RESUME_DIR) -name '*.tex')

all: clean coverletter resume

help:
	$(TEX) -help

version:
	$(TEX) -version

resume: $(SOURCE_DIR)/resume.tex $(RESUME_SRCS)
	mkdir -p $(OUTPUT_DIR)
	rm -rf $(OUTPUT_DIR)/resume*
	$(TEX) -halt-on-error -output-directory=$(OUTPUT_DIR) $<
	$(GS) -sOutputFile=$(OUTPUT_DIR)/resume-%d.png $(OUTPUT_DIR)/resume.pdf

coverletter: $(SOURCE_DIR)/coverletter.tex
	mkdir -p $(OUTPUT_DIR)
	rm -rf $(OUTPUT_DIR)/coverletter*
	$(TEX) -halt-on-error -output-directory=$(OUTPUT_DIR) $<
	$(GS) -sOutputFile=$(OUTPUT_DIR)/coverletter-%d.png $(OUTPUT_DIR)/coverletter.pdf

cl: coverletter

clean:
	rm -rf $(OUTPUT_DIR)
