
package 
{
    import com.sulake.iid.IIDCoreWindowManager;
    import com.sulake.core.window.ICoreWindowManager;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.IWindowContext;
    import com.sulake.core.window.components.IBackgroundWindow;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import com.sulake.core.window.components.IBorderWindow;
    import com.sulake.core.window.components.IButtonWindow;
    import com.sulake.core.window.components.ICanvasWindow;
    import com.sulake.core.window.components.ICaptionWindow;
    import com.sulake.core.window.components.ICheckBoxWindow;
    import com.sulake.core.window.components.IContainerButtonWindow;
    import com.sulake.core.window.components.IDesktopWindow;
    import com.sulake.core.window.components.IDisplayObjectWrapper;
    import com.sulake.core.window.components.IDragBarWindow;
    import com.sulake.core.window.components.IDropMenuItemWindow;
    import com.sulake.core.window.components.IDropMenuWindow;
    import com.sulake.core.window.components.IFrameWindow;
    import com.sulake.core.window.components.IHeaderWindow;
    import com.sulake.core.window.components.IIconWindow;
    import com.sulake.core.window.components.IInteractiveWindow;
    import com.sulake.core.window.components.IItemGridWindow;
    import com.sulake.core.window.components.IItemListWindow;
    import com.sulake.core.window.components.INotifyWindow;
    import com.sulake.core.window.components.IPasswordFieldWindow;
    import com.sulake.core.window.components.IRadioButtonSelectionWindow;
    import com.sulake.core.window.components.IRadioButtonWindow;
    import com.sulake.core.window.components.IRegionWindow;
    import com.sulake.core.window.components.IScalerWindow;
    import com.sulake.core.window.components.IScrollableWindow;
    import com.sulake.core.window.components.IScrollbarWindow;
    import com.sulake.core.window.components.ISelectableWindow;
    import com.sulake.core.window.components.ISelectorWindow;
    import com.sulake.core.window.components.ITabButtonWindow;
    import com.sulake.core.window.components.ITabContentWindow;
    import com.sulake.core.window.components.ITabContextWindow;
    import com.sulake.core.window.components.ITabSelectorWindow;
    import com.sulake.core.window.components.ITextFieldWindow;
    import com.sulake.core.window.components.ITextWindow;
    import com.sulake.core.window.components.IToolBarWindow;
    import com.sulake.core.window.enum.MouseListenerType;
    import com.sulake.core.window.enum.WindowParam;
    import com.sulake.core.window.enum.WindowState;
    import com.sulake.core.window.enum.WindowStyle;
    import com.sulake.core.window.enum.WindowType;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.events.WindowKeyboardEvent;
    import com.sulake.core.window.events.WindowMessage;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.window.utils.IMargins;

    public class ICoreWindowFrameworkLib 
    {

        public static var IIDCoreWindowManager:Class = IIDCoreWindowManager;
        public static var ICoreWindowManager:Class = ICoreWindowManager;
        public static var IWindow:Class = IWindow;
        public static var IWindowContainer:Class = IWindowContainer;
        public static var IWindowContext:Class = IWindowContext;
        public static var IBackgroundWindow:Class = IBackgroundWindow;
        public static var IBitmapWrapperWindow:Class = IBitmapWrapperWindow;
        public static var IBorderWindow:Class = IBorderWindow;
        public static var IButtonWindow:Class = IButtonWindow;
        public static var ICanvasWindow:Class = ICanvasWindow;
        public static var ICaptionWindow:Class = ICaptionWindow;
        public static var ICheckBoxWindow:Class = ICheckBoxWindow;
        public static var IContainerButtonWindow:Class = IContainerButtonWindow;
        public static var IDesktopWindow:Class = IDesktopWindow;
        public static var IDisplayObjectWrapper:Class = IDisplayObjectWrapper;
        public static var IDragBarWindow:Class = IDragBarWindow;
        public static var IDropMenuItemWindow:Class = IDropMenuItemWindow;
        public static var IDropMenuWindow:Class = IDropMenuWindow;
        public static var IFrameWindow:Class = IFrameWindow;
        public static var IHeaderWindow:Class = IHeaderWindow;
        public static var IIconWindow:Class = IIconWindow;
        public static var IInteractiveWindow:Class = IInteractiveWindow;
        public static var IItemGridWindow:Class = IItemGridWindow;
        public static var IItemListWindow:Class = IItemListWindow;
        public static var INotifyWindow:Class = INotifyWindow;
        public static var IPasswordFieldWindow:Class = IPasswordFieldWindow;
        public static var IRadioButtonSelectionWindow:Class = IRadioButtonSelectionWindow;
        public static var IRadioButtonWindow:Class = IRadioButtonWindow;
        public static var IRegionWindow:Class = IRegionWindow;
        public static var IScalerWindow:Class = IScalerWindow;
        public static var IScrollableWindow:Class = IScrollableWindow;
        public static var IScrollbarWindow:Class = IScrollbarWindow;
        public static var ISelectableWindow:Class = ISelectableWindow;
        public static var ISelectorWindow:Class = ISelectorWindow;
        public static var ITabButtonWindow:Class = ITabButtonWindow;
        public static var ITabContentWindow:Class = ITabContentWindow;
        public static var ITabContextWindow:Class = ITabContextWindow;
        public static var ITabSelectorWindow:Class = ITabSelectorWindow;
        public static var ITextFieldWindow:Class = ITextFieldWindow;
        public static var ITextWindow:Class = ITextWindow;
        public static var IToolBarWindow:Class = IToolBarWindow;
        public static var MouseListenerType:Class = MouseListenerType;
        public static var WindowParam:Class = WindowParam;
        public static var WindowState:Class = WindowState;
        public static var WindowStyle:Class = WindowStyle;
        public static var WindowType:Class = WindowType;
        public static var WindowEvent:Class = WindowEvent;
        public static var WindowKeyboardEvent:Class = WindowKeyboardEvent;
        public static var WindowMessage:Class = WindowMessage;
        public static var WindowMouseEvent:Class = WindowMouseEvent;
        public static var IMargins:Class = IMargins;

    }
}//package 

// WindowEvent = "_-Jh" (String#2085, DoABC#2)
// IDisplayObjectWrapper = "_-FC" (String#2078, DoABC#2)
// IScrollableWindow = "_-2R2" (String#1880, DoABC#2)
// IIconWindow = "_-1ph" (String#1764, DoABC#2)
// IWindowContext = "_-8b" (String#2061, DoABC#2)
// WindowType = "_-1yl" (String#6008, DoABC#2)
// IInteractiveWindow = "_-0KX" (String#1454, DoABC#2)
// ITextFieldWindow = "_-3EL" (String#2027, DoABC#2)
// ISelectableWindow = "_-nA" (String#2188, DoABC#2)
// ITabButtonWindow = "_-1Gf" (String#1649, DoABC#2)
// IBackgroundWindow = "_-7D" (String#2053, DoABC#2)
// IScalerWindow = "_-2bU" (String#1906, DoABC#2)
// WindowState = "_-1Kt" (String#5262, DoABC#2)
// ITabContentWindow = "_-0AI" (String#1416, DoABC#2)
// IHeaderWindow = "_-1zq" (String#1792, DoABC#2)
// ICheckBoxWindow = "_-1zu" (String#1793, DoABC#2)
// IScrollbarWindow = "_-2fP" (String#1920, DoABC#2)
// IBorderWindow = "_-0Br" (String#1422, DoABC#2)
// IRadioButtonSelectionWindow = "_-2DU" (String#1835, DoABC#2)
// IDragBarWindow = "_-BG" (String#2070, DoABC#2)
// WindowMessage = "_-31u" (String#7344, DoABC#2)
// IMargins = "_-1mu" (String#1757, DoABC#2)
// ISelectorWindow = "_-1aY" (String#1714, DoABC#2)
// IRadioButtonWindow = "_-234" (String#1804, DoABC#2)
// IPasswordFieldWindow = "_-1L7" (String#1664, DoABC#2)
// ICanvasWindow = "_-1Ij" (String#1656, DoABC#2)
// WindowStyle = "_-10b" (String#4885, DoABC#2)
// IDropMenuWindow = "_-4Z" (String#2049, DoABC#2)
// MouseListenerType = "_-0a" (String#4300, DoABC#2)
// IDropMenuItemWindow = "_-11J" (String#1605, DoABC#2)
// IItemGridWindow = "_-265" (String#1809, DoABC#2)
// ICaptionWindow = "_-n" (String#2186, DoABC#2)
// IRegionWindow = "_-dg" (String#2146, DoABC#2)
// WindowKeyboardEvent = "_-0Di" (String#1433, DoABC#2)
// IContainerButtonWindow = "_-0UF" (String#1484, DoABC#2)
// IToolBarWindow = "_-2mJ" (String#1936, DoABC#2)
// ITabContextWindow = "_-0L6" (String#1455, DoABC#2)
// INotifyWindow = "_-2FM" (String#1843, DoABC#2)
// ICoreWindowManager = "_-YU" (String#2128, DoABC#2)
// ICoreWindowFrameworkLib = "_-lk" (String#2178, DoABC#2)


