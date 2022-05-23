package dev;

using rehax.components.Components;
using rehax.Rehax;
using rehax.Style;

class CustomComponent extends Component {
  public function new() {
    super();
  }
  var body = <View>
    My Custom Body
    {children}
  </View>;
}

class CustomComponentTest extends Component {
  public function new() {
    super();
  }

  var body = <View>
    Outside the custom component
    <CustomComponent>
        Inside the custom component
        <View>!</View>
    </CustomComponent>
  </View>;
}

