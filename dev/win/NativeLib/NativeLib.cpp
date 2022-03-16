#include "pch.h"
#include "NativeLib.h"

using namespace winrt;
using namespace Windows::UI::Xaml::Controls;
using namespace Windows::UI::Xaml;
using namespace Windows::UI::Xaml::Hosting;

using namespace Microsoft::Toolkit::Win32::UI::XamlHost;

using namespace Microsoft::UI::Xaml::Controls;

ContentPresenter presenter{ nullptr };

StackPanel createView()
{
    StackPanel main;

    TextBlock tb;
    tb.Text(L"XAML islands Playground");
    tb.HorizontalAlignment(HorizontalAlignment::Center);
    tb.FontWeight(Windows::UI::Text::FontWeights::Black());
    tb.FontSize(32);
    main.Children().Append(tb);

    auto infobar = Microsoft::UI::Xaml::Controls::InfoBar();
    main.Children().Append(infobar);

    StackPanel sp;
    sp.Orientation(Orientation::Horizontal);

    Grid editPanel;
    TextBox edit;
    edit.Height(600);
    edit.MinWidth(600);
    edit.HorizontalAlignment(HorizontalAlignment::Stretch);
    edit.VerticalAlignment(VerticalAlignment::Top);
    edit.AcceptsReturn(true);
    edit.IsSpellCheckEnabled(false);
    Media::FontFamily consolas(L"Consolas");
    edit.FontFamily(consolas);

    edit.Text(LR"(
<StackPanel 
  xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation" 
  xmlns:winui="using:Microsoft.UI.Xaml.Controls"
  Background="Black">
<!-- Your content goes here -->
</StackPanel>
)");
    editPanel.Children().Append(edit);

    Button run;
    run.Content(winrt::box_value(L"Run"));
    run.Tapped([=](auto&, auto&) {
        try {
            auto parsedContent = Markup::XamlReader::Load(edit.Text());
            presenter.Content(parsedContent);
        }
        catch (const winrt::hresult_error& e) {
            infobar.Title(L"Error");
            infobar.Message(e.message());
            infobar.Severity(InfoBarSeverity::Error);
            infobar.IsOpen(true);
        }
        });

    run.Margin(ThicknessHelper::FromUniformLength(4));
    run.HorizontalAlignment(HorizontalAlignment::Right);
    run.VerticalAlignment(VerticalAlignment::Top);
    editPanel.Margin(ThicknessHelper::FromUniformLength(12));
    editPanel.Children().Append(run);

    sp.Children().Append(editPanel);
    presenter = ContentPresenter();
    presenter.HorizontalAlignment(HorizontalAlignment::Stretch);
    presenter.Background(Media::SolidColorBrush{ Windows::UI::Colors::Aqua() });
    presenter.Margin(ThicknessHelper::FromUniformLength(4));

    presenter.MinWidth(600);
    presenter.MinHeight(800);
    sp.Children().Append(presenter);

    main.Children().Append(sp);

    return main;
}

ContentPresenter getPresenter()
{
    return presenter;
}