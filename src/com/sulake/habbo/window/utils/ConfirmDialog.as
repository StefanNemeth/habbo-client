
package com.sulake.habbo.window.utils
{
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.window.IWindow;

    public class ConfirmDialog extends AlertDialog implements IConfirmDialog 
    {

        public function ConfirmDialog(_arg_1:IHabboWindowManager, _arg_2:XML, _arg_3:String, _arg_4:String, _arg_5:uint, _arg_6:Function)
        {
            super(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5, _arg_6);
        }
        override protected function dialogEventProc(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            var _local_3:WindowEvent;
            if (_arg_1.type == WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK){
                switch (_arg_2.name){
                    case _SafeStr_7586:
                        if (_callback != null){
                            _local_3 = WindowEvent.allocate(WindowEvent.WE_OK, null, null);
                            _callback(this, _local_3);
                            _local_3.recycle();
                        };
                        return;
                    case _SafeStr_7587:
                    case _SafeStr_11027:
                        if (_callback != null){
                            _local_3 = WindowEvent.allocate(WindowEvent.WE_CANCEL, null, null);
                            _callback(this, _local_3);
                            _local_3.recycle();
                        };
                        return;
                };
            };
        }

    }
}//package com.sulake.habbo.window.utils

// _SafeStr_11027 = "_-2Zb" (String#894, DoABC#2)
// WindowEvent = "_-Jh" (String#2085, DoABC#2)
// dialogEventProc = "_-2eS" (String#1917, DoABC#2)
// IConfirmDialog = "_-35c" (String#7421, DoABC#2)
// AlertDialog = "_-eF" (String#8488, DoABC#2)
// ConfirmDialog = "_-Nb" (String#8156, DoABC#2)
// _SafeStr_7586 = "_-2yB" (String#7242, DoABC#2)
// _SafeStr_7587 = "_-N" (String#8142, DoABC#2)
// WE_OK = "_-0UB" (String#15212, DoABC#2)
// _callback = "_-0t2" (String#593, DoABC#2)
// allocate = "_-08G" (String#14374, DoABC#2)
// WE_CANCEL = "_-0gf" (String#15696, DoABC#2)


