[CmdletBinding()]
param(
    [switch]$Clean
)

$ErrorActionPreference = 'Stop'
$projectRoot = $PSScriptRoot
$outputDirectory = Join-Path $projectRoot 'output\pdf'
$pdfPaths = @(
    (Join-Path $outputDirectory 'eduardo-guevara-cv.pdf'),
    (Join-Path $outputDirectory 'eduardo-guevara-cv-ats.pdf')
)
$generatedFiles = @(
    'eduardo-guevara-cv.aux',
    'eduardo-guevara-cv.log',
    'eduardo-guevara-cv.out',
    'eduardo-guevara-cv.xdv',
    'eduardo-guevara-cv.synctex.gz',
    'eduardo-guevara-cv-ats.aux',
    'eduardo-guevara-cv-ats.log',
    'eduardo-guevara-cv-ats.out',
    'eduardo-guevara-cv-ats.xdv',
    'eduardo-guevara-cv-ats.synctex.gz'
)

New-Item -ItemType Directory -Force -Path $outputDirectory | Out-Null

if ($Clean) {
    foreach ($fileName in $generatedFiles) {
        $path = Join-Path $outputDirectory $fileName
        if (Test-Path -LiteralPath $path) {
            Remove-Item -LiteralPath $path -Force
        }
    }
    foreach ($pdfPath in $pdfPaths) {
        if (Test-Path -LiteralPath $pdfPath) {
            Remove-Item -LiteralPath $pdfPath -Force
        }
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
    $builds = @(
        @{ Source = 'main.tex'; JobName = 'eduardo-guevara-cv' },
        @{ Source = 'main-ats.tex'; JobName = 'eduardo-guevara-cv-ats' }
    )

    Push-Location $projectRoot
    try {
        foreach ($build in $builds) {
            $arguments = @(
                '-interaction=nonstopmode',
                '-halt-on-error',
                "-output-directory=$outputDirectory",
                "-jobname=$($build.JobName)",
                $build.Source
            )
            1..2 | ForEach-Object {
                & $xelatex.Source @arguments
                if ($LASTEXITCODE -ne 0) {
                    throw "XeLaTeX terminó con el código $LASTEXITCODE al compilar $($build.Source)."
                }
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

foreach ($pdfPath in $pdfPaths) {
    if (-not (Test-Path -LiteralPath $pdfPath) -or (Get-Item -LiteralPath $pdfPath).Length -eq 0) {
        throw "La compilación terminó sin producir un PDF válido en $pdfPath."
    }
}

Write-Host "CVs generados en $outputDirectory"
