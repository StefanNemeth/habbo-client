
package com.sulake.habbo.notifications
{
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.habbo.localization.IHabboLocalizationManager;
    import com.sulake.habbo.window.utils.IAlertDialog;
    import com.sulake.core.window.events.WindowEvent;

    public class HabboAlertDialogManager 
    {

        private var _windowManager:IHabboWindowManager;
        private var _localization:IHabboLocalizationManager;

        public function HabboAlertDialogManager(_arg_1:IHabboWindowManager, _arg_2:IHabboLocalizationManager)
        {
            this._windowManager = _arg_1;
            this._localization = _arg_2;
        }
        public function dispose():void
        {
            this._windowManager = null;
            this._localization = null;
        }
        public function handleModMessage(message:String, url:String=""):void
        {
            var p:RegExp = /\\r/g;
            message = message.replace(p, "\r");
            if (url.length > 0){
                this._windowManager.alertWithLink("${mod.alert.title}", message, "${mod.alert.link}", url, 0, function (_arg_1:IAlertDialog, _arg_2:WindowEvent):void
                {
                    _arg_1.dispose();
                });
            }
            else {
                this._windowManager.alert("${mod.alert.title}", message, 0, function (_arg_1:IAlertDialog, _arg_2:WindowEvent):void
                {
                    _arg_1.dispose();
                });
            };
        }
        public function handleUserBannedMessage(message:String):void
        {
            this._windowManager.alert("${mod.ban.title}", message, 0, function (_arg_1:IAlertDialog, _arg_2:WindowEvent):void
            {
                _arg_1.dispose();
            });
        }
        public function handleHotelClosingMessage(minutesUntilClosing:int):void
        {
            this._localization.registerParameter("opening.hours.shutdown", "m", String(minutesUntilClosing));
            this._windowManager.alert("${opening.hours.title}", "${opening.hours.shutdown}", 0, function (_arg_1:IAlertDialog, _arg_2:WindowEvent):void
            {
                _arg_1.dispose();
            });
        }
        public function handleHotelClosedMessage(openHour:int, openMinute:int, userThrownOutAtClose:Boolean):void
        {
            if (userThrownOutAtClose){
                this._localization.registerParameter("opening.hours.disconnected", "h", this.getTimeZeroPadded(openHour));
                this._localization.registerParameter("opening.hours.disconnected", "m", this.getTimeZeroPadded(openMinute));
                this._windowManager.alert("${opening.hours.title}", "${opening.hours.disconnected}", 0, function (_arg_1:IAlertDialog, _arg_2:WindowEvent):void
                {
                    _arg_1.dispose();
                });
            }
            else {
                this._localization.registerParameter("opening.hours.closed", "h", this.getTimeZeroPadded(openHour));
                this._localization.registerParameter("opening.hours.closed", "m", this.getTimeZeroPadded(openMinute));
                this._windowManager.alert("${opening.hours.title}", "${opening.hours.closed}", 0, function (_arg_1:IAlertDialog, _arg_2:WindowEvent):void
                {
                    _arg_1.dispose();
                });
            };
        }
        public function handleLoginFailedHotelClosedMessage(openHour:int, openMinute:int):void
        {
            this._localization.registerParameter("opening.hours.disconnected", "h", this.getTimeZeroPadded(openHour));
            this._localization.registerParameter("opening.hours.disconnected", "m", this.getTimeZeroPadded(openMinute));
            this._windowManager.alert("${opening.hours.title}", "${opening.hours.disconnected}", 0, function (_arg_1:IAlertDialog, _arg_2:WindowEvent):void
            {
                _arg_1.dispose();
            });
        }
        private function getTimeZeroPadded(_arg_1:int):String
        {
            var _local_2:String = ("0" + String(_arg_1));
            return (_local_2.substr((_local_2.length - 2), _local_2.length));
        }

    }
}//package com.sulake.habbo.notifications

// handleModMessage = "_-1Bx" (String#16938, DoABC#2)
// alertWithLink = "_-KV" (String#8092, DoABC#2)
// handleUserBannedMessage = "_-0KQ" (String#14856, DoABC#2)
// handleHotelClosingMessage = "_-2G7" (String#19647, DoABC#2)
// handleHotelClosedMessage = "_-3Iu" (String#22235, DoABC#2)
// getTimeZeroPadded = "_-0j7" (String#15798, DoABC#2)
// handleLoginFailedHotelClosedMessage = "_-1hn" (String#18203, DoABC#2)
// HabboAlertDialogManager = "_-13b" (String#4945, DoABC#2)
// WindowEvent = "_-Jh" (String#2085, DoABC#2)
// IAlertDialog = "_-2LY" (String#6472, DoABC#2)


