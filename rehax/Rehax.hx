package rehax;

using rehax.components.Components;

@:autoBuild(rehax.builder.Builder.build())
class Component extends Fragment {
  public function new() {
    super();
  }
}

class Rehax {
  static var app:Null<Rehax> = null;

  var root:Root;
  var mainComponent:Component;

  public static function mountRoot(root:Component) {
    if (app != null) {
      // TODO Handle this
    }
    app = new Rehax(root);
    app.root.initialize(app.initDone);
  }

  public static function getRoot():View {
    return app.root;
  }

  private function new(main:Component) {
    this.mainComponent = main;
    root = new Root();
  }

  function initDone() {
    mainComponent.createFragment();
    mainComponent.mount(root);
  }
}
