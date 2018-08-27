
package com.sulake.habbo.ui.handler
{
    import com.sulake.habbo.ui.IRoomWidgetHandler;
    import com.sulake.habbo.ui.IRoomWidgetHandlerContainer;
    import com.sulake.habbo.ui.widget.enums.RoomWidgetEnum;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetChatTypingMessage;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetMessage;
    import com.sulake.habbo.ui.widget.events.RoomWidgetUpdateEvent;
    import com.sulake.habbo.session.events.RoomSessionChatEvent;
    import flash.events.Event;
    import com.sulake.habbo.ui.widget.events.RoomWidgetFloodControlEvent;

    public class ChatInputWidgetHandler implements IRoomWidgetHandler 
    {

        private var _disposed:Boolean = false;
        private var _container:IRoomWidgetHandlerContainer = null;

        public function get disposed():Boolean
        {
            return (this._disposed);
        }
        public function get type():String
        {
            return (RoomWidgetEnum.RWE_CHAT_INPUT_WIDGET);
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
        public function getWidgetMessages():Array
        {
            var _local_1:Array = [];
            _local_1.push(RoomWidgetChatTypingMessage.RWCTM_TYPING_STATUS);
            return (_local_1);
        }
        public function processWidgetMessage(_arg_1:RoomWidgetMessage):RoomWidgetUpdateEvent
        {
            var _local_2:RoomWidgetChatTypingMessage;
            switch (_arg_1.type){
                case RoomWidgetChatTypingMessage.RWCTM_TYPING_STATUS:
                    _local_2 = (_arg_1 as RoomWidgetChatTypingMessage);
                    if (_local_2 != null){
                        this._container.roomSession.sendChatTypingMessage(_local_2.isTyping);
                    };
                    break;
            };
            return (null);
        }
        public function getProcessedEvents():Array
        {
            return ([RoomSessionChatEvent.RSCE_FLOOD_EVENT]);
        }
        public function processEvent(_arg_1:Event):void
        {
            var _local_3:RoomSessionChatEvent;
            var _local_4:int;
            var _local_2:Event;
            if ((((this._container == null)) || ((this._container.events == null)))){
                return;
            };
            switch (_arg_1.type){
                case RoomSessionChatEvent.RSCE_FLOOD_EVENT:
                    _local_3 = (_arg_1 as RoomSessionChatEvent);
                    _local_4 = parseInt(_local_3.text);
                    _local_2 = new RoomWidgetFloodControlEvent(_local_4);
                    break;
            };
            if (((((!((this._container == null))) && (!((this._container.events == null))))) && (!((_local_2 == null))))){
                this._container.events.dispatchEvent(_local_2);
            };
        }
        public function update():void
        {
        }

    }
}//package com.sulake.habbo.ui.handler

// RoomWidgetMessage = "_-04U" (String#3654, DoABC#2)
// RoomSessionChatEvent = "_-2e3" (String#6834, DoABC#2)
// RoomWidgetUpdateEvent = "_-0ZP" (String#4289, DoABC#2)
// ChatInputWidgetHandler = "_-Ep" (String#22806, DoABC#2)
// RoomWidgetFloodControlEvent = "_-23V" (String#19155, DoABC#2)
// RoomWidgetChatTypingMessage = "_-0Yw" (String#4277, DoABC#2)
// RWCTM_TYPING_STATUS = "_-1om" (String#18489, DoABC#2)
// isTyping = "_-1wh" (String#18831, DoABC#2)
// RWE_CHAT_INPUT_WIDGET = "_-L1" (String#23048, DoABC#2)
// _disposed = "_-6m" (String#31, DoABC#2)
// RSCE_FLOOD_EVENT = "_-2Pn" (String#20035, DoABC#2)
// roomSession = "_-0cq" (String#4363, DoABC#2)
// getWidgetMessages = "_-1dr" (String#5626, DoABC#2)
// getProcessedEvents = "_-0gb" (String#4436, DoABC#2)
// processEvent = "_-xT" (String#2223, DoABC#2)
// sendChatTypingMessage = "_-1Ys" (String#5539, DoABC#2)


