#pragma once

#include <functional>
#include "../../view/cpp/NativeView.h"

class NativeVectorContainer : public NativeView
{
public:
  RHX_EXPORT void createFragment() override;

  RHX_EXPORT void setDrawCallback(std::function<void(void)> cb);

  RHX_EXPORT void setFillColor();
  RHX_EXPORT void setStrokeColor();

  RHX_EXPORT void beginPath();
  RHX_EXPORT void pathHorizontalTo(float x);
  RHX_EXPORT void pathVerticalTo(float y);
  RHX_EXPORT void pathMoveTo(float x, float y);
  RHX_EXPORT void pathMoveBy(float x, float y);
  RHX_EXPORT void pathLineTo(float x, float y);
  RHX_EXPORT void pathArc(float rx, float ry, float xAxisRotation, int largeArcFlag, int sweepFlag, float x, float y);
  RHX_EXPORT void pathCubicBezier(float x1, float y1, float x2, float y2, float x, float y);
  RHX_EXPORT void pathQuadraticBezier(float x1, float y1, float x, float y);
  RHX_EXPORT void pathClose();
  RHX_EXPORT void pathStroke(float width, int capsStyle, int joinStyle);
  RHX_EXPORT void pathFill();
  RHX_EXPORT void endPath();
};
