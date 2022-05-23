package rehax.components.view.web;

enum GestureState {
    Possible;
    Recognized;
    Began;
    Changed;
    Canceled;
    Ended;
}

// class FluxeGesture
//     implements fluxe.events.MouseEventsManager.IMouseDownEventListener
//     implements fluxe.events.MouseEventsManager.IMouseUpEventListener
//     implements fluxe.events.MouseEventsManager.IMouseMoveEventListener
// {

//     private var action:() -> Void;
//     private var mouseDownCb:(x:Float,y:Float) -> Void;
//     private var mouseUpCb:(x:Float,y:Float) -> Void;
//     private var mouseMoveCb:(x:Float,y:Float) -> Void;

//     public function new(action:() -> Void, onMouseDown:(x:Float,y:Float) -> Void, onMouseUp:(x:Float,y:Float) -> Void, onMouseMove:(x:Float,y:Float) -> Void) {
//         this.action = action;
//         this.mouseDownCb = onMouseDown;
//         this.mouseUpCb = onMouseUp;
//         this.mouseMoveCb = onMouseMove;
//     }

//     public function onMouseDown(event:fluxe.events.MouseEventsManager.MouseDownEvent):Void {
//         mouseDownCb(event.left, event.top);
//     }
//     public function onMouseUp(event:fluxe.events.MouseEventsManager.MouseUpEvent):Void {
//         mouseUpCb(event.left, event.top);
//     }
//     public function onMouseMove(event:fluxe.events.MouseEventsManager.MouseMoveEvent):Void {
//         mouseMoveCb(event.left, event.top);
//     }
// }

class Gesture {
    // public var fluxeGesture:FluxeGesture;
    public var action = () -> {};

    public function new(action:() -> Void) {
        this.action = action;
        // fluxeGesture = new FluxeGesture(
        //     action,
        //     (x:Float, y:Float) -> {
        //         this.onMouseDown(x, y);
        //         switch(state) {
        //             case Began:
        //                 this.action();
        //             case Recognized:
        //                 this.action();
        //             case Changed:
        //                 this.action();
        //             default:
        //         }
        //         this.state = Possible;
        //     },
        //     (x:Float, y:Float) -> {
        //         this.onMouseUp(x, y);
        //         switch(state) {
        //             case Began:
        //                 this.action();
        //             case Recognized:
        //                 this.action();
        //             case Changed:
        //                 this.action();
        //             default:
        //         }
        //         this.state = Possible;
        //     },
        //     (x:Float, y:Float) -> {
        //         this.onMouseMove(x, y);
        //         switch(state) {
        //             case Began:
        //                 this.action();
        //             case Recognized:
        //                 this.action();
        //             case Changed:
        //                 this.action();
        //             default:
        //         }
        //         this.state = Possible;
        //     }
        // );
    }

    public function onMouseDown(xInView:Float, yInView:Float) {}
    public function onMouseUp(xInView:Float, yInView:Float) {}
    public function onMouseMove(xInView:Float, yInView:Float) {}

    public var state = Possible;
}
