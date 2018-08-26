
package com.sulake.habbo.catalog.purse
{
    public interface IPurse 
    {

        function set credits(_arg_1:int):void;
        function set clubDays(_arg_1:int):void;
        function set clubPeriods(_arg_1:int):void;
        function get isExpiring():Boolean;
        function set isExpiring(_arg_1:Boolean):void;
        function get credits():int;
        function get clubDays():int;
        function get clubPeriods():int;
        function get hasClubLeft():Boolean;
        function get isVIP():Boolean;
        function get pastClubDays():int;
        function get pastVipDays():int;
        function getActivityPointsForType(_arg_1:int):int;

    }
}//package com.sulake.habbo.catalog.purse

// IPurse = "_-0GN" (String#3880, DoABC#2)
// isVIP = "_-3K4" (String#7705, DoABC#2)
// hasClubLeft = "_-1Sl" (String#5409, DoABC#2)
// getActivityPointsForType = "_-1c9" (String#5603, DoABC#2)
// pastClubDays = "_-2W7" (String#6687, DoABC#2)
// pastVipDays = "_-373" (String#7449, DoABC#2)
// isExpiring = "_-YW" (String#8383, DoABC#2)


