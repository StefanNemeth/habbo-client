
package com.sulake.habbo.window.utils
{
    import com.sulake.core.window.utils.INotify;
    import com.sulake.core.window.components.IFrameWindow;
    import com.sulake.core.window.IWindow;
    import com.sulake.habbo.window.enum.HabboAlertDialogFlag;
    import com.sulake.core.window.components.IItemListWindow;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.window.components.IInteractiveWindow;
    import com.sulake.core.window.components.ITextWindow;

    public class AlertDialog implements IAlertDialog, INotify 
    {

        protected static const _SafeStr_14367:String = "_alert_button_list";
        protected static const _SafeStr_7586:String = "_alert_button_ok";
        protected static const _SafeStr_7587:String = "_alert_button_cancel";
        protected static const _SafeStr_7588:String = "_alert_button_custom";
        protected static const _SafeStr_11027:String = "header_button_close";
        protected static const _SafeStr_7583:String = "_alert_text_summary";
        private static var _SafeStr_4425:uint = 0;

        protected var _title:String = "";
        protected var _summary:String = "";
        protected var _disposed:Boolean = false;
        protected var _callback:Function = null;
        protected var _window:IFrameWindow;

        public function AlertDialog(_arg_1:IHabboWindowManager, _arg_2:XML, _arg_3:String, _arg_4:String, _arg_5:uint, _arg_6:Function)
        {
            var _local_8:IWindow;
            super();
            _SafeStr_4425++;
            this._window = (_arg_1.buildFromXML(_arg_2, 2) as IFrameWindow);
            if (_arg_5 == HabboAlertDialogFlag._SafeStr_4662){
                _arg_5 = ((HabboAlertDialogFlag._SafeStr_7586 | HabboAlertDialogFlag._SafeStr_7582) | HabboAlertDialogFlag._SafeStr_7583);
            };
            var _local_7:IItemListWindow = (this._window.findChildByName(_SafeStr_14367) as IItemListWindow);
            if (_local_7){
                if (!(_arg_5 & HabboAlertDialogFlag._SafeStr_7586)){
                    _local_8 = _local_7.getListItemByName(_SafeStr_7586);
                    _local_8.dispose();
                };
                if (!(_arg_5 & HabboAlertDialogFlag._SafeStr_7587)){
                    _local_8 = _local_7.getListItemByName(_SafeStr_7587);
                    _local_8.dispose();
                };
                if (!(_arg_5 & HabboAlertDialogFlag._SafeStr_7588)){
                    _local_8 = _local_7.getListItemByName(_SafeStr_7588);
                    _local_8.dispose();
                };
            };
            this._window.procedure = this.dialogEventProc;
            this._window.center();
            this.title = _arg_3;
            this.summary = _arg_4;
            this.callback = _arg_6;
        }
        public function dispose():void
        {
            if (!this._disposed){
                if (((this._window) && (!(this._window.disposed)))){
                    this._window.dispose();
                    this._window = null;
                };
                this._callback = null;
                this._disposed = true;
            };
        }
        protected function dialogEventProc(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            var _local_3:WindowEvent;
            if (_arg_1.type == WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK){
                switch (_arg_2.name){
                    case _SafeStr_7586:
                        if (this._callback != null){
                            _local_3 = WindowEvent.allocate(WindowEvent.WE_OK, null, null);
                            this._callback(this, _local_3);
                            _local_3.recycle();
                        }
                        else {
                            this.dispose();
                        };
                        return;
                    case _SafeStr_11027:
                        if (this._callback != null){
                            _local_3 = WindowEvent.allocate(WindowEvent.WE_CANCEL, null, null);
                            this._callback(this, _local_3);
                            _local_3.recycle();
                        }
                        else {
                            this.dispose();
                        };
                        return;
                };
            };
        }
        public function getButtonCaption(_arg_1:int):ICaption
        {
            var _local_2:IInteractiveWindow;
            if (!this._disposed){
                switch (_arg_1){
                    case HabboAlertDialogFlag._SafeStr_7586:
                        _local_2 = (this._window.findChildByName(_SafeStr_7586) as IInteractiveWindow);
                        break;
                    case HabboAlertDialogFlag._SafeStr_7587:
                        _local_2 = (this._window.findChildByName(_SafeStr_7587) as IInteractiveWindow);
                        break;
                    case HabboAlertDialogFlag._SafeStr_7588:
                        _local_2 = (this._window.findChildByName(_SafeStr_7588) as IInteractiveWindow);
                        break;
                };
            };
            return (((_local_2) ? new AlertDialogCaption(_local_2.caption, _local_2.toolTipCaption, _local_2.visible) : null));
        }
        public function setButtonCaption(_arg_1:int, _arg_2:ICaption):void
        {
        }
        public function set title(_arg_1:String):void
        {
            this._title = _arg_1;
            if (this._window){
                this._window.caption = this._title;
            };
        }
        public function get title():String
        {
            return (this._title);
        }
        public function set summary(_arg_1:String):void
        {
            this._summary = _arg_1;
            if (this._window){
                ITextWindow(this._window.findChildByTag("DESCRIPTION")).text = this._summary;
            };
        }
        public function get summary():String
        {
            return (this._summary);
        }
        public function set callback(_arg_1:Function):void
        {
            this._callback = _arg_1;
        }
        public function get callback():Function
        {
            return (this._callback);
        }
        public function get disposed():Boolean
        {
            return (this._disposed);
        }

    }
}//package com.sulake.habbo.window.utils

// _SafeStr_11027 = "_-2Zb" (String#894, DoABC#2)
// WindowEvent = "_-Jh" (String#2085, DoABC#2)
// IAlertDialog = "_-2LY" (String#6472, DoABC#2)
// getButtonCaption = "_-3Dj" (String#7591, DoABC#2)
// setButtonCaption = "_-2YJ" (String#6733, DoABC#2)
// _SafeStr_14367 = "_-1rU" (String#18606, DoABC#2)
// dialogEventProc = "_-2eS" (String#1917, DoABC#2)
// INotify = "_-3FZ" (String#7620, DoABC#2)
// AlertDialog = "_-eF" (String#8488, DoABC#2)
// IInteractiveWindow = "_-0KX" (String#1454, DoABC#2)
// ICaption = "_-1ZX" (String#5555, DoABC#2)
// AlertDialogCaption = "_-LZ" (String#8115, DoABC#2)
// HabboAlertDialogFlag = "_-1mF" (String#18390, DoABC#2)
// _SafeStr_4425 = "_-vA" (String#643, DoABC#2)
// _SafeStr_4662 = "_-0g1" (String#15673, DoABC#2)
// _summary = "_-0Dd" (String#811, DoABC#2)
// summary = "_-Vo" (String#2121, DoABC#2)
// toolTipCaption = "_-0cC" (String#4347, DoABC#2)
// _SafeStr_7582 = "_-2qt" (String#21118, DoABC#2)
// _SafeStr_7583 = "_-0Fk" (String#3868, DoABC#2)
// _SafeStr_7586 = "_-2yB" (String#7242, DoABC#2)
// _SafeStr_7587 = "_-N" (String#8142, DoABC#2)
// _SafeStr_7588 = "_-JG" (String#8068, DoABC#2)
// WE_OK = "_-0UB" (String#15212, DoABC#2)
// _callback = "_-0t2" (String#593, DoABC#2)
// allocate = "_-08G" (String#14374, DoABC#2)
// WE_CANCEL = "_-0gf" (String#15696, DoABC#2)


