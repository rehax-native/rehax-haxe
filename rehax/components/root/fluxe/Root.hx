package rehax.components.root.fluxe;

using rehax.components.view.View;

#if fluxe

using fluxe.views.View;
using fluxe.views.Button;
using fluxe.views.Text;
using fluxe.views.TextInput;
using fluxe.views.Externs;
using fluxe.views.Engine;
using fluxe.layout.StackLayout;

// using Root.ElementStyleExtender;

// class ElementStyleExtender {
//   static public function setElementStyle(el:Element, style:Style) {
//     for (item in style) {
//       switch (item) {
//         case backgroundColor(color):
//           el.style.backgroundColor = 'rgba(${color.red}, ${color.green}, ${color.blue}, ${color.alpha})';
//         case textColor(color):
//           el.style.color = 'rgba(${color.red}, ${color.green}, ${color.blue}, ${color.alpha})';
//         case opacity(amount):
//           el.style.opacity = Std.string(amount);
//         case horizontalAlignment(alignment):
//         // el.style.textAlign
//         // el.style.justifyContent
//         // el.style.alignItems
//         case verticalAlignment(alignment):
//           // el.style.textAlign
//           // el.style.justifyContent
//           // el.style.alignItems
//       }
//     }
//   }
// }

class Root extends rehax.components.view.View {

  public static function CreateWithExistingPlatformView(platformView:cpp.RawPointer<Void>):Root {
    var root = new Root();
    root.platformView = platformView;
    root.hasPlatformView = true;
    EngineUtility.startWithViewAndPlatformWindow(root.view, platformView);
    return root;
  }

  public function new() {
    super();
    var container = new View();
    view = container;
  }

  private var hasPlatformView:Bool = false;
  private var platformView:cpp.RawPointer<Void>;

  public function initialize(onReady:Void->Void) {
      onReady();
      if (hasPlatformView) {
        EngineUtility.startWithViewAndPlatformWindow(view, platformView);
      } else {
        EngineUtility.startWithView(view);
      }
  }

  // public override function set_style(style:rehax.Style):rehax.Style {
  //   var el = document.querySelector("body");
  //   el.setElementStyle(style);
  //   return style;
  // }
}
#end
