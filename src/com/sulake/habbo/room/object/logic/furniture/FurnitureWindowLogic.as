
package com.sulake.habbo.room.object.logic.furniture
{
    import com.sulake.room.utils.XMLValidator;
    import com.sulake.habbo.room.object.RoomObjectVariableEnum;

    public class FurnitureWindowLogic extends FurnitureMultiStateLogic 
    {

        override public function initialize(_arg_1:XML):void
        {
            var _local_3:XML;
            var _local_4:String;
            super.initialize(_arg_1);
            if (_arg_1 == null){
                return;
            };
            var _local_2:XMLList = _arg_1.mask;
            if (_local_2.length() > 0){
                _local_3 = _local_2[0];
                if (XMLValidator.checkRequiredAttributes(_local_3, ["type"])){
                    _local_4 = _local_3.@type;
                    object.getModelController().setNumber(RoomObjectVariableEnum._SafeStr_12483, 1, true);
                    object.getModelController().setString(RoomObjectVariableEnum._SafeStr_12484, _local_4, true);
                };
            };
        }

    }
}//package com.sulake.habbo.room.object.logic.furniture

// _SafeStr_12483 = "_-2T8" (String#20170, DoABC#2)
// _SafeStr_12484 = "_-WN" (String#23505, DoABC#2)
// RoomObjectVariableEnum = "_-1MH" (String#17370, DoABC#2)
// FurnitureMultiStateLogic = "_-23" (String#6104, DoABC#2)
// FurnitureWindowLogic = "_-1Xo" (String#17808, DoABC#2)


