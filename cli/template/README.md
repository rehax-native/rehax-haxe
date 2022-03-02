
## Usage

Requirements for building this project:

- Make sure you have [Haxe](https://haxe.org/download/) installed and verify it\' accessible with `haxe --version`

### To add a new target

- Make sure you have the [Rehax cli](https://github.com/rehax-native/rehax-cli) installed on your computer.
- Run `rehax --add-target <target-type> [target-name]`
- You can list available target types by doing `rehax --list-target-types
- `target-name` will default to the same as `target-type`
- For instance:
  - `rehax --add-target macos`
  - `rehax --add-target win`
  - `rehax --add-target ios`
  - `rehax --add-target android`
  - `rehax --add-target web site1`

### To run a target

`rehax --run <target-name>`

You can list available targets in your project with

`rehax --list-targets`
