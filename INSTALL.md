# INSTALL

## Fork the project

* Go to https://github.com/ablagoev/clashofalcoholics and click the fork button
* Clone your own version of the project
  * Go to your project on github
  * Copy the repo URL
  * On your machine do a `git clone URL` to checkout the project in a new directory

## Create a new branch

* `git branch NAME_OF_BRANCH`
* `git checkout NAME_OF_BRANCH`
* Install dependencies `bundle install`
* Setup database `bundle exec rake db:setup`

## Synchronize your fork with the original course repo

### Onetime setup of the remote upstream

* `git remote -v` to list all the remote sources, if ablagoev is present you are already done
* `git remote add upstream ABLAGOEV_GITHUB_URL`
* `git remote -v` ablagoev should already be present

### Reset fork master to upstream master
* `git reset --hard upstream/master`
* `git push origin master --force`

### Synchronizing

* `git fetch upstream`
* Switch to master branch `git checkout master`
* Merge my master branch with yours `git merge upstream/master`
