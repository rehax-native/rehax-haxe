
import os
import sys
import urllib

if len(sys.argv) < 2:
  print('Usage: prepare.py <backend>')
  print('Possible backends: fluxe, native, web')
  sys.exit(1)

is_mac = sys.platform == 'darwin'
backend = sys.argv[1]

# is_win = sys.platform
# is_mac = sys.platform == 'darwin'

if backend == 'fluxe':
  fluxe_lib_url = 'https://github.com/rehax-native/fluxe/releases/download/v0.0.1/fluxe-static.zip'
  deps_dir = os.path.join(os.path.dirname(__file__), 'dev', 'apple', 'deps')
  zip_path = os.path.join(deps_dir, 'fluxe-static.zip')

  import pathlib
  pathlib.Path(deps_dir).mkdir(parents=True, exist_ok=True)

  import urllib.request
  urllib.request.urlretrieve(fluxe_lib_url, zip_path)

  import zipfile
  with zipfile.ZipFile(zip_path, 'r') as zip_ref:
      zip_ref.extractall(deps_dir)

if is_mac:
  os.system('premake5 xcode4')
os.system('premake5 gmake2')