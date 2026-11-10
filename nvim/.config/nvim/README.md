	# Configuración de Neovim

Configuración en Lua, en un solo archivo (`init.lua`), pensada para aprender poco a poco.

## Requisitos

- Neovim 0.12 o superior (usa `vim.pack`, el gestor de plugins nativo, y el LSP nativo)
- `git`
- `fzf`
- `ripgrep` (`rg`), necesario para buscar texto
- `fd`, para buscar archivos
- `tree-sitter` (CLI), para instalar los parsers
- Una Nerd Font en la terminal, para los iconos

Servidores de lenguaje (LSP), deben estar en el `PATH`:

| Lenguaje | Servidor | Instalación |
|---|---|---|
| Go | `gopls` | `go install golang.org/x/tools/gopls@latest` |
| JavaScript / TypeScript | `vtsls` | `npm install -g @vtsls/language-server` |
| Lua | `lua-language-server` | `brew install lua-language-server` |

## Plugins

| Plugin | Uso |
|---|---|
| [fzf-lua](https://github.com/ibhagwan/fzf-lua) | Buscar archivos y texto |
| [nvim-tree.lua](https://github.com/nvim-tree/nvim-tree.lua) | Árbol de archivos |
| [lualine.nvim](https://github.com/nvim-lualine/lualine.nvim) | Barra de estado |
| [dracula.nvim](https://github.com/Mofiqul/dracula.nvim) | Tema de colores |
| [which-key.nvim](https://github.com/folke/which-key.nvim) | Popup con los atajos disponibles al presionar `Espacio` |
| [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim) | Marca en el margen las líneas cambiadas en git |
| [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) | Resaltado de sintaxis (rama `main`) |
| [nvim-web-devicons](https://github.com/nvim-tree/nvim-web-devicons) | Iconos de archivo en el árbol, la búsqueda y la barra |
| [mini.pairs](https://github.com/nvim-mini/mini.pairs) | Cierra automáticamente `(`, `[`, `{` y comillas |
| [conform.nvim](https://github.com/stevearc/conform.nvim) | Formatear al guardar |

Las versiones instaladas quedan fijadas en `nvim-pack-lock.json`.

## Fuente

Neovim en terminal usa la fuente de la terminal. Se define en la configuración de Ghostty (`~/Library/Application Support/com.mitchellh.ghostty/config.ghostty`):

```
font-family = JetBrainsMono Nerd Font Mono
font-size = 13
adjust-cell-height = 20%
macos-option-as-alt = left
```

## Atajos

La tecla leader es `Espacio`. Los atajos siguen los de LazyVim solo como referencia, para que sirvan igual en caso de cambiar en el futuro. Esta configuración no instala ni depende de LazyVim.

| Atajo | Acción |
|---|---|
| `Espacio Espacio` | Buscar archivos |
| `Espacio ff` | Buscar archivos |
| `Espacio /` | Buscar texto en el proyecto |
| `Espacio sg` | Buscar texto en el proyecto |
| `Espacio fg` | Buscar archivos de git (solo dentro de un repo git) |
| `Espacio e` | Abrir o cerrar el árbol de archivos |
| `Espacio qq` | Cerrar Neovim por completo (no guarda) |
| `Ctrl-s` | Guardar el archivo (modos normal, insert y visual) |
| `Ctrl-h` / `Ctrl-j` / `Ctrl-k` / `Ctrl-l` | Ir a la ventana izquierda / abajo / arriba / derecha |

Las búsquedas parten de la carpeta donde se abrió `nvim`, por lo que conviene abrirlo en la raíz del proyecto. LazyVim, en cambio, busca desde la raíz del proyecto.

El árbol se abre automáticamente al iniciar, con 40 columnas de ancho y el cursor en el archivo. No se abre en mensajes de commit de git.

### Archivos ocultos e ignorados

Por defecto no aparecen algunos archivos, como `.env.local`:

- **Árbol:** oculta los archivos listados en `.gitignore`. Los dotfiles sí se muestran.
- **Búsqueda de archivos:** oculta los dotfiles (los que empiezan con `.`) y los archivos listados en `.gitignore`.

Para verlos en el momento:

| Dónde | Tecla | Efecto |
|---|---|---|
| Árbol | `I` | Mostrar u ocultar archivos de `.gitignore` |
| Árbol | `H` | Mostrar u ocultar dotfiles |
| Búsqueda | `Alt-h` | Incluir dotfiles |
| Búsqueda | `Alt-i` | Incluir archivos de `.gitignore` |

En macOS, `Alt` es la tecla Option **izquierda**. Está activado en Ghostty con `macos-option-as-alt = left`, así que la Option derecha sigue escribiendo acentos y `ñ`.

Dentro del árbol, `Ctrl-k` muestra la información del archivo (atajo propio de nvim-tree) en lugar de cambiar de ventana.

### Dos editores en pantalla (ventanas divididas)

Mismos atajos que LazyVim:

| Atajo | Acción |
|---|---|
| `Espacio \|` | Dividir la ventana a la derecha (dos editores lado a lado) |
| `Espacio -` | Dividir la ventana abajo |
| `Espacio wd` | Cerrar la ventana actual |
| `Ctrl-h` / `Ctrl-j` / `Ctrl-k` / `Ctrl-l` | Moverse entre ventanas |

La ventana nueva muestra el mismo archivo. Para abrir otro, usar `Espacio Espacio` desde ella.

Equivalentes nativos: `:vsplit` o `Ctrl-w v` (derecha), `:split` o `Ctrl-w s` (abajo), `Ctrl-w c` (cerrar). Para abrir un archivo directamente en una división: `:vsplit ruta/al/archivo`.

## LSP y autocompletado

Usa el LSP nativo de Neovim (`vim.lsp.config` y `vim.lsp.enable`), sin `nvim-lspconfig` ni `mason`. Los errores aparecen al final de la línea.

| Atajo | Acción |
|---|---|
| `gd` | Ir a la definición |
| `K` | Ver documentación |
| `grn` | Renombrar |
| `grr` | Ver referencias |
| `gra` | Acciones de código |
| `gri` | Ir a la implementación |

Todos son nativos de Neovim excepto `gd`, que define esta configuración.

El menú de autocompletado se abre solo al escribir caracteres de activación del servidor, como `.`. Al escribir solo letras no se abre; LazyVim, en cambio, lo abre con cada tecla.

| Tecla | Acción |
|---|---|
| `Ctrl-n` / `Ctrl-p` | Siguiente / anterior sugerencia |
| `Ctrl-y` | Aceptar sugerencia (`Enter` no acepta) |
| `Ctrl-x Ctrl-o` | Abrir el menú manualmente |

En modo insert, `Ctrl-s` guarda el archivo, por lo que reemplaza el atajo nativo de Neovim que muestra la firma de la función.

## Opciones

| Opción | Efecto |
|---|---|
| `number` + `relativenumber` | La línea actual muestra su número real y las demás su distancia. `5j` baja 5 líneas, `3k` sube 3 |
| `cursorline` | Resalta la línea actual |
| `signcolumn = "yes"` | Margen fijo, para que no salte al aparecer errores o cambios de git |
| `ignorecase` + `smartcase` | Búsqueda sin distinguir mayúsculas, salvo que se escriba alguna |
| `showmode = false` | El modo se ve en la barra de estado, no abajo |
| `scrolloff = 8` | Mantiene 8 líneas visibles arriba y abajo del cursor |

Al copiar con `y`, el texto copiado parpadea brevemente.

## Formatear al guardar

Usa [conform.nvim](https://github.com/stevearc/conform.nvim) y se configura en `formatters_by_ft` dentro de `init.lua`.

| Lenguaje | Formateador | Cuándo |
|---|---|---|
| Go | `gopls` (gofmt) | Siempre |
| JS / TS / JSX / TSX | Prettier del proyecto (`node_modules`) | Solo si el proyecto tiene `.prettierrc` (u otro archivo de config de Prettier) o la clave `prettier` en `package.json` |
| Resto | Ninguno | Nunca |

Si un proyecto JS/TS no usa Prettier, el archivo se guarda sin cambios. El formateador de `vtsls` no se usa nunca, porque no es Prettier y generaría diffs con otro estilo.

## Comandos nativos de Neovim

Estos no dependen de esta configuración.

| Comando | Acción |
|---|---|
| `/palabra` | Buscar en el archivo actual |
| `n` / `N` | Resultado siguiente / anterior |
| `h` `j` `k` `l` | Moverse |
| `5j` / `3k` | Bajar 5 / subir 3 líneas (un número repite el comando) |
| `gcc` / `gc` (visual) | Comentar o descomentar |
| `Ctrl-w h` / `Ctrl-w l` | Cambiar de ventana |
| `:w` | Guardar |
| `:wa` | Guardar todos los archivos |
| `:q` | Cerrar la ventana actual |
| `:wqa` | Guardar todo y salir |
| `:qa!` | Salir descartando cambios |
| `:Tutor` | Tutorial interactivo |

## Cambiar o agregar atajos

Los atajos están al final de `init.lua`:

```lua
vim.keymap.set("n", "<leader>ff", fzf.files, { desc = "Find files" })
```

## Agregar plugins

Añadir la URL del repositorio a la lista de `vim.pack.add` en `init.lua` y reiniciar Neovim. Para actualizar los plugins instalados:

```vim
:lua vim.pack.update()
```
