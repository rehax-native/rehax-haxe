#include "NativeView.h"

NativePosition NativePosition::create(float x, float y)
{
  NativePosition pos;
  pos.x = x;
  pos.y = y;
  return pos;
}

NativeSize NativeSize::create(float width, float height)
{
  NativeSize size;
  size.width = width;
  size.height = height;
  return size;
}

NativeFrame NativeFrame::create(NativePosition position, NativeSize size)
{
  NativeFrame frame;
  frame.position = position;
  frame.size = size;
  return frame;
}

NativeColor NativeColor::create(float r, float g, float b, float a)
{
  NativeColor color;
  color.r = r;
  color.g = g;
  color.b = b;
  color.a = a;
  return color;
}

void NativeView::createFragment()
{}

void NativeView::addView(NativeView *child)
{}

void NativeView::removeView(NativeView *child)
{}

void NativeView::removeFromParent()
{}

void NativeView::setWidthFixed(float width)
{}

void NativeView::setHeightFixed(float height)
{}

void NativeView::setWidthFill()
{}

void NativeView::setHeightFill()
{}

void NativeView::setBackgroundColor(NativeColor color)
{}

void NativeView::setTextColor(NativeColor color)
{}

void NativeView::setOpacity(float opacity)
{}
