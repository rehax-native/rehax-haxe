package dev;

using rehax.components.Components;
using rehax.Rehax;
using rehax.Style;

class CustomGesture extends Gesture {
    private var onChange:(x:Float, y:Float) -> Void;
    private var startX = 0.0;
    private var startY = 0.0;
    private var currentX = 0.0;
    private var currentY = 0.0;
    private var isDown = false;

    public function new(onChange:(x:Float, y:Float) -> Void) {
        super(() -> { onChange(currentX - startX, currentY - startY); });
        this.onChange = onChange;
    }

    public override function onMouseDown(xInView:Float, yInView:Float) {
        startX = xInView;
        startY = yInView;
        currentX = xInView;
        currentY = yInView;
        this.state = Began;
        isDown = true;
    }

    public override function onMouseUp(xInView:Float, yInView:Float) {
        this.state = Ended;
        isDown = false;
    }

    public override function onMouseMove(xInView:Float, yInView:Float) {
        if (isDown) {
            currentX = xInView;
            currentY = yInView;
            this.state = Changed;
        }
    }
}

class GestureTest extends Component {

    var color = Color.RGBA(0.0, 0.0, 0.0, 1.0);

    var body = <View
        size={{
            width: Fixed(200),
            height: Fixed(200),
        }}
        style={[
            backgroundColor(color)
        ]}
    >
    </View>;

    public override function componentDidMount() {
        this._body.v_0.addGesture(new CustomGesture((x:Float, y:Float) -> {
            color = Color.RGBA(x, y, 0.0, 1.0);
            // trace(color.red);
            updateViews();
        }));
    }
}
