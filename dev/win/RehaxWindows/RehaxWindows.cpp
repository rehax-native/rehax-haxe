#include <windows.h>
#include <iostream>
#include "../../../rehax/components/root/cpp/NativeRoot.h"
#include "../lib/include/rhx/dev/App.h"

int APIENTRY wWinMain(_In_ HINSTANCE hInstance,
    _In_opt_ HINSTANCE hPrevInstance,
    _In_ LPWSTR    lpCmdLine,
    _In_ int       nCmdShow)
{
    UNREFERENCED_PARAMETER(hInstance);
    UNREFERENCED_PARAMETER(hPrevInstance);
    UNREFERENCED_PARAMETER(lpCmdLine);
    UNREFERENCED_PARAMETER(nCmdShow);

    HX_TOP_OF_STACK
    ::hx::Boot();
    __boot_all();
    dev::App_obj::main();

    // auto root = new NativeRoot();
    // root->initialize([]() {
    //     std::cout << "DONE" << std::endl;
    // });
    return 0;
}