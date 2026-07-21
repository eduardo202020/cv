[CmdletBinding()]
param(
    [switch]$Clean
)

$ErrorActionPreference = 'Stop'
$projectRoot = $PSScriptRoot
$outputDirectory = Join-Path $projectRoot 'output\pdf'
$pdfPath = Join-Path $outputDirectory 'eduardo-guevara-cv.pdf'
$generatedFiles = @(
    'eduardo-guevara-cv.aux',
    'eduardo-guevara-cv.log',
    'eduardo-guevara-cv.out',
    'eduardo-guevara-cv.xdv',
    'eduardo-guevara-cv.synctex.gz'
)

New-Item -ItemType Directory -Force -Path $outputDirectory | Out-Null

if ($Clean) {
    foreach ($fileName in $generatedFiles) {
        $path = Join-Path $outputDirectory $fileName
        if (Test-Path -LiteralPath $path) {
            Remove-Item -LiteralPath $path -Force
        }
    }
    if (Test-Path -LiteralPath $pdfPath) {
        Remove-Item -LiteralPath $pdfPath -Force
    }
}

$xelatex = Get-Command xelatex -ErrorAction SilentlyContinue
if (-not $xelatex) {
    $miktexCandidates = @(
        (Join-Path $env:LOCALAPPDATA 'Programs\MiKTeX\miktex\bin\x64\xelatex.exe'),
        (Join-Path $env:ProgramFiles 'MiKTeX\miktex\bin\x64\xelatex.exe')
    )
    $xelatexPath = $miktexCandidates | Where-Object { Test-Path -LiteralPath $_ } | Select-Object -First 1
    if ($xelatexPath) {
        $xelatex = Get-Item -LiteralPath $xelatexPath
    }
}

if ($xelatex) {
    $arguments = @(
        '-interaction=nonstopmode',
        '-halt-on-error',
        "-output-directory=$outputDirectory",
        '-jobname=eduardo-guevara-cv',
        'main.tex'
    )

    Push-Location $projectRoot
    try {
        1..2 | ForEach-Object {
            & $xelatex.Source @arguments
            if ($LASTEXITCODE -ne 0) {
                throw "XeLaTeX terminó con el código $LASTEXITCODE."
            }
        }
    }
    finally {
        Pop-Location
    }
}
else {
    $wsl = Get-Command wsl.exe -ErrorAction SilentlyContinue
    if (-not $wsl) {
        throw 'No se encontró XeLaTeX ni WSL. Instala TeX Live/MiKTeX o ejecuta el proyecto desde WSL.'
    }

    & $wsl.Source --cd $projectRoot sh scripts/build.sh
    if ($LASTEXITCODE -ne 0) {
        throw "La compilación mediante WSL terminó con el código $LASTEXITCODE."
    }
}

if (-not (Test-Path -LiteralPath $pdfPath) -or (Get-Item -LiteralPath $pdfPath).Length -eq 0) {
    throw 'La compilación terminó sin producir un PDF válido.'
}

Write-Host "CV generado en $pdfPath"
