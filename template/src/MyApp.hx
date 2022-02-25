package ;

using rehax.Rehax;
using rehax.components.Components;
using rehax.Style;

class MyApp extends Component {
  static function main() {
    App.mountRoot(new MyApp());
  }

  public function new() {
    super();
  }

  var text = "Hello World";

  var body = <View>
    {text}
  </View>;
}
