Git 'Er Done is a ruby tool for automating common git operations. It's similar in concept to git flow (https://github.com/nvie/gitflow) but is designed for small teams. It's branching model is quite a bit simpler but still makes it easy to keep an organized Git repository.

## Reasons for this project

This project exists for a few reasons:

1. Encourage good habits: Practices like rebasing, feature branches and squashing commits make code repositories easy to follow.
1. Make 'Right way' easy: Doing proper git workflows require a lot of commands. We should script them to make them easy.
1. Exploration: I want to understand more how to configure git process flows (much like git-flow) does, but have more configurability (via Ruby)

## Installation

```
gem install git_er_done
```

This makes the `gd` command available on your system. In 0.5.1, I have added some other alias commands `gi` and `gti` just to try them out for style.


## What you get

### 1. Starting Feature Branches

When you work locally, it's helpful to work in a feature branch. To create a feature branch, you would normally do something like:

```
git checkout -b features/new_widget
```

With GitErDone, you can type the following to get the same thing:

```
$ gd feature new_widget
````

Really, the only benefit from this is prefixing branches with features/, which provides some context to your branch names. (Later, we might add bugs/ and/or 'remote-features')

### 2. Finishing a feature 

After you are done with your feature, you might want to do a few things:

1. Squash your feature's commits into a single commit
1. Checkout master
1. Merge your changes
1. Delete the branch

That's a lot of commands to remember and type. Instead, you can do:

```
gd done
```

This will trigger an [interactive rebase](http://book.git-scm.com/4_interactive_rebasing.html) including all changes made since master. You can choose to squash them (or not). Then it will merge your changes with master, and delete your branch.

Pretty simple.

### 3. Keeping in Sync with the master using rebase

Unless you are working by yourself, its likely you may start a feature and before you can merge and push your changes, somebody is going to push changes. It's going to be a lot easier to reconcile your changes sooner than later. With GitErDone, you can do the following when working in your feature branch.

```
(features/new_widget)$ gd sync
```

This will do the following:

1. Checkout master and then pull
1. Checkout your branch
1. Rebase your branch from master. See [rebasing](http://book.git-scm.com/4_rebasing.html) for more info.

Syncing frequently will help avoid nasty merges later.

## Syntax

Command reference:

```
gd - Lists all available commands.
gd help <command> - Get help for a specific command.
gd feature new_widget - Creates a new feature branch with the name 'new_widget'.
gd done new_widget  - Completes a feature branch with the name 'new_widget' (Commit, squash, merge and delete branch).
gd done - Completes the current feature branch you are on.
gd squash - Condenses multiple commits for the current branch into a single commit.
gd sync - Brings your branch up to date with the latest version (Use before finishing a feature)
gd inception - Determines the original branch(es) your current commit came from.
```

## Goals

Here's what I want to be able to support

* Creating and closing feature branches should be simple.
* Small projects that can work from and merge to master shouldn't need a 'develop' branch. (i.e. git-flow)
* Should automatically squashing commits from feature branches into a single commit via rebase
* Support git-flow's Feature, hotfix, release branches to/from develop if necessary.
* Provide a nice discoverable CLI for doing this sort of thing.

## Todo

* Improve error messages for incorrectly supplied parameters. (i.e. gd feature)
* If you gd sync with unstaged changes, it should not switch branches. (It does, which is probably wrong)
* Better error checking (merges failing may cause problems)

## References

* Interactive Rebasing (i.e. Squashing Commits) - http://book.git-scm.com/4_interactive_rebasing.html
* Target workflow - http://reinh.com/blog/2009/03/02/a-git-workflow-for-agile-teams.html -
* http://stackoverflow.com/questions/5294069/best-way-to-create-an-executable-for-a-gem-using-rake - Minimum work to make a CLI bin file.