
package com.sulake.habbo.room.object.logic
{
    import com.sulake.room.utils.Vector3d;
    import flash.utils.getTimer;
    import com.sulake.room.events.RoomObjectMouseEvent;
    import com.sulake.habbo.room.events.RoomObjectMoveEvent;
    import com.sulake.habbo.room.events.RoomObjectFurnitureActionEvent;
    import com.sulake.room.events.RoomObjectEvent;
    import com.sulake.habbo.room.messages.RoomObjectAvatarPostureUpdateMessage;
    import com.sulake.habbo.room.messages.RoomObjectAvatarChatUpdateMessage;
    import com.sulake.habbo.room.messages.RoomObjectAvatarTypingUpdateMessage;
    import com.sulake.habbo.room.messages.RoomObjectAvatarUpdateMessage;
    import com.sulake.habbo.room.messages.RoomObjectAvatarGestureUpdateMessage;
    import com.sulake.habbo.room.messages.RoomObjectAvatarWaveUpdateMessage;
    import com.sulake.habbo.room.messages.RoomObjectAvatarDanceUpdateMessage;
    import com.sulake.habbo.room.messages.RoomObjectAvatarSleepUpdateMessage;
    import com.sulake.habbo.room.messages.RoomObjectAvatarPlayerValueUpdateMessage;
    import com.sulake.habbo.room.messages.RoomObjectAvatarEffectUpdateMessage;
    import com.sulake.habbo.room.messages.RoomObjectAvatarCarryObjectUpdateMessage;
    import com.sulake.habbo.room.messages.RoomObjectAvatarUseObjectUpdateMessage;
    import com.sulake.habbo.room.messages.RoomObjectAvatarSignUpdateMessage;
    import com.sulake.habbo.room.messages.RoomObjectAvatarFlatControlUpdateMessage;
    import com.sulake.habbo.room.messages.RoomObjectAvatarFigureUpdateMessage;
    import com.sulake.habbo.room.messages.RoomObjectAvatarSelectedMessage;
    import com.sulake.room.object.IRoomObjectModelController;
    import com.sulake.habbo.room.object.RoomObjectVariableEnum;
    import com.sulake.habbo.avatar.enum.AvatarAction;
    import com.sulake.room.messages.RoomObjectUpdateMessage;
    import flash.events.MouseEvent;
    import com.sulake.room.events.RoomSpriteMouseEvent;
    import com.sulake.room.utils.IRoomGeometry;
    import com.sulake.room.utils.IVector3d;

    public class AvatarLogic extends MovingObjectLogic 
    {

        private static const _SafeStr_7628:Number = 1.5;
        private static const _SafeStr_7629:int = 28;
        private static const _SafeStr_7630:int = 29;
        private static const _SafeStr_7631:int = 500;
        private static const _SafeStr_7632:int = 999999999;

        private var _selected:Boolean = false;
        private var _SafeStr_7617:Vector3d = null;
        private var _SafeStr_7633:int = 0;
        private var _SafeStr_7634:int = 0;
        private var _SafeStr_7614:int = 0;
        private var _SafeStr_7635:int = 0;
        private var _SafeStr_7636:int = 0;
        private var _SafeStr_7616:int = 0;
        private var _SafeStr_7615:int = 0;
        private var _SafeStr_7637:int = 0;
        private var _SafeStr_7638:int = 0;
        private var _SafeStr_7639:Boolean = false;
        private var _SafeStr_7640:int = 0;
        private var _SafeStr_7641:int = 0;
        private var _SafeStr_7642:int = 0;

        public function AvatarLogic()
        {
            this._SafeStr_7641 = (getTimer() + this.getBlinkInterval());
        }
        override public function getEventTypes():Array
        {
            var _local_1:Array = [RoomObjectMouseEvent.ROE_MOUSE_CLICK, RoomObjectMoveEvent.ROME_POSITION_CHANGED, RoomObjectMouseEvent.ROE_MOUSE_ENTER, RoomObjectMouseEvent.ROE_MOUSE_LEAVE, RoomObjectFurnitureActionEvent.ROFCAE_MOUSE_BUTTON, RoomObjectFurnitureActionEvent.ROFCAE_MOUSE_ARROW];
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
            var _local_4:RoomObjectAvatarChatUpdateMessage;
            var _local_5:RoomObjectAvatarTypingUpdateMessage;
            var _local_6:RoomObjectAvatarUpdateMessage;
            var _local_7:RoomObjectAvatarGestureUpdateMessage;
            var _local_8:RoomObjectAvatarWaveUpdateMessage;
            var _local_9:RoomObjectAvatarDanceUpdateMessage;
            var _local_10:RoomObjectAvatarSleepUpdateMessage;
            var _local_11:RoomObjectAvatarPlayerValueUpdateMessage;
            var _local_12:RoomObjectAvatarEffectUpdateMessage;
            var _local_13:int;
            var _local_14:int;
            var _local_15:RoomObjectAvatarCarryObjectUpdateMessage;
            var _local_16:RoomObjectAvatarUseObjectUpdateMessage;
            var _local_17:RoomObjectAvatarSignUpdateMessage;
            var _local_18:RoomObjectAvatarFlatControlUpdateMessage;
            var _local_19:RoomObjectAvatarFigureUpdateMessage;
            var _local_20:String;
            var _local_21:String;
            var _local_22:String;
            var _local_23:RoomObjectAvatarSelectedMessage;
            if ((((_arg_1 == null)) || ((object == null)))){
                return;
            };
            super.processUpdateMessage(_arg_1);
            var _local_2:IRoomObjectModelController = object.getModelController();
            if ((_arg_1 is RoomObjectAvatarPostureUpdateMessage)){
                _local_3 = (_arg_1 as RoomObjectAvatarPostureUpdateMessage);
                _local_2.setString(RoomObjectVariableEnum._SafeStr_4366, _local_3.postureType);
                _local_2.setString(RoomObjectVariableEnum._SafeStr_4442, _local_3.parameter);
                return;
            };
            if ((_arg_1 is RoomObjectAvatarChatUpdateMessage)){
                _local_4 = (_arg_1 as RoomObjectAvatarChatUpdateMessage);
                _local_2.setNumber(RoomObjectVariableEnum._SafeStr_6545, 1);
                this._SafeStr_7614 = (getTimer() + (_local_4.numberOfWords * 1000));
                return;
            };
            if ((_arg_1 is RoomObjectAvatarTypingUpdateMessage)){
                _local_5 = (_arg_1 as RoomObjectAvatarTypingUpdateMessage);
                _local_2.setNumber(RoomObjectVariableEnum._SafeStr_6548, Number(_local_5.isTyping));
                return;
            };
            if ((_arg_1 is RoomObjectAvatarUpdateMessage)){
                _local_6 = (_arg_1 as RoomObjectAvatarUpdateMessage);
                _local_2.setNumber(RoomObjectVariableEnum._SafeStr_4375, _local_6.dirHead);
                return;
            };
            if ((_arg_1 is RoomObjectAvatarGestureUpdateMessage)){
                _local_7 = (_arg_1 as RoomObjectAvatarGestureUpdateMessage);
                _local_2.setNumber(RoomObjectVariableEnum._SafeStr_4367, _local_7.gesture);
                this._SafeStr_7615 = (getTimer() + (3 * 1000));
                return;
            };
            if ((_arg_1 is RoomObjectAvatarWaveUpdateMessage)){
                _local_8 = (_arg_1 as RoomObjectAvatarWaveUpdateMessage);
                if (_local_8.isWaving){
                    _local_2.setNumber(RoomObjectVariableEnum._SafeStr_6546, 1);
                    this._SafeStr_7616 = (getTimer() + (AvatarAction._SafeStr_7645 * 1000));
                }
                else {
                    _local_2.setNumber(RoomObjectVariableEnum._SafeStr_6546, 0);
                    this._SafeStr_7616 = 0;
                };
                return;
            };
            if ((_arg_1 is RoomObjectAvatarDanceUpdateMessage)){
                _local_9 = (_arg_1 as RoomObjectAvatarDanceUpdateMessage);
                _local_2.setNumber(RoomObjectVariableEnum._SafeStr_6550, _local_9.danceStyle);
                return;
            };
            if ((_arg_1 is RoomObjectAvatarSleepUpdateMessage)){
                _local_10 = (_arg_1 as RoomObjectAvatarSleepUpdateMessage);
                _local_2.setNumber(RoomObjectVariableEnum._SafeStr_4374, Number(_local_10.isSleeping));
                return;
            };
            if ((_arg_1 is RoomObjectAvatarPlayerValueUpdateMessage)){
                _local_11 = (_arg_1 as RoomObjectAvatarPlayerValueUpdateMessage);
                _local_2.setNumber(RoomObjectVariableEnum._SafeStr_6554, _local_11.value);
                this._SafeStr_7642 = (getTimer() + 3000);
                return;
            };
            if ((_arg_1 is RoomObjectAvatarEffectUpdateMessage)){
                _local_12 = (_arg_1 as RoomObjectAvatarEffectUpdateMessage);
                _local_13 = _local_12.effect;
                _local_14 = _local_12.delayMilliSeconds;
                this.updateEffect(_local_13, _local_14, _local_2);
                return;
            };
            if ((_arg_1 is RoomObjectAvatarCarryObjectUpdateMessage)){
                _local_15 = (_arg_1 as RoomObjectAvatarCarryObjectUpdateMessage);
                _local_2.setNumber(RoomObjectVariableEnum._SafeStr_6552, _local_15.itemType);
                if (_local_15.itemType < _SafeStr_7632){
                    this._SafeStr_7638 = (getTimer() + (100 * 1000));
                    this._SafeStr_7639 = true;
                }
                else {
                    this._SafeStr_7638 = (getTimer() + 1500);
                    this._SafeStr_7639 = false;
                };
                return;
            };
            if ((_arg_1 is RoomObjectAvatarUseObjectUpdateMessage)){
                _local_16 = (_arg_1 as RoomObjectAvatarUseObjectUpdateMessage);
                _local_2.setNumber(RoomObjectVariableEnum._SafeStr_6553, _local_16.itemType);
                return;
            };
            if ((_arg_1 is RoomObjectAvatarSignUpdateMessage)){
                _local_17 = (_arg_1 as RoomObjectAvatarSignUpdateMessage);
                _local_2.setNumber(RoomObjectVariableEnum._SafeStr_6556, _local_17._SafeStr_7649);
                this._SafeStr_7637 = (getTimer() + (5 * 1000));
                return;
            };
            if ((_arg_1 is RoomObjectAvatarFlatControlUpdateMessage)){
                _local_18 = (_arg_1 as RoomObjectAvatarFlatControlUpdateMessage);
                _local_2.setString(RoomObjectVariableEnum._SafeStr_7361, _local_18.rawData);
                _local_2.setNumber(RoomObjectVariableEnum._SafeStr_7651, Number(_local_18.isAdmin));
                return;
            };
            if ((_arg_1 is RoomObjectAvatarFigureUpdateMessage)){
                _local_19 = (_arg_1 as RoomObjectAvatarFigureUpdateMessage);
                _local_20 = _local_2.getString(RoomObjectVariableEnum._SafeStr_4443);
                _local_21 = _local_19.figure;
                _local_22 = _local_19.gender;
                if (((!((_local_20 == null))) && (!((_local_20.indexOf(".bds-") == -1))))){
                    _local_21 = (_local_21 + _local_20.substr(_local_20.indexOf(".bds-")));
                };
                _local_2.setString(RoomObjectVariableEnum._SafeStr_4443, _local_21);
                _local_2.setString(RoomObjectVariableEnum.AVATAR_GENDER, _local_22);
                return;
            };
            if ((_arg_1 is RoomObjectAvatarSelectedMessage)){
                _local_23 = (_arg_1 as RoomObjectAvatarSelectedMessage);
                this._selected = _local_23.selected;
                this._SafeStr_7617 = null;
                return;
            };
        }
        private function updateEffect(_arg_1:int, _arg_2:int, _arg_3:IRoomObjectModelController):void
        {
            if (_arg_1 == _SafeStr_7629){
                this._SafeStr_7633 = (getTimer() + _SafeStr_7631);
                this._SafeStr_7634 = _SafeStr_7630;
            }
            else {
                if (_arg_3.getNumber(RoomObjectVariableEnum._SafeStr_6551) == _SafeStr_7630){
                    this._SafeStr_7633 = (getTimer() + _SafeStr_7631);
                    this._SafeStr_7634 = _arg_1;
                    _arg_1 = _SafeStr_7629;
                }
                else {
                    if (_arg_2 == 0){
                        this._SafeStr_7633 = 0;
                    }
                    else {
                        this._SafeStr_7633 = (getTimer() + _arg_2);
                        this._SafeStr_7634 = _arg_1;
                        return;
                    };
                };
            };
            _arg_3.setNumber(RoomObjectVariableEnum._SafeStr_6551, _arg_1);
        }
        override public function mouseEvent(_arg_1:RoomSpriteMouseEvent, _arg_2:IRoomGeometry):void
        {
            var _local_4:int;
            var _local_5:String;
            var _local_6:RoomObjectEvent;
            if ((((object == null)) || ((_arg_1 == null)))){
                return;
            };
            var _local_3:String;
            switch (_arg_1.type){
                case MouseEvent.CLICK:
                    _local_3 = RoomObjectMouseEvent.ROE_MOUSE_CLICK;
                    break;
                case MouseEvent.ROLL_OVER:
                    _local_3 = RoomObjectMouseEvent.ROE_MOUSE_ENTER;
                    eventDispatcher.dispatchEvent(new RoomObjectFurnitureActionEvent(RoomObjectFurnitureActionEvent.ROFCAE_MOUSE_BUTTON, object.getId(), object.getType()));
                    break;
                case MouseEvent.ROLL_OUT:
                    _local_3 = RoomObjectMouseEvent.ROE_MOUSE_LEAVE;
                    eventDispatcher.dispatchEvent(new RoomObjectFurnitureActionEvent(RoomObjectFurnitureActionEvent.ROFCAE_MOUSE_ARROW, object.getId(), object.getType()));
                    break;
            };
            if (_local_3 != null){
                _local_4 = object.getId();
                _local_5 = object.getType();
                if (eventDispatcher != null){
                    _local_6 = new RoomObjectMouseEvent(_local_3, _arg_1.eventId, _local_4, _local_5, _arg_1.altKey, _arg_1.ctrlKey, _arg_1.shiftKey, _arg_1.buttonDown);
                    eventDispatcher.dispatchEvent(_local_6);
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
            if (this._SafeStr_7614 > 0){
                if (_arg_1 > this._SafeStr_7614){
                    _arg_2.setNumber(RoomObjectVariableEnum._SafeStr_6545, 0);
                    this._SafeStr_7614 = 0;
                    this._SafeStr_7636 = 0;
                    this._SafeStr_7635 = 0;
                }
                else {
                    if ((((this._SafeStr_7635 == 0)) && ((this._SafeStr_7636 == 0)))){
                        this._SafeStr_7636 = (_arg_1 + this.getTalkingPauseInterval());
                        this._SafeStr_7635 = (this._SafeStr_7636 + this.getTalkingPauseLength());
                    }
                    else {
                        if ((((this._SafeStr_7636 > 0)) && ((_arg_1 > this._SafeStr_7636)))){
                            _arg_2.setNumber(RoomObjectVariableEnum._SafeStr_6545, 0);
                            this._SafeStr_7636 = 0;
                        }
                        else {
                            if ((((this._SafeStr_7635 > 0)) && ((_arg_1 > this._SafeStr_7635)))){
                                _arg_2.setNumber(RoomObjectVariableEnum._SafeStr_6545, 1);
                                this._SafeStr_7635 = 0;
                            };
                        };
                    };
                };
            };
            if ((((this._SafeStr_7616 > 0)) && ((_arg_1 > this._SafeStr_7616)))){
                _arg_2.setNumber(RoomObjectVariableEnum._SafeStr_6546, 0);
                this._SafeStr_7616 = 0;
            };
            if ((((this._SafeStr_7615 > 0)) && ((_arg_1 > this._SafeStr_7615)))){
                _arg_2.setNumber(RoomObjectVariableEnum._SafeStr_4367, 0);
                this._SafeStr_7615 = 0;
            };
            if ((((this._SafeStr_7637 > 0)) && ((_arg_1 > this._SafeStr_7637)))){
                _arg_2.setNumber(RoomObjectVariableEnum._SafeStr_6556, 0);
                this._SafeStr_7637 = 0;
            };
            if (this._SafeStr_7638 > 0){
                if (_arg_1 > this._SafeStr_7638){
                    _arg_2.setNumber(RoomObjectVariableEnum._SafeStr_6552, 0);
                    this._SafeStr_7638 = 0;
                }
                else {
                    if ((((((this._SafeStr_7638 - _arg_1) % 10000) < 1000)) && (this._SafeStr_7639))){
                        _arg_2.setNumber(RoomObjectVariableEnum._SafeStr_6553, 1);
                    }
                    else {
                        _arg_2.setNumber(RoomObjectVariableEnum._SafeStr_6553, 0);
                    };
                };
            };
            if (_arg_1 > this._SafeStr_7641){
                _arg_2.setNumber(RoomObjectVariableEnum._SafeStr_6547, 1);
                this._SafeStr_7641 = (_arg_1 + this.getBlinkInterval());
                this._SafeStr_7640 = (_arg_1 + this.getBlinkLength());
            };
            if ((((this._SafeStr_7640 > 0)) && ((_arg_1 > this._SafeStr_7640)))){
                _arg_2.setNumber(RoomObjectVariableEnum._SafeStr_6547, 0);
                this._SafeStr_7640 = 0;
            };
            if ((((this._SafeStr_7633 > 0)) && ((_arg_1 > this._SafeStr_7633)))){
                _arg_2.setNumber(RoomObjectVariableEnum._SafeStr_6551, this._SafeStr_7634);
                this._SafeStr_7633 = 0;
            };
            if ((((this._SafeStr_7642 > 0)) && ((_arg_1 > this._SafeStr_7642)))){
                _arg_2.setNumber(RoomObjectVariableEnum._SafeStr_6554, 0);
                this._SafeStr_7642 = 0;
            };
        }
        private function getTalkingPauseInterval():int
        {
            return ((100 + (Math.random() * 200)));
        }
        private function getTalkingPauseLength():int
        {
            return ((75 + (Math.random() * 75)));
        }
        private function getBlinkInterval():int
        {
            return ((4500 + (Math.random() * 1000)));
        }
        private function getBlinkLength():int
        {
            return ((50 + (Math.random() * 200)));
        }
        private function targetIsWarping(_arg_1:IVector3d):Boolean
        {
            var _local_2:IVector3d = object.getLocation();
            if (_arg_1 == null){
                return (false);
            };
            if ((((_local_2.x == 0)) && ((_local_2.y == 0)))){
                return (false);
            };
            if ((((Math.abs((_local_2.x - _arg_1.x)) > _SafeStr_7628)) || ((Math.abs((_local_2.y - _arg_1.y)) > _SafeStr_7628)))){
                return (true);
            };
            return (false);
        }

    }
}//package com.sulake.habbo.room.object.logic

// IVector3d = "_-hf" (String#8547, DoABC#2)
// Vector3d = "_-1Rb" (String#17568, DoABC#2)
// RoomObjectVariableEnum = "_-1MH" (String#17370, DoABC#2)
// MovingObjectLogic = "_-36D" (String#21738, DoABC#2)
// AvatarLogic = "_-2iP" (String#20784, DoABC#2)
// IRoomObjectModelController = "_-1yp" (String#6010, DoABC#2)
// IRoomGeometry = "_-0z9" (String#4829, DoABC#2)
// RoomObjectUpdateMessage = "_-73" (String#22503, DoABC#2)
// RoomObjectAvatarEffectUpdateMessage = "_-Tq" (String#23400, DoABC#2)
// RoomObjectAvatarWaveUpdateMessage = "_-0XU" (String#15334, DoABC#2)
// RoomObjectAvatarUseObjectUpdateMessage = "_-2HN" (String#19699, DoABC#2)
// RoomObjectMouseEvent = "_-20k" (String#19042, DoABC#2)
// RoomObjectAvatarPlayerValueUpdateMessage = "_-0X2" (String#15316, DoABC#2)
// RoomObjectAvatarTypingUpdateMessage = "_-2BI" (String#19455, DoABC#2)
// RoomObjectFurnitureActionEvent = "_-2H6" (String#19689, DoABC#2)
// RoomObjectAvatarUpdateMessage = "_-1ht" (String#18207, DoABC#2)
// RoomObjectAvatarFlatControlUpdateMessage = "_-0bw" (String#15508, DoABC#2)
// RoomObjectAvatarFigureUpdateMessage = "_-0tn" (String#16195, DoABC#2)
// RoomObjectAvatarGestureUpdateMessage = "_-2NZ" (String#19946, DoABC#2)
// RoomObjectAvatarChatUpdateMessage = "_-08" (String#14365, DoABC#2)
// RoomObjectAvatarCarryObjectUpdateMessage = "_-ft" (String#23885, DoABC#2)
// RoomObjectAvatarSleepUpdateMessage = "_-0Hl" (String#14746, DoABC#2)
// RoomObjectAvatarPostureUpdateMessage = "_-0OI" (String#15001, DoABC#2)
// RoomObjectAvatarDanceUpdateMessage = "_-MT" (String#23103, DoABC#2)
// RoomObjectAvatarSignUpdateMessage = "_-V" (String#23446, DoABC#2)
// RoomSpriteMouseEvent = "_-wc" (String#8815, DoABC#2)
// RoomObjectAvatarSelectedMessage = "_-1fk" (String#18125, DoABC#2)
// RoomObjectMoveEvent = "_-2gn" (String#20720, DoABC#2)
// itemType = "_-De" (String#22756, DoABC#2)
// isTyping = "_-1wh" (String#18831, DoABC#2)
// _SafeStr_4366 = "_-2r-" (String#21121, DoABC#2)
// _SafeStr_4367 = "_-3At" (String#21914, DoABC#2)
// _SafeStr_4374 = "_-GG" (String#22862, DoABC#2)
// _SafeStr_4375 = "_-0Jq" (String#14835, DoABC#2)
// _SafeStr_4442 = "_-0Mv" (String#14951, DoABC#2)
// _SafeStr_4443 = "_-2Lr" (String#19878, DoABC#2)
// updateActions = "_-2p4" (String#900, DoABC#2)
// danceStyle = "_-0M0" (String#14915, DoABC#2)
// dirHead = "_-2Ej" (String#19594, DoABC#2)
// ObjectLogicBase = "_-uN" (String#24466, DoABC#2)
// processUpdateMessage = "_-FX" (String#7984, DoABC#2)
// mouseEvent = "_-0Um" (String#4199, DoABC#2)
// ROE_MOUSE_ENTER = "_-9-" (String#22579, DoABC#2)
// ROE_MOUSE_LEAVE = "_-0o9" (String#15981, DoABC#2)
// ROFCAE_MOUSE_BUTTON = "_-Sz" (String#23363, DoABC#2)
// ROFCAE_MOUSE_ARROW = "_-2VP" (String#20258, DoABC#2)
// ROME_POSITION_CHANGED = "_-114" (String#16501, DoABC#2)
// ROME_OBJECT_REMOVED = "_-0PW" (String#15043, DoABC#2)
// ROE_MOUSE_CLICK = "_-2sU" (String#21178, DoABC#2)
// eventId = "_-3ER" (String#22053, DoABC#2)
// _SafeStr_6545 = "_-2IW" (String#19747, DoABC#2)
// _SafeStr_6546 = "_-n1" (String#24155, DoABC#2)
// _SafeStr_6547 = "_-ZI" (String#23609, DoABC#2)
// _SafeStr_6548 = "_-09g" (String#14434, DoABC#2)
// _SafeStr_6550 = "_-aD" (String#23641, DoABC#2)
// _SafeStr_6551 = "_-If" (String#22952, DoABC#2)
// _SafeStr_6552 = "_-0ig" (String#15779, DoABC#2)
// _SafeStr_6553 = "_-2wB" (String#21318, DoABC#2)
// _SafeStr_6554 = "_-4J" (String#22390, DoABC#2)
// _SafeStr_6556 = "_-02t" (String#14155, DoABC#2)
// _SafeStr_7361 = "_-0xm" (String#16345, DoABC#2)
// _SafeStr_7614 = "_-LO" (String#8110, DoABC#2)
// _SafeStr_7615 = "_-10h" (String#4889, DoABC#2)
// _SafeStr_7616 = "_-21l" (String#6079, DoABC#2)
// _SafeStr_7617 = "_-2Vp" (String#6680, DoABC#2)
// postureType = "_-1It" (String#17232, DoABC#2)
// numberOfWords = "_-33I" (String#21633, DoABC#2)
// isSleeping = "_-sI" (String#24373, DoABC#2)
// _SafeStr_7628 = "_-2f9" (String#20652, DoABC#2)
// _SafeStr_7629 = "_-z7" (String#24654, DoABC#2)
// _SafeStr_7630 = "_-5l" (String#22453, DoABC#2)
// _SafeStr_7631 = "_-0jm" (String#15818, DoABC#2)
// _SafeStr_7632 = "_-2K9" (String#19811, DoABC#2)
// _SafeStr_7633 = "_-gD" (String#23901, DoABC#2)
// _SafeStr_7634 = "_-0mU" (String#15916, DoABC#2)
// _SafeStr_7635 = "_-iO" (String#23974, DoABC#2)
// _SafeStr_7636 = "_-3M" (String#22352, DoABC#2)
// _SafeStr_7637 = "_-1RY" (String#17566, DoABC#2)
// _SafeStr_7638 = "_-1y2" (String#18888, DoABC#2)
// _SafeStr_7639 = "_-10Q" (String#16479, DoABC#2)
// _SafeStr_7640 = "_-1TR" (String#17643, DoABC#2)
// _SafeStr_7641 = "_-04k" (String#14229, DoABC#2)
// _SafeStr_7642 = "_-2i0" (String#20772, DoABC#2)
// getBlinkInterval = "_-1Ea" (String#17052, DoABC#2)
// isWaving = "_-0Ph" (String#15050, DoABC#2)
// _SafeStr_7645 = "_-Ea" (String#22796, DoABC#2)
// effect = "_-rk" (String#24350, DoABC#2)
// delayMilliSeconds = "_-Rk" (String#23313, DoABC#2)
// updateEffect = "_-3As" (String#21913, DoABC#2)
// _SafeStr_7649 = "package" (String#46219, DoABC#2)
// rawData = "_-1ug" (String#18745, DoABC#2)
// _SafeStr_7651 = "_-18Q" (String#16792, DoABC#2)
// isAdmin = "_-1O3" (String#17436, DoABC#2)
// getTalkingPauseInterval = "_-0Qa" (String#15086, DoABC#2)
// getTalkingPauseLength = "_-1-I" (String#16440, DoABC#2)
// getBlinkLength = "_-dj" (String#23788, DoABC#2)
// targetIsWarping = "_-13d" (String#16602, DoABC#2)


