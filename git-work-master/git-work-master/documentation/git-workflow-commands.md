#### [Click here to readme](https://github.com/SarvM/git-work)


## Git commands - Workflow                          

Below commands may be used to achieve the branching model explained in previous topic.

### Scenario

1. Below freelancers are working for an experimental project called 'pratice-git'

    * Developers: Lisa and Rachel
    * Developer Lead: Sophie
    * Admin: Erika 

2. Below task is assigned to each of them:

    * Erika - Setup existing project in git, create *develop* branch
    * Lisa - Signup API -- api change; Enhancement Reference # IME02384
    * Sophie - Signup API -- code reviewer and responsible for releasing the task to QA
    * Rachel - Fixing bug on login page; Bug Reference # BZ2948
    
3. Release Process - Tag this enhancement, feature and bug fix in single release with tag name v1.0.1


### Git commands

Please refer [git useful commands](https://github.com/SarvM/git-work/blob/master/documentation/git-useful-commands.md) for more details on below commands.

#### Initialize the project

This command is used by admin to initialize the project in server and to setup *develop* branch. 

Note: This section is not required for developers.

```sh

Erika used below commands to finish her task.

$ git init 

$ git commit --allow-empty -m "Initial commit"

$ git checkout -b develop master

$ git push origin develop

```

#### Clone the project 

To copy a git repository. First, clone a remote Git repository and cd into it:

```sh

Lisa and Rachel copies a git repository to their local to finish the work assigned to them.

$ git clone -b develop --single-branch http://immidart-git.azurewebsites.net/pratice-git.git

$ cd pratice-git/

$ git config user.name "lisa"

$ git config user.email "lisa@mail.com"

```

Note: The config entry *user.name* and *user.email* is used to set user name and user email for this repository. 

Next, look at the local branches in your repository:

```sh

$ git branch
    
  *develop

```

There are remote branches hiding in your repository. Use below command to view it. 

```sh

$ git branch -a

 *develop

  remotes/origin/develop

```

#### Create branch in local and push to remote for tracking

This branch is used by developer to fix the bug or enhance the feature without disturbing the develop branch. 

```sh

$ git checkout -b feature/signup-api develop

$ git push -u origin feature/signup-api

```

Now, the branch is available in both local and remote for tracking.

* Best Practice: 

    * The developer should update local develop branch with remote branch.
    * The feature branch should be pushed periodically to remote -- it acts like a backup.
    
Back to story. While lisa enhancing the feature, Rachel has fixed the login page issue. Hence, Sophie has to review it and merge it to develop so that it will be available for Lisa.


#### Clone and create branch for review

* Sophie need to copy the repository. This step is not required if the repository is already setup.
* The repository should be updated with latest changes

```sh

$ git clone http://immidart-git.azurewebsites.net/pratice-git.git

$ cd pratice-git/

$ git checkout -b  bug/bz2948 origin/bug/bz2948

```

The branch bug/bz2948 should have all changes committed by Rachel. 

Sophie modified few lines of code and committed to the same branch for Rachel to take it further. 

```sh

$ git status // To identify the files modified by her

$ git add . // To add the files for stracking

$ git commit -m "Code Reviewed. Modified few lines" 

$ git push origin bug/bz2948

```

#### Pull the latest code and Merge the files if required.

Now, Rachel need to pull the latest code and do merge if required and push it to develop. 

```sh

$ git pull // To pull the latest code 

$ git log --oneline -5 // To understand the commit 

```

Time to merge the changes with develop branch. 

```sh

$ git checkout develop // This is local branch

$ git merge --no-ff bug/bz2948 // Merge the changes to local develop branch

$ git push origin develop // All changes are pushed to develop branch

$ git branch -d bug/bz2948 // To delete the local branch

$ git push origin --delete bug/bz2948 // To delete the remote branch from server

```

* Best Practices:

    * It is recommended to use the option * --no-ff * while merging. 
    * Delete the feature/hotfix/bug/release branch once it is merged with corresponding main branches.
    
Well, Now Lisa need to update the branch to have the changes done by Rachel. 

```sh

$ git checkout develop // switch from feature branch to develop branch to pull latest changes

$ git pull origin develop // All latest changes available in develop branch is pulled from server to local

$ git checkout feature/signup-api // switch to feature branch

$ git merge --no-ff develop // all changes available in local develop branch is merged with future branch

```

Now, Lisa has done with the work. Hence, she will follow the same process:

1. Push the code for review
2. Code review from developer lead
3. Pull the latest changes
4. Merge with local develop branch
5. Push the changes to remote develop branch
6. Delete feature branch from local and remote

```sh

$ git status // To know the status of tracked files

$ git add . // Stage the modified files.

$ git commit -m "Feature enhanced and reviewed by developer lead"

$ git checkout develop

$ git merge --no-ff feature/signup-api

$ git push origin develop // push the changes to remote develop branch

$ git branch -d feature/signup-api  // delete the local branch

$ git push origin --delete feature/signup-api  // delete the remote branch 

```

#### Create Release

Now, Sophie is going  to create Release branch with all the bug fixes and enhancement for QA / Integration testing. 

```sh

$ git checkout -b develop origin/develop // incase the *develop* branch is not available in release admin system

$ git pull origin develop // just to make sure the *develop* branch is having latest code available.

$ git checkout -b release/v1.0.12 develop // create release branch from local develop branch

$ git push origin release/v1.0.12 // push this release branch to remote for tracking -- deploy this branch for testing. 

$ git commit -m "Commit the version v1.0.12 // committing all bug fixes and make it ready for production ready. 


```

#### Create tag for release

The code is now ready for production release. Hence, perform below:

1. Merge the release branch with Master and develop branch. 
2. Tag the master branch for release point.
3. Delete the release branch.

```sh

$ git checkout master

$ git pull origin master // just to make sure the master branch is up-to-date

$ git merge --no-ff release/v1.0.12 // merge the release branch with master branch locally

$ git push origin master // push the changes to remote master

$ git checkout develop

$ git merge --no-ff release/v1.0.12  // to merge the release branch with develop branch locally

$ git push origin develop  // push the change to remote develop branch -- so that other developer can push the latest code

$ git checkout master  // switch to master branch to tag 

$ git tag -a v1.0.12 -m "enterprise version v1.0.12 ready"

$ git push origin v1.0.12  // push the tag to remote/server

$ git branch -d release/v1.0.12  // delete the branch locally

$ git push origin --delete release/v1.0.12  // delete the remote release branch 

```

Graphical representation of git commits -- used gitk to produce this image.

![gitk - releasev1.0.12](/documentation/img/gitk-release-v1.0.12.png?raw=true "gitk - releasev1.0.12")

Done. Enjoy Git :) 




    