#### [Click here to readme](https://github.com/SarvM/git-work)


### Useful Git Commands 

1. git init

    * Create an empty Git repository or reinitialize an existing project
    * It is safe to run this command on existing directory
    
2. git commit --allow-empty -m "Initial commit"

    * Just to have initial commit to server before we create a *develop* branch
    * Option *--allow-empty* allow us to override safety commit because git won't allow us to commit without changes to the project
    
3. git checkout -b develop master

    * Create and checkout develop branch from master. 
    
4. git push origin develop

    * This command is used to push develop branch to remote *origin* for remote tracking. 
    
5. git status --short

    * This command is used to output the working status of the tree. 
    * --short is used to output the result in short format.

6. git clone *[url]*

    * If you need to collaborate with someone on a project, or if you want to get a copy of a project so you can look at or use the code, you will clone it. You simply run the git clone [url] command with the URL of the project you want to copy.
    
7. git log --oneline -2

    * This command is used to display the commits
    * The output can be altered by using sub commands. *--oneline* is used to display the output in single line. 
    * sub command *-2* is used to display last 2 commits.
    
8. logout

    * This command is used to exit the bash command line. 
    
9. git branch -d {the_local_branch}

    * To remove local branch from your machine.
    * Use -D instead to force deletion without checking merged status
    
10. git push origin --delete {the_remote_branch}

    * To remove remote branch from your server.
    
11. git merge --abort 

    * To backout of the merge
    
12. git reset --hard *< commit number >*

    * To rever the repository back to commit mentioned.
    
13. rm .git/index.lock

    * Above command can be used to fix below issue, which occurs while merging. 
    
    ```sh 
    
    fatal: Unable to create '/path/to/repo/.git/index.lock': File exists.

    If no other git process is currently running, this probably means a
    git process crashed in this repository earlier. Make sure no other git
    process is running and remove the file manually to continue.
    ```
    
14. git clean  -d  -fx

    * To delete untracked files
    
15. git rm --cached -r [folder/file name]

    * To clean tracked file mentioned in .gitignore file 
    
16. Use below commands to squeeze all intermediate commit to single commit along with message while merging it with actual branch (not feature or bug branch)

    ```sh
    git checkout develop
    
    git merge --squash feature/f10293-data-grid-css // This command will merge all the changes
    
    git add . // Stage all the files merged from feature branch
    
    git commit -m "Give meaningful commit message"
     
    ```

