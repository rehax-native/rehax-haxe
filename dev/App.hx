package dev;

import Type as RunTimeType;

using rehax.components.Components;
using rehax.Rehax;
using rehax.Style;
using dev.LayoutTest;
using dev.VectorTest;


class App extends Component {
  static function main() {
    Rehax.mountRoot(new App());
  }

  public function new() {
    super();
  }

  var body = <View size={{ width: Fill, height: Fill }}>
    <HeartShape />
  </View>;
    // <LayoutTest4 />

    // <LayoutTest2 />
    // <LayoutTest3 />
    // <LayoutTest3 />
    // <LayoutTest4 />
}
