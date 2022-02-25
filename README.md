# Rehax CLI

This tool helps you generate Rehax projects, add build targets, and to build and run targets.

## Installation

[todo]

## Usage

### Create a new Rehax project

`rehax --create-project projectName`

This will create a new rehax project for you, and is the easiest way to get started with Rehax.

The next step after creating the project is to add a target, in order to build and run your app.

If you want to join Rehax to an existing Xcode/Visual Studio/Web project, see [todo].

### Add a target

`rehax --add-target <target-type> [target-name]`

This will add a target (optionally with the given name) to your project directory. It will create a native project for you, with all necessary rehax libraries and build steps added.

`target-name` defaults to the same as `target-type`.

Possible values for `target-type` are:

- `web`: Creates a new webpack ([todo]) project
- `macos`: Creates an Xcode project
- `win`: Creates a new Visual Studio project
- `ios`: Creates a new Xcode project
- `android`: Creates a new Gradle ([todo]) project

You can list available target types with

`rehax --list-target-types`

### Run a target

[todo]

`rehax --run <target-name>`

You can list available targets in your project with

`rehax --list-targets`