
package com.sulake.core.window
{
    import flash.utils.Dictionary;
    import com.sulake.core.window.enum.WindowType;
    import com.sulake.core.window.components.ActivatorController;
    import com.sulake.core.window.components.BackgroundController;
    import com.sulake.core.window.components.BadgeController;
    import com.sulake.core.window.components.BorderController;
    import com.sulake.core.window.components.BubbleController;
    import com.sulake.core.window.components.ButtonController;
    import com.sulake.core.window.components.SelectableButtonController;
    import com.sulake.core.window.components.BitmapWrapperController;
    import com.sulake.core.window.components.CanvasController;
    import com.sulake.core.window.components.CheckBoxController;
    import com.sulake.core.window.components.ContainerController;
    import com.sulake.core.window.components.ContainerButtonController;
    import com.sulake.core.window.components.CloseButtonController;
    import com.sulake.core.window.components.DisplayObjectWrapperController;
    import com.sulake.core.window.components.ScrollbarLiftController;
    import com.sulake.core.window.components.DropMenuController;
    import com.sulake.core.window.components.DropMenuItemController;
    import com.sulake.core.window.components.FrameController;
    import com.sulake.core.window.components.HeaderController;
    import com.sulake.core.window.components.HTMLTextController;
    import com.sulake.core.window.components.IconController;
    import com.sulake.core.window.components.ItemListController;
    import com.sulake.core.window.components.ItemGridController;
    import com.sulake.core.window.components.TextLabelController;
    import com.sulake.core.window.components.PasswordFieldController;
    import com.sulake.core.window.components.RadioButtonController;
    import com.sulake.core.window.components.RegionController;
    import com.sulake.core.window.components.ScalerController;
    import com.sulake.core.window.components.ScrollbarController;
    import com.sulake.core.window.components.ScrollableItemListWindow;
    import com.sulake.core.window.components.SelectorController;
    import com.sulake.core.window.components.TabSelectorController;
    import com.sulake.core.window.components.TabButtonController;
    import com.sulake.core.window.components.TabContainerButtonController;
    import com.sulake.core.window.components.TabContextController;
    import com.sulake.core.window.components.TextController;
    import com.sulake.core.window.components.TextFieldController;
    import com.sulake.core.window.components.ToolTipController;
    import com.sulake.core.window.components.*;

    public class Classes 
    {

        protected static var _SafeStr_9816:Dictionary;

        public static function init():void
        {
            if (!_SafeStr_9816){
                _SafeStr_9816 = new Dictionary();
                _SafeStr_9816[WindowType._SafeStr_7510] = WindowController;
                _SafeStr_9816[WindowType._SafeStr_9443] = ActivatorController;
                _SafeStr_9816[WindowType._SafeStr_7568] = BackgroundController;
                _SafeStr_9816[WindowType._SafeStr_9435] = BadgeController;
                _SafeStr_9816[WindowType._SafeStr_7575] = BorderController;
                _SafeStr_9816[WindowType._SafeStr_7539] = BubbleController;
                _SafeStr_9816[WindowType._SafeStr_9444] = WindowController;
                _SafeStr_9816[WindowType._SafeStr_9445] = WindowController;
                _SafeStr_9816[WindowType._SafeStr_9446] = WindowController;
                _SafeStr_9816[WindowType._SafeStr_9447] = WindowController;
                _SafeStr_9816[WindowType._SafeStr_7535] = ButtonController;
                _SafeStr_9816[WindowType._SafeStr_7537] = ButtonController;
                _SafeStr_9816[WindowType._SafeStr_7577] = SelectableButtonController;
                _SafeStr_9816[WindowType._SafeStr_7579] = SelectableButtonController;
                _SafeStr_9816[WindowType._SafeStr_7581] = SelectableButtonController;
                _SafeStr_9816[WindowType._SafeStr_7569] = BitmapWrapperController;
                _SafeStr_9816[WindowType._SafeStr_7553] = CanvasController;
                _SafeStr_9816[WindowType._SafeStr_7561] = CheckBoxController;
                _SafeStr_9816[WindowType._SafeStr_7544] = ContainerController;
                _SafeStr_9816[WindowType._SafeStr_7546] = ContainerButtonController;
                _SafeStr_9816[WindowType._SafeStr_9455] = CloseButtonController;
                _SafeStr_9816[WindowType._SafeStr_7571] = DisplayObjectWrapperController;
                _SafeStr_9816[WindowType._SafeStr_9459] = ScrollbarLiftController;
                _SafeStr_9816[WindowType._SafeStr_7548] = DropMenuController;
                _SafeStr_9816[WindowType._SafeStr_7550] = DropMenuItemController;
                _SafeStr_9816[WindowType._SafeStr_7512] = FrameController;
                _SafeStr_9816[WindowType._SafeStr_7541] = HeaderController;
                _SafeStr_9816[WindowType._SafeStr_9434] = HTMLTextController;
                _SafeStr_9816[WindowType._SafeStr_9430] = IconController;
                _SafeStr_9816[WindowType.WINDOW_TYPE_ITEMLIST] = ItemListController;
                _SafeStr_9816[WindowType._SafeStr_7518] = ItemListController;
                _SafeStr_9816[WindowType._SafeStr_7520] = ItemListController;
                _SafeStr_9816[WindowType._SafeStr_9448] = ItemGridController;
                _SafeStr_9816[WindowType._SafeStr_7522] = ItemGridController;
                _SafeStr_9816[WindowType._SafeStr_7524] = ItemGridController;
                _SafeStr_9816[WindowType._SafeStr_7516] = TextLabelController;
                _SafeStr_9816[WindowType._SafeStr_7573] = PasswordFieldController;
                _SafeStr_9816[WindowType._SafeStr_7559] = RadioButtonController;
                _SafeStr_9816[WindowType._SafeStr_6090] = RegionController;
                _SafeStr_9816[WindowType._SafeStr_9468] = ScalerController;
                _SafeStr_9816[WindowType._SafeStr_7526] = ScrollbarController;
                _SafeStr_9816[WindowType._SafeStr_7528] = ScrollbarController;
                _SafeStr_9816[WindowType._SafeStr_9478] = ButtonController;
                _SafeStr_9816[WindowType._SafeStr_9476] = ButtonController;
                _SafeStr_9816[WindowType._SafeStr_9477] = ButtonController;
                _SafeStr_9816[WindowType._SafeStr_9475] = ButtonController;
                _SafeStr_9816[WindowType._SafeStr_9471] = ScrollbarLiftController;
                _SafeStr_9816[WindowType._SafeStr_9472] = ScrollbarLiftController;
                _SafeStr_9816[WindowType._SafeStr_9473] = WindowController;
                _SafeStr_9816[WindowType._SafeStr_9474] = WindowController;
                _SafeStr_9816[WindowType.WINDOW_TYPE_SCROLLABLE_ITEMLIST_VERTICAL] = ScrollableItemListWindow;
                _SafeStr_9816[WindowType._SafeStr_7555] = SelectorController;
                _SafeStr_9816[WindowType._SafeStr_7557] = TabSelectorController;
                _SafeStr_9816[WindowType._SafeStr_7563] = TabButtonController;
                _SafeStr_9816[WindowType._SafeStr_9461] = TabContainerButtonController;
                _SafeStr_9816[WindowType._SafeStr_9460] = ContainerController;
                _SafeStr_9816[WindowType._SafeStr_7567] = TabContextController;
                _SafeStr_9816[WindowType._SafeStr_7565] = TabSelectorController;
                _SafeStr_9816[WindowType._SafeStr_7551] = TextController;
                _SafeStr_9816[WindowType._SafeStr_7543] = TextFieldController;
                _SafeStr_9816[WindowType._SafeStr_9432] = ToolTipController;
            };
        }
        public static function getWindowClassByType(_arg_1:uint):Class
        {
            return (_SafeStr_9816[_arg_1]);
        }

    }
}//package com.sulake.core.window

// WindowType = "_-1yl" (String#6008, DoABC#2)
// TextController = "_-2vO" (String#7184, DoABC#2)
// TextFieldController = "_-2rC" (String#7105, DoABC#2)
// HTMLTextController = "_-0F9" (String#3855, DoABC#2)
// Classes = "_-0TN" (String#1480, DoABC#2)
// ContainerController = "_-1v4" (String#5943, DoABC#2)
// ActivatorController = "_-Wd" (String#8339, DoABC#2)
// ButtonController = "_-Mw" (String#8140, DoABC#2)
// ToolTipController = "_-33w" (String#7386, DoABC#2)
// HeaderController = "_-il" (String#8572, DoABC#2)
// TextLabelController = "_-2Hc" (String#6396, DoABC#2)
// RadioButtonController = "_-Jz" (String#8083, DoABC#2)
// DropMenuController = "_-1-O" (String#4855, DoABC#2)
// CanvasController = "_-0SU" (String#4149, DoABC#2)
// ContainerButtonController = "_-2QO" (String#6568, DoABC#2)
// DisplayObjectWrapperController = "_-1h1" (String#5686, DoABC#2)
// BitmapWrapperController = "_-2Vt" (String#6681, DoABC#2)
// TabButtonController = "_-og" (String#8685, DoABC#2)
// BorderController = "_-3IY" (String#7681, DoABC#2)
// ItemListController = "_-06j" (String#3696, DoABC#2)
// FrameController = "_-Tj" (String#8280, DoABC#2)
// BubbleController = "_-1Qj" (String#5365, DoABC#2)
// ScrollbarController = "_-1Mk" (String#5287, DoABC#2)
// DropMenuItemController = "_-A5" (String#7867, DoABC#2)
// ScrollbarLiftController = "_-1WE" (String#5477, DoABC#2)
// ScalerController = "_-1Gi" (String#5181, DoABC#2)
// TabContainerButtonController = "_-At" (String#7884, DoABC#2)
// BadgeController = "_-0O3" (String#4048, DoABC#2)
// BackgroundController = "_-1UO" (String#5440, DoABC#2)
// PasswordFieldController = "_-1Pz" (String#5351, DoABC#2)
// CheckBoxController = "_-0pH" (String#4619, DoABC#2)
// RegionController = "_-1kV" (String#5760, DoABC#2)
// ScrollableItemListWindow = "_-Kv" (String#8101, DoABC#2)
// SelectableButtonController = "_-240" (String#6123, DoABC#2)
// CloseButtonController = "_-1NA" (String#5297, DoABC#2)
// ItemGridController = "_-1hV" (String#5697, DoABC#2)
// SelectorController = "_-0GX" (String#3886, DoABC#2)
// TabSelectorController = "_-3K5" (String#7706, DoABC#2)
// IconController = "_-2j1" (String#6934, DoABC#2)
// _SafeStr_6090 = "_-34m" (String#21687, DoABC#2)
// _SafeStr_7510 = "_-1EE" (String#17037, DoABC#2)
// _SafeStr_7512 = "_-3A6" (String#21888, DoABC#2)
// _SafeStr_7516 = "_-371" (String#21769, DoABC#2)
// _SafeStr_7518 = "_-9I" (String#22590, DoABC#2)
// _SafeStr_7520 = "_-0pO" (String#16030, DoABC#2)
// _SafeStr_7522 = "_-2m1" (String#20919, DoABC#2)
// _SafeStr_7524 = "_-0g-" (String#15671, DoABC#2)
// _SafeStr_7526 = "_-17o" (String#16766, DoABC#2)
// _SafeStr_7528 = "_-01s" (String#14123, DoABC#2)
// _SafeStr_7535 = "_-1VS" (String#17718, DoABC#2)
// _SafeStr_7537 = "_-0l4" (String#15869, DoABC#2)
// _SafeStr_7539 = "_-wY" (String#24554, DoABC#2)
// _SafeStr_7541 = "_-Bt" (String#22683, DoABC#2)
// _SafeStr_7543 = "_-2is" (String#20801, DoABC#2)
// _SafeStr_7544 = "_-0c" (String#15512, DoABC#2)
// _SafeStr_7546 = "_-30T" (String#21520, DoABC#2)
// _SafeStr_7548 = "_-5u" (String#22460, DoABC#2)
// _SafeStr_7550 = "_-2tU" (String#21221, DoABC#2)
// _SafeStr_7551 = "_-1XK" (String#17789, DoABC#2)
// _SafeStr_7553 = "_-r2" (String#24317, DoABC#2)
// _SafeStr_7555 = "_-qz" (String#24314, DoABC#2)
// _SafeStr_7557 = "_-pd" (String#24259, DoABC#2)
// _SafeStr_7559 = "_-00u" (String#14090, DoABC#2)
// _SafeStr_7561 = "_-398" (String#21852, DoABC#2)
// _SafeStr_7563 = "_-1BK" (String#16911, DoABC#2)
// _SafeStr_7565 = "_-0Pd" (String#15047, DoABC#2)
// _SafeStr_7567 = "_-7P" (String#22518, DoABC#2)
// _SafeStr_7568 = "_-sf" (String#24385, DoABC#2)
// _SafeStr_7569 = "_-2vP" (String#21293, DoABC#2)
// _SafeStr_7571 = "_-1Q3" (String#17512, DoABC#2)
// _SafeStr_7573 = "_-nz" (String#24189, DoABC#2)
// _SafeStr_7575 = "_-2Pd" (String#20028, DoABC#2)
// _SafeStr_7577 = "_-3AC" (String#21889, DoABC#2)
// _SafeStr_7579 = "_-139" (String#16586, DoABC#2)
// _SafeStr_7581 = "_-1AW" (String#16880, DoABC#2)
// _SafeStr_9430 = "_-0os" (String#16007, DoABC#2)
// _SafeStr_9432 = "_-oz" (String#24234, DoABC#2)
// _SafeStr_9434 = "_-1uS" (String#18734, DoABC#2)
// _SafeStr_9435 = "_-2KX" (String#19824, DoABC#2)
// _SafeStr_9443 = "_-0Dc" (String#14593, DoABC#2)
// _SafeStr_9444 = "_-bb" (String#23696, DoABC#2)
// _SafeStr_9445 = "_-09H" (String#14419, DoABC#2)
// _SafeStr_9446 = "_-1qa" (String#18566, DoABC#2)
// _SafeStr_9447 = "_-1HD" (String#17159, DoABC#2)
// _SafeStr_9448 = "_-359" (String#21701, DoABC#2)
// _SafeStr_9455 = "_-1dJ" (String#18027, DoABC#2)
// _SafeStr_9459 = "_-k6" (String#24039, DoABC#2)
// _SafeStr_9460 = "_-0l" (String#15865, DoABC#2)
// _SafeStr_9461 = "_-0tR" (String#16177, DoABC#2)
// _SafeStr_9468 = "_-0La" (String#14896, DoABC#2)
// _SafeStr_9471 = "_-1ZS" (String#17869, DoABC#2)
// _SafeStr_9472 = "_-ML" (String#23097, DoABC#2)
// _SafeStr_9473 = "_-jC" (String#24007, DoABC#2)
// _SafeStr_9474 = "_-1b7" (String#17940, DoABC#2)
// _SafeStr_9475 = "_-VX" (String#23472, DoABC#2)
// _SafeStr_9476 = "_-2SF" (String#20128, DoABC#2)
// _SafeStr_9477 = "_-05D" (String#14252, DoABC#2)
// _SafeStr_9478 = "_-2uR" (String#21259, DoABC#2)
// getWindowClassByType = "_-UC" (String#23415, DoABC#2)
// _SafeStr_9816 = "_-3LY" (String#22348, DoABC#2)


