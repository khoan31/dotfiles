# dotfiles
These are my personal configuration files, which could be changed as I develop my environment on macOS.


## Installation
Clone repository to your local device and `cd` into it:
```shell
$ git clone https://github.com/sciovir/dotfiles.git
$ cd dotfiles
```

Then run the setup script:
```shell
$ source bootstrap
```

This might take quite a while as it needs to download and install several tools.

After script execution finish, reload your `zsh` config file:
```shell
$ source ~/.zshrc
```

Finally, launch Vim (ignore all errors) and install all plugins using `:PlugInstall`.


## Additional Notes
If you are using `ctags`, it's very useful if you put the `ctags` related files in `~/.gitignore` 
```
.DS_Store
tags
tags.lock
tags.temp
```

and specify it in global `.gitconfig` using `git config --global core.excludesFile '~/.gitignore'`, so you don't have to duel with git commit anymore


## References
[vim](https://www.vim.org)\
[tmux](https://github.com/tmux/tmux)
