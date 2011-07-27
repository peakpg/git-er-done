This project exists for a few reasons:

1. I have a terrible memory for command line syntax, so I want something that reduces the number of commands I have to remember to do things right.
1. I want to understand more how to configure git process flows (much like git-flow) does, but have more configurability (via Ruby)
2. Gives an interesting test case for my Thor talk at DCRUG and Arlington RUG.
3. Make doing the 'right' thing easy (i.e. feature branches should be simple. Smaller projects)
4. The world needs more gems with silly pop culture references.

## Git Process Flow

Here's what I want to be able to support

* Creating and closing feature branches should be simple.
* Small projects that can work from and merge to master shouldn't need a 'develop' branch.
* Should automatically squashing commits from feature branches into a single commit via rebase
* Support git-flow's Feature, hotfix, release branches to/from develop if necessary.
* Provide a nice discoverable CLI for doing this sort of thing.

### Target workflow

http://reinh.com/blog/2009/03/02/a-git-workflow-for-agile-teams.html

## Syntax

Possible ideas:

```
gd feature new_widget
gd done new_widget
gd hotfix
gd done 
```

## Todo

* Improve error messages for incorrectly supplied parameters. (i.e. gd feature)
* If you gd sync with unstaged changes, it should not switch branches. (It does)

## GitFlow Behavior

* Starting a gitflow project (git flow init)- Asks some questions (mostly about naming) and creates a develop branch to work in.
* Starting a feature - Creates a feature/name_of_feature branch
* Completing a feature - Merges the feature back into develop and deletes the branch


## Other Resources

http://grit.rubyforge.org/ - A Ruby wrapper around git: Might be useful for more indepth interaction with git.
http://stackoverflow.com/questions/5294069/best-way-to-create-an-executable-for-a-gem-using-rake - Minimum work to make a CLI bin file.