package rehax.components.view.cpp;

@:native('NativeGesture')
@:include("rehax/components/view/cpp/NativeGesture.h")
@:unreflective
@:structAccess
extern class NativeGesture {

    @:native('NativeGesture')
    public function new();
	public function setup(action:() -> Void, onMouseDown:(xInView:Float, yInView:Float) -> Void, onMouseUp:(xInView:Float, yInView:Float) -> Void,
		onMouseMove:(xInView:Float, yInView:Float) -> Void):Void;
    public function setState(state:Int):Void;
}

enum GestureState {
    Possible;
    Recognized;
    Began;
    Changed;
    Canceled;
    Ended;
}

class Gesture {

    public var native:NativeGesture;

    public function new(action:() -> Void) {
        this.action = action;
        untyped __cpp__('native.setup([this] () { doAction(); }, [this] (float x, float y) { onMouseDown(x, y); }, [this] (float x, float y) { onMouseUp(x, y); }, [this] (float x, float y) { onMouseMove(x, y); })');
    }

    public function onMouseDown(xInView:Float, yInView:Float) {}
    public function onMouseUp(xInView:Float, yInView:Float) {}
    public function onMouseMove(xInView:Float, yInView:Float) {}
    public function doAction() {
        action();
    }

    public var action = () -> {};
    public var state(default, set) = Possible;

    public function set_state(state:GestureState):GestureState {
        this.state = state;
        switch(state) {
            case Possible:
                native.setState(0);
            case Recognized:
                native.setState(1);
            case Began:
                native.setState(2);
            case Changed:
                native.setState(3);
            case Canceled:
                native.setState(4);
            case Ended:
                native.setState(5);
        }
        return state;
    }

}
