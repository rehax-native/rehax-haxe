package dev;

import Type as RunTimeType;

using rehax.components.Components;
using rehax.Rehax;
using rehax.Style;

using rehax.components.vector.Vector;
using rehax.components.vector.Vector;
using rehax.components.vector.Vector;

class HeartShape extends Component {
  var body = <View size={{ width: SizeDimension.Fixed(100), height: SizeDimension.Fixed(100) }}>
    <VectorContainer width={100} height={100}>
      <VectorLinearGradient id={"gradient1"} stops={[
        {
          offset: 0.0,
          color: Color.Black()
        },
        {
          offset: 0.2,
          color: Color.Red()
        },
        {
          offset: 0.5,
          color: Color.Red()
        },
        {
          offset: 1.0,
          color: Color.White()
        },
      ]}/>
      <VectorRadialGradient id={"gradient2"} stops={[
        {
          offset: 0.0,
          color: Color.Black()
        },
        {
          offset: 1.0,
          color: Color.Red()
        },
      ]}/>
      <VectorPath operations={[
        MoveTo(10, 30),
        Arc(20, 20, 0, 0, 1, 50, 30),
        Arc(20, 20, 0, 0, 1, 90, 30),
        QuadraticBezier(90, 60, 50, 90),
        QuadraticBezier(10, 60, 10, 30),
        Close,
      ]} vectorStyle={[
        StrokeLineJoin(Miter),
        StrokeWidth(5),
        StrokeWithDefinition('gradient1'),
        FillWithDefinition('gradient2'),
      ]} />
    </VectorContainer>
  </View>
}
