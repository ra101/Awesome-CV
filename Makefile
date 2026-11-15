.PHONY: all clean help version resume coverletter cl

-include .env

ifeq ($(strip $(RESUME_PDF_NAME)),)
	RESUME_PDF_NAME := resume
endif

ifeq ($(strip $(COVER_PDF_NAME)),)
	COVER_PDF_NAME := coverletter
endif

CRI ?= $(shell which docker 2>/dev/null || which podman 2>/dev/null)
TEX = $(CRI) run --rm -v .:/data -w /data thomasweise/docker-texlive-full xelatex
GS = $(CRI) run --rm -v .:/data -w /data minidocks/ghostscript gs -dSAFER -dBATCH -dNOPAUSE -sDEVICE=pngalpha -r180
SOURCE_DIR = src
OUTPUT_DIR = output
RESUME_DIR = src/resume
RESUME_SRCS = $(shell find $(RESUME_DIR) -name '*.tex')

all: clean resume coverletter

help:
	$(TEX) -help

version:
	$(TEX) -version

resume: $(SOURCE_DIR)/resume.tex $(RESUME_SRCS)
	mkdir -p $(OUTPUT_DIR)
	find $(OUTPUT_DIR) -maxdepth 1 -iname "*resume*" -delete
	$(TEX) -halt-on-error -output-directory=$(OUTPUT_DIR) $<
	$(GS) -sOutputFile=$(OUTPUT_DIR)/resume-%d.png $(OUTPUT_DIR)/resume.pdf
	mv "$(OUTPUT_DIR)/resume.pdf" "$(OUTPUT_DIR)/$(RESUME_PDF_NAME).pdf"

coverletter: $(SOURCE_DIR)/coverletter.tex
	mkdir -p $(OUTPUT_DIR)
	find $(OUTPUT_DIR) -maxdepth 1 -iname "*cover*" -delete
	$(TEX) -halt-on-error -output-directory=$(OUTPUT_DIR) $<
	$(GS) -sOutputFile=$(OUTPUT_DIR)/coverletter-%d.png $(OUTPUT_DIR)/coverletter.pdf
	mv "$(OUTPUT_DIR)/coverletter.pdf" "$(OUTPUT_DIR)/$(COVER_PDF_NAME).pdf"

cl: coverletter

clean:
	rm -rf $(OUTPUT_DIR)
