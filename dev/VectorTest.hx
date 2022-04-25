package dev;

import Type as RunTimeType;

using rehax.components.Components;
using rehax.Rehax;
using rehax.Style;

using rehax.components.vector.Vector;

class HeartShape extends Component {
  var body = <View size={{ width: SizeDimension.Fixed(100), height: SizeDimension.Fixed(100) }}>
    <VectorContainer width={100} height={100}>
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
        Stroke(Color.Red()),
        Fill(Color.Black()),
      ]} />
    </VectorContainer>
  </View>
}

class HeartShapeColorful extends Component {
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


// class PrettyColors {
//   public static var GreenishColor = {
//     base: Color.RGBA(69.0, 244.0, 213.0, 1.0),
//     variant: Color.RGBA(9.0, 184.0, 154.0, 1.0),
//   };
// }

// class Knob extends Component {
//   var WIDTH = 100.0;
//   var HEIGHT = 100.0;
//   var radius = 40.0;
//   var HALF_WIDTH = 50.0;
//   var HALF_HEIGHT = 50.0;
//   var OPEN_ANGLE = 70.0;

//   public var value(default, set) = 0.7;
//   var largeArc = 1;
//   var arcDirection = 1;

//   var startPosX = 0.0;
//   var startPosY = 0.0;
//   var valuePosX = 0.0;
//   var valuePosY = 0.0;
//   var endPosX = 0.0;
//   var endPosY = 0.0;

//   public function new() {
//     super();
//     calc();
//   }

//   public function set_value(value:Float):Float {
//     this.value = value;
//     calc();
//     return value;
//   }

//   var body = <View size={{ width: SizeDimension.Fixed(WIDTH), height: SizeDimension.Fixed(HEIGHT) }}>
//     <VectorContainer width={WIDTH} height={HEIGHT}>
//       <VectorRadialGradient id={"gradient"} stops={[
//         {
//           offset: 0.0,
//           color: PrettyColors.GreenishColor.base,
//         },
//         {
//           offset: 1.0,
//           color: PrettyColors.GreenishColor.variant,
//         },
//       ]} />
//       <VectorPath operations={[
//         MoveTo(startPosX, startPosY),
//         Arc(radius, radius, 0, 1, arcDirection, endPosX, endPosY),
//       ]} vectorStyle={[
//         StrokeLineCap(Round),
//         StrokeWidth(5),
//         Stroke(Color.Black().withOpacity(0.3)),
//       ]} />
//       <VectorPath operations={[
//         // TODO Blur
//         MoveTo(startPosX, startPosY),
//         Arc(radius, radius, 0, largeArc, arcDirection, valuePosX, valuePosY),
//       ]} vectorStyle={[
//         StrokeLineCap(Round),
//         StrokeWidth(5),
//         StrokeWithDefinition('gradient'),
//       ]} />
//       <VectorPath operations={[
//         MoveTo(startPosX, startPosY),
//         Arc(radius, radius, 0, largeArc, arcDirection, valuePosX, valuePosY),
//       ]} vectorStyle={[
//         StrokeLineCap(Round),
//         StrokeWidth(5),
//         StrokeWithDefinition('gradient'),
//       ]} />
//     </VectorContainer>
//   </View>;

//   private function calc() {
//     var a0 = 0.0;
//     var maxAngle = 360.0 - OPEN_ANGLE;
//     var a1 = -(maxAngle - a0) * value;

//     var startPos = getViewboxCoord(a0 - 90.0 - OPEN_ANGLE / 2.0, radius);
//     var valuePos = getViewboxCoord(a1 - 90.0 - OPEN_ANGLE / 2.0, radius);
//     var endPos = getViewboxCoord(-maxAngle - 90.0 - OPEN_ANGLE / 2.0, radius);

//     var delta_angle = (a0 - a1 + 360.0) % 360.0;

//     largeArc = delta_angle < 180.0 ? 0 : 1;
//     arcDirection = 1;

//     startPosX = startPos.x;
//     startPosY = startPos.y;
//     endPosX = endPos.x;
//     endPosY = endPos.y;
//     valuePosX = valuePos.x;
//     valuePosY = valuePos.y;
//   }

//   private function getViewboxCoord(angle:Float, radius:Float):{ x: Float, y: Float} {
//     var a = angle * Math.PI / 180.0;
//     var r = radius;
//     var x = Math.cos(a) * r;
//     var y = Math.sin(a) * r;
//     return {
//         x: HALF_WIDTH + x,
//         y: HALF_HEIGHT - y
//     }
//   }
// }
