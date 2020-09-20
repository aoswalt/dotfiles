Retrieving the status of a repository with submodules can take a long time.

Aliases
-------

### Git

# `g` is short for `git`.

### Branch

# `gb` lists, creates, renames, and deletes branches.
# `gbc` creates a new branch.
# `gbl` lists branches and their commits. (also `gbv`)
# `gbL` lists all local and remote branches and their commits.
# `gbr` renames a branch. (also `gbm`)
# `gbR` renames a branch even if the new branch name already exists. (also
    `gbM`)
# `gbs` lists branches and their commits with ancestry graphs.
# `gbS` lists local and remote branches and their commits with ancestry
    graphs.
# `gbV` lists branches with more verbose information about their commits.
# `gbx` deletes a branch. (also `gbd`)
# `gbX` deletes a branch irrespective of its merged status. (also `gbD`)


### Commit

# `gc` records changes to the repository.
# `gca` stages all modified and deleted files.
# `gcm` records changes to the repository with the given message.
# `gcS` records changes to the repository. (Signed)
# `gcSa` stages all modified and deleted files. (Signed)
# `gcSm` records changes to the repository with the given message. (Signed)
# `gcam` stages all modified and deleted files, and records changes to the repository with the given message.
# `gco` checks out a branch or paths to work tree.
# `gcO` checks out hunks from the index or the tree interactively.
# `gcf` amends the tip of the current branch using the same log message as *HEAD*.
# `gcSf` amends the tip of the current branch using the same log message as *HEAD*. (Signed)
# `gcF` amends the tip of the current branch.
# `gcSF` amends the tip of the current branch. (Signed)
# `gcp` applies changes introduced by existing commits.
# `gcP` applies changes introduced by existing commits without committing.
# `gcr` reverts existing commits by reverting patches and recording new
     commits.
# `gcR` removes the *HEAD* commit.
# `gcs` displays various types of objects.
# `gcsS` displays commits with GPG signature.
# `gcl` lists lost commits.
# `gcy` displays commits yet to be applied to upstream in the short format.
# `gcY` displays commits yet to be applied to upstream.

### Conflict

# `gCl` lists unmerged files.
# `gCa` adds unmerged file contents to the index.
# `gCe` executes merge-tool on all unmerged file.
# `gCo` checks out our changes for unmerged paths.
# `gCO` checks out our changes for all unmerged paths.
# `gCt` checks out their changes for unmerged paths.
# `gCT` checks out their changes for all unmerged paths.

### Data

# `gd` displays information about files in the index and the work tree.
# `gdc` lists cached files.
# `gdx` lists deleted files.
# `gdm` lists modified files.
# `gdu` lists untracked files.
# `gdk` lists killed files.
# `gdi` lists ignored files.

### Fetch

# `gf` downloads objects and references from another repository.
# `gfa` downloads objects and references from all remote repositories.
# `gfc` clones a repository into a new directory.
# `gfcr` clones a repository into a new directory including all submodules.
# `gfm` fetches from and merges with another repository or local branch.
# `gfr` fetches from and rebases on another repository or local branch.

### Flow

# `gFi` is short for `git flow init`

#### Feature

# `gFf` is short for `git flow feature`
# `gFfl` is short for `git flow feature list`
# `gFfs` is short for `git flow feature start`
# `gFff` is short for `git flow feature finish`
# `gFfp` is short for `git flow feature publish`
# `gFft` is short for `git flow feature track`
# `gFfd` is short for `git flow feature diff`
# `gFfr` is short for `git flow feature rebase`
# `gFfc` is short for `git flow feature checkout`
# `gFfm` is short for `git flow feature pull`
# `gFfx` is short for `git flow feature delete`

#### Bugfix

# `gFb` is short for `git flow bugfix`
# `gFbl` is short for `git flow bugfix list`
# `gFbs` is short for `git flow bugfix start`
# `gFbf` is short for `git flow bugfix finish`
# `gFbp` is short for `git flow bugfix publish`
# `gFbt` is short for `git flow bugfix track`
# `gFbd` is short for `git flow bugfix diff`
# `gFbr` is short for `git flow bugfix rebase`
# `gFbc` is short for `git flow bugfix checkout`
# `gFbm` is short for `git flow bugfix pull`
# `gFbx` is short for `git flow bugfix delete`

#### Release

# `gFl` is short for `git flow release`
# `gFll` is short for `git flow release list`
# `gFls` is short for `git flow release start`
# `gFlf` is short for `git flow release finish`
# `gFlp` is short for `git flow release publish`
# `gFlt` is short for `git flow release track`
# `gFld` is short for `git flow release diff`
# `gFlr` is short for `git flow release rebase`
# `gFlc` is short for `git flow release checkout`
# `gFlm` is short for `git flow release pull`
# `gFlx` is short for `git flow release delete`

#### Hotfix

# `gFh` is short for `git flow hotfix`
# `gFhl` is short for `git flow hotfix list`
# `gFhs` is short for `git flow hotfix start`
# `gFhf` is short for `git flow hotfix finish`
# `gFhp` is short for `git flow hotfix publish`
# `gFht` is short for `git flow hotfix track`
# `gFhd` is short for `git flow hotfix diff`
# `gFhr` is short for `git flow hotfix rebase`
# `gFhc` is short for `git flow hotfix checkout`
# `gFhm` is short for `git flow hotfix pull`
# `gFhx` is short for `git flow hotfix delete`

#### Support

# `gFs` is short for `git flow support`
# `gFsl` is short for `git flow support list`
# `gFss` is short for `git flow support start`
# `gFsf` is short for `git flow support finish`
# `gFsp` is short for `git flow support publish`
# `gFst` is short for `git flow support track`
# `gFsd` is short for `git flow support diff`
# `gFsr` is short for `git flow support rebase`
# `gFsc` is short for `git flow support checkout`
# `gFsm` is short for `git flow support pull`
# `gFsx` is short for `git flow support delete`

### Grep

# `gg` displays lines matching a pattern.
# `ggi` displays lines matching a pattern ignoring case.
# `ggl` lists files matching a pattern.
# `ggL` lists files that are not matching a pattern.
# `ggv` displays lines not matching a pattern.
# `ggw` displays lines matching a pattern at word boundary.

### Index

# `gia` adds file contents to the index.
# `giA` adds file contents to the index interactively.
# `giu` adds file contents to the index (updates only known files).
# `gid` displays changes between the index and a named commit (diff).
# `giD` displays changes between the index and a named commit (word diff).
# `gii` temporarily ignore differences in a given file.
# `giI` unignore differences in a given file.
# `gir` resets the current HEAD to the specified state.
# `giR` resets the current index interactively.
# `gix` removes files/directories from the index (recursively).
# `giX` removes files/directories from the index (recursively and forced).

### Log

# `gl` displays the log.
# `gls` displays the stats log.
# `gld` displays the diff log.
# `glo` displays the one line log.
# `glg` displays the graph log.
# `glb` displays the brief commit log.
# `glc` displays the commit count for each contributor in descending order.
# `glS` displays the log and checks the validity of signed commits.

### Merge

# `gm` joins two or more development histories together.
# `gmC` joins two or more development histories together but does not commit.
# `gmF` joins two or more development histories together but does not commit
     generating a merge commit even if the merge resolved as a fast-forward.
# `gma` aborts the conflict resolution, and reconstructs the pre-merge state.
# `gmt` runs the merge conflict resolution tools to resolve conflicts.

### Push

# `gp` updates remote refs along with associated objects.
# `gpf` forcefully updates remote refs along with associated objects using the safer `--force-with-lease` option.
# `gpF` forcefully updates remote refs along with associated objects using the riskier `--force` option.
# `gpa` updates remote branches along with associated objects.
# `gpA` updates remote branches and tags along with associated objects.
# `gpt` updates remote tags along with associated objects.
# `gpc` updates remote refs along with associated objects and adds *origin*
     as an upstream reference for the current branch.
# `gpp` pulls and pushes from origin to origin.

### Rebase

# `gr` forward-ports local commits to the updated upstream head.
# `gra` aborts the rebase.
# `grc` continues the rebase after merge conflicts are resolved.
# `gri` makes a list of commits to be rebased and opens the editor.
# `grs` skips the current patch.

### Remote

# `gR` manages tracked repositories.
# `gRl` lists remote names and their URLs.
# `gRa` adds a new remote.
# `gRx` removes a remote.
# `gRm` renames a remote.
# `gRu` fetches remotes updates.
# `gRp` prunes all stale remote tracking branches.
# `gRs` displays information about a given remote.
# `gRb` opens a remote on [GitHub][3] in the default browser.

### Stash

# `gs` stashes the changes of the dirty working directory.
# `gsa` applies the changes recorded in a stash to the working directory.
# `gsx` drops a stashed state.
# `gsX` drops all the stashed states.
# `gsl` lists stashed states.
# `gsL` lists dropped stashed states.
# `gsd` displays changes between the stash and its original parent.
# `gsp` removes and applies a single stashed state from the stash list.
# `gsr` recovers a given stashed state.
# `gss` stashes the changes of the dirty working directory, including untracked.
# `gsS` stashes the changes of the dirty working directory interactively.
# `gsw` stashes the changes of the dirty working directory retaining the index.

### Submodule

# `gS` initializes, updates, or inspects submodules.
# `gSa` adds given a repository as a submodule.
# `gSf` evaluates a shell command in each of checked out submodules.
# `gSi` initializes submodules.
# `gSI` initializes and clones submodules recursively.
# `gSl` lists the commits of all submodules.
# `gSm` moves a submodule.
# `gSs` synchronizes submodules' remote URL to the value specified in
    .gitmodules.
# `gSu` fetches and merges the latest changes for all submodule.
# `gSx` removes a submodule.

### Tag

# `gt` lists tags or creates tag.
# `gtl` lists tags matching pattern.
# `gts` creates a signed tag.
# `gtv` validate a signed tag.

### Working directory

# `gws` displays working-tree status in the short format.
# `gwS` displays working-tree status.
# `gwd` displays changes between the working tree and the index (diff).
# `gwD` displays changes between the working tree and the index (word diff).
# `gwr` resets the current HEAD to the specified state, does not touch the
     index nor the working tree.
# `gwR` resets the current HEAD, index and working tree to the specified state.
# `gwc` removes untracked files from the working tree (dry-run).
# `gwC` removes untracked files from the working tree.
# `gwx` removes files from the working tree and from the index recursively.
# `gwX` removes files from the working tree and from the index recursively and
    forcefully.



## Backup

```sh
# Flow (F)
alias gFi='git flow init'
alias gFf='git flow feature'
alias gFb='git flow bugfix'
alias gFl='git flow release'
alias gFh='git flow hotfix'
alias gFs='git flow support'

alias gFfl='git flow feature list'
alias gFfs='git flow feature start'
alias gFff='git flow feature finish'
alias gFfp='git flow feature publish'
alias gFft='git flow feature track'
alias gFfd='git flow feature diff'
alias gFfr='git flow feature rebase'
alias gFfc='git flow feature checkout'
alias gFfm='git flow feature pull'
alias gFfx='git flow feature delete'

alias gFbl='git flow bugfix list'
alias gFbs='git flow bugfix start'
alias gFbf='git flow bugfix finish'
alias gFbp='git flow bugfix publish'
alias gFbt='git flow bugfix track'
alias gFbd='git flow bugfix diff'
alias gFbr='git flow bugfix rebase'
alias gFbc='git flow bugfix checkout'
alias gFbm='git flow bugfix pull'
alias gFbx='git flow bugfix delete'

alias gFll='git flow release list'
alias gFls='git flow release start'
alias gFlf='git flow release finish'
alias gFlp='git flow release publish'
alias gFlt='git flow release track'
alias gFld='git flow release diff'
alias gFlr='git flow release rebase'
alias gFlc='git flow release checkout'
alias gFlm='git flow release pull'
alias gFlx='git flow release delete'

alias gFhl='git flow hotfix list'
alias gFhs='git flow hotfix start'
alias gFhf='git flow hotfix finish'
alias gFhp='git flow hotfix publish'
alias gFht='git flow hotfix track'
alias gFhd='git flow hotfix diff'
alias gFhr='git flow hotfix rebase'
alias gFhc='git flow hotfix checkout'
alias gFhm='git flow hotfix pull'
alias gFhx='git flow hotfix delete'

alias gFsl='git flow support list'
alias gFss='git flow support start'
alias gFsf='git flow support finish'
alias gFsp='git flow support publish'
alias gFst='git flow support track'
alias gFsd='git flow support diff'
alias gFsr='git flow support rebase'
alias gFsc='git flow support checkout'
alias gFsm='git flow support pull'
alias gFsx='git flow support delete'

# Grep (g)
alias gg='git grep'
alias ggi='git grep --ignore-case'
alias ggl='git grep --files-with-matches'
alias ggL='git grep --files-without-matches'
alias ggv='git grep --invert-match'
alias ggw='git grep --word-regexp'

# Remote (R)
alias gR='git remote'
alias gRl='git remote --verbose'
alias gRa='git remote add'
alias gRx='git remote rm'
alias gRm='git remote rename'
alias gRu='git remote update'
alias gRp='git remote prune'
alias gRs='git remote show'
alias gRb='git-hub-browse'

# Submodule (S)
alias gS='git submodule'
alias gSa='git submodule add'
alias gSf='git submodule foreach'
alias gSi='git submodule init'
alias gSI='git submodule update --init --recursive'
alias gSl='git submodule status'
alias gSm='git-submodule-move'
alias gSs='git submodule sync'
alias gSu='git submodule foreach git pull origin master'
alias gSx='git-submodule-remove'

# Tag (t)
alias gt='git tag'
alias gtl='git tag -l'
alias gts='git tag -s'
alias gtv='git verify-tag'

```
