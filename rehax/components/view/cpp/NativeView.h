#pragma once
// #include "../../../cpp/yoga/Yoga.h"

#ifndef RHX_EXPORT
#if defined(_WIN64) || defined(_WIN32)
#define RHX_EXPORT __declspec(dllexport)
#else
#define RHX_EXPORT
#endif
#endif

struct NativePosition
{
  float x;
  float y;
  RHX_EXPORT static NativePosition create(float x, float y);
};

struct NativeSize
{
  float width;
  float height;
  RHX_EXPORT static NativeSize create(float width, float height);
};

struct NativeFrame
{
  NativePosition position;
  NativeSize size;
  RHX_EXPORT static NativeFrame create(NativePosition position, NativeSize size);
};

struct NativeColor
{
  float r;
  float g;
  float b;
  float a;
  RHX_EXPORT static NativeColor create(float r, float g, float b, float a);
};

class NativeView
{
public:
  RHX_EXPORT virtual void createFragment();
  RHX_EXPORT virtual void addView(NativeView *child);
  RHX_EXPORT virtual void removeView(NativeView *child);
  RHX_EXPORT virtual void removeFromParent();
  RHX_EXPORT virtual void teardown();

  // Layouting
  RHX_EXPORT void setWidthFill();
  RHX_EXPORT void setHeightFill();
  RHX_EXPORT virtual void setWidthNatural();
  RHX_EXPORT virtual void setHeightNatural();
  RHX_EXPORT void setWidthFixed(float width);
  RHX_EXPORT void setHeightFixed(float height);
  RHX_EXPORT void setWidthPercentage(float percent);
  RHX_EXPORT void setHeightPercentage(float percent);

  RHX_EXPORT virtual void setVerticalPositionNatural(NativeView *previousView);
  RHX_EXPORT virtual void setHorizontalPositionNatural(NativeView *previousView);
  RHX_EXPORT void setVerticalPositionFixed(float x);
  RHX_EXPORT void setHorizontalPositionFixed(float y);

  // Styling
  RHX_EXPORT void setBackgroundColor(NativeColor color);
  RHX_EXPORT void setTextColor(NativeColor color);
  RHX_EXPORT void setOpacity(float opacity);

  RHX_EXPORT void setNativeViewRaw(void * nativeView);

  void *nativeView = nullptr;
};

class INativeLayout {
  virtual void layoutContainer(NativeView* container) = 0;
};
