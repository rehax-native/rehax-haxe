# Rehax

Rehax is a native first, cross platform UI toolkit. It allows you to build apps with a jsx-like syntax for mobile, web and desktop. Since it's using the [Haxe](https://haxe.org/) programming language, it compiles to the native langauge of the target platform, and it's using the native UI toolkit to build user interfaces, for example JS/DOM for web, Objective-C++/UIKit/Cococa for iOS and Mac, C++/WinRT for Windows, Java for Android.

## Comparing Rehax to other Frameworks

To understand how Rehax works, you can compare it to other frameworks:

- React:
    - JSX-like syntax
    - Reactive programming
- React Native:
    - Both frameworks create native UI components on the target platform
    - React Native uses Javascript in the runtime.
    - Rehax uses Haxe, which compiles to many languages. This has a couple of advantages:
        - You don't have to bundle a JS interpreter in your app, making your app size small
        - Since you're creating the UI components in the native language, you don't have any overhead converting between two different langauges
        - It's faster
    - Main disadvantage of Rehax is that you cannot use javascript libraries (if you target other platforms than web. You can still use them in web targets).
- Svelte:
    - The code that Rehax generates looks similar to what svelte generates
    - Both don't use a shadow DOM, giving you better performance
- wxWidgets/QT:
    - For Cocoa/WinRT Rehax is abstracting the creation of native components similar to wxWidgets and QT

## What does it look like?

```
class MyView extends Component {
	public function new() { super(); }
    var world = "World";
	var body = <View style={[ backgroundColor(Color.Red()) ]}>
        Hello {world}!
    </View>;
}

class Test extends Component {
	static function main() {
		App.mountRoot(new Test());
	}

	public function new() { super(); }

	var body = <MyView />;
}
```

## Roadmap

Rehax is in an early stage of development.

### Layouting

|                                            | Web  | Mac | Win | iOS | Android |
|--------------------------------------------|------|-----|-----|-----|---------|
| FlexLayout row                             |      |     |     |     |         |
| FlexLayout row-reverse                     |      |     |     |     |         |
| FlexLayout column                          |      |     |     |     |         |
| FlexLayout column-reverse                  |      |     |     |     |         |
| FlexLayout justify-content flex-start      |      |     |     |     |         |
| FlexLayout justify-content flex-end        |      |     |     |     |         |
| FlexLayout justify-content center          |      |     |     |     |         |
| FlexLayout justify-content space-between   |      |     |     |     |         |
| FlexLayout justify-content space-around    |      |     |     |     |         |
| FlexLayout justify-content space-evenly    |      |     |     |     |         |
| FlexLayout align-items flex-start          |      |     |     |     |         |
| FlexLayout align-items flex-end            |      |     |     |     |         |
| FlexLayout align-items center              |      |     |     |     |         |
| FlexLayout align-items stretch             |      |     |     |     |         |
| FlexLayout align-items baseline            |      |     |     |     |         |
| FlexLayout gap                             |      |     |     |     |         |
| FlexLayout row-gap                         |      |     |     |     |         |
| FlexLayout column-gap                      |      |     |     |     |         |
| FlexLayout flex-grow                       |      |     |     |     |         |
| FlexLayout align-self                      |      |     |     |     |         |

### Components

|                                | Web  | Mac | Win | iOS | Android |
|--------------------------------|------|-----|-----|-----|---------|
| Button                         | done |     |     |     |         |
| Text                           |      |     |     |     |         |
| TextInput                      |      |     |     |     |         |

### Vector Graphics

The interface for vector graphics is close to SVG.

On web it uses <svg> elements.

|                         | Web  | Mac  | Win | iOS | Android |
|-------------------------|------|------|-----|-----|---------|
| Line                    |      |      |     |     |         |
| Rect                    |      |      |     |     |         |
| Circle                  | done |      |     |     |         |
| Ellipse                 |      |      |     |     |         |
| Path Move Horizontal    | done | done |     |     |         |
| Path Vertical           | done | done |     |     |         |
| Path Move To            | done | done |     |     |         |
| Path Move By            | done | done |     |     |         |
| Path Line To            | done | done |     |     |         |
| Path Arc                | done | done |     |     |         |
| Path Cubic Bezier       | done | done |     |     |         |
| Path Quadratic Bezier   | done | done |     |     |         |
| Path Close              | done | done |     |     |         |
| Fill Color              | done |      |     |     |         |
| Stroke Color            | done |      |     |     |         |
| Stroke Width            | done | done |     |     |         |
| Stroke Line Cap butt    | done | done |     |     |         |
| Stroke Line Cap square  | done | done |     |     |         |
| Stroke Line Cap round   | done | done |     |     |         |
| Stroke Line Join miter  | done | done |     |     |         |
| Stroke Line Join round  | done | done |     |     |         |
| Stroke Line Join bevel  | done | done |     |     |         |
| Text                    |      |      |     |     |         |
| Linear gradients        |      |      |     |     |         |
| Radial gradients        |      |      |     |     |         |
| Pattern                 |      |      |     |     |         |
| Polygon                 |      |      |     |     |         |
| Polyline                |      |      |     |     |         |
| Filters                 |      |      |     |     |         |
| Mask                    |      |      |     |     |         |
| ClipPath                |      |      |     |     |         |
| Animations              |      |      |     |     |         |

### Styles

The interface for styling uses the same property names as css as much as possible.

|                             | Web  | Mac | Win | iOS | Android |
|-----------------------------|------|-----|-----|-----|---------|
| backgroundColor             |      |     |     |     |         |