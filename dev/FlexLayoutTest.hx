package dev;

using rehax.components.Components;
using rehax.Rehax;
using rehax.Style;

class FlexLayoutTest1 extends Component {
  public function new() {
    super();
  }

  private var justify:rehax.components.layout.FlexLayout.FlexJustifyContent = FlexStart;
  private var align:rehax.components.layout.FlexLayout.FlexAlignItems = FlexStart;
  private var flexGrow = true;

  var body = <View layout={FlexLayout.Create({
    justifyContent: justify,
    alignItems: align,
    items: [
      {},
      {},
      { flexGrow: flexGrow ? 1.0 : null },
      {},
      { flexGrow: flexGrow ? 2.0 : null },
      {},
      {},
    ]
  })}>
    <Button text={"Button 1 | Justify Flex Start"} onClick={() -> { justify = FlexStart; updateViews(); }} />
    <Button text={"Button 2 | Justify Flex End"} onClick={() -> { justify = FlexEnd; updateViews(); }} />
    <View>
      <Button text={"Button flex 1 | Justify Center"} onClick={() -> { justify = Center; updateViews(); }} />
    </View>
    <Button text={"Button 3 | Toggle flex grow"} onClick={() -> { flexGrow = !flexGrow; updateViews(); }} />
    <View>
      <Button text={"Button flex 2 | Align Center"} onClick={() -> { align = Center; updateViews(); }} />
    </View>
    <Button text={"Button 4 | Align Start"} onClick={() -> { align = FlexStart; updateViews(); }} />
    <Button text={"Button 5 | Align End"} onClick={() -> { align = FlexEnd; updateViews(); }} />
    <Button text={"Button 6 | Align Stretch"} onClick={() -> { align = Stretch; updateViews(); }} />
  </View>;
}

