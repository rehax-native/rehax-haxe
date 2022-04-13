package dev;

using rehax.components.Components;
using rehax.Rehax;
using rehax.Style;

class FlexLayoutTest1 extends Component {
  public function new() {
    super();
  }

  var body = <View layout={FlexLayout.Create({
    items: [
      {},
      {},
      { flexGrow: 1.0 },
      {},
      { flexGrow: 1.0 },
      {},
      {},
    ]
  })}>
    <Button text={"Button 1"} />
    <Button text={"Button 2"} />
    <View>
      <Button text={"Button flex 1"} />
    </View>
  </View>;
}
    // <Button text={"Button 3"} />
    // <View>
    //   <Button text={"Button flex 2"} />
    // </View>
    // <Button text={"Button 4"} />
    // <Button text={"Button 5"} />
