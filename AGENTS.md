# AGENTS.md

## Objetivo del repositorio

Este repositorio contiene el CV reproducible de Eduardo Guevara. El objetivo de cualquier cambio es conservar un documento profesional de dos páginas, compilable con XeLaTeX y visualmente coherente con las referencias incluidas.

Estas instrucciones se aplican a todo el repositorio.

## Fuentes de verdad

- `main.tex`: contenido, enlaces y orden de las secciones del CV visual.
- `main-ats.tex`: versión lineal de una página para sistemas ATS.
- `cvstyle.sty`: geometría, tipografía, colores y componentes visuales.
- `perfil.png`: fotografía de perfil.
- `src/apps/previews/`: capturas optimizadas que aparecen en el PDF.
- `src/apps/*.png`: capturas originales de las aplicaciones.
- `src/qr-portfolio.png`: QR del portafolio.
- `cv.pdf`: CV de referencia.
- `plantilla/`: plantilla LaTeX original de referencia.
- `output/pdf/eduardo-guevara-cv.pdf`: artefacto final que se entrega y versiona.
- `output/pdf/eduardo-guevara-cv-ats.pdf`: versión ATS que también se entrega y versiona.

No edites directamente el PDF generado. Modifica los fuentes y recompila.

## Restricciones de diseño

- Mantener exactamente dos páginas A4 en el CV visual y una página A4 en la versión ATS.
- Mantener la barra lateral celeste y la cabecera azul marino.
- Conservar la fotografía circular y enlazada al portafolio.
- Conservar alineados los iconos y textos de contacto e idiomas.
- Mantener las capturas de las apps alineadas con sus descripciones.
- Evitar texto superpuesto, cortado, desbordado o excesivamente comprimido.
- Mantener una separación vertical moderada entre títulos y contenido.
- Conservar visibles las secciones de cursos, formación y habilidades técnicas.
- No inventar experiencia, estudios, enlaces, fechas ni tecnologías.

Si se añade contenido, primero optimiza redacción y espacios existentes. No reduzcas la legibilidad solo para evitar una tercera página.

## Flujo de trabajo para agentes de IA

1. Lee `README.md`, `main.tex` y las macros relevantes de `cvstyle.sty`.
2. Inspecciona `git status` antes de editar y conserva cambios ajenos.
3. Realiza cambios de contenido visual en `main.tex`, sincroniza la información relevante en `main-ats.tex` y aplica cambios reutilizables de diseño en `cvstyle.sty`.
4. Compila con uno de los comandos soportados.
5. Revisa el log y confirma que no existan errores ni cajas desbordadas.
6. Renderiza visualmente ambas páginas y comprueba alineación, márgenes y legibilidad.
7. Verifica que el PDF tenga dos páginas y que los enlaces sigan activos.
8. Actualiza el PDF final versionado cuando cambie el documento.
9. Resume los cambios y las verificaciones realizadas.

## Compilación

Linux, macOS o WSL:

```bash
make verify
```

Windows PowerShell:

```powershell
.\build.ps1
```

Compilación limpia en PowerShell:

```powershell
.\build.ps1 -Clean
```

La compilación ejecuta XeLaTeX dos veces y genera `output/pdf/eduardo-guevara-cv.pdf`.

## Verificación mínima

Antes de considerar terminado un cambio:

- La compilación debe finalizar con código `0`.
- El PDF debe existir y no estar vacío.
- El CV visual debe tener exactamente dos páginas y la versión ATS exactamente una.
- El log no debe contener `LaTeX Error`, `Emergency stop` ni `Overfull`.
- Ambas páginas deben revisarse visualmente después del último cambio significativo.
- La fotografía, el QR, las capturas y los iconos deben renderizarse correctamente.
- Los archivos auxiliares deben permanecer ignorados por Git.

Los avisos `Underfull \hbox` conocidos pueden aceptarse si la revisión visual confirma que no hay defectos.

## Convenciones de contenido

- Idioma principal: español.
- Usar nombres de tecnologías con su capitalización oficial.
- Preferir frases breves, concretas y orientadas a resultados.
- Mantener consistencia entre experiencia, habilidades, stack y proyectos.
- Usar `\href` para enlaces y verificar sus destinos al cambiarlos.
- Escapar los caracteres especiales de LaTeX cuando corresponda.

## Convenciones de Git

- No versionar archivos auxiliares de LaTeX ni el directorio `tmp/`.
- Sí versionar el PDF final estable.
- Separar cambios de contenido/diseño, infraestructura y documentación cuando sea razonable.
- Usar mensajes de commit breves con prefijos como `feat:`, `fix:`, `build:`, `docs:` o `chore:`.
- No reescribir ni eliminar trabajo del usuario que no pertenezca a la tarea actual.
