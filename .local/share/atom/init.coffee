atom.commands.add 'atom-text-editor',
  'user:toggle-vim-mode-plus': (event) ->
    if atom.packages.isPackageDisabled("vim-mode-plus")
      atom.packages.enablePackage("vim-mode-plus")
    else
      atom.packages.disablePackage("vim-mode-plus")
