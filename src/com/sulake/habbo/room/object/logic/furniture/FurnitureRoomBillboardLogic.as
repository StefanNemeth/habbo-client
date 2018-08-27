
package com.sulake.habbo.room.object.logic.furniture
{
    import com.sulake.habbo.room.object.RoomObjectVariableEnum;
    import com.sulake.room.object.IRoomObjectModelController;
    import com.sulake.habbo.utils.HabboWebTools;

    public class FurnitureRoomBillboardLogic extends FurnitureRoomBrandingLogic 
    {

        public function FurnitureRoomBillboardLogic()
        {
            _SafeStr_12471 = true;
        }
        override protected function getAdClickUrl(_arg_1:IRoomObjectModelController):String
        {
            return (_arg_1.getString(RoomObjectVariableEnum.FURNITURE_BRANDING_CLICK_URL));
        }
        override protected function handleAdClick(_arg_1:int, _arg_2:String, _arg_3:String):void
        {
            HabboWebTools.openWebPage(_arg_3);
        }

    }
}//package com.sulake.habbo.room.object.logic.furniture

// getAdClickUrl = "_-0z5" (String#438, DoABC#2)
// handleAdClick = "_-2qp" (String#7093, DoABC#2)
// _SafeStr_12471 = "_-2eH" (String#20615, DoABC#2)
// HabboWebTools = "_-2pX" (String#21059, DoABC#2)
// RoomObjectVariableEnum = "_-1MH" (String#17370, DoABC#2)
// FurnitureRoomBrandingLogic = "_-3JR" (String#7693, DoABC#2)
// FurnitureRoomBillboardLogic = "_-1Ll" (String#5273, DoABC#2)
// IRoomObjectModelController = "_-1yp" (String#6010, DoABC#2)
// openWebPage = "_-27c" (String#6194, DoABC#2)


