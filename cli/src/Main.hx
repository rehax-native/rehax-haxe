package;

var targetTypes = [
  'web',
  'macos',
  'win',
  'ios',
  'android'
];

/**
  Rehax CLI
**/
class Main extends mcli.CommandLine {
  /**
    Say it in uppercase?
  **/
  public var loud:Bool;

  /**
    Show this message.
  **/
  public function help() {
    Sys.println(this.showUsage());
    Sys.exit(0);
  }

  public function runDefault() {
    Sys.println(this.showUsage());
    Sys.exit(0);
  }

  /**
    Create a new rehax project in the given directory
  **/
  public function createProject(name:String, ?directory:String) {
    var directoryName = directory == null ? name : directory;
    var projectPath = sys.FileSystem.absolutePath(directoryName);
    Sys.println('Creating project $name in $projectPath');
    if (sys.FileSystem.exists(projectPath)) {
      Sys.println('Directory/File already exists at $projectPath');
      Sys.exit(1);

    }
    sys.FileSystem.createDirectory(projectPath);
    sys.FileSystem.createDirectory(haxe.io.Path.join([projectPath, 'src']));
    sys.FileSystem.createDirectory(haxe.io.Path.join([projectPath, 'targets']));

    sys.io.File.saveContent(haxe.io.Path.join([projectPath, 'src', 'MyApp.hx']), haxe.Resource.getString('MyApp.hx'));
    sys.io.File.saveContent(haxe.io.Path.join([projectPath, 'README.md']), haxe.Resource.getString('README.md'));

    Sys.exit(0);
  }

  /**
    List available targets
  **/
  public function listTargetTypes() {
    Sys.println('Target types:');
    for (target in targetTypes) {
      Sys.println("\t" + target);
    }
    Sys.exit(0);
  }

  /**
    Add target
  **/
  public function addTarget(targetType:String, ?targetName:String) {
    if (!targetTypes.contains(targetType)) {
      Sys.stderr().writeString('Invalid target type $targetType\r\n');
      Sys.stderr().writeString('Use --list-target-types to get a list of possible values');
      Sys.exit(1);
    }

    var name = targetName == null ? targetType : targetName;

    Sys.println('Add target $name');
    var rootDir = haxe.io.Path.join(['.', 'targets', name]);
    if (sys.FileSystem.exists(rootDir)) {
      Sys.println('Directory/File already exists at $rootDir');
      Sys.exit(1);
    }
    sys.FileSystem.createDirectory(rootDir);

    switch (targetType) {
      case 'web':
        sys.io.File.saveContent(haxe.io.Path.join([rootDir, 'package.json']), haxe.Resource.getString('web_package.json'));
        sys.io.File.saveContent(haxe.io.Path.join([rootDir, 'index.html']), haxe.Resource.getString('web_index.html'));
        sys.io.File.saveContent(haxe.io.Path.join([rootDir, 'webpack.config.js']), haxe.Resource.getString('web_webpack.config.js'));
        sys.io.File.saveContent(haxe.io.Path.join([rootDir, '.gitignore']), haxe.Resource.getString('web_.gitignore'));
        sys.FileSystem.createDirectory(haxe.io.Path.join([rootDir, 'src']));
        var install = new sys.io.Process('cd $rootDir && npm install');
    }
    Sys.exit(0);
  }

  // /**
  //   Build target
  // **/
  // public function buildTarget(target:String) {
  //   if (!targets.contains(target)) {
  //     Sys.stderr().writeString('Invalid target $target\r\n');
  //     Sys.stderr().writeString('Use --list-targets to get a list of possible values');
  //     Sys.exit(1);
  //   }
  //   Sys.println('Build target $target');
  //   Sys.exit(0);
  // }

  public static function main() {
    new mcli.Dispatch(Sys.args()).dispatch(new Main());
  }
}