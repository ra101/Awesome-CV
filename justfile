set shell := ["bash", "-uc"]
set dotenv-load
src_dir := "src"
output_dir := "output"

cri := shell('''
    if command -v podman >/dev/null 2>&1; then
        echo podman
    elif command -v docker >/dev/null 2>&1; then
        echo docker
    else
        echo "ERROR: podman or docker is required" >&2
        exit 1
    fi
''')

mount_opt := if cri == "podman" { "-v $PWD:/data:Z" } else { "-v $PWD:/data" }
tex := cri + " run --rm " + mount_opt + " -w /data thomasweise/docker-texlive-full xelatex"
gs := cri + " run --rm --entrypoint /usr/bin/gs " + mount_opt + " -w /data minidocks/ghostscript -dSAFER -dBATCH -dNOPAUSE -sDEVICE=pngalpha -r180"

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
