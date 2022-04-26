
import os
import sys
import pathlib
from distutils.dir_util import copy_tree
import shutil
import glob

# is_win = sys.platform
# is_mac = sys.platform == 'darwin'

pathlib.Path('build/out').mkdir(parents=True, exist_ok=True)

print('Building rehax core')
os.system('cd out && make rehax-cpp-mac && cp rehax-cpp-mac/bin/Debug/librehax-cpp-mac.a ../build/out/librehax-mac.a')

header_files = [[path, 'build/out/include/' + path] for path in glob.glob('rehax/components/**/**/*.h')]

for source, target in header_files:
  pathlib.Path(os.path.dirname(target)).mkdir(parents=True, exist_ok=True)
  shutil.copyfile(source, target)