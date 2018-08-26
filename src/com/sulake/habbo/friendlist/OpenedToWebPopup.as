
package com.sulake.habbo.friendlist
{
    import com.sulake.core.window.IWindowContainer;
    import flash.utils.Timer;
    import flash.events.TimerEvent;
    import flash.events.Event;

    public class OpenedToWebPopup 
    {

        private var _friendList:HabboFriendList;
        private var _alert:IWindowContainer;
        private var _SafeStr_5297:Timer;

        public function OpenedToWebPopup(_arg_1:HabboFriendList)
        {
            this._friendList = _arg_1;
        }
        public function show(_arg_1:int, _arg_2:int):void
        {
            if (this._alert != null){
                this.close(null);
            };
            this._alert = this.getOpenedToWebAlert();
            if (this._SafeStr_5297 != null){
                this._SafeStr_5297.stop();
            };
            this._SafeStr_5297 = new Timer(2000, 1);
            this._SafeStr_5297.addEventListener(TimerEvent.TIMER, this.close);
            this._SafeStr_5297.start();
            this._alert.x = _arg_1;
            this._alert.y = _arg_2;
        }
        private function close(_arg_1:Event):void
        {
            this._alert.destroy();
            this._alert = null;
        }
        private function getOpenedToWebAlert():IWindowContainer
        {
            var _local_1:IWindowContainer = IWindowContainer(this._friendList.getXmlWindow("opened_to_web_popup"));
            this._friendList.refreshButton(_local_1, "opened_to_web", true, null, 0);
            return (_local_1);
        }

    }
}//package com.sulake.habbo.friendlist

// getOpenedToWebAlert = "_-00t" (String#14089, DoABC#2)
// OpenedToWebPopup = "_-RA" (String#8230, DoABC#2)
// _SafeStr_5297 = "_-0Gy" (String#355, DoABC#2)
// destroy = "_-25R" (String#615, DoABC#2)


