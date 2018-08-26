
package com.sulake.core.window.utils
{
    import com.sulake.core.window.enum.WindowParam;
    import flash.utils.Dictionary;

    public class ParamCodeTable extends WindowParam 
    {

        public static function fillTables(_arg_1:Dictionary, _arg_2:Dictionary=null):void
        {
            var _local_3:String;
            _arg_1["null"] = _SafeStr_7433;
            _arg_1["bound_to_parent_rect"] = _SafeStr_7445;
            _arg_1["child_window"] = _SafeStr_7504;
            _arg_1["embedded_controller"] = _SafeStr_7506;
            _arg_1["expand_to_accommodate_children"] = WINDOW_PARAM_EXPAND_TO_ACCOMMODATE_CHILDREN;
            _arg_1["input_event_processor"] = _SafeStr_7434;
            _arg_1["internal_event_handling"] = _SafeStr_7442;
            _arg_1["mouse_dragging_target"] = _SafeStr_7486;
            _arg_1["mouse_dragging_trigger"] = _SafeStr_7488;
            _arg_1["mouse_scaling_target"] = _SafeStr_7492;
            _arg_1["mouse_scaling_trigger"] = _SafeStr_7494;
            _arg_1["horizontal_mouse_scaling_trigger"] = _SafeStr_7496;
            _arg_1["vertical_mouse_scaling_trigger"] = _SafeStr_7497;
            _arg_1["observe_parent_input_events"] = _SafeStr_7440;
            _arg_1["parent_window"] = _SafeStr_7502;
            _arg_1["resize_to_accommodate_children"] = _SafeStr_7436;
            _arg_1["relative_horizontal_scale_center"] = _SafeStr_7452;
            _arg_1["relative_horizontal_scale_fixed"] = _SafeStr_7447;
            _arg_1["relative_horizontal_scale_move"] = _SafeStr_7449;
            _arg_1["relative_horizontal_scale_strech"] = _SafeStr_7450;
            _arg_1["relative_scale_center"] = _SafeStr_7472;
            _arg_1["relative_scale_fixed"] = _SafeStr_7466;
            _arg_1["relative_scale_move"] = _SafeStr_7468;
            _arg_1["relative_scale_strech"] = _SafeStr_7470;
            _arg_1["relative_vertical_scale_center"] = _SafeStr_7462;
            _arg_1["relative_vertical_scale_fixed"] = _SafeStr_7456;
            _arg_1["relative_vertical_scale_move"] = _SafeStr_7458;
            _arg_1["relative_vertical_scale_strech"] = _SafeStr_7460;
            _arg_1["on_resize_align_left"] = _SafeStr_7474;
            _arg_1["on_resize_align_right"] = _SafeStr_7478;
            _arg_1["on_resize_align_center"] = _SafeStr_7476;
            _arg_1["on_resize_align_top"] = _SafeStr_7480;
            _arg_1["on_resize_align_bottom"] = _SafeStr_7484;
            _arg_1["on_resize_align_middle"] = _SafeStr_7482;
            _arg_1["on_accommodate_align_left"] = _SafeStr_9499;
            _arg_1["on_accommodate_align_right"] = _SafeStr_9500;
            _arg_1["on_accommodate_align_center"] = _SafeStr_9501;
            _arg_1["on_accommodate_align_top"] = _SafeStr_9502;
            _arg_1["on_accommodate_align_bottom"] = _SafeStr_9503;
            _arg_1["on_accommodate_align_middle"] = _SafeStr_9504;
            _arg_1["route_input_events_to_parent"] = _SafeStr_7438;
            _arg_1["use_parent_graphic_context"] = _SafeStr_7443;
            _arg_1["draggable_with_mouse"] = _SafeStr_7490;
            _arg_1["scalable_with_mouse"] = _SafeStr_7500;
            _arg_1["reflect_horizontal_resize_to_parent"] = _SafeStr_9318;
            _arg_1["reflect_vertical_resize_to_parent"] = _SafeStr_9319;
            _arg_1["reflect_resize_to_parent"] = _SafeStr_9362;
            _arg_1["force_clipping"] = WINDOW_PARAM_FORCE_CLIPPING;
            _arg_1["inherit_caption"] = _SafeStr_9508;
            if (_arg_2 != null){
                for (_local_3 in _arg_1) {
                    _arg_2[_arg_1[_local_3]] = _local_3;
                };
            };
        }

    }
}//package com.sulake.core.window.utils

// ParamCodeTable = "_-2E5" (String#6322, DoABC#2)
// _SafeStr_7433 = "_-222" (String#19092, DoABC#2)
// _SafeStr_7434 = "_-2xA" (String#21356, DoABC#2)
// _SafeStr_7436 = "_-0zN" (String#16403, DoABC#2)
// _SafeStr_7438 = "_-2pe" (String#21065, DoABC#2)
// _SafeStr_7440 = "_-1Y4" (String#17817, DoABC#2)
// _SafeStr_7442 = "_-2kb" (String#20869, DoABC#2)
// _SafeStr_7443 = "_-0YX" (String#15382, DoABC#2)
// _SafeStr_7445 = "_-3Kg" (String#22311, DoABC#2)
// _SafeStr_7447 = "_-2dV" (String#20584, DoABC#2)
// _SafeStr_7449 = "_-01-" (String#14095, DoABC#2)
// _SafeStr_7450 = "_-9f" (String#22606, DoABC#2)
// _SafeStr_7452 = "_-2Hm" (String#19717, DoABC#2)
// _SafeStr_7456 = "_-2vm" (String#21305, DoABC#2)
// _SafeStr_7458 = "_-cq" (String#23748, DoABC#2)
// _SafeStr_7460 = "_-ZZ" (String#23619, DoABC#2)
// _SafeStr_7462 = "_-15I" (String#16664, DoABC#2)
// _SafeStr_7466 = "_-20p" (String#19045, DoABC#2)
// _SafeStr_7468 = "_-2ns" (String#20994, DoABC#2)
// _SafeStr_7470 = "_-Bf" (String#22677, DoABC#2)
// _SafeStr_7472 = "_-2wQ" (String#21326, DoABC#2)
// _SafeStr_7474 = "_-0JH" (String#14813, DoABC#2)
// _SafeStr_7476 = "_-2eb" (String#20630, DoABC#2)
// _SafeStr_7478 = "_-09q" (String#14440, DoABC#2)
// _SafeStr_7480 = "_-ml" (String#24140, DoABC#2)
// _SafeStr_7482 = "_-22c" (String#19116, DoABC#2)
// _SafeStr_7484 = "_-28R" (String#19349, DoABC#2)
// _SafeStr_7486 = "_-2NN" (String#19938, DoABC#2)
// _SafeStr_7488 = "_-1ib" (String#18232, DoABC#2)
// _SafeStr_7490 = "_-12S" (String#16557, DoABC#2)
// _SafeStr_7492 = "_-0tz" (String#16201, DoABC#2)
// _SafeStr_7494 = "_-2Hx" (String#19725, DoABC#2)
// _SafeStr_7496 = "_-1Ig" (String#17221, DoABC#2)
// _SafeStr_7497 = "_-0TU" (String#15191, DoABC#2)
// _SafeStr_7500 = "_-35I" (String#21705, DoABC#2)
// _SafeStr_7502 = "_-JD" (String#22975, DoABC#2)
// _SafeStr_7504 = "_-2Gk" (String#19671, DoABC#2)
// _SafeStr_7506 = "_-Uj" (String#23437, DoABC#2)
// _SafeStr_9318 = "_-2PC" (String#20010, DoABC#2)
// _SafeStr_9319 = "_-1jm" (String#18275, DoABC#2)
// _SafeStr_9362 = "_-199" (String#16823, DoABC#2)
// _SafeStr_9499 = "_-mW" (String#24128, DoABC#2)
// _SafeStr_9500 = "_-3G5" (String#22121, DoABC#2)
// _SafeStr_9501 = "_-JZ" (String#22986, DoABC#2)
// _SafeStr_9502 = "_-1JZ" (String#17260, DoABC#2)
// _SafeStr_9503 = "_-0es" (String#15621, DoABC#2)
// _SafeStr_9504 = "_-32-" (String#21579, DoABC#2)
// _SafeStr_9508 = "_-36f" (String#21753, DoABC#2)
// fillTables = "_-15n" (String#16687, DoABC#2)


