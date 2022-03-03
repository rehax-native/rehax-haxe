#pragma once

#include <functional>
#include "../../view/cpp/NativeView.h"

class NativeVectorContainer : public NativeView
{
public:
  void createFragment() override;

  void setDrawCallback(std::function<void(void)> cb);

  void setFillColor();
  void setStrokeColor();

  void beginPath();
  void pathHorizontalTo(float x);
  void pathVerticalTo(float y);
  void pathMoveTo(float x, float y);
  void pathMoveBy(float x, float y);
  void pathLineTo(float x, float y);
  void pathArc(float rx, float ry, float xAxisRotation, int largeArcFlag, int sweepFlag, float x, float y);
  void pathCubicBezier(float x1, float y1, float x2, float y2, float x, float y);
  void pathQuadraticBezier(float x1, float y1, float x, float y);
  void pathClose();
  void pathStroke(float width, int capsStyle, int joinStyle);
  void pathFill();
  void endPath();
};
