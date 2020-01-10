#!/usr/bin/env python
#
# script for updating files stored in the bundle folder
#

import os
import stat
import shutil
import subprocess

git_bundles = [
   'git://github.com/tpope/vim-fugitive.git',
   'git://github.com/altercation/vim-colors-solarized.git',
   'git://repo.or.cz/vcscommand',
   'https://github.com/scrooloose/nerdcommenter.git',
   'https://github.com/scrooloose/nerdtree.git',
   'https://github.com/elzr/vim-json.git',
   'git://github.com/AndrewRadev/linediff.vim.git',
   'https://github.com/henrik/vim-indexed-search.git',
   'https://github.com/bling/vim-airline.git',
   'https://github.com/tpope/vim-markdown.git',
   'https://github.com/vim-airline/vim-airline-themes.git',
   'git://github.com/tmux-plugins/vim-tmux.git',
   'git://github.com/craigemery/vim-autotag.git',
   'https://github.com/fatih/vim-go.git',
   'https://github.com/lifepillar/vim-solarized8.git',
   #'https://github.com/Valloric/YouCompleteMe.git'
   ];

# clear out folders in the bundle folder so that we can restore
# everything from scratch

os.chdir( 'bundle' )

def remove_readonly(fn, path, excinfo):
    if fn is os.rmdir:
        os.chmod(path, stat.S_IWRITE)
        os.rmdir(path)
    elif fn is os.remove or fn is os.unlink:
        os.chmod(path, stat.S_IWRITE)
        os.remove(path)

for root,dirs,files in os.walk('.'):
    for f in files:
        os.unlink( os.path.join(root, f) )
    for d in dirs:
        shutil.rmtree( os.path.join(root, d), onerror=remove_readonly )

# for each bundle, pull from repository

for bundle in git_bundles:
    bundle_name = bundle.rsplit('/', 1)[1].replace('.git','')
    print("Cloning %r" % ( bundle ))
    subprocess.call( ['git', 'clone', bundle] )

    # remove the .git folder in the bundle so that we can actually commit the
    # folders to git without having them look like sub repositories
    repo_name = os.path.join(bundle_name, '.git')
    if os.path.exists(repo_name) == True:
        shutil.rmtree( repo_name, onerror=remove_readonly )

os.chdir( '..' )

