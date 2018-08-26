
package com.sulake.core.window.utils
{
    import com.sulake.core.window.enum.WindowType;
    import flash.utils.Dictionary;

    public class TypeCodeTable extends WindowType 
    {

        public static function fillTables(_arg_1:Dictionary, _arg_2:Dictionary=null):void
        {
            var _local_3:String;
            _arg_1["background"] = _SafeStr_7568;
            _arg_1["badge"] = _SafeStr_9435;
            _arg_1["bitmap"] = _SafeStr_7569;
            _arg_1["border"] = _SafeStr_7575;
            _arg_1["border_notify"] = _SafeStr_9439;
            _arg_1["bubble"] = _SafeStr_7539;
            _arg_1["bubble_pointer_up"] = _SafeStr_9444;
            _arg_1["bubble_pointer_right"] = _SafeStr_9445;
            _arg_1["bubble_pointer_down"] = _SafeStr_9446;
            _arg_1["bubble_pointer_left"] = _SafeStr_9447;
            _arg_1["button"] = _SafeStr_7535;
            _arg_1["button_thick"] = _SafeStr_7537;
            _arg_1["button_icon"] = _SafeStr_9450;
            _arg_1["button_group_left"] = _SafeStr_7577;
            _arg_1["button_group_center"] = _SafeStr_7579;
            _arg_1["button_group_right"] = _SafeStr_7581;
            _arg_1["canvas"] = _SafeStr_7553;
            _arg_1["checkbox"] = _SafeStr_7561;
            _arg_1["closebutton"] = _SafeStr_9455;
            _arg_1["container"] = _SafeStr_7544;
            _arg_1["container_button"] = _SafeStr_7546;
            _arg_1["display_object_wrapper"] = _SafeStr_7571;
            _arg_1["dropmenu"] = _SafeStr_7548;
            _arg_1["dropmenu_item"] = _SafeStr_7550;
            _arg_1["frame"] = _SafeStr_7512;
            _arg_1["frame_notify"] = _SafeStr_9442;
            _arg_1["header"] = _SafeStr_7541;
            _arg_1["html"] = _SafeStr_9434;
            _arg_1["icon"] = _SafeStr_9430;
            _arg_1["itemgrid"] = _SafeStr_9448;
            _arg_1["itemgrid_horizontal"] = _SafeStr_7522;
            _arg_1["itemgrid_vertical"] = _SafeStr_7524;
            _arg_1["itemlist"] = WINDOW_TYPE_ITEMLIST;
            _arg_1["itemlist_horizontal"] = _SafeStr_7518;
            _arg_1["itemlist_vertical"] = _SafeStr_7520;
            _arg_1["label"] = _SafeStr_7516;
            _arg_1["maximizebox"] = _SafeStr_9457;
            _arg_1["menu"] = _SafeStr_9462;
            _arg_1["menu_item"] = _SafeStr_9463;
            _arg_1["submenu"] = _SafeStr_9464;
            _arg_1["minimizebox"] = _SafeStr_9456;
            _arg_1["notify"] = _SafeStr_9433;
            _arg_1["null"] = _SafeStr_7510;
            _arg_1["password"] = _SafeStr_7573;
            _arg_1["radiobutton"] = _SafeStr_7559;
            _arg_1["region"] = _SafeStr_6090;
            _arg_1["restorebox"] = _SafeStr_9458;
            _arg_1["scaler"] = _SafeStr_9468;
            _arg_1["scaler_horizontal"] = _SafeStr_9470;
            _arg_1["scaler_vertical"] = _SafeStr_9469;
            _arg_1["scrollbar_horizontal"] = _SafeStr_7526;
            _arg_1["scrollbar_vertical"] = _SafeStr_7528;
            _arg_1["scrollbar_slider_button_up"] = _SafeStr_9478;
            _arg_1["scrollbar_slider_button_down"] = _SafeStr_9476;
            _arg_1["scrollbar_slider_button_left"] = _SafeStr_9477;
            _arg_1["scrollbar_slider_button_right"] = _SafeStr_9475;
            _arg_1["scrollbar_slider_bar_horizontal"] = _SafeStr_9471;
            _arg_1["scrollbar_slider_bar_vertical"] = _SafeStr_9472;
            _arg_1["scrollbar_slider_track_horizontal"] = _SafeStr_9473;
            _arg_1["scrollbar_slider_track_vertical"] = _SafeStr_9474;
            _arg_1["scrollable_itemlist"] = _SafeStr_9449;
            _arg_1["scrollable_itemlist_vertical"] = WINDOW_TYPE_SCROLLABLE_ITEMLIST_VERTICAL;
            _arg_1["scrollable_itemlist_horizontal"] = _SafeStr_7532;
            _arg_1["selector"] = _SafeStr_7555;
            _arg_1["selector_list"] = _SafeStr_7557;
            _arg_1["submenu"] = _SafeStr_9464;
            _arg_1["tab_button"] = _SafeStr_7563;
            _arg_1["tab_container_button"] = _SafeStr_9461;
            _arg_1["tab_context"] = _SafeStr_7567;
            _arg_1["tab_content"] = _SafeStr_9460;
            _arg_1["tab_selector"] = _SafeStr_7565;
            _arg_1["text"] = _SafeStr_7551;
            _arg_1["input"] = _SafeStr_7543;
            _arg_1["toolbar"] = _SafeStr_9431;
            _arg_1["tooltip"] = _SafeStr_9432;
            if (_arg_2 != null){
                for (_local_3 in _arg_1) {
                    _arg_2[_arg_1[_local_3]] = _local_3;
                };
            };
        }

    }
}//package com.sulake.core.window.utils

// WindowType = "_-1yl" (String#6008, DoABC#2)
// TypeCodeTable = "_-0bK" (String#4329, DoABC#2)
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
// _SafeStr_7532 = "_-0hy" (String#15747, DoABC#2)
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
// _SafeStr_9431 = "_-19x" (String#16854, DoABC#2)
// _SafeStr_9432 = "_-oz" (String#24234, DoABC#2)
// _SafeStr_9433 = "_-1tG" (String#18688, DoABC#2)
// _SafeStr_9434 = "_-1uS" (String#18734, DoABC#2)
// _SafeStr_9435 = "_-2KX" (String#19824, DoABC#2)
// _SafeStr_9439 = "_-18z" (String#16815, DoABC#2)
// _SafeStr_9442 = "_-0GB" (String#14693, DoABC#2)
// _SafeStr_9444 = "_-bb" (String#23696, DoABC#2)
// _SafeStr_9445 = "_-09H" (String#14419, DoABC#2)
// _SafeStr_9446 = "_-1qa" (String#18566, DoABC#2)
// _SafeStr_9447 = "_-1HD" (String#17159, DoABC#2)
// _SafeStr_9448 = "_-359" (String#21701, DoABC#2)
// _SafeStr_9449 = "_-cS" (String#23732, DoABC#2)
// _SafeStr_9450 = "_-ai" (String#23661, DoABC#2)
// _SafeStr_9455 = "_-1dJ" (String#18027, DoABC#2)
// _SafeStr_9456 = "_-Hf" (String#22919, DoABC#2)
// _SafeStr_9457 = "_-3Kk" (String#22314, DoABC#2)
// _SafeStr_9458 = "_-18x" (String#16813, DoABC#2)
// _SafeStr_9460 = "_-0l" (String#15865, DoABC#2)
// _SafeStr_9461 = "_-0tR" (String#16177, DoABC#2)
// _SafeStr_9462 = "_-Br" (String#22681, DoABC#2)
// _SafeStr_9463 = "_-2JE" (String#19777, DoABC#2)
// _SafeStr_9464 = "_-3EO" (String#22051, DoABC#2)
// _SafeStr_9468 = "_-0La" (String#14896, DoABC#2)
// _SafeStr_9469 = "_-2Q7" (String#20049, DoABC#2)
// _SafeStr_9470 = "_-287" (String#19334, DoABC#2)
// _SafeStr_9471 = "_-1ZS" (String#17869, DoABC#2)
// _SafeStr_9472 = "_-ML" (String#23097, DoABC#2)
// _SafeStr_9473 = "_-jC" (String#24007, DoABC#2)
// _SafeStr_9474 = "_-1b7" (String#17940, DoABC#2)
// _SafeStr_9475 = "_-VX" (String#23472, DoABC#2)
// _SafeStr_9476 = "_-2SF" (String#20128, DoABC#2)
// _SafeStr_9477 = "_-05D" (String#14252, DoABC#2)
// _SafeStr_9478 = "_-2uR" (String#21259, DoABC#2)
// fillTables = "_-15n" (String#16687, DoABC#2)


