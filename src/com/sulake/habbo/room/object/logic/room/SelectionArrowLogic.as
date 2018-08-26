
package com.sulake.habbo.room.object.logic.room
{
    import com.sulake.room.object.logic.ObjectLogicBase;
    import com.sulake.room.object.IRoomObjectModelController;
    import com.sulake.habbo.room.object.RoomObjectVariableEnum;
    import com.sulake.habbo.room.messages.RoomObjectVisibilityUpdateMessage;
    import com.sulake.room.messages.RoomObjectUpdateMessage;

    public class SelectionArrowLogic extends ObjectLogicBase 
    {

        override public function initialize(_arg_1:XML):void
        {
            var _local_2:IRoomObjectModelController;
            if (object != null){
                _local_2 = object.getModelController();
                if (_local_2 != null){
                    _local_2.setNumber(RoomObjectVariableEnum._SafeStr_5760, 1);
                    object.setState(1, 0);
                };
            };
        }
        override public function processUpdateMessage(_arg_1:RoomObjectUpdateMessage):void
        {
            super.processUpdateMessage(_arg_1);
            var _local_2:RoomObjectVisibilityUpdateMessage = (_arg_1 as RoomObjectVisibilityUpdateMessage);
            if (_local_2 != null){
                if (_local_2.type == RoomObjectVisibilityUpdateMessage.ROVUM_ENABLED){
                    if (object != null){
                        object.setState(0, 0);
                    };
                }
                else {
                    if (_local_2.type == RoomObjectVisibilityUpdateMessage.ROVUM_DISABLED){
                        if (object != null){
                            object.setState(1, 0);
                        };
                    };
                };
            };
        }

    }
}//package com.sulake.habbo.room.object.logic.room

// RoomObjectVariableEnum = "_-1MH" (String#17370, DoABC#2)
// ObjectLogicBase = "_-VT" (String#8310, DoABC#2)
// SelectionArrowLogic = "_-2pr" (String#21076, DoABC#2)
// IRoomObjectModelController = "_-1yp" (String#6010, DoABC#2)
// RoomObjectUpdateMessage = "_-73" (String#22503, DoABC#2)
// RoomObjectVisibilityUpdateMessage = "_-1ye" (String#18914, DoABC#2)
// processUpdateMessage = "_-FX" (String#7984, DoABC#2)
// _SafeStr_5760 = "_-2gS" (String#20707, DoABC#2)
// ROVUM_ENABLED = "_-0f3" (String#15631, DoABC#2)
// ROVUM_DISABLED = "_-18v" (String#16811, DoABC#2)


