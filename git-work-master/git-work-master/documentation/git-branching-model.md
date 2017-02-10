#### [Click here to readme](https://github.com/SarvM/git-work)


## Git branching model                       

There are many ways to implement workflow in Git. We are going to discuss about the variant of [nvie's git branching workflow](http://nvie.com/posts/a-successful-git-branching-model/).

Note: Please refer [naming convention page](https://github.com/SarvM/git-work/blob/master/documentation/git-naming-convention.md) for more details on branch naming conventions.

### Main branch

These branches have an infinite lifetime

1. master branch
    
    * This branch always points to latest stable release (production-ready state). 
    * It's equivalent to release candidate in release process.
    
2. develop branch
    
    * This branch always points to latest development code.
    * It's equivalent to alpha state in release process.
        
### Supporting branch

These branches have limited life-time with specific purpose and it will be removed eventually once it's merged with corresponding branches.

1. feature branch
    
    * This branch is used to develop new features / enhance existing feature.
    * This branch should branch off from: *develop*.
    * This branch should merge back into: *develop*.

    Note: The feature branch should be merged into *develop* branch only after peer review, code review and QA Sign-off.
        
2. bug branch
    
    * This branch is used to fix the bugs in existing system.
    * This branch should branch off from: *develop*.
    * This branch should merge back into: *develop*.

    Note: The feature branch should be merged into *develop* branch only after peer review, code review and QA Sign-off.
        
3. release branch
    
    * It's equivalent to beta state in release process.
    * This branch is used for UAT.
    * Issues will be fixed in this branch. 
    * This brach should branch off from: *develop*
    * This branch should merge back into: *master* and *develop*
    * The master branch merge commit will be tagged with the new version number.
        
4. hotfix branch

    * This branch is used to fix P1 issues.
    * This branch should branch off from: *master*
    * This branch should merge back into: *master* and *develop*
