
package com.sulake.habbo.room.object.visualization.furniture
{
    import com.sulake.habbo.room.object.RoomObjectVariableEnum;
    import com.sulake.room.object.IRoomObjectModel;

    public class FurnitureRoomBillboardVisualization extends FurnitureRoomBrandingVisualization 
    {

        override protected function getAdClickUrl(_arg_1:IRoomObjectModel):String
        {
            return (_arg_1.getString(RoomObjectVariableEnum.FURNITURE_BRANDING_CLICK_URL));
        }
        override protected function getSpriteXOffset(_arg_1:int, _arg_2:int, _arg_3:int):int
        {
            return ((super.getSpriteXOffset(_arg_1, _arg_2, _arg_3) + _SafeStr_12659));
        }
        override protected function getSpriteYOffset(_arg_1:int, _arg_2:int, _arg_3:int):int
        {
            return ((super.getSpriteYOffset(_arg_1, _arg_2, _arg_3) + _SafeStr_12660));
        }
        override protected function getSpriteZOffset(_arg_1:int, _arg_2:int, _arg_3:int):Number
        {
            return ((super.getSpriteZOffset(_arg_1, _arg_2, _arg_3) + (_paramOffsetZ * -1)));
        }

    }
}//package com.sulake.habbo.room.object.visualization.furniture

// getAdClickUrl = "_-0z5" (String#438, DoABC#2)
// _SafeStr_12659 = "_-Hj" (String#22921, DoABC#2)
// _SafeStr_12660 = "_-1-i" (String#16455, DoABC#2)
// RoomObjectVariableEnum = "_-1MH" (String#17370, DoABC#2)
// IRoomObjectModel = "_-253" (String#6141, DoABC#2)
// FurnitureRoomBrandingVisualization = "_-1XC" (String#5501, DoABC#2)
// FurnitureRoomBillboardVisualization = "_-1iK" (String#5718, DoABC#2)
// getSpriteXOffset = "_-03Y" (String#354, DoABC#2)
// getSpriteYOffset = "_-3IZ" (String#251, DoABC#2)
// getSpriteZOffset = "_-25C" (String#614, DoABC#2)


