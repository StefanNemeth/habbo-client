
package com.sulake.habbo.ui.handler
{
    import com.sulake.habbo.ui.IRoomWidgetHandler;
    import com.sulake.habbo.ui.IRoomWidgetHandlerContainer;
    import com.sulake.habbo.ui.widget.enums.RoomWidgetEnum;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetLetUserInMessage;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetMessage;
    import com.sulake.habbo.ui.widget.events.RoomWidgetUpdateEvent;
    import com.sulake.habbo.session.events.RoomSessionDoorbellEvent;
    import com.sulake.habbo.ui.widget.events.RoomWidgetDoorbellEvent;
    import flash.events.Event;

    public class DoorbellWidgetHandler implements IRoomWidgetHandler 
    {

        private var _disposed:Boolean = false;
        private var _container:IRoomWidgetHandlerContainer = null;

        public function get disposed():Boolean
        {
            return (this._disposed);
        }
        public function get type():String
        {
            return (RoomWidgetEnum.RSDE_DOORBELL);
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
            return ([RoomWidgetLetUserInMessage.RWLUIM_LET_USER_IN]);
        }
        public function processWidgetMessage(_arg_1:RoomWidgetMessage):RoomWidgetUpdateEvent
        {
            var _local_2:RoomWidgetLetUserInMessage;
            switch (_arg_1.type){
                case RoomWidgetLetUserInMessage.RWLUIM_LET_USER_IN:
                    _local_2 = (_arg_1 as RoomWidgetLetUserInMessage);
                    this._container.roomSession.RoomSession(_local_2.userName, _local_2.canEnter);
                    break;
            };
            return (null);
        }
        public function IRoomWidgetHandler():Array
        {
            return ([RoomSessionDoorbellEvent.RSDE_DOORBELL, RoomSessionDoorbellEvent.RWDE_REJECTED, RoomSessionDoorbellEvent.RWDE_ACCEPTED]);
        }
        public function IRoomWidgetHandler(_arg_1:Event):void
        {
            var _local_2:RoomSessionDoorbellEvent;
            switch (_arg_1.type){
                case RoomSessionDoorbellEvent.RSDE_DOORBELL:
                    _local_2 = (_arg_1 as RoomSessionDoorbellEvent);
                    if (_local_2 == null){
                        return;
                    };
                    this._container.events.dispatchEvent(new RoomWidgetDoorbellEvent(RoomWidgetDoorbellEvent.RWDE_RINGING, _local_2.userName));
                    return;
                case RoomSessionDoorbellEvent.RWDE_REJECTED:
                    _local_2 = (_arg_1 as RoomSessionDoorbellEvent);
                    if (_local_2 == null){
                        return;
                    };
                    this._container.events.dispatchEvent(new RoomWidgetDoorbellEvent(RoomWidgetDoorbellEvent.RWDE_REJECTED, _local_2.userName));
                    return;
                case RoomSessionDoorbellEvent.RWDE_ACCEPTED:
                    _local_2 = (_arg_1 as RoomSessionDoorbellEvent);
                    if (_local_2 == null){
                        return;
                    };
                    this._container.events.dispatchEvent(new RoomWidgetDoorbellEvent(RoomWidgetDoorbellEvent.RWDE_ACCEPTED, _local_2.userName));
                    return;
            };
        }
        public function update():void
        {
        }

    }
}//package com.sulake.habbo.ui.handler

// RoomSessionDoorbellEvent = "_-30k" (String#7320, DoABC#2)
// RoomWidgetMessage = "_-04U" (String#3654, DoABC#2)
// RoomWidgetUpdateEvent = "_-0ZP" (String#4289, DoABC#2)
// DoorbellWidgetHandler = "_-zx" (String#24682, DoABC#2)
// RoomWidgetDoorbellEvent = "_-3CX" (String#7566, DoABC#2)
// RoomWidgetLetUserInMessage = "_-2Tq" (String#6644, DoABC#2)
// RWLUIM_LET_USER_IN = "_-3G7" (String#22122, DoABC#2)
// canEnter = "_-1wn" (String#18835, DoABC#2)
// RSDE_DOORBELL = "_-0bt" (String#15507, DoABC#2)
// RWDE_ACCEPTED = "_-1OB" (String#17441, DoABC#2)
// _disposed = "_-6m" (String#31, DoABC#2)
// RWDE_REJECTED = "_-1MV" (String#17378, DoABC#2)
// RWDE_RINGING = "_-3FK" (String#22090, DoABC#2)
// roomSession = "_-0cq" (String#4363, DoABC#2)
// IRoomWidgetHandler = "_-1dr" (String#5626, DoABC#2)
// IRoomWidgetHandler = "_-0gb" (String#4436, DoABC#2)
// IRoomWidgetHandler = "_-xT" (String#2223, DoABC#2)
// RoomSession = "_-0KK" (String#3961, DoABC#2)


