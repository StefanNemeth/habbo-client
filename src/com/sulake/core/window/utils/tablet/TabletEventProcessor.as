
package com.sulake.core.window.utils.tablet
{
    import com.sulake.core.window.utils.MouseEventProcessor;
    import com.sulake.core.window.WindowController;
    import com.sulake.core.window.utils.EventProcessorState;
    import com.sulake.core.window.utils.IEventQueue;

    public class TabletEventProcessor extends MouseEventProcessor 
    {

        private var _SafeStr_8615:String = "";

        override public function MouseEventProcessor(_arg_1:EventProcessorState, _arg_2:IEventQueue):void
        {
            if (_arg_2.length == 0){
                return;
            };
            _SafeStr_8617 = _arg_1.desktop;
            _SafeStr_8618 = (_arg_1._SafeStr_8619 as WindowController);
            _SafeStr_8620 = (_arg_1._SafeStr_8621 as WindowController);
            _RoomInstance = _arg_1.renderer;
            _SafeStr_8623 = _arg_1._SafeStr_8624;
            _arg_2.begin();
            _arg_2.end();
            _arg_1.desktop = _SafeStr_8617;
            _arg_1._SafeStr_8619 = _SafeStr_8618;
            _arg_1._SafeStr_8621 = _SafeStr_8620;
            _arg_1.renderer = _RoomInstance;
            _arg_1._SafeStr_8624 = _SafeStr_8623;
        }

    }
}//package com.sulake.core.window.utils.tablet

// EventProcessorState = "_-Ct" (String#7930, DoABC#2)
// IEventQueue = "_-cw" (String#8470, DoABC#2)
// MouseEventProcessor = "_-1zl" (String#6028, DoABC#2)
// TabletEventProcessor = "_-1h0" (String#5685, DoABC#2)
// _SafeStr_8615 = "_-1aV" (String#17914, DoABC#2)
// MouseEventProcessor = "_-3Fw" (String#2032, DoABC#2)
// _SafeStr_8617 = "_-1WY" (String#5483, DoABC#2)
// _SafeStr_8618 = "_-3JL" (String#22257, DoABC#2)
// _SafeStr_8619 = "_-0fY" (String#15653, DoABC#2)
// _SafeStr_8620 = "_-1pW" (String#18526, DoABC#2)
// _SafeStr_8621 = "_-1ek" (String#18088, DoABC#2)
// _RoomInstance = "_-32W" (String#628, DoABC#2)
// _SafeStr_8623 = "_-20v" (String#19048, DoABC#2)
// _SafeStr_8624 = "_-3ED" (String#22044, DoABC#2)


