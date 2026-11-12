set shell := ["bash", "-uc"]

src_dir := "src"
output_dir := "output"
resume_dir := src_dir + "/resume"

cri := shell('''
    if command -v docker >/dev/null 2>&1; then
        echo docker
    elif command -v podman >/dev/null 2>&1; then
        echo podman
    else
        echo "ERROR: docker or podman is required"
    fi
''')
tex := cri + " run --rm -v .:/data -w \"/data\" thomasweise/docker-texlive-full xelatex"
gs := cri + " run --rm -v .:/data -w \"/data\" minidocks/ghostscript gs -dSAFER -dBATCH -dNOPAUSE -sDEVICE=pngalpha -r180"

default: all

all: clean coverletter resume

help:
    {{tex}} -help

version:
    {{tex}} -version

resume:
    mkdir -p {{output_dir}}
    rm -rf {{output_dir}}/resume.*
    {{tex}} -halt-on-error -output-directory={{output_dir}} {{src_dir}}/resume.tex
    {{gs}} -sOutputFile={{output_dir}}/resume-%d.png {{output_dir}}/resume.pdf

coverletter:
    mkdir -p {{output_dir}}
    rm -rf {{output_dir}}/coverletter.*
    {{tex}} -halt-on-error -output-directory={{output_dir}} {{src_dir}}/coverletter.tex
    {{gs}} -sOutputFile={{output_dir}}/coverletter-%d.png {{output_dir}}/coverletter.pdf

cl: coverletter

clean:
    rm -rf {{output_dir}}
