
package com.sulake.habbo.ui.widget.poll
{
    import com.sulake.habbo.ui.widget.RoomWidgetBase;
    import com.sulake.core.utils.Map;
    import com.sulake.habbo.ui.IRoomWidgetHandler;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.habbo.localization.IHabboLocalizationManager;
    import com.sulake.habbo.ui.widget.events.RoomWidgetPollUpdateEvent;
    import flash.events.IEventDispatcher;
    import flash.events.Event;
    import com.sulake.habbo.window.utils.IAlertDialog;
    import com.sulake.core.window.events.WindowEvent;

    public class PollWidget extends RoomWidgetBase 
    {

        private var _SafeStr_14106:Map;

        public function PollWidget(_arg_1:IRoomWidgetHandler, _arg_2:IHabboWindowManager, _arg_3:IAssetLibrary=null, _arg_4:IHabboLocalizationManager=null)
        {
            super(_arg_1, _arg_2, _arg_3, _arg_4);
            this._SafeStr_14106 = new Map();
        }
        override public function dispose():void
        {
            var _local_1:int;
            var _local_2:int;
            var _local_3:PollSession;
            if (disposed){
                return;
            };
            if (this._SafeStr_14106 != null){
                _local_1 = this._SafeStr_14106.length;
                _local_2 = 0;
                while (_local_2 < _local_1) {
                    _local_3 = (this._SafeStr_14106.getWithIndex(0) as PollSession);
                    if (_local_3 != null){
                        _local_3.dispose();
                    };
                    _local_2++;
                };
                this._SafeStr_14106.dispose();
                this._SafeStr_14106 = null;
            };
            super.dispose();
        }
        override public function registerUpdateEvents(_arg_1:IEventDispatcher):void
        {
            if (_arg_1 == null){
                return;
            };
            _arg_1.addEventListener(RoomWidgetPollUpdateEvent.RWPUW_OFFER, this.showPollOffer);
            _arg_1.addEventListener(RoomWidgetPollUpdateEvent.RWPUW_ERROR, this.showPollError);
            _arg_1.addEventListener(RoomWidgetPollUpdateEvent.RWPUW_CONTENT, this.showPollContent);
            super.registerUpdateEvents(_arg_1);
        }
        override public function unregisterUpdateEvents(_arg_1:IEventDispatcher):void
        {
            if (_arg_1 == null){
                return;
            };
            _arg_1.removeEventListener(RoomWidgetPollUpdateEvent.RWPUW_OFFER, this.showPollOffer);
            _arg_1.removeEventListener(RoomWidgetPollUpdateEvent.RWPUW_ERROR, this.showPollError);
            _arg_1.removeEventListener(RoomWidgetPollUpdateEvent.RWPUW_CONTENT, this.showPollContent);
        }
        private function showPollOffer(_arg_1:Event):void
        {
            var _local_2:int = RoomWidgetPollUpdateEvent(_arg_1).id;
            var _local_3:PollSession = (this._SafeStr_14106.getValue(_local_2) as PollSession);
            var _local_4:String = RoomWidgetPollUpdateEvent(_arg_1).summary;
            if (!_local_3){
                _local_3 = new PollSession(_local_2, this);
                this._SafeStr_14106.add(_local_2, _local_3);
                _local_3.showOffer(_local_4);
            }
            else {
                Logger.log("Poll with given id already exists!");
                _local_3.showOffer(_local_4);
            };
        }
        private function showPollError(e:Event):void
        {
            windowManager.alert("${win_error}", RoomWidgetPollUpdateEvent(e).summary, 0, function (_arg_1:IAlertDialog, _arg_2:WindowEvent):void
            {
                _arg_1.dispose();
            });
        }
        private function showPollContent(_arg_1:Event):void
        {
            var _local_3:int;
            var _local_4:PollSession;
            var _local_2:RoomWidgetPollUpdateEvent = (_arg_1 as RoomWidgetPollUpdateEvent);
            if (_local_2 != null){
                _local_3 = _local_2.id;
                _local_4 = (this._SafeStr_14106.getValue(_local_3) as PollSession);
                if (_local_4 != null){
                    _local_4.showContent(_local_2.startMessage, _local_2.endMessage, _local_2.questionArray);
                };
            };
        }
        public function pollFinished(_arg_1:int):void
        {
            var _local_2:PollSession = (this._SafeStr_14106.getValue(_arg_1) as PollSession);
            if (_local_2 != null){
                _local_2.showThanks();
                _local_2.dispose();
                this._SafeStr_14106.remove(_arg_1);
            };
        }
        public function pollCancelled(_arg_1:int):void
        {
            var _local_2:PollSession = (this._SafeStr_14106.getValue(_arg_1) as PollSession);
            if (_local_2 != null){
                _local_2.dispose();
                this._SafeStr_14106.remove(_arg_1);
            };
        }

    }
}//package com.sulake.habbo.ui.widget.poll

// WindowEvent = "_-Jh" (String#2085, DoABC#2)
// IAlertDialog = "_-2LY" (String#6472, DoABC#2)
// _SafeStr_14106 = "_-1VV" (String#17721, DoABC#2)
// showPollOffer = "_-1Dm" (String#17015, DoABC#2)
// showPollError = "_-2QP" (String#20062, DoABC#2)
// showPollContent = "_-1p8" (String#18506, DoABC#2)
// showContent = "_-ly" (String#24108, DoABC#2)
// pollFinished = "_-0qF" (String#16059, DoABC#2)
// showThanks = "_-1Tx" (String#17664, DoABC#2)
// pollCancelled = "_-1uv" (String#18752, DoABC#2)
// RoomWidgetBase = "_-0eQ" (String#4398, DoABC#2)
// PollWidget = "_-0pz" (String#4635, DoABC#2)
// PollSession = "_-2C-" (String#6285, DoABC#2)
// RoomWidgetPollUpdateEvent = "_-0GJ" (String#3876, DoABC#2)
// registerUpdateEvents = "_-1yD" (String#1787, DoABC#2)
// unregisterUpdateEvents = "_-0-c" (String#3556, DoABC#2)
// RWPUW_OFFER = "_-2v3" (String#21280, DoABC#2)
// RWPUW_ERROR = "_-0CA" (String#14535, DoABC#2)
// RWPUW_CONTENT = "_-su" (String#24399, DoABC#2)
// summary = "_-Vo" (String#2121, DoABC#2)
// startMessage = "_-1qR" (String#18561, DoABC#2)
// endMessage = "_-2a3" (String#20444, DoABC#2)
// questionArray = "_-37S" (String#21785, DoABC#2)
// showOffer = "_-2nW" (String#20980, DoABC#2)


