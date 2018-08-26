
package com.sulake.habbo.room.object.logic
{
    import com.sulake.room.utils.Vector3d;
    import com.sulake.room.events.RoomObjectMouseEvent;
    import com.sulake.habbo.room.events.RoomObjectMoveEvent;
    import com.sulake.room.events.RoomObjectEvent;
    import com.sulake.habbo.room.messages.RoomObjectAvatarPostureUpdateMessage;
    import com.sulake.habbo.room.messages.RoomObjectAvatarUpdateMessage;
    import com.sulake.habbo.room.messages.RoomObjectAvatarChatUpdateMessage;
    import com.sulake.habbo.room.messages.RoomObjectAvatarPetGestureUpdateMessage;
    import com.sulake.habbo.room.messages.RoomObjectAvatarSleepUpdateMessage;
    import com.sulake.habbo.room.messages.RoomObjectAvatarSelectedMessage;
    import com.sulake.habbo.room.messages.RoomObjectAvatarExperienceUpdateMessage;
    import com.sulake.habbo.room.messages.RoomObjectAvatarFigureUpdateMessage;
    import com.sulake.room.object.IRoomObjectModelController;
    import com.sulake.habbo.room.object.RoomObjectVariableEnum;
    import flash.utils.getTimer;
    import com.sulake.room.messages.RoomObjectUpdateMessage;
    import com.sulake.room.utils.IVector3d;
    import flash.events.MouseEvent;
    import com.sulake.room.events.RoomSpriteMouseEvent;
    import com.sulake.room.utils.IRoomGeometry;

    public class PetLogic extends MovingObjectLogic 
    {

        private var _SafeStr_7614:int = 0;
        private var _SafeStr_7615:int = 0;
        private var _SafeStr_7616:int = 0;
        private var _selected:Boolean = false;
        private var _SafeStr_7617:Vector3d = null;
        private var _SafeStr_7618:Boolean = false;
        private var _SafeStr_7619:int = 0;
        private var _SafeStr_7620:int = 0;
        private var _SafeStr_7621:int = 0;

        override public function getEventTypes():Array
        {
            var _local_1:Array = [RoomObjectMouseEvent.ROE_MOUSE_CLICK, RoomObjectMoveEvent.ROME_POSITION_CHANGED];
            return (ObjectLogicBase(super.getEventTypes(), _local_1));
        }
        override public function dispose():void
        {
            var _local_1:RoomObjectEvent;
            if (((this._selected) && (!((object == null))))){
                if (eventDispatcher != null){
                    _local_1 = new RoomObjectMoveEvent(RoomObjectMoveEvent.ROME_OBJECT_REMOVED, object.getId(), object.getType());
                    eventDispatcher.dispatchEvent(_local_1);
                };
            };
            super.dispose();
            this._SafeStr_7617 = null;
        }
        override public function processUpdateMessage(_arg_1:RoomObjectUpdateMessage):void
        {
            var _local_3:RoomObjectAvatarPostureUpdateMessage;
            var _local_4:RoomObjectAvatarUpdateMessage;
            var _local_5:RoomObjectAvatarChatUpdateMessage;
            var _local_6:RoomObjectAvatarPetGestureUpdateMessage;
            var _local_7:RoomObjectAvatarSleepUpdateMessage;
            var _local_8:RoomObjectAvatarSelectedMessage;
            var _local_9:RoomObjectAvatarExperienceUpdateMessage;
            var _local_10:RoomObjectAvatarFigureUpdateMessage;
            var _local_11:String;
            if ((((_arg_1 == null)) || ((object == null)))){
                return;
            };
            var _local_2:IRoomObjectModelController = object.getModelController();
            if (!this._SafeStr_7618){
                super.processUpdateMessage(_arg_1);
                if ((_arg_1 is RoomObjectAvatarPostureUpdateMessage)){
                    _local_3 = (_arg_1 as RoomObjectAvatarPostureUpdateMessage);
                    _local_2.setString(RoomObjectVariableEnum._SafeStr_4366, _local_3.postureType);
                    return;
                };
                if ((_arg_1 is RoomObjectAvatarUpdateMessage)){
                    _local_4 = (_arg_1 as RoomObjectAvatarUpdateMessage);
                    _local_2.setNumber(RoomObjectVariableEnum._SafeStr_4375, _local_4.dirHead);
                    return;
                };
                if ((_arg_1 is RoomObjectAvatarChatUpdateMessage)){
                    _local_5 = (_arg_1 as RoomObjectAvatarChatUpdateMessage);
                    _local_2.setNumber(RoomObjectVariableEnum._SafeStr_6545, 1);
                    this._SafeStr_7614 = (getTimer() + (_local_5.numberOfWords * 1000));
                    return;
                };
                if ((_arg_1 is RoomObjectAvatarPetGestureUpdateMessage)){
                    _local_6 = (_arg_1 as RoomObjectAvatarPetGestureUpdateMessage);
                    _local_2.setString(RoomObjectVariableEnum._SafeStr_4367, _local_6.gesture);
                    this._SafeStr_7615 = (getTimer() + (3 * 1000));
                    return;
                };
                if ((_arg_1 is RoomObjectAvatarSleepUpdateMessage)){
                    _local_7 = (_arg_1 as RoomObjectAvatarSleepUpdateMessage);
                    _local_2.setNumber(RoomObjectVariableEnum._SafeStr_4374, Number(_local_7.isSleeping));
                    return;
                };
            };
            if ((_arg_1 is RoomObjectAvatarSelectedMessage)){
                _local_8 = (_arg_1 as RoomObjectAvatarSelectedMessage);
                this._selected = _local_8.selected;
                this._SafeStr_7617 = null;
                return;
            };
            if ((_arg_1 is RoomObjectAvatarExperienceUpdateMessage)){
                _local_9 = (_arg_1 as RoomObjectAvatarExperienceUpdateMessage);
                _local_2.setNumber(RoomObjectVariableEnum.AVATAR_EXPERIENCE_TIMESTAMP, Number(getTimer()));
                _local_2.setNumber(RoomObjectVariableEnum._SafeStr_4376, Number(_local_9.gainedExperience));
                return;
            };
            if ((_arg_1 is RoomObjectAvatarFigureUpdateMessage)){
                _local_10 = (_arg_1 as RoomObjectAvatarFigureUpdateMessage);
                _local_11 = _local_2.getString(RoomObjectVariableEnum._SafeStr_4443);
                _local_2.setString(RoomObjectVariableEnum._SafeStr_4443, _local_10.figure);
                _local_2.setString(RoomObjectVariableEnum._SafeStr_7625, _local_10.race);
                _local_2.setNumber(RoomObjectVariableEnum._SafeStr_4377, this.getPaletteIndex(_local_10.figure));
                return;
            };
        }
        override public function mouseEvent(_arg_1:RoomSpriteMouseEvent, _arg_2:IRoomGeometry):void
        {
            var _local_6:int;
            var _local_7:String;
            var _local_8:RoomObjectMouseEvent;
            if ((((object == null)) || ((_arg_1 == null)))){
                return;
            };
            var _local_3:IRoomObjectModelController = object.getModelController();
            var _local_4:IVector3d;
            var _local_5:Vector3d;
            switch (_arg_1.type){
                case MouseEvent.CLICK:
                    _local_6 = object.getId();
                    _local_7 = object.getType();
                    if (eventDispatcher != null){
                        _local_8 = new RoomObjectMouseEvent(RoomObjectMouseEvent.ROE_MOUSE_CLICK, _arg_1.eventId, _local_6, _local_7, _arg_1.altKey, _arg_1.ctrlKey, _arg_1.shiftKey, _arg_1.buttonDown);
                        eventDispatcher.dispatchEvent(_local_8);
                    };
                    if (this._SafeStr_7618){
                        this.debugMouseEvent(_arg_1);
                    };
                    return;
                case MouseEvent.DOUBLE_CLICK:
                    return;
            };
        }
        private function debugMouseEvent(_arg_1:RoomSpriteMouseEvent):void
        {
            var _local_3:int;
            var _local_2:IRoomObjectModelController = object.getModelController();
            if (((!(_arg_1.altKey)) && (!(_arg_1.ctrlKey)))){
                _local_3 = object.getDirection().x;
                _local_3 = ((_local_3 + 45) % 360);
                object.setDirection(new Vector3d(_local_3));
                _local_2.setNumber(RoomObjectVariableEnum._SafeStr_4375, (_local_3 + this._SafeStr_7621));
            }
            else {
                if (((_arg_1.altKey) && (!(_arg_1.ctrlKey)))){
                    this._SafeStr_7619++;
                    _local_2.setNumber(RoomObjectVariableEnum._SafeStr_4366, this._SafeStr_7619);
                    _local_2.setNumber(RoomObjectVariableEnum._SafeStr_4367, NaN);
                }
                else {
                    if (((_arg_1.ctrlKey) && (!(_arg_1.altKey)))){
                        this._SafeStr_7620++;
                        _local_2.setNumber(RoomObjectVariableEnum._SafeStr_4367, this._SafeStr_7620);
                    }
                    else {
                        this._SafeStr_7621 = (this._SafeStr_7621 + 45);
                        if (this._SafeStr_7621 > 45){
                            this._SafeStr_7621 = -45;
                        };
                        _local_3 = object.getDirection().x;
                        _local_2.setNumber(RoomObjectVariableEnum._SafeStr_4375, (_local_3 + this._SafeStr_7621));
                    };
                };
            };
        }
        override public function update(_arg_1:int):void
        {
            var _local_2:IVector3d;
            var _local_3:RoomObjectEvent;
            super.update(_arg_1);
            if (((this._selected) && (!((object == null))))){
                if (eventDispatcher != null){
                    _local_2 = object.getLocation();
                    if ((((((((this._SafeStr_7617 == null)) || (!((this._SafeStr_7617.x == _local_2.x))))) || (!((this._SafeStr_7617.y == _local_2.y))))) || (!((this._SafeStr_7617.z == _local_2.z))))){
                        if (this._SafeStr_7617 == null){
                            this._SafeStr_7617 = new Vector3d();
                        };
                        this._SafeStr_7617.assign(_local_2);
                        _local_3 = new RoomObjectMoveEvent(RoomObjectMoveEvent.ROME_POSITION_CHANGED, object.getId(), object.getType());
                        eventDispatcher.dispatchEvent(_local_3);
                    };
                };
            };
            if (((!((object == null))) && (!((object.getModelController() == null))))){
                this.updateActions(_arg_1, object.getModelController());
            };
        }
        private function updateActions(_arg_1:int, _arg_2:IRoomObjectModelController):void
        {
            if ((((this._SafeStr_7615 > 0)) && ((_arg_1 > this._SafeStr_7615)))){
                _arg_2.setString(RoomObjectVariableEnum._SafeStr_4367, null);
                this._SafeStr_7615 = 0;
            };
            if (this._SafeStr_7614 > 0){
                if (_arg_1 > this._SafeStr_7614){
                    _arg_2.setNumber(RoomObjectVariableEnum._SafeStr_6545, 0);
                    this._SafeStr_7614 = 0;
                };
            };
            if ((((this._SafeStr_7616 > 0)) && ((_arg_1 > this._SafeStr_7616)))){
                _arg_2.setNumber(RoomObjectVariableEnum._SafeStr_6546, 0);
                this._SafeStr_7616 = 0;
            };
        }
        private function getPaletteIndex(_arg_1:String):int
        {
            var _local_2:Array;
            if (_arg_1 != null){
                _local_2 = _arg_1.split(" ");
                if (_local_2.length >= 2){
                    return (parseInt(_local_2[1]));
                };
            };
            return (0);
        }

    }
}//package com.sulake.habbo.room.object.logic

// IVector3d = "_-hf" (String#8547, DoABC#2)
// Vector3d = "_-1Rb" (String#17568, DoABC#2)
// RoomObjectVariableEnum = "_-1MH" (String#17370, DoABC#2)
// MovingObjectLogic = "_-36D" (String#21738, DoABC#2)
// PetLogic = "_-2tA" (String#21208, DoABC#2)
// IRoomObjectModelController = "_-1yp" (String#6010, DoABC#2)
// IRoomGeometry = "_-0z9" (String#4829, DoABC#2)
// RoomObjectUpdateMessage = "_-73" (String#22503, DoABC#2)
// RoomObjectAvatarExperienceUpdateMessage = "_-2al" (String#20478, DoABC#2)
// RoomObjectMouseEvent = "_-20k" (String#19042, DoABC#2)
// RoomObjectAvatarUpdateMessage = "_-1ht" (String#18207, DoABC#2)
// RoomObjectAvatarFigureUpdateMessage = "_-0tn" (String#16195, DoABC#2)
// RoomObjectAvatarPetGestureUpdateMessage = "_-3N" (String#22353, DoABC#2)
// RoomObjectAvatarChatUpdateMessage = "_-08" (String#14365, DoABC#2)
// RoomObjectAvatarSleepUpdateMessage = "_-0Hl" (String#14746, DoABC#2)
// RoomObjectAvatarPostureUpdateMessage = "_-0OI" (String#15001, DoABC#2)
// RoomSpriteMouseEvent = "_-wc" (String#8815, DoABC#2)
// RoomObjectAvatarSelectedMessage = "_-1fk" (String#18125, DoABC#2)
// RoomObjectMoveEvent = "_-2gn" (String#20720, DoABC#2)
// _SafeStr_4366 = "_-2r-" (String#21121, DoABC#2)
// _SafeStr_4367 = "_-3At" (String#21914, DoABC#2)
// _SafeStr_4374 = "_-GG" (String#22862, DoABC#2)
// _SafeStr_4375 = "_-0Jq" (String#14835, DoABC#2)
// _SafeStr_4376 = "_-0Bp" (String#14520, DoABC#2)
// _SafeStr_4377 = "_-cz" (String#23755, DoABC#2)
// _SafeStr_4443 = "_-2Lr" (String#19878, DoABC#2)
// updateActions = "_-2p4" (String#900, DoABC#2)
// dirHead = "_-2Ej" (String#19594, DoABC#2)
// ObjectLogicBase = "_-uN" (String#24466, DoABC#2)
// processUpdateMessage = "_-FX" (String#7984, DoABC#2)
// mouseEvent = "_-0Um" (String#4199, DoABC#2)
// ROME_POSITION_CHANGED = "_-114" (String#16501, DoABC#2)
// ROME_OBJECT_REMOVED = "_-0PW" (String#15043, DoABC#2)
// ROE_MOUSE_CLICK = "_-2sU" (String#21178, DoABC#2)
// eventId = "_-3ER" (String#22053, DoABC#2)
// _SafeStr_6545 = "_-2IW" (String#19747, DoABC#2)
// _SafeStr_6546 = "_-n1" (String#24155, DoABC#2)
// gainedExperience = "_-7m" (String#22533, DoABC#2)
// _SafeStr_7614 = "_-LO" (String#8110, DoABC#2)
// _SafeStr_7615 = "_-10h" (String#4889, DoABC#2)
// _SafeStr_7616 = "_-21l" (String#6079, DoABC#2)
// _SafeStr_7617 = "_-2Vp" (String#6680, DoABC#2)
// _SafeStr_7618 = "_-2hV" (String#20753, DoABC#2)
// _SafeStr_7619 = "_-0DW" (String#14588, DoABC#2)
// _SafeStr_7620 = "_-0Y2" (String#15359, DoABC#2)
// _SafeStr_7621 = "_-2R8" (String#20089, DoABC#2)
// postureType = "_-1It" (String#17232, DoABC#2)
// numberOfWords = "_-33I" (String#21633, DoABC#2)
// isSleeping = "_-sI" (String#24373, DoABC#2)
// _SafeStr_7625 = "_-Kz" (String#23044, DoABC#2)
// getPaletteIndex = "_-1X5" (String#17780, DoABC#2)
// debugMouseEvent = "_-0FY" (String#14668, DoABC#2)


