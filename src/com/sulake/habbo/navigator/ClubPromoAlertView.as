
package com.sulake.habbo.navigator
{
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.window.components.IFrameWindow;

    public class ClubPromoAlertView extends AlertView 
    {

        private var _text:String;
        private var _SafeStr_12017:String;

        public function ClubPromoAlertView(_arg_1:HabboNavigator, _arg_2:String, _arg_3:String, _arg_4:String)
        {
            super(_arg_1, "nav_promo_alert", _arg_2);
            this._text = _arg_3;
            this._SafeStr_12017 = _arg_4;
        }
        override function setupAlertWindow(_arg_1:IFrameWindow):void
        {
            var _local_2:IWindowContainer = _arg_1.content;
            _local_2.findChildByName("body_text").caption = this._text;
            _local_2.findChildByName("promo_text").caption = this._SafeStr_12017;
            var _local_3:IWindow = _local_2.findChildByName("ok");
            if (_local_3 != null){
                _local_3.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.PollOfferDialog);
            };
            var _local_4:IWindow = _local_2.findChildByName("promo_container");
            if (_local_4 != null){
                _local_4.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onPromo);
            };
        }
        private function PollOfferDialog(_arg_1:WindowMouseEvent):void
        {
            dispose();
        }
        private function onPromo(_arg_1:WindowMouseEvent):void
        {
            navigator.openCatalogClubPage();
            dispose();
        }

    }
}//package com.sulake.habbo.navigator

// setupAlertWindow = "_-2MF" (String#19894, DoABC#2)
// _SafeStr_12017 = "_-qH" (String#24283, DoABC#2)
// onPromo = "_-1v0" (String#18756, DoABC#2)
// AlertView = "_-2G6" (String#883, DoABC#2)
// ClubPromoAlertView = "_-c3" (String#8457, DoABC#2)
// PollOfferDialog = "_-39j" (String#457, DoABC#2)


