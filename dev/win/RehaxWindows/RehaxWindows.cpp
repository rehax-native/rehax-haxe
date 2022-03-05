#include <windows.h>
#include <iostream>
#include "../../../rehax/components/root/cpp/NativeRoot.h"

int APIENTRY wWinMain(_In_ HINSTANCE hInstance,
    _In_opt_ HINSTANCE hPrevInstance,
    _In_ LPWSTR    lpCmdLine,
    _In_ int       nCmdShow)
{
    UNREFERENCED_PARAMETER(hInstance);
    UNREFERENCED_PARAMETER(hPrevInstance);
    UNREFERENCED_PARAMETER(lpCmdLine);
    UNREFERENCED_PARAMETER(nCmdShow);
    auto root = new NativeRoot();
    root->initialize([]() {
        std::cout << "DONE" << std::endl;
    });
    return 0;
}