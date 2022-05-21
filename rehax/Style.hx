package rehax;

class Color {
  public var red = 0.0;
  public var green = 0.0;
  public var blue = 0.0;
  public var alpha = 1.0;

  public static function RGB(red:Float, green:Float, blue:Float):Color {
    var color = new Color();
    color.red = Math.max(0.0, Math.min(255.0, red));
    color.green = Math.max(0.0, Math.min(255.0, green));
    color.blue = Math.max(0.0, Math.min(255.0, blue));
    return color;
  }

  public static function RGBA(red:Float, green:Float, blue:Float, alpha:Float):Color {
    var color = RGB(red, green, blue);
    color.alpha = Math.max(0.0, Math.min(1.0, alpha));
    return color;
  }

  public static function Transparent():Color {
    return RGBA(255, 255, 255, 0);
  }

  public static function White():Color {
    return RGB(255, 255, 255);
  }

  public static function Black():Color {
    return RGB(0, 0, 0);
  }

  public static function Red():Color {
    return RGB(255, 0, 0);
  }

  public static function Green():Color {
    return RGB(0, 255, 0);
  }

  public static function Blue():Color {
    return RGB(0, 0, 255);
  }

  public function new(?color:Color = null) {
    if (color != null) {
      this.red = color.red;
      this.green = color.green;
      this.blue = color.blue;
      this.alpha = color.alpha;
    }
  }

  public function withOpacity(opacity:Float) {
    var newColor = new Color(this);
    newColor.alpha = opacity;
    return newColor;
  }
}

enum StyleProperty {
  backgroundColor(color:Color);
  textColor(color:Color);
  opacity(opacity:Float);
}

enum MediaQueryOrientation {
  Portrait;
  Landscape;
}

enum MediaQueryDeclaration {
  MinWidth(width:Float);
  MaxWidth(width:Float);
  AspectRatio(ratio:Float);
  MinAspectRatio(ratio:Float);
  MaxAspectRatio(ratio:Float);
  Orientation(orientation:MediaQueryOrientation);
  MinResolution(resolution:Float);
  MaxResolution(resolution:Float);
  Or(queries:Array<MediaQueryDeclaration>);
}

class StyleDefinition {
  var styles:Array<StyleProperty> = [];
  var queries:Null<Array<MediaQueryDeclaration>>;

  function new(styles:Array<StyleProperty>, ?queries:Array<MediaQueryDeclaration>) {
    this.styles = styles;
    this.queries = queries;
  }
}

typedef Style = Array<StyleProperty>
