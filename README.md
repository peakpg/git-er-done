This project exists for a few reasons:

1. I want to understand more how to configure git process flows (much like git-flow) does, but have more configurablity (via Ruby)
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

## Syntax

Possible ideas:

gd feature new_widget
gd done new_widget
gd hotfix
gd done 

## Other Resources

http://grit.rubyforge.org/ - A Ruby wrapper around git: Might be useful for more indepth interaction with git.