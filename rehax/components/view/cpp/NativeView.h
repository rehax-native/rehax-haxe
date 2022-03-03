#pragma once
// #include "../../../cpp/yoga/Yoga.h"

struct NativePosition
{
  float x;
  float y;
  static NativePosition create(float x, float y);
};

struct NativeSize
{
  float width;
  float height;
  static NativeSize create(float width, float height);
};

struct NativeFrame
{
  NativePosition position;
  NativeSize size;
  static NativeFrame create(NativePosition position, NativeSize size);
};

struct NativeColor
{
  float r;
  float g;
  float b;
  float a;
  static NativeColor create(float r, float g, float b, float a);
};

class NativeView
{
public:
  // YGNodeRef node;

  virtual void createFragment();
  virtual void addView(NativeView *child);
  virtual void removeView(NativeView *child);
  virtual void removeFromParent();

  void setWidthFill();
  void setHeightFill();
  void setWidthNatural();
  void setHeightNatural();
  void setWidthFixed(float width);
  void setHeightFixed(float height);
  void setWidthPercentage(float percent);
  void setHeightPercentage(float percent);
  void setWidthFlex(float flex, float totalFlex);
  void setHeightFlex(float flex, float totalFlex);

  void setVerticalPositionNatural(NativeView *previousView);
  void setHorizontalPositionNatural(NativeView *previousView);
  void setVerticalPositionFixed(float x);
  void setHorizontalPositionFixed(float y);

  void setBackgroundColor(NativeColor color);
  void setTextColor(NativeColor color);
  void setOpacity(float opacity);

  // void layout();

  void *nativeView = nullptr;
};
