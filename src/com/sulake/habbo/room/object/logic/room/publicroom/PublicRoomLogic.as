
package com.sulake.habbo.room.object.logic.room.publicroom
{
    import com.sulake.habbo.room.object.logic.room.RoomLogic;
    import com.sulake.habbo.room.events.RoomObjectRoomAdEvent;
    import com.sulake.room.object.IRoomObjectModelController;
    import com.sulake.habbo.room.object.RoomObjectVariableEnum;
    import com.sulake.habbo.room.messages.RoomObjectRoomAdUpdateMessage;
    import flash.utils.getTimer;
    import com.sulake.habbo.room.RoomVariableEnum;
    import com.sulake.room.messages.RoomObjectUpdateMessage;
    import com.sulake.room.events.RoomSpriteMouseEvent;
    import com.sulake.habbo.utils.HabboWebTools;
    import flash.events.MouseEvent;
    import com.sulake.room.utils.IRoomGeometry;

    public class PublicRoomLogic extends RoomLogic 
    {

        private var _initialized:Boolean = false;
        private var _SafeStr_5311:int = 0;

        override public function getEventTypes():Array
        {
            var _local_1:Array = [RoomObjectRoomAdEvent.RORAE_ROOM_AD_FURNI_CLICK, RoomObjectRoomAdEvent.RORAE_ROOM_AD_TOOLTIP_SHOW, RoomObjectRoomAdEvent.RORAE_ROOM_AD_TOOLTIP_HIDE];
            return (ObjectLogicBase(super.getEventTypes(), _local_1));
        }
        override public function initialize(_arg_1:XML):void
        {
            super.initialize(_arg_1);
            if ((((_arg_1 == null)) || ((object == null)))){
                return;
            };
            var _local_2:IRoomObjectModelController = (object.getModel() as IRoomObjectModelController);
            if (_local_2 == null){
                return;
            };
            _local_2.setString(RoomObjectVariableEnum._SafeStr_5316, "");
            _local_2.setString(RoomObjectVariableEnum._SafeStr_5317, "");
            _local_2.setNumber(RoomObjectVariableEnum._SafeStr_5318, Number(false));
            this._initialized = true;
        }
        override public function update(_arg_1:int):void
        {
            super.update(_arg_1);
            if ((((this._SafeStr_5311 > 0)) && ((_arg_1 > this._SafeStr_5311)))){
                this.adDelayTimeout();
                this._SafeStr_5311 = 0;
            };
        }
        override public function processUpdateMessage(_arg_1:RoomObjectUpdateMessage):void
        {
            if ((((_arg_1 == null)) || ((object == null)))){
                return;
            };
            var _local_2:IRoomObjectModelController = (object.getModel() as IRoomObjectModelController);
            if (_local_2 == null){
                return;
            };
            var _local_3:RoomObjectRoomAdUpdateMessage = (_arg_1 as RoomObjectRoomAdUpdateMessage);
            if (_local_3 != null){
                switch (_local_3.type){
                    case RoomObjectRoomAdUpdateMessage.RORUM_ROOM_AD_ACTIVATE:
                        _local_2.setString(RoomObjectVariableEnum._SafeStr_5316, _local_3.asset);
                        _local_2.setString(RoomObjectVariableEnum._SafeStr_5317, _local_3.clickUrl);
                        _local_2.setNumber(RoomObjectVariableEnum._SafeStr_5318, Number(true));
                        this._SafeStr_5311 = (getTimer() + _local_2.getNumber(RoomVariableEnum._SafeStr_5321));
                        return;
                };
            };
        }
        public function adDelayTimeout():void
        {
            if (object == null){
                return;
            };
            var _local_1:IRoomObjectModelController = (object.getModel() as IRoomObjectModelController);
            if (_local_1 == null){
                return;
            };
            _local_1.setNumber(RoomObjectVariableEnum._SafeStr_5318, Number(false));
        }
        override public function mouseEvent(_arg_1:RoomSpriteMouseEvent, _arg_2:IRoomGeometry):void
        {
            var _local_7:String;
            super.mouseEvent(_arg_1, _arg_2);
            var _local_3:RoomSpriteMouseEvent = _arg_1;
            if (_local_3 == null){
                return;
            };
            if ((((object == null)) || ((_arg_1 == null)))){
                return;
            };
            var _local_4:IRoomObjectModelController = (object.getModel() as IRoomObjectModelController);
            if (_local_4 == null){
                return;
            };
            var _local_5:int = object.getId();
            var _local_6:String = object.getType();
            switch (_local_3.type){
                case MouseEvent.CLICK:
                    if (_local_3.spriteTag == RoomObjectVariableEnum._SafeStr_5325){
                        _local_7 = _local_4.getString(RoomObjectVariableEnum._SafeStr_5317);
                        if (((!((_local_7 == null))) && ((_local_7.indexOf("http") == 0)))){
                            eventDispatcher.dispatchEvent(new RoomObjectRoomAdEvent(RoomObjectRoomAdEvent.RORAE_ROOM_AD_FURNI_CLICK, _local_5, _local_6, _local_7));
                            HabboWebTools.HTMLTextController(_local_7);
                        };
                    };
                    return;
                case MouseEvent.ROLL_OVER:
                    if (_local_3.spriteTag == RoomObjectVariableEnum._SafeStr_5325){
                        eventDispatcher.dispatchEvent(new RoomObjectRoomAdEvent(RoomObjectRoomAdEvent.RORAE_ROOM_AD_TOOLTIP_SHOW, _local_5, _local_6));
                    };
                    return;
                case MouseEvent.ROLL_OUT:
                    if (_local_3.spriteTag == RoomObjectVariableEnum._SafeStr_5325){
                        eventDispatcher.dispatchEvent(new RoomObjectRoomAdEvent(RoomObjectRoomAdEvent.RORAE_ROOM_AD_TOOLTIP_HIDE, _local_5, _local_6));
                    };
                    return;
            };
        }

    }
}//package com.sulake.habbo.room.object.logic.room.publicroom

// HabboWebTools = "_-2pX" (String#21059, DoABC#2)
// RoomObjectVariableEnum = "_-1MH" (String#17370, DoABC#2)
// RoomLogic = "_-Qn" (String#8222, DoABC#2)
// PublicRoomLogic = "_-2QI" (String#6566, DoABC#2)
// IRoomObjectModelController = "_-1yp" (String#6010, DoABC#2)
// IRoomGeometry = "_-0z9" (String#4829, DoABC#2)
// RoomObjectUpdateMessage = "_-73" (String#22503, DoABC#2)
// RoomVariableEnum = "_-0J6" (String#14804, DoABC#2)
// RoomObjectRoomAdUpdateMessage = "_-070" (String#14324, DoABC#2)
// RoomSpriteMouseEvent = "_-wc" (String#8815, DoABC#2)
// HTMLTextController = "_-27c" (String#6194, DoABC#2)
// _initialized = "_-0EY" (String#214, DoABC#2)
// _SafeStr_5311 = "_-1dg" (String#18043, DoABC#2)
// RORAE_ROOM_AD_FURNI_CLICK = "_-0v3" (String#16239, DoABC#2)
// RORAE_ROOM_AD_TOOLTIP_SHOW = "_-1bW" (String#17956, DoABC#2)
// RORAE_ROOM_AD_TOOLTIP_HIDE = "_-37a" (String#21790, DoABC#2)
// ObjectLogicBase = "_-uN" (String#24466, DoABC#2)
// _SafeStr_5316 = "_-1FV" (String#17095, DoABC#2)
// _SafeStr_5317 = "_-0cX" (String#15535, DoABC#2)
// _SafeStr_5318 = "_-0zX" (String#16408, DoABC#2)
// adDelayTimeout = "_-0AC" (String#14455, DoABC#2)
// processUpdateMessage = "_-FX" (String#7984, DoABC#2)
// _SafeStr_5321 = "_-2jv" (String#20841, DoABC#2)
// RORUM_ROOM_AD_ACTIVATE = "_-1jv" (String#18281, DoABC#2)
// mouseEvent = "_-0Um" (String#4199, DoABC#2)
// spriteTag = "_-1jr" (String#18278, DoABC#2)
// _SafeStr_5325 = "_-1vh" (String#18784, DoABC#2)
// RoomObjectRoomAdEvent = "_-mk" (String#24139, DoABC#2)


