
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
        function getActivatedAvatarEffects():Array;
        function getAvatarEffects():Array;
        function getItemById(_arg_1:String, _arg_2:int):IItem;
        function setEffectSelected(_arg_1:int):void;
        function setEffectDeselected(_arg_1:int):void;
        function deselectAllEffects():void;
        function setupTrading(_arg_1:int, _arg_2:String):void;
        function toggleInventoryPage(_arg_1:String, _arg_2:Boolean=false):void;
        function toggleInventorySubPage(_arg_1:String):void;
        function setupRecycler(_arg_1:Boolean):void;
        function requestSelectedFurniToRecycler():int;
        function returnInventoryFurniFromRecycler(_arg_1:int):Boolean;

    }
}//package com.sulake.habbo.inventory

// returnInventoryFurniFromRecycler = "_-81" (String#2057, DoABC#2)
// tradingActive = "_-1-4" (String#1595, DoABC#2)
// setupRecycler = "_-2Iv" (String#6420, DoABC#2)
// toggleInventorySubPage = "_-NR" (String#8153, DoABC#2)
// hasRoomSession = "_-Iw" (String#8059, DoABC#2)
// IItem = "_-1-k" (String#4863, DoABC#2)
// clubPastPeriods = "_-U4" (String#8286, DoABC#2)
// clubHasEverBeenMember = "_-2m" (String#7004, DoABC#2)
// clubIsExpiring = "_-0Gw" (String#3893, DoABC#2)
// requestSelectedFurniToRecycler = "_-2P" (String#6543, DoABC#2)
// IHabboInventory = "_-ud" (String#8776, DoABC#2)
// toggleInventoryPage = "_-1MK" (String#5280, DoABC#2)
// getActivatedAvatarEffects = "_-33d" (String#1992, DoABC#2)
// getAvatarEffects = "_-aN" (String#2133, DoABC#2)
// setEffectSelected = "_-1Ct" (String#1634, DoABC#2)
// setEffectDeselected = "_-2rY" (String#1952, DoABC#2)
// deselectAllEffects = "_-0tu" (String#4721, DoABC#2)
// setupTrading = "_-26E" (String#6170, DoABC#2)
// getItemById = "_-Ap" (String#7883, DoABC#2)


