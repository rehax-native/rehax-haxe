package dev;

import Type as RunTimeType;

using rehax.components.Components;
using rehax.Rehax;
using rehax.Style;

using rehax.components.vector.Vector;

class LayoutTest1 extends Component {
  public function new() {
    super();
  }

  var body = <View>
    <Button text={"Button"} />
  </View>
}

class LayoutTest2 extends Component {
  public function new() {
    super();
  }

  var body = <View>
    <View position={{ left: Fixed(10), top: Fixed(10) }} size={{ width: Fixed(20), height: Fixed(10) }} style={[ backgroundColor(Color.Red())]} />
    <Button text={"Button"} />
    <View position={{ left: Fixed(20), top: Fixed(15) }} size={{ width: Fixed(20), height: Fixed(20) }} style={[ backgroundColor(Color.Green())]} />
    <Button text={"Button"} />
  </View>
}

class LayoutTest3 extends Component {
  public function new() {
    super();
  }

  var isDirVertical = true;

  var body = <View size={{ width: Fill, height: Fill }} layoutDirection={isDirVertical ? Vertical : Horizontal }>
    <Button text={"Button fill"} size={{ width: isDirVertical ? Fill : Fixed(100), height: Natural }} />
    <Button text={"Button natural"} />
    <Button text={"Button fill"} size={{ width: isDirVertical ? Fill : Fixed(100), height: Natural }} />
    <Button text={"Button percentage 25%"} size={{ width: Percentage(25), height: Natural }} />
    <Button text={"Button flex 1"} size={{ width: Flex(1), height: Natural }} />
    <Button text={"Button fixed 200"} size={{ width: Fixed(200), height: Natural }} />
    <Button text={"Button natural/change dir"} onClick={() -> {
      isDirVertical = !isDirVertical;
      updateViews();
    }} />
  </View>
}

class LayoutTest4 extends Component {
  public function new() {
    super();
  }

  var alignment:AlignmentCrossAxis = Start;

  function setAlignment(alignmentCrossAxis:AlignmentCrossAxis) {
    this.alignment = alignmentCrossAxis;
    updateViews();
  }

  var body = <View size={{ width: Fill, height: Fill }} layoutDirection={Horizontal} alignmentCrossAxis={alignment}>
    <Button text={"Button 100 / Main Axis flex start"} size={{ width: Fixed(100), height: Natural }} onClick={() -> setAlignment(Start)} />
    <Button text={"Button natural"} onClick={() -> setAlignment(End)} />
    <Button text={"Button fill"} size={{ width: Fixed(100), height: Fill }} onClick={() -> setAlignment(Center)} />
    <Button text={"Button percentage 25%"} size={{ width: Percentage(25), height: Percentage(25) }} onClick={() -> setAlignment(Stretch)} />
    <Button text={"Button flex 1"} size={{ width: Flex(1), height: Flex(1) }} />
    <Button text={"Button fixed 200"} size={{ width: Fixed(200), height: Fixed(200) }} />
    <Button text={"Button natural/change dir"} />
  </View>
}
