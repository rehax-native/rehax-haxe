package dev;

import Type as RunTimeType;

using rehax.components.Components;
using rehax.Rehax;
using rehax.Style;
using dev.FlexLayoutTest;
using dev.SomeAppTest;
// using dev.LayoutTest;
using dev.VectorTest;
using dev.GestureTest;

class App extends Component {
  static function main() {
    Rehax.mountRoot(new App());
  }

  public function new() {
    super();
  }

  // var email = "";
  // // var body = <Text text={"Hey there"} />;
  // var body = <View>
  //   Email
  //   <TextInput value={email} placeholder={"Email"} />

  //   <Button text={"Login"} onClick={() -> trace("OK")} />
  // </View>;

  // var body = <View>
  //   Hello World
  //   <Button text={"Click Me"} onClick={() -> trace("OK")} />
  //   <TextInput value={""} placeholder={"Email"} />
  // </View>;

  var body = <FlexLayoutTest1 />;
  // var body = <SomeAppTest />;
  // var body = <HeartShapeColorful />;
  // var body = <GestureTest />;
  // var body = <Knob />;


    // <Button text={"General Kenobi"} />;

  // var body = <View size={{ width: Fill, height: Fill }}>
  //   <LayoutTest4 />
  // </View>;
  // var body = <View size={{ width: Fill, height: Fill }}>
  //   <HeartShape />
  // </View>;
    // <LayoutTest4 />

    // <LayoutTest2 />
    // <LayoutTest3 />
    // <LayoutTest3 />
    // <LayoutTest4 />
}
