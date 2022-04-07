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
  public function new() {
    super();
  }

  public function initialize(onReady:Void->Void) {
      var container = new View();
      view = container;
      onReady();
      EngineUtility.startWithView(container);
  }

  // public override function set_style(style:rehax.Style):rehax.Style {
  //   var el = document.querySelector("body");
  //   el.setElementStyle(style);
  //   return style;
  // }
}
#end
