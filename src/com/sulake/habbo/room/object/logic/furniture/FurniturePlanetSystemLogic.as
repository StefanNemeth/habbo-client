
package com.sulake.habbo.room.object.logic.furniture
{
    import com.sulake.room.object.IRoomObjectModelController;
    import com.sulake.habbo.room.object.RoomObjectVariableEnum;

    public class FurniturePlanetSystemLogic extends FurnitureLogic 
    {

        override public function initialize(_arg_1:XML):void
        {
            var _local_3:IRoomObjectModelController;
            super.initialize(_arg_1);
            if (_arg_1 == null){
                return;
            };
            var _local_2:XMLList = _arg_1.planetsystem;
            if (_local_2.length() == 0){
                return;
            };
            if (object != null){
                _local_3 = object.getModelController();
                if (_local_3 != null){
                    _local_3.setString(RoomObjectVariableEnum._SafeStr_12495, String(_local_2));
                };
            };
        }

    }
}//package com.sulake.habbo.room.object.logic.furniture

// _SafeStr_12495 = "_-0uB" (String#16212, DoABC#2)
// RoomObjectVariableEnum = "_-1MH" (String#17370, DoABC#2)
// FurnitureLogic = "_-001" (String#14053, DoABC#2)
// FurniturePlanetSystemLogic = "_-G4" (String#22856, DoABC#2)
// IRoomObjectModelController = "_-1yp" (String#6010, DoABC#2)


