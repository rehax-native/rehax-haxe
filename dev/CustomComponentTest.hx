package dev;

using rehax.components.Components;
using rehax.Rehax;
using rehax.Style;

class CustomComponent extends Component {
  public function new() {
    super();
  }

  var showSlot = true;

  var body = <View>
    My Custom Body
    {showSlot}
    {if showSlot}
            Toggling
        <Slot />
    {/if}
    <Button text={"Toggle slot"} onClick={() -> { showSlot = !showSlot; updateViews(); }} />
  </View>;
}

class CustomComponentTest extends Component {
  public function new() {
    super();
  }

  var body = <View layout={StackLayout.Create({ spacing: 10.0 })}>
    Outside the custom component
    <CustomComponent>
        Inside the custom component
        <View>!</View>
    </CustomComponent>
  </View>;
}
