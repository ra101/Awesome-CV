set shell := ["bash", "-uc"]
set dotenv-load
src_dir := "src"
output_dir := "output"

cri := shell('''
    if command -v docker >/dev/null 2>&1; then
        echo docker
    elif command -v podman >/dev/null 2>&1; then
        echo podman
    else
        echo "ERROR: docker or podman is required" >&2
        exit 1
    fi
''')

tex := cri + " run --rm -v .:/data -w /data thomasweise/docker-texlive-full xelatex"
gs := cri + " run --rm -v .:/data -w /data minidocks/ghostscript gs -dSAFER -dBATCH -dNOPAUSE -sDEVICE=pngalpha -r180"

default: all

all: clean coverletter resume

help:
    {{tex}} -help

version:
    {{tex}} -version

resume:
    mkdir -p {{output_dir}}
    find {{output_dir}} -maxdepth 1 -iname '*resume*' -delete
    {{tex}} -halt-on-error -output-directory={{output_dir}} {{src_dir}}/resume.tex
    {{gs}} -sOutputFile={{output_dir}}/resume-%d.png {{output_dir}}/resume.pdf
    mv {{output_dir}}/resume.pdf "{{output_dir}}/${RESUME_PDF_NAME:-resume}.pdf"

coverletter:
    mkdir -p {{output_dir}}
    find {{output_dir}} -maxdepth 1 -iname '*cover*' -delete
    {{tex}} -halt-on-error -output-directory={{output_dir}} {{src_dir}}/coverletter.tex
    {{gs}} -sOutputFile={{output_dir}}/coverletter-%d.png {{output_dir}}/coverletter.pdf
    mv {{output_dir}}/coverletter.pdf "{{output_dir}}/${COVER_PDF_NAME:-coverletter}.pdf"

cl: coverletter

clean:
    rm -rf {{output_dir}}
