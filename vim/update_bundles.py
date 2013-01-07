#!/usr/bin/env python
#
# script for updating files stored in the bundle folder
#

import os
import shutil
import subprocess

git_bundles = [
        'git://github.com/tpope/vim-fugitive.git',
        'git://github.com/altercation/vim-colors-solarized.git',
];

# clear out folders in the bundle folder so that we can restore
# everything from scratch

os.chdir( 'bundle' )

for root,dirs,files in os.walk('.'):
    for f in files:
        os.unlink( os.path.join(root, f) )
    for d in dirs:
        shutil.rmtree( os.path.join(root, d) )

# for each bundle, pull from repository

for bundle in git_bundles:
    bundle_name = bundle.rsplit('/', 1)[1].replace('.git','')
    print 'Cloning {0}'.format( bundle )
    subprocess.call( ['git', 'clone', bundle] )

    # remove the .git folder in the bundle so that we can actually commit the
    # folders to git without having them look like sub repositories
    shutil.rmtree( os.path.join(bundle_name, '.git') )

os.chdir( '..' )

