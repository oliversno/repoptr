# repoptr
A tool for organizations to make one super repo that points to other repos
 # Motivation
 Allow organizations already using remote git repos to create a single super repo that can be pulled from a remote to update all repos that are pointed to.
 Multiple super repos can be made to allow different levels of access.
 
 # Use
 Consider a single super repo named `super` and two repos named `src1` and `src2`. `super` will contain pointers to `src1` and `src2`.
 ## repoptr init
 Run `repoptr init` to initilize repo pointers in a repo. This command will create a `.ptrs`file which will contain all the pointers to other remote repos. If repo pointers already exist in this directory then `repoptr init` will reinitilize all pointers.
 ### Example
 ```
 ~/ $ mkdir super/
 ~/ $ cd super/
 ~/super/ $ git init
 ~/super/ $ Initialized empty Git repository in ~/super/.git/
 ~/super/ $ repoptr init
 ~/super/ $ Initialized repo pointers in ~/super/.ptrs/
 ~/super/ $ repoptr init
 ~/super/ $ Reinitialized existing repo pointers in ~/super/.ptrs/
 ```
