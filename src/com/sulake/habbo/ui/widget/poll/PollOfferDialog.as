
package com.sulake.habbo.ui.widget.poll
{
    import com.sulake.core.window.components.IFrameWindow;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.components.ITextWindow;
    import com.sulake.core.window.components.IItemListWindow;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetPollMessage;
    import com.sulake.core.window.events.WindowEvent;

    public class PollOfferDialog implements IPollDialog 
    {

        public static const POLL_OFFER_STATE_OK:String = "POLL_OFFER_STATE_OK";
        public static const POLL_OFFER_STATE_CANCEL:String = "POLL_OFFER_STATE_CANCEL";
        public static const POLL_OFFER_STATE_UNKNOWN:String = "POLL_OFFER_STATE_UNKNOWN";

        private var _disposed:Boolean = false;
        private var _window:IFrameWindow;
        private var _state:String = "POLL_OFFER_STATE_UNKNOWN";
        private var _widget:PollWidget;
        private var _id:int = -1;

        public function PollOfferDialog(_arg_1:int, _arg_2:String, _arg_3:PollWidget)
        {
            var _local_5:IWindow;
            var _local_6:IWindow;
            var _local_7:IWindow;
            var _local_8:IWindow;
            var _local_9:ITextWindow;
            var _local_10:IItemListWindow;
            super();
            this._id = _arg_1;
            this._widget = _arg_3;
            var _local_4:XmlAsset = (this._widget.assets.getAssetByName("poll_offer") as XmlAsset);
            if (_local_4 != null){
                this._window = (this._widget.windowManager.buildFromXML((_local_4.content as XML)) as IFrameWindow);
                if (this._window){
                    this._window.center();
                    _local_5 = this._window.findChildByName("poll_offer_button_ok");
                    if (_local_5 != null){
                        _local_5.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onOk);
                    };
                    _local_6 = this._window.findChildByName("poll_offer_button_cancel");
                    if (_local_6 != null){
                        _local_6.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onCancel);
                    };
                    _local_7 = this._window.findChildByName("poll_offer_button_later");
                    if (_local_7 != null){
                        _local_7.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onLater);
                    };
                    _local_8 = this._window.findChildByName("header_button_close");
                    if (_local_8 != null){
                        _local_8.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onClose);
                    };
                    _local_9 = (this._window.findChildByName("poll_offer_summary") as ITextWindow);
                    if (_local_9){
                        _local_9.htmlText = _arg_2;
                        _local_10 = (this._window.findChildByName("poll_offer_summary_wrapper") as IItemListWindow);
                        if (_local_10){
                            this._window.height = (this._window.height + (_local_10.scrollableRegion.height - _local_10.visibleRegion.height));
                        };
                    };
                };
            };
        }
        public function get disposed():Boolean
        {
            return (this._disposed);
        }
        public function get state():String
        {
            return (this._state);
        }
        public function start():void
        {
        }
        public function dispose():void
        {
            if (this._disposed){
                return;
            };
            this._disposed = true;
            if (this._window){
                this._window.dispose();
                this._window = null;
            };
            this._widget = null;
        }
        private function onOk(_arg_1:WindowEvent):void
        {
            if (this._state != POLL_OFFER_STATE_UNKNOWN){
                return;
            };
            this._state = POLL_OFFER_STATE_OK;
            this._widget.messageListener.processWidgetMessage(new RoomWidgetPollMessage(RoomWidgetPollMessage.RWPM_START, this._id));
        }
        private function onCancel(_arg_1:WindowEvent):void
        {
            if (this._state != POLL_OFFER_STATE_UNKNOWN){
                return;
            };
            this._state = POLL_OFFER_STATE_CANCEL;
            this._widget.messageListener.processWidgetMessage(new RoomWidgetPollMessage(RoomWidgetPollMessage.RWPM_REJECT, this._id));
            this._widget.pollCancelled(this._id);
        }
        private function onLater(_arg_1:WindowEvent):void
        {
            if (this._state != POLL_OFFER_STATE_UNKNOWN){
                return;
            };
            this._state = POLL_OFFER_STATE_CANCEL;
            this._widget.pollCancelled(this._id);
        }
        private function onClose(_arg_1:WindowEvent):void
        {
            if (this._state != POLL_OFFER_STATE_UNKNOWN){
                return;
            };
            this._state = POLL_OFFER_STATE_CANCEL;
            this._widget.messageListener.processWidgetMessage(new RoomWidgetPollMessage(RoomWidgetPollMessage.RWPM_REJECT, this._id));
            this._widget.pollCancelled(this._id);
        }

    }
}//package com.sulake.habbo.ui.widget.poll

// WindowEvent = "_-Jh" (String#2085, DoABC#2)
// pollCancelled = "_-1uv" (String#18752, DoABC#2)
// POLL_OFFER_STATE_OK = "_-0gj" (String#15698, DoABC#2)
// POLL_OFFER_STATE_CANCEL = "_-As" (String#22651, DoABC#2)
// onLater = "_-25P" (String#19235, DoABC#2)
// PollWidget = "_-0pz" (String#4635, DoABC#2)
// RoomWidgetPollMessage = "_-0uI" (String#4731, DoABC#2)
// IPollDialog = "_-1OE" (String#5315, DoABC#2)
// PollOfferDialog = "_-JC" (String#8066, DoABC#2)
// RWPM_START = "_-1VF" (String#17711, DoABC#2)
// RWPM_REJECT = "_-1pH" (String#18513, DoABC#2)
// scrollableRegion = "_-2ku" (String#6976, DoABC#2)
// onClose = "_-2Ts" (String#54, DoABC#2)
// onCancel = "_-3JX" (String#633, DoABC#2)
// onOk = "_-39j" (String#457, DoABC#2)
// visibleRegion = "_-MK" (String#8129, DoABC#2)
// POLL_OFFER_STATE_UNKNOWN = "_-2VV" (String#20262, DoABC#2)


