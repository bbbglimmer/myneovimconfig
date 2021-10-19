# Antovim
> Super-simple vim plugin for cycling through antonyms/words related to word under cursor

![Example usage](screencast.gif)
## Installing

Assuming you are using [pathogen.vim](https://github.com/tpope/vim-pathogen), simply copy and paste these commands:

```bash
cd ~/.vim/bundle
git clone git://github.com/jwarby/antovim.git
```

## Usage

The plugin provides a single command, `Antovim`, which will replace the word under the cursor if there is a
matching word within a list of substitutions. eg, with your cursor over the word **true**, typing `:Antovim`
will swap **true** for **false**.

There is also a default mapping of `gs` included by the plugin.
## Lists

To view the list of global substitutions (applicable for file types), run `:echo g:antovim_definitions`.

To view the list of substitutions for the current buffer, which may have additional substitutions defined
if there is a list for the current file type, type `:echo b:antovim_definitions`.  File types which have
extra lists (so far) are:
  - css, less
  - html, ejs

Take a look at `[plugin/antovim.vim](https://github.com/jwarby/antovim/blob/master/plugin/antovim.vim)` for the lists.

### Extending lists

To extend the global list, you can simply extend it.  The example below shows how you would add swaps for 'yes', 'no'
and 'maybe':

```vim
:let g:antovim_definitions = extend(g:antovim_definitions, [['yes', 'no', 'maybe']])
```

Extending the buffer-specific list is the same, except you use `b:antovim_definitions` instead of
`g:antovim_definitions`.

#### Custom definition lists

Alternatively, you can also define a global `custom_antovim_definitions` variable which the dictionary will be
extended with at runtime.  You could combine this file type autocommands to add your own definitions per file, eg

```vim
autocmd FileType javascript let g:custom_antovim_definitions = [
  \   ['this', 'that']
  \ ]
```

You could then stick that in a file and source that file from within your `.vimrc`.
