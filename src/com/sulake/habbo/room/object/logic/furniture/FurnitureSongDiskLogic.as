
package com.sulake.habbo.room.object.logic.furniture
{
    import com.sulake.habbo.room.object.RoomObjectVariableEnum;
    import com.sulake.habbo.ui.widget.enums.RoomWidgetInfostandExtraParamEnum;
    import com.sulake.room.messages.RoomObjectUpdateMessage;

    public class FurnitureSongDiskLogic extends FurnitureLogic 
    {

        override public function processUpdateMessage(_arg_1:RoomObjectUpdateMessage):void
        {
            var _local_2:String;
            var _local_3:int;
            super.processUpdateMessage(_arg_1);
            if (object == null){
                return;
            };
            if (object.getModelController().getNumber(RoomObjectVariableEnum._SafeStr_12500) == 1){
                _local_2 = object.getModelController().getString(RoomObjectVariableEnum._SafeStr_7295);
                _local_3 = int(_local_2);
                object.getModelController().setString(RoomWidgetInfostandExtraParamEnum.RWEIEP_INFOSTAND_EXTRA_PARAM, (RoomWidgetInfostandExtraParamEnum.RWEIEP_SONGDISK + _local_3));
            };
        }

    }
}//package com.sulake.habbo.room.object.logic.furniture

// _SafeStr_12500 = "_-2Sa" (String#20140, DoABC#2)
// RoomObjectVariableEnum = "_-1MH" (String#17370, DoABC#2)
// FurnitureLogic = "_-001" (String#14053, DoABC#2)
// FurnitureSongDiskLogic = "_-2hP" (String#20748, DoABC#2)
// RoomObjectUpdateMessage = "_-73" (String#22503, DoABC#2)
// RoomWidgetInfostandExtraParamEnum = "_-2ru" (String#7121, DoABC#2)
// RWEIEP_INFOSTAND_EXTRA_PARAM = "_-3J-" (String#22238, DoABC#2)
// RWEIEP_SONGDISK = "_-0eV" (String#15606, DoABC#2)
// processUpdateMessage = "_-FX" (String#7984, DoABC#2)
// _SafeStr_7295 = "_-2nE" (String#20969, DoABC#2)


