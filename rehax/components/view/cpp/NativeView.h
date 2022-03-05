#pragma once
// #include "../../../cpp/yoga/Yoga.h"

#ifndef RHX_EXPORT
#define RHX_EXPORT
#if defined(_WIN64) || defined(_WIN32)
#define RHX_EXPORT __declspec(dllexport)
#endif
#endif

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

  RHX_EXPORT virtual void createFragment();
  RHX_EXPORT virtual void addView(NativeView *child);
  RHX_EXPORT virtual void removeView(NativeView *child);
  RHX_EXPORT virtual void removeFromParent();

  RHX_EXPORT void setWidthFill();
  RHX_EXPORT void setHeightFill();
  RHX_EXPORT void setWidthNatural();
  RHX_EXPORT void setHeightNatural();
  RHX_EXPORT void setWidthFixed(float width);
  RHX_EXPORT void setHeightFixed(float height);
  RHX_EXPORT void setWidthPercentage(float percent);
  RHX_EXPORT void setHeightPercentage(float percent);
  RHX_EXPORT void setWidthFlex(float flex, float totalFlex);
  RHX_EXPORT void setHeightFlex(float flex, float totalFlex);

  RHX_EXPORT void setVerticalPositionNatural(NativeView *previousView);
  RHX_EXPORT void setHorizontalPositionNatural(NativeView *previousView);
  RHX_EXPORT void setVerticalPositionFixed(float x);
  RHX_EXPORT void setHorizontalPositionFixed(float y);

  RHX_EXPORT void setBackgroundColor(NativeColor color);
  RHX_EXPORT void setTextColor(NativeColor color);
  RHX_EXPORT void setOpacity(float opacity);

  // void layout();

  void *nativeView = nullptr;
};
