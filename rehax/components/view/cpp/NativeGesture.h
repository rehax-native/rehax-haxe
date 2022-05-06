#pragma once

#include <functional>
#include "./NativeView.h"

class NativeGesture {

public:
    void setup(std::function<void(void)> action, std::function<void(float, float)> onMouseDown, std::function<void(float, float)> onMouseUp, std::function<void(float, float)> onMouseMove);
    void setState(int state);

    void * native;
};
