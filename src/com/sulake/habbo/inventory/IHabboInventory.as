
package com.sulake.habbo.inventory
{
    import com.sulake.core.runtime.IUnknown;
    import flash.events.IEventDispatcher;
    import com.sulake.habbo.inventory.items.IItem;

    public interface IHabboInventory extends IUnknown 
    {

        function get events():IEventDispatcher;
        function get clubDays():int;
        function get clubPeriods():int;
        function get clubPastPeriods():int;
        function get clubLevel():int;
        function get clubHasEverBeenMember():Boolean;
        function get clubIsExpiring():Boolean;
        function get tradingActive():Boolean;
        function get hasRoomSession():Boolean;
        function HabboInventory():Array;
        function HabboInventory():Array;
        function HabboInventory(_arg_1:String, _arg_2:int):IItem;
        function HabboInventory(_arg_1:int):void;
        function HabboInventory(_arg_1:int):void;
        function HabboInventory():void;
        function HabboInventory(_arg_1:int, _arg_2:String):void;
        function HabboInventory(_arg_1:String, _arg_2:Boolean=false):void;
        function HabboInventory(_arg_1:String):void;
        function HabboInventory(_arg_1:Boolean):void;
        function HabboInventory():int;
        function HabboInventory(_arg_1:int):Boolean;

    }
}//package com.sulake.habbo.inventory

// HabboInventory = "_-81" (String#2057, DoABC#2)
// tradingActive = "_-1-4" (String#1595, DoABC#2)
// HabboInventory = "_-2Iv" (String#6420, DoABC#2)
// HabboInventory = "_-NR" (String#8153, DoABC#2)
// hasRoomSession = "_-Iw" (String#8059, DoABC#2)
// IItem = "_-1-k" (String#4863, DoABC#2)
// clubPastPeriods = "_-U4" (String#8286, DoABC#2)
// clubHasEverBeenMember = "_-2m" (String#7004, DoABC#2)
// clubIsExpiring = "_-0Gw" (String#3893, DoABC#2)
// HabboInventory = "_-2P" (String#6543, DoABC#2)
// IHabboInventory = "_-ud" (String#8776, DoABC#2)
// HabboInventory = "_-1MK" (String#5280, DoABC#2)
// HabboInventory = "_-33d" (String#1992, DoABC#2)
// HabboInventory = "_-aN" (String#2133, DoABC#2)
// HabboInventory = "_-1Ct" (String#1634, DoABC#2)
// HabboInventory = "_-2rY" (String#1952, DoABC#2)
// HabboInventory = "_-0tu" (String#4721, DoABC#2)
// HabboInventory = "_-26E" (String#6170, DoABC#2)
// HabboInventory = "_-Ap" (String#7883, DoABC#2)


