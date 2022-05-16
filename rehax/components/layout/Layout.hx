package rehax.components.layout;

enum SizeDimension {
  /** Natural, meaning the same size as its' content **/
  Natural;

  /** Fixed size in screen independent pixels **/
  Fixed(size:Float);

  /** Fill the parent **/
  Fill;

  /** Percentage of parent **/
  Percentage(percent:Float);
}

enum PositionDimension {
  /** Natural, meaning the position it's assigned by the parent **/
  Natural;

  /** Fixed positin in screen independent pixels **/
  Fixed(size:Float);
}

typedef Size = {
  var width:SizeDimension;
  var height:SizeDimension;
}

typedef Position = {
  var left:PositionDimension;
  var top:PositionDimension;
}

typedef Frame = {
  var position:Position;
  var size:Size;
}

#if js
// typedef View = rehax.components.view.web.View.View;
#elseif fluxe
interface ILayout {
  public var fluxeLayout:fluxe.layout.ILayout;
}
#elseif cpp
interface ILayout {
  public function layout(container:cpp.Pointer<rehax.components.view.cpp.View.NativeView>):Void;
  public function cleanUp(container:cpp.Pointer<rehax.components.view.cpp.View.NativeView>):Void;
}
// typedef View = rehax.components.view.cpp.View.View;
#end