package dev;

using rehax.components.Components;
using rehax.Rehax;
using rehax.Style;

class Browser extends Component {
    public static var plugins:Array<String> = [
      'Test A',
      'Test B',
      'Test C',
    ];
  var body = <View layout={StackLayout.Create({
      spacing: 5.0
    })}>
    Browser
    {for name in plugins}
      <View>{name}</View>
    {/for}
  </View>;
}

class Header extends Component {
  var body = <View layout={StackLayout.Create({
    direction: Horizontal
  })}>
    <Button text={"Play"} />
    00:00:00
  </View>;
}

class Tester extends Component {
  var body = <View>Tester</View>;
}

class SomeAppTest extends Component {
  var body = <View layout={FlexLayout.Create({
      direction: Row,
      items: [
        { flexGrow: 1.0 },
        { flexGrow: 3.0 },
      ]
  })}>
    <View>
      <Browser />
    </View>
    <View>
      <Header />
      <Tester />
    </View>
  </View>;

  public override function componentDidMount() {
    trace(this._body);
  }
}
