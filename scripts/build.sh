#!/usr/bin/env sh
set -eu

if ! command -v xelatex >/dev/null 2>&1; then
  echo "Error: no se encontró xelatex. Instala TeX Live con XeLaTeX." >&2
  exit 127
fi

project_root=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)
output_directory="$project_root/output/pdf"

mkdir -p "$output_directory"
cd "$project_root"

for build_spec in "main.tex:eduardo-guevara-cv" "main-ats.tex:eduardo-guevara-cv-ats"; do
  source_file=${build_spec%%:*}
  job_name=${build_spec#*:}
  pass=1
  while [ "$pass" -le 2 ]; do
    echo "Compilación XeLaTeX de $source_file $pass/2"
    xelatex \
      -interaction=nonstopmode \
      -halt-on-error \
      -output-directory="$output_directory" \
      -jobname="$job_name" \
      "$source_file"
    pass=$((pass + 1))
  done

  pdf="$output_directory/$job_name.pdf"
  if [ ! -s "$pdf" ]; then
    echo "Error: la compilación no produjo $pdf." >&2
    exit 1
  fi
  echo "CV generado en $pdf"
done
