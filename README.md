Git 'Er Done is a ruby tool for automating common git operations. It's similiar in concept to git flow (https://github.com/nvie/gitflow) but implements a simpler branching model.

## Reasons for this project

This project exists for a few reasons:

1. I have a terrible memory for command line syntax, so I want something that reduces the number of commands I have to remember to do things right.
2. I want to understand more how to configure git process flows (much like git-flow) does, but have more configurability (via Ruby)
3. Gives an interesting test case for my Thor talk at DCRUG and Arlington RUG.
4. Make doing the 'right' thing easy (i.e. feature branches should be simple. Smaller projects)

## Installation

```
gem install git_er_done
```

This makes the `gd` command available on your system.

## Syntax

Things you can do:

```
gd - Lists all available commands.
gd help <command> - Get help for a specific command.
gd feature new_widget - Creates a new feature branch with the name 'new_widget'.
gd done new_widget  - Completes a feature branch with the name 'new_widget' (Commit, squash, merge and delete branch).
gd done - Completes the current feature branch you are on.
gd squash - Condenses multiple commits for the current branch into a single commit.
gd sync - Brings your branch up to date with the latest version (Use before finishing a feature)
```

## Goals

Here's what I want to be able to support

* Creating and closing feature branches should be simple.
* Small projects that can work from and merge to master shouldn't need a 'develop' branch.
* Should automatically squashing commits from feature branches into a single commit via rebase
* Support git-flow's Feature, hotfix, release branches to/from develop if necessary.
* Provide a nice discoverable CLI for doing this sort of thing.

## Todo

* Improve error messages for incorrectly supplied parameters. (i.e. gd feature)
* If you gd sync with unstaged changes, it should not switch branches. (It does, which is probably wrong)
* Figure out how to unit test this.
* Better error checking (merges failing may cause problems)

## References

http://reinh.com/blog/2009/03/02/a-git-workflow-for-agile-teams.html - Target workflow
http://grit.rubyforge.org/ - A Ruby wrapper around git: Might be useful for more indepth interaction with git.
http://stackoverflow.com/questions/5294069/best-way-to-create-an-executable-for-a-gem-using-rake - Minimum work to make a CLI bin file.