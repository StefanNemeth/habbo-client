
package com.sulake.habbo.ui.handler
{
    import com.sulake.habbo.ui.IRoomWidgetHandler;
    import com.sulake.habbo.ui.IRoomWidgetHandlerContainer;
    import com.sulake.habbo.ui.widget.enums.RoomWidgetEnum;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetFurniToWidgetMessage;
    import com.sulake.room.object.IRoomObject;
    import com.sulake.room.object.IRoomObjectModel;
    import com.sulake.habbo.ui.widget.events.RoomWidgetTrophyDataUpdateEvent;
    import com.sulake.habbo.room.object.RoomObjectVariableEnum;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetMessage;
    import com.sulake.habbo.ui.widget.events.RoomWidgetUpdateEvent;
    import flash.events.Event;

    public class FurnitureTrophyWidgetHandler implements IRoomWidgetHandler 
    {

        private var _disposed:Boolean = false;
        private var _container:IRoomWidgetHandlerContainer = null;

        public function get disposed():Boolean
        {
            return (this._disposed);
        }
        public function get type():String
        {
            return (RoomWidgetEnum.RWE_FURNI_TROPHY_WIDGET);
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
            return ([RoomWidgetFurniToWidgetMessage.RWFWM_MESSAGE_REQUEST_TROPHY]);
        }
        public function processWidgetMessage(_arg_1:RoomWidgetMessage):RoomWidgetUpdateEvent
        {
            var _local_2:RoomWidgetFurniToWidgetMessage;
            var _local_3:IRoomObject;
            var _local_4:IRoomObjectModel;
            var _local_5:Number;
            var _local_6:String;
            var _local_7:String;
            var _local_8:String;
            var _local_9:String;
            var _local_10:RoomWidgetTrophyDataUpdateEvent;
            if (((this.disposed) || ((_arg_1 == null)))){
                return (null);
            };
            switch (_arg_1.type){
                case RoomWidgetFurniToWidgetMessage.RWFWM_MESSAGE_REQUEST_TROPHY:
                    _local_2 = (_arg_1 as RoomWidgetFurniToWidgetMessage);
                    _local_3 = this._container.roomEngine.IRoomSpriteCanvasContainer(_local_2.roomId, _local_2.roomCategory, _local_2.id, _local_2.category);
                    if (_local_3 != null){
                        _local_4 = _local_3.getModel();
                        if (_local_4 != null){
                            _local_5 = _local_4.getNumber(RoomObjectVariableEnum._SafeStr_7220);
                            _local_6 = _local_4.getString(RoomObjectVariableEnum._SafeStr_7217);
                            _local_7 = _local_6.substring(0, _local_6.indexOf("\t"));
                            _local_6 = _local_6.substring((_local_7.length + 1), _local_6.length);
                            _local_8 = _local_6.substring(0, _local_6.indexOf("\t"));
                            _local_9 = _local_6.substring((_local_8.length + 1), _local_6.length);
                            _local_10 = new RoomWidgetTrophyDataUpdateEvent(RoomWidgetTrophyDataUpdateEvent.RWTDUE_TROPHY_DATA, _local_5, _local_7, _local_8, _local_9);
                            this._container.events.dispatchEvent(_local_10);
                        };
                    };
                    break;
            };
            return (null);
        }
        public function IRoomWidgetHandler():Array
        {
            return ([]);
        }
        public function IRoomWidgetHandler(_arg_1:Event):void
        {
            var _local_2:Event;
        }
        public function update():void
        {
        }

    }
}//package com.sulake.habbo.ui.handler

// RoomObjectVariableEnum = "_-1MH" (String#17370, DoABC#2)
// IRoomObjectModel = "_-253" (String#6141, DoABC#2)
// RoomWidgetMessage = "_-04U" (String#3654, DoABC#2)
// RoomWidgetUpdateEvent = "_-0ZP" (String#4289, DoABC#2)
// FurnitureTrophyWidgetHandler = "_-0Ha" (String#14741, DoABC#2)
// RoomWidgetFurniToWidgetMessage = "_-2Rk" (String#6600, DoABC#2)
// RoomWidgetTrophyDataUpdateEvent = "_-3LM" (String#7726, DoABC#2)
// RWFWM_MESSAGE_REQUEST_TROPHY = "_-2dM" (String#20578, DoABC#2)
// RWE_FURNI_TROPHY_WIDGET = "_-2lt" (String#20911, DoABC#2)
// _disposed = "_-6m" (String#31, DoABC#2)
// IRoomSpriteCanvasContainer = "_-1qD" (String#866, DoABC#2)
// RWTDUE_TROPHY_DATA = "_-0ag" (String#15461, DoABC#2)
// IRoomWidgetHandler = "_-1dr" (String#5626, DoABC#2)
// IRoomWidgetHandler = "_-0gb" (String#4436, DoABC#2)
// IRoomWidgetHandler = "_-xT" (String#2223, DoABC#2)
// _SafeStr_7217 = "_-1mr" (String#18416, DoABC#2)
// _SafeStr_7220 = "_-1eF" (String#18068, DoABC#2)


