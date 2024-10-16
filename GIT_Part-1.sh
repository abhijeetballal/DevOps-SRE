1. Git vs GitHub
Git is an application which helps to track your code changes.
Git also allows to work on the same codebase with multiple developers.
GitHub == GitLab == Bitbucket == Azure Repo provides a platform to host your code Remotely.

2. What are the basic Git commands you use frequently or on a daily basis?
git add .; git commit -m "demo"; git push origin <branch>
git pull origin <branch>
git clone <repo-url>

3. Git Clone  vs Fork
Git Clone creates a copy of the repository in your local machine and you can pull and push changes to the remote repository.

Fork is useful when you want to contribute to the original repository. Fork creates a copy of the repository in your GitHub account. You can make changes and raise a pull request to the original repository. This is helpful when you are working on open-source projects. Example if you want to build some new app over kubernetes, you can fork the kubernetes repository and make changes to the code and raise a pull request.

4. Can I use both SSH and HTTPS for Git?
Yes, you can use both SSH and HTTPS for Git. SSH is more secure than HTTPS.
But we need to update .ssh/config file to use multiple SSH keys for multiple GitHub accounts.
#git remote add origin2 git@github-mavrick202:mavrick202/terraformsingleinstance.git
# Default github account: mavrick202
Host github-mavrick202
   HostName github.com
   IdentityFile ~/.ssh/id_rsa_new
   IdentitiesOnly yes

#git remote add origin3 git@github-sreeveerdevops:sreeveerdevops/terraformsingleinstance.git   
# Other github account: sreeveerdevops
Host github-sreeveerdevops
   HostName github.com
   IdentityFile ~/.ssh/id_rsa
   IdentitiesOnly yes

5. How can I migrate my code from one repository to another repository?
PS C:\SUREDELETELATER\SRE\4.VersionControl\terraformsingleinstance> git remote -v
gitlab  git@gitlab.com:mavrick202/sreb01migration.git (fetch)
gitlab  git@gitlab.com:mavrick202/sreb01migration.git (push)
origin  https://github.com/mavrick202/terraformsingleinstance (fetch)
origin  https://github.com/mavrick202/terraformsingleinstance (push)
git push gitlab <branch>

6. Git Pull vs Git Fetch
Git Fetch will fetch the changes from the remote repository to your local repository but it will not merge the changes to your local repository. You need to merge the changes manually by running git merge origin/<branch>.

Git Pull = Git Fetch + Git Merge. Git Pull will fetch the changes from the remote repository and merge the changes to your local repository.

7. What is Git Merge?
Git Merge is used to merge the changes from one branch to another branch. You can merge the changes from the feature branch to the main branch. The main advantage of Git Merge is that it will not alter the commit history. But if you perform too many merges, it will create a lot of merge commits which will make the commit history complex.

8. Git Rebase?
Git Rebase is used to merge the changes from one branch to another branch. You can merge the changes from the feature branch to the main branch. The main disadvantage of Git Rebase is that it will alter the commit history. It will make the commit history linear. But if you perform too many rebases, it will create a lot of conflicts which will make the commit history complex.
The MAIN GOLDEN RULE of rabase is "NEVER REBASE A PUBLIC REPO USED BY MULTIPLE PEOPLE".

9. Git Merge vs Git Rebase?
Both achieve the same goal of merging the changes from one branch to another branch. But Git Merge will not alter the commit history. But Git Rebase will alter the commit history. Git Rebase is used to make the commit history linear. But if you perform too many rebases, it will create a lot of conflicts which will make the commit history complex.

10. How to work with Large Files using Git? What is Git LFS?
Max file limit for GitHub/GitLab/Bibucket/Azure Repo is 100MB. If you have large files, you can use Git LFS (Large File Storage) to store large files. Git LFS will store the large files in a separate storage and store the reference in the Git repository. You need to install Git LFS in your local machine and configure the Git LFS in your repository.
git lfs install
git lfs track "*.iso"
git add .gitattributes
git add <large-file>
git commit -m "Added large file"
git push origin <branch>

10. What is Git Stash?
Git Stash is used to save the changes in your working directory to a temporary location. You can revert the changes in your working directory to the last commit. You can apply the changes from the stash to your working directory. You can apply the changes from the stash to a different branch.
git stash
git stash list
git stash pop
git stash pop 0
git stash clear


11. What is Git Cherry-Pick?
git cherry-pick <commit-hash>
To apply the changes from a specific commit to the current branch. This is useful when you want to apply a specific commit to the current branch for hotfixes.

12. git log --oneline && git log --oneline --graph
To list the commit history in one line.

13. Git Reset? - Hard vs Soft vs Mixed(default)
git reset --hard c224fd2 #Delete commits and data which is destrutable and data loss.
git reset --hard HEAD~5 #Delete the last 5 commits.
git reset --soft 662bfbd #Delete commits and changes are staged.
git reset --soft HEAD~5 #Delete the last 5 commits and changes are staged.
git reset --mixed 662bfbd #Delete commits and changes are unstaged.
git reset --mixed HEAD~5 #Delete the last 5 commits and changes are unstaged.

14. Git Revert? 
git revert 662bfbd #Revert the changes of the commit. But wont delete the commit history.
git revert HEAD~5 #Revert the last 5 commits.But wont delete the commit history.
Its recommended to use revert instead of reset when you are working on a public repository. If its a personal repository, you can use reset.

15. Git Reset vs Git Revert?

16. git branch -D hello #Delete the branch hello
17. Use reflog to recover the deleted branch.
    git reflog && git checkout -b 5d1e2b2
18. git rename -m <old-branch-name> <new-branch-name>

19. How to delete specific commit in Git?
git rebase -i HEAD~5 and drop the commit.
git rebase -i aaac44b(firstcommit)


19. What is Git Squash?
Git Squash is used to combine multiple commits into a single commit. You can squash the last 3 commits into a single commit. This is useful when you want to combine multiple commits into a single commit before raising a pull request. It can be used with interactive rebase.
git rebase -i aaac44b # use squash instead of pick for the commits you want to squash.

20. What is Git Bisect?
Git Bisect is used to find the commit which introduced a bug. You can mark a commit as good and bad. Git Bisect will help you to find the commit which introduced the bug. You can use git bisect start, git bisect bad, git bisect good, git bisect reset.

17. Git Tag?
git tag -a v1.0 -m "Version 1.0"
git push origin v1.0
git tag -d v1.0
Git Tags are usefull to mark the release versions.

18. How PR works in GitHub and use branching policies?
Brancing Policies:
1. Branch Protection
2. Required Reviewers
3. Required Checks
4. Required Status Checks
5. Required Pull Request Reviews.

19. What are verified commits in GitHub?
GitHub will verify GPG, SSH, or S/MIME signatures so other people will know that your commits come from a trusted source. GitHub will automatically sign commits you make using the GitHub web interface.

20. What is Git Submodule?
A Git submodule is a record within a host Git repository that points to a specific commit in another external repository. Submodules are very static and only track specific commits. Submodules do not track Git refs or branches and are not automatically updated when the host repository is updated.

Chery-Pick happens in the same repository.
Submodule happens between different repositories.

git submodule add https://github.com/SreeVeerDevOps/python-fastapi-docker-public.git fastapi

git submodule deinit --all
git submodule deinit -f .\fastapi\
rm -rf .git/modules/path/to/submodule
git rm -f path/to/submodule

21. Multirepo vs Monorepo?
Monorepo is a single repository that contains all the code for an organization. 
Google and Facebook use Monorepo.

Multirepo is a separate repository for each project

22. Braching Strategies in Git?
https://www.gitkraken.com/learn/git/best-practices/git-branch-strategy

1. Git Flow - Production Branch, Development Branch, Feature Branch, Release Branch, Hotfix Branch.
For HotFix - Clone Production Branch, Create HotFix Branch, Merge HotFix Branch to Production Branch and Development Branch.

2. GitHub Flow - The GitHub flow branching strategy is a relatively simple workflow that allows smaller teams, or web applications/products that don’t require supporting multiple versions, to expedite their work.
Main Branch & Feature Branch. Feature Branch will be merged to Main Branch.

3. GitLab Flow - Production & pre-production branches.

4. Trunk Based Development
a. Web Application with no mobile versions - One Production Branch & One Development Branch.
b. Web Application with mobile versions. - One Production Branch & One Development Branch & One Release Branch. Latest Release Branch will be merged to Production Branch.

23. git barebone repository
git init --bare .
Run ls on that direc­to­ry and you won’t see a Work­ing Tree but just the con­tents of what is typ­i­cal­ly in the .git directory.

 Using --bare flag with git init simply initializes a private remote git repository which you can access using SSH over default port 22. 

 https://opstree.com/blog/2022/06/21/what-is-a-bare-git-repository/

Using Git barebone repository we can host our code on a remote server and push our code to it. This is useful when we want to share our code with multiple developers.

24. What is Git Hooks?
Git hooks are scripts that Git executes before or after events such as: commit, push, and receive. Git hooks are a built-in feature - no need to download anything. Git hooks are run locally.

25. How do you deal with merge conflicts in Git?
When you have a merge conflict, Git will mark the conflicted area in the file. You need to resolve the conflict manually. You can use git status to check the conflicted files. You can use git diff to check the changes in the conflicted files. You can use git add <file> to stage the changes. You can use git commit to commit the changes.


26. https://github.com/marketplace/actions/git-repo-backup-action

27. Sprint Ceremonies:
1. Sprint Planning
2. Daily Standup
3. Sprint Review
4. Sprint Retrospective
5. Backlog/Sprint grooming