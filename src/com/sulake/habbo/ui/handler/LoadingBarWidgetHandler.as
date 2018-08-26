
package com.sulake.habbo.ui.handler
{
    import com.sulake.habbo.ui.IRoomWidgetHandler;
    import com.sulake.habbo.ui.IRoomWidgetHandlerContainer;
    import com.sulake.habbo.ui.widget.enums.RoomWidgetEnum;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetMessage;
    import com.sulake.habbo.ui.widget.events.RoomWidgetUpdateEvent;
    import com.sulake.habbo.advertisement.events.InterstitialEvent;
    import com.sulake.habbo.ui.widget.events.RoomWidgetLoadingBarUpdateEvent;
    import com.sulake.habbo.ui.widget.events.RoomWidgetInterstitialUpdateEvent;
    import flash.events.Event;

    public class LoadingBarWidgetHandler implements IRoomWidgetHandler 
    {

        private var _disposed:Boolean = false;
        private var _container:IRoomWidgetHandlerContainer = null;

        public function get disposed():Boolean
        {
            return (this._disposed);
        }
        public function get type():String
        {
            return (RoomWidgetEnum.RWE_LOADINGBAR);
        }
        public function set container(_arg_1:IRoomWidgetHandlerContainer):void
        {
            this._container = _arg_1;
        }
        public function dispose():void
        {
            this._disposed = true;
            this._container = null;
        }
        public function IRoomWidgetHandler():Array
        {
            return ([]);
        }
        public function processWidgetMessage(_arg_1:RoomWidgetMessage):RoomWidgetUpdateEvent
        {
            return (null);
        }
        public function IRoomWidgetHandler():Array
        {
            var _local_1:Array = [];
            _local_1.push(InterstitialEvent.AE_INTERSTITIAL_SHOW);
            _local_1.push(InterstitialEvent.AE_INTERSTITIAL_COMPLETE);
            _local_1.push(RoomWidgetLoadingBarUpdateEvent.RWIUE_SHOW);
            _local_1.push(RoomWidgetLoadingBarUpdateEvent.RWLBUW_HIDE_LOADING_BAR);
            return (_local_1);
        }
        public function IRoomWidgetHandler(_arg_1:Event):void
        {
            var _local_2:InterstitialEvent;
            var _local_3:RoomWidgetInterstitialUpdateEvent;
            if ((((this._container == null)) || ((this._container.events == null)))){
                return;
            };
            switch (_arg_1.type){
                case InterstitialEvent.AE_INTERSTITIAL_SHOW:
                    _local_2 = (_arg_1 as InterstitialEvent);
                    if (_local_2 == null){
                        return;
                    };
                    _local_3 = new RoomWidgetInterstitialUpdateEvent(RoomWidgetInterstitialUpdateEvent.RWIUE_SHOW, _local_2.image, _local_2.clickURL);
                    this._container.events.dispatchEvent(_local_3);
                    return;
                case InterstitialEvent.AE_INTERSTITIAL_COMPLETE:
                    this._container.IRoomWidgetHandlerContainer();
                    return;
                case RoomWidgetLoadingBarUpdateEvent.RWIUE_SHOW:
                    this._container.events.dispatchEvent(_arg_1);
                    return;
                case RoomWidgetLoadingBarUpdateEvent.RWLBUW_HIDE_LOADING_BAR:
                    this._container.events.dispatchEvent(_arg_1);
                    return;
            };
        }
        public function update():void
        {
        }

    }
}//package com.sulake.habbo.ui.handler

// InterstitialEvent = "_-2PZ" (String#6552, DoABC#2)
// RoomWidgetMessage = "_-04U" (String#3654, DoABC#2)
// RoomWidgetUpdateEvent = "_-0ZP" (String#4289, DoABC#2)
// LoadingBarWidgetHandler = "_-33A" (String#21626, DoABC#2)
// RoomWidgetLoadingBarUpdateEvent = "_-0ux" (String#4743, DoABC#2)
// RoomWidgetInterstitialUpdateEvent = "_-198" (String#5059, DoABC#2)
// RWE_LOADINGBAR = "_-3IO" (String#22216, DoABC#2)
// _disposed = "_-6m" (String#31, DoABC#2)
// RWIUE_SHOW = "_-32i" (String#21606, DoABC#2)
// RWLBUW_HIDE_LOADING_BAR = "_-0-1" (String#14011, DoABC#2)
// AE_INTERSTITIAL_SHOW = "_-2Fx" (String#19641, DoABC#2)
// AE_INTERSTITIAL_COMPLETE = "_-7z" (String#22543, DoABC#2)
// clickURL = "_-0-5" (String#14015, DoABC#2)
// IRoomWidgetHandler = "_-1dr" (String#5626, DoABC#2)
// IRoomWidgetHandler = "_-0gb" (String#4436, DoABC#2)
// IRoomWidgetHandler = "_-xT" (String#2223, DoABC#2)
// IRoomWidgetHandlerContainer = "_-0lq" (String#4543, DoABC#2)


