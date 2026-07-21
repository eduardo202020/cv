# CV de Eduardo Guevara

Repositorio reproducible del currículum de Eduardo Guevara, construido con XeLaTeX. Incluye los fuentes, recursos gráficos, referencias de diseño, scripts multiplataforma, el PDF final y una validación automática con GitHub Actions.

[Abrir el PDF compilado](output/pdf/eduardo-guevara-cv.pdf)

## Inicio rápido

Clona el repositorio y entra en su directorio:

```bash
git clone <URL-DEL-REPOSITORIO>
cd cv
```

En Linux, macOS o WSL:

```bash
make verify
```

En Windows PowerShell:

```powershell
.\build.ps1
```

El script de PowerShell utiliza XeLaTeX instalado en Windows. Si no lo encuentra, intenta compilar automáticamente mediante WSL. El resultado se escribe siempre en `output/pdf/eduardo-guevara-cv.pdf`.

## Requisitos

- XeLaTeX, incluido en TeX Live, MacTeX o MiKTeX.
- Paquetes LaTeX: `adjustbox`, `array`, `enumitem`, `eso-pic`, `fontawesome5`, `geometry`, `graphicx`, `hyperref`, `pgf`/TikZ, `tabularx` y `xcolor`.
- GNU Make y un shell POSIX para usar `make`; en Windows puede usarse directamente `build.ps1`.

En Ubuntu, Debian o WSL se pueden instalar las dependencias con:

```bash
sudo apt-get update
sudo apt-get install make texlive-xetex texlive-latex-extra texlive-fonts-extra
```

MiKTeX puede instalar automáticamente los paquetes faltantes. En TeX Live también pueden instalarse mediante `tlmgr` si la distribución es mínima.

## Comandos

```bash
make          # compila dos veces con XeLaTeX
make verify   # compila y comprueba que el PDF exista y no esté vacío
make clean    # elimina únicamente los artefactos generados
```

En PowerShell, `build.ps1 -Clean` limpia primero los archivos generados y vuelve a construir el documento.

## Estructura del repositorio

```text
.
|-- main.tex                         # contenido del CV
|-- cvstyle.sty                      # diseño y componentes reutilizables
|-- perfil.png                       # fotografía de perfil
|-- src/
|   |-- qr-portfolio.png             # QR enlazado al portafolio
|   `-- apps/
|       |-- previews/                # imágenes optimizadas usadas en el PDF
|       `-- *.png                    # capturas originales de las aplicaciones
|-- plantilla/                       # plantilla LaTeX original de referencia
|-- cv.pdf                           # CV original usado como referencia
|-- scripts/build.sh                 # compilación para Linux, macOS y WSL
|-- build.ps1                        # compilación para PowerShell o WSL
|-- Makefile                         # interfaz de construcción
|-- AGENTS.md                        # instrucciones para asistentes de IA
|-- .github/workflows/build-cv.yml   # compilación automática en GitHub
`-- output/pdf/eduardo-guevara-cv.pdf
```

## Editar y actualizar

1. Modifica el contenido en `main.tex`.
2. Ajusta colores, espaciado o componentes en `cvstyle.sty`.
3. Sustituye imágenes conservando sus rutas o actualiza `\graphicspath`.
4. Ejecuta `make verify` o `.\build.ps1`.
5. Revisa visualmente las dos páginas antes de publicar el PDF.

Los enlaces del documento son interactivos, incluida la fotografía de perfil, el QR y las capturas de las aplicaciones.

## Trabajo asistido por IA

`AGENTS.md` documenta las fuentes de verdad, restricciones visuales, comandos y verificaciones obligatorias para asistentes de IA. Un agente nuevo debe leer ese archivo antes de modificar el CV; así puede continuar el trabajo sin depender del contexto de una conversación anterior.

## Integración continua

Cada `push` y `pull request` ejecuta `.github/workflows/build-cv.yml` en Ubuntu. El flujo instala XeLaTeX, compila el CV y publica el PDF como artefacto descargable. Esto comprueba que el proyecto pueda reconstruirse fuera de la computadora original.

Enlaces principales: [portafolio web](https://portafolio-eduardo.vercel.app/), [código del portafolio](https://github.com/eduardo202020/portafolio-Tech) y [Papeleta Clara / satApp](https://github.com/eduardo202020/satApp).
