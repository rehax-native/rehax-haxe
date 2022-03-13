#include "pch.h"
#include "./NativeButton.h"
#include "../../view/cpp/NativeView.win.h"
/*
#include <winrt/base.h>
#include <winrt/Windows.UI.Xaml.Controls.h>

using namespace winrt;
using namespace Windows::UI::Xaml::Controls;
using namespace Windows::UI::Xaml;
*/

void NativeButton::createFragment()
{
    Controls::Button btn;
    UIElement element = btn.try_as<UIElement>();
    auto wrapper = new NativeViewWrapper { element };
    nativeView = (void*) wrapper;
}

void NativeButton::setText(const char * text)
{
    NativeViewWrapper * wrapper = (NativeViewWrapper * ) nativeView;
    Controls::TextBlock textBlock;

    size_t size = strlen(text) + 1;
    wchar_t* wcstring = new wchar_t[size];
    size_t convertedChars = 0;
    mbstowcs_s(&convertedChars, wcstring, size, text, _TRUNCATE);
    textBlock.Text(wcstring);
    if (Controls::Button button = wrapper->element.try_as<Controls::Button>()) {
        button.Content(textBlock);
    }
}

const char * NativeButton::getText()
{
    return "No text";
}

void NativeButton::setTextColor(NativeColor color)
{}

void NativeButton::addView(NativeView * child)
{}

void NativeButton::setOnClick(std::function<void(void)> onClick)
{
    NativeViewWrapper* wrapper = (NativeViewWrapper*)nativeView;
    if (Controls::Button button = wrapper->element.try_as<Controls::Button>()) {
        button.Tapped([onClick](auto&, auto&) {
            onClick();
        });
    }
}