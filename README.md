# random_colorscheme.vim

Load a random colorscheme for every new (neo)vim session.

## Installation

- This plugin needs (neo)vim to be compiled with either python2 or python3.
- Use your favourite plugin manager to load this plugin.
- `Vim-Plug`:
  ```
  Plug 'Sammyalhashe/random_colorscheme.vim'
  ```

## Usage

- The default behaviour of this plugin is to open a random colorscheme for every new instance of (neo)vim.
  - If you want to disable this behaviour, in your `vimrc` or `init.vim` put `let g:random_scheme = 0`.
  - NOTE: if you disable this default option, make sure to set the `g:default_theme` to your favourite colorscheme. By default, `g:default_theme='default'`, which is the default vim colorscheme.

## Airline Integration

- This plugin can also select a random Airline theme as well.
- By default, this option is turned off as it is assumed most people don't have Airline.
- If you want this option, put `let g:airline_integration = 1` in your configuration file.
- It only loads the default `dark` Airline theme at first. See the below options to change this behaviour.

## Options

| Option                              | Description                                                                                                                | Default                                       |
| ----------------------------------- | -------------------------------------------------------------------------------------------------------------------------- | --------------------------------------------- |
| `g:random_disabled`                 | Disables the plugin                                                                                                        | 0                                             |
| `g:random_scheme`                   | Opens (neo)vim with a random colorscheme                                                                                   | 1                                             |
| `g:airline_integration`             | Opens (neo)vim with a random Airline theme                                                                                 | 0                                             |
| `g:default_theme`                   | If `g:random_scheme=0`, this is the colorscheme that will open                                                             | 'default'                                     |
| `g:default_theme_airline`           | If `g:random_scheme=0`, this is the Airline theme that will open                                                           | 'dark'                                        |
| `g:available_colorschemes`          | The list of colorschemes that will randomly load                                                                           | ['blue', 'delek', 'desert', 'morning', 'ron'] |
| `g:available_airline_themes`        | The list of Airline themes that will randomly load                                                                         | ['dark']                                      |
| `g:colorscheme_airline_correlation` | If you like similar colorschemes and Airline themes to load together, place them in the same indices in the above options. | 0                                             |

NOTE: the `g:colorscheme_airline_correlation` option will not work unless `len(g:available_colorschemes) == len(g:available_airline_themes)`.
