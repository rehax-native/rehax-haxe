#include "NativeRoot.h"
#include <iostream>
#include <windows.h>
#include <windows.ui.xaml.hosting.desktopwindowxamlsource.h>

#include <winrt/base.h>
#include <winrt/Windows.UI.Xaml.Controls.h>
#include <winrt/Windows.UI.Xaml.h>
#include <winrt/Windows.UI.Xaml.Hosting.h>
#include <winrt/Windows.UI.Xaml.Interop.h>
#include <winrt/Microsoft.Toolkit.Win32.UI.XamlHost.h>

#define IDS_APP_TITLE			103

#define IDR_MAINFRAME			128
#define IDD_WINDOWSPROJECT3_DIALOG	102
#define IDD_ABOUTBOX			103
#define IDM_ABOUT				104
#define IDM_EXIT				105
#define IDI_WINDOWSPROJECT3			107
#define IDI_SMALL				108
#define IDC_WINDOWSPROJECT3			109
#define IDC_MYICON				2
#ifndef IDC_STATIC
#define IDC_STATIC				-1
#endif
// Next default values for new objects
//
#ifdef APSTUDIO_INVOKED
#ifndef APSTUDIO_READONLY_SYMBOLS

#define _APS_NO_MFC					130
#define _APS_NEXT_RESOURCE_VALUE	129
#define _APS_NEXT_COMMAND_VALUE		32771
#define _APS_NEXT_CONTROL_VALUE		1000
#define _APS_NEXT_SYMED_VALUE		110
#endif
#endif


using namespace winrt;
using namespace Windows::UI::Xaml::Controls;
using namespace Windows::UI::Xaml;
using namespace Windows::UI::Xaml::Hosting;

// XamlApplication xapp{ nullptr };
DesktopWindowXamlSource desktopXamlSource{ nullptr };

#define MAX_LOADSTRING 100

// Global Variables:
HINSTANCE hInst;                                // current instance
// WCHAR szTitle[MAX_LOADSTRING];                  // The title bar text
// WCHAR szWindowClass[MAX_LOADSTRING];            // the main window class name
LPCWSTR szTitle = L"Test";
LPCWSTR szWindowClass = L"HuxiWindow";

// Forward declarations of functions included in this code module:
ATOM                MyRegisterClass(HINSTANCE hInstance);
BOOL                InitInstance(HINSTANCE, int);
LRESULT CALLBACK    WndProc(HWND, UINT, WPARAM, LPARAM);
INT_PTR CALLBACK    About(HWND, UINT, WPARAM, LPARAM);

// int APIENTRY wWinMain(_In_ HINSTANCE hInstance,
//                      _In_opt_ HINSTANCE hPrevInstance,
//                      _In_ LPWSTR    lpCmdLine,
//                      _In_ int       nCmdShow)
int initWindows()
{
    HINSTANCE hInstance = (HINSTANCE) GetModuleHandle(nullptr);
    STARTUPINFO si;
    GetStartupInfo(&si);
    int nCmdShow = si.wShowWindow;
    // UNREFERENCED_PARAMETER(hPrevInstance);
    // UNREFERENCED_PARAMETER(lpCmdLine);

    // TODO: Place code here.

    // Initialize global strings
    // LoadStringW(hInstance, IDS_APP_TITLE, szTitle, MAX_LOADSTRING);
    // LoadStringW(hInstance, IDC_WINDOWSPROJECT3, szWindowClass, MAX_LOADSTRING);
    MyRegisterClass(hInstance);

    // Usually we would have to do this, but seems like haxe is doing for us when we compile with -win_rt
    // winrt::init_apartment(apartment_type::single_threaded);
    std::cout << "Apartment inited" << std::endl;

    desktopXamlSource = DesktopWindowXamlSource();
    std::cout << "Have a source" << std::endl;

    // Perform application initialization:
    if (!InitInstance (hInstance, nCmdShow))
    {
        std::cout << "This didn't work" << std::endl;
        return FALSE;
    }

    HACCEL hAccelTable = LoadAccelerators(hInstance, MAKEINTRESOURCE(IDC_WINDOWSPROJECT3));

    MSG msg;

    // Main message loop:
    std::cout << "Going into main loop" << std::endl;
    while (GetMessage(&msg, nullptr, 0, 0))
    {
        if (auto xamlSourceNative2 = desktopXamlSource.as<IDesktopWindowXamlSourceNative2>()) {
            BOOL xamlSourceProcessedMessage = FALSE;
            winrt::check_hresult(xamlSourceNative2->PreTranslateMessage(&msg, &xamlSourceProcessedMessage));
            if (xamlSourceProcessedMessage) {
                continue;
            }
        }
        if (!TranslateAccelerator(msg.hwnd, hAccelTable, &msg))
        {
            TranslateMessage(&msg);
            DispatchMessage(&msg);
        }
    }

    std::cout << "Done" << std::endl;

    return (int) msg.wParam;
}



//
//  FUNCTION: MyRegisterClass()
//
//  PURPOSE: Registers the window class.
//
ATOM MyRegisterClass(HINSTANCE hInstance)
{
    WNDCLASSEXW wcex;

    wcex.cbSize = sizeof(WNDCLASSEX);

    wcex.style          = CS_HREDRAW | CS_VREDRAW;
    wcex.lpfnWndProc    = WndProc;
    wcex.cbClsExtra     = 0;
    wcex.cbWndExtra     = 0;
    wcex.hInstance      = hInstance;
    // wcex.hIcon          = LoadIcon(hInstance, MAKEINTRESOURCE(IDI_WINDOWSPROJECT3));
    wcex.hIcon          = LoadIcon(nullptr, IDI_APPLICATION);
    wcex.hCursor        = LoadCursor(nullptr, IDC_ARROW);
    wcex.hbrBackground  = (HBRUSH)(COLOR_WINDOW+1);
    // wcex.lpszMenuName   = MAKEINTRESOURCEW(IDC_WINDOWSPROJECT3);
    wcex.lpszMenuName   = nullptr;
    wcex.lpszClassName  = szWindowClass;
    // wcex.hIconSm        = LoadIcon(wcex.hInstance, MAKEINTRESOURCE(IDI_SMALL));
    wcex.hIconSm        = LoadIcon(nullptr, IDI_APPLICATION);

    return RegisterClassExW(&wcex);
}

//
//   FUNCTION: InitInstance(HINSTANCE, int)
//
//   PURPOSE: Saves instance handle and creates main window
//
//   COMMENTS:
//
//        In this function, we save the instance handle in a global variable and
//        create and display the main program window.
//
BOOL InitInstance(HINSTANCE hInstance, int nCmdShow)
{
   hInst = hInstance; // Store instance handle in our global variable

   HWND hWnd = CreateWindowW(szWindowClass, szTitle, WS_OVERLAPPEDWINDOW,
      CW_USEDEFAULT, 0, CW_USEDEFAULT, 0, nullptr, nullptr, hInstance, nullptr);

   if (!hWnd)
   {
      return FALSE;
   }

   ShowWindow(hWnd, nCmdShow);
   UpdateWindow(hWnd);

   return TRUE;
}

//
//  FUNCTION: WndProc(HWND, UINT, WPARAM, LPARAM)
//
//  PURPOSE: Processes messages for the main window.
//
//  WM_COMMAND  - process the application menu
//  WM_PAINT    - Paint the main window
//  WM_DESTROY  - post a quit message and return
//
//
LRESULT CALLBACK WndProc(HWND hWnd, UINT message, WPARAM wParam, LPARAM lParam)
{
    auto interop = desktopXamlSource.as<IDesktopWindowXamlSourceNative>();
    switch (message)
    {
    case WM_CREATE: {
        check_hresult(interop->AttachToWindow(hWnd));
        auto createStruct = reinterpret_cast<LPCREATESTRUCT>(lParam);
        HWND hWndXamlIsland = nullptr;
        check_hresult(interop->get_WindowHandle(&hWndXamlIsland));
        SetWindowPos(hWndXamlIsland, nullptr, 0, 0, createStruct->cx, createStruct->cy, SWP_SHOWWINDOW);

        // Controls::TextBlock tb;
        // tb.Text(L"Hello World");
        // desktopXamlSource.Content(tb);

        Controls::TextBox box;
        box.PlaceholderText(L"Placeholder x");
        //panel.Children().InsertAt(1, box);
        desktopXamlSource.Content(box);

        break;
    }
    case WM_COMMAND:
        {
            int wmId = LOWORD(wParam);
            // Parse the menu selections:
            switch (wmId)
            {
            case IDM_ABOUT:
                DialogBox(hInst, MAKEINTRESOURCE(IDD_ABOUTBOX), hWnd, About);
                break;
            case IDM_EXIT:
                DestroyWindow(hWnd);
                break;
            default:
                return DefWindowProc(hWnd, message, wParam, lParam);
            }
        }
        break;
    case WM_PAINT:
        {
            /*
            PAINTSTRUCT ps;
            HDC hdc = BeginPaint(hWnd, &ps);
            // TODO: Add any drawing code that uses hdc here...
            EndPaint(hWnd, &ps);
            */
        }
        break;
    case WM_SIZE:
    {
        HWND hWndXamlIsland = nullptr;
        check_hresult(interop->get_WindowHandle(&hWndXamlIsland));
        SetWindowPos(hWndXamlIsland, nullptr, 0, 0, LOWORD(lParam), HIWORD(lParam), SWP_SHOWWINDOW);
        break;
    }
    case WM_DESTROY:
        PostQuitMessage(0);
        break;
    default:
        return DefWindowProc(hWnd, message, wParam, lParam);
    }
    return 0;
}

// Message handler for about box.
INT_PTR CALLBACK About(HWND hDlg, UINT message, WPARAM wParam, LPARAM lParam)
{
    UNREFERENCED_PARAMETER(lParam);
    switch (message)
    {
    case WM_INITDIALOG:
        return (INT_PTR)TRUE;

    case WM_COMMAND:
        if (LOWORD(wParam) == IDOK || LOWORD(wParam) == IDCANCEL)
        {
            EndDialog(hDlg, LOWORD(wParam));
            return (INT_PTR)TRUE;
        }
        break;
    }
    return (INT_PTR)FALSE;
}


void NativeRoot::initialize(std::function<void(void)> onReady)
{
    std::cout << "Lets go" << std::endl;
    initWindows();
}

void NativeRoot::createFragment()
{
}

// void NativeRoot::addView(NativeView * child)
// {
//   NativeView::addView(child);
//   NSView * view = (__bridge NSView *) nativeView;
//   NSView * childView = (__bridge NSView *) child->nativeView;
//   [childView setAutoresizingMask:NSViewWidthSizable | NSViewHeightSizable];
//   [childView setFrame:[view bounds]];
// }