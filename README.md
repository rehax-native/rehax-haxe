# Rehax

Rehax is a native first, cross platform UI toolkit. It allows you to build apps with a jsx-like syntax for mobile, web and desktop. Since it's using the [Haxe](https://haxe.org/) programming language, it compiles to the native language of the target platform, and it's using the native UI toolkit to build user interfaces, for example JS/DOM for web, Objective-C++/UIKit/Cococa for iOS and Mac, C++/WinRT for Windows, Java for Android.

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
- Flutter:
    - Rehax has support for [fluxe](https://github.com/rehax-native/fluxe), a rendering engine using haxe and Skia
    - Both use a fast, cross platform rendering engine
    - Since haxe compiles to the native target langauge, there's no need for another runtime. Flutter bundles a dart runtime in every app, and passing data to and from this runtime can be expensive. Rehax doesn't have that problem.

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

|                                            | Web  | Mac  | Win | iOS | Android | Fluxe |
|--------------------------------------------|------|------|-----|-----|---------|-------|
| FlexLayout row                             | done |      |     |     |         |       |
| FlexLayout row-reverse                     | done |      |     |     |         |       |
| FlexLayout column                          | done |      |     |     |         |       |
| FlexLayout column-reverse                  | done |      |     |     |         |       |
| FlexLayout justify-content flex-start      | done |      |     |     |         |       |
| FlexLayout justify-content flex-end        | done |      |     |     |         |       |
| FlexLayout justify-content center          | done |      |     |     |         |       |
| FlexLayout justify-content space-between   | done |      |     |     |         |       |
| FlexLayout justify-content space-around    | done |      |     |     |         |       |
| FlexLayout justify-content space-evenly    | done |      |     |     |         |       |
| FlexLayout align-items flex-start          | done |      |     |     |         |       |
| FlexLayout align-items flex-end            | done |      |     |     |         |       |
| FlexLayout align-items center              | done |      |     |     |         |       |
| FlexLayout align-items stretch             | done |      |     |     |         |       |
| FlexLayout align-items baseline            |      |      |     |     |         |       |
| FlexLayout gap                             |      |      |     |     |         |       |
| FlexLayout row-gap                         |      |      |     |     |         |       |
| FlexLayout column-gap                      |      |      |     |     |         |       |
| FlexLayout flex-grow                       | done |      |     |     |         |       |
| FlexLayout align-self                      |      |      |     |     |         |       |
| Fixed width                                | done | done |     |     |         |       |
| Percentage width                           | done | done |     |     |         |       |
| Fill width                                 | done |      |     |     |         |       |

### Components

|                                | Web  | Mac | Win  | iOS | Android | Fluxe |
|--------------------------------|------|-----|------|-----|---------|-------|
| Button                         |      |     |      |     |         |       |
| Button text                    | done |     | done |     |         |       |
| Button on click                | done |     | done |     |         |       |
| Text                           |      |     |      |     |         |       |
| Text text                      | done |     | done |     |         |       |
| TextInput                      |      |     |      |     |         |       |
| TextInput placeholder          |      |     | done |     |         |       |

### Vector Graphics

The interface for vector graphics is close to SVG.

On web it uses <svg> elements.

|                         | Web  | Mac  | Win | iOS | Android | Fluxe |
|-------------------------|------|------|-----|-----|---------|-------|
| Line                    |      |      |     |     |         |       |
| Rect                    |      |      |     |     |         |       |
| Circle                  | done |      |     |     |         |       |
| Ellipse                 |      |      |     |     |         |       |
| Path Move Horizontal    | done | done |     |     |         |       |
| Path Vertical           | done | done |     |     |         |       |
| Path Move To            | done | done |     |     |         |       |
| Path Move By            | done | done |     |     |         |       |
| Path Line To            | done | done |     |     |         |       |
| Path Arc                | done | done |     |     |         |       |
| Path Cubic Bezier       | done | done |     |     |         |       |
| Path Quadratic Bezier   | done | done |     |     |         |       |
| Path Close              | done | done |     |     |         |       |
| Fill Color              | done | done |     |     |         |       |
| Stroke Color            | done | done |     |     |         |       |
| Stroke Width            | done | done |     |     |         |       |
| Stroke Line Cap butt    | done | done |     |     |         |       |
| Stroke Line Cap square  | done | done |     |     |         |       |
| Stroke Line Cap round   | done | done |     |     |         |       |
| Stroke Line Join miter  | done | done |     |     |         |       |
| Stroke Line Join round  | done | done |     |     |         |       |
| Stroke Line Join bevel  | done | done |     |     |         |       |
| Text                    |      |      |     |     |         |       |
| Linear gradients        | done | do   |     |     |         |       |
| Radial gradients        | done | do   |     |     |         |       |
| Pattern                 |      |      |     |     |         |       |
| Polygon                 |      |      |     |     |         |       |
| Polyline                |      |      |     |     |         |       |
| Filters                 |      |      |     |     |         |       |
| Mask                    |      |      |     |     |         |       |
| ClipPath                |      |      |     |     |         |       |
| Animations              |      |      |     |     |         |       |

### Styles

The interface for styling uses the same property names as css as much as possible.

|                             | Web  | Mac | Win | iOS | Android | Fluxe |
|-----------------------------|------|-----|-----|-----|---------|-------|
| backgroundColor             |      |     |     |     |         |       |