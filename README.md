# Dotfiles

This repository contains some dotfiles for my working environment.

## usage
Simply place your dotfiles or dot-directories in the *files* directory. Execute *setup.sh*, to install all dotfiles and dot-directories in your home directory. If a file or directory already exists in your home directory, a backup will be created with the *.save* extension.

## template files
You can also use template files with variables, that can be replaced with user input during setup. A template file must be named with the *.tpl* extension. Template variables can be defined in the following way:
```
{{var: varname}}
```

Please see the following example:
```
[user]
        email = {{var: git email}}
        name = {{var: git name}}
```

During setup, all *.tpl* files will be searched for template variables, for every variable the user will be asked which value should be used, the template variables will be replaced with the user input and the *.tpl* extension will be removed.

