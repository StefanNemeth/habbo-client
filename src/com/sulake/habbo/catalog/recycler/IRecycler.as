
package com.sulake.habbo.catalog.recycler
{
    public interface IRecycler 
    {

        function init(_arg_1:IRecyclerVisualization=null):void;
        function cancel():void;
        function getSlotContent(_arg_1:int):FurniSlotItem;
        function placeObjectAtSlot(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:int, _arg_5:String):void;
        function releaseSlot(_arg_1:int):void;
        function executeRecycler():void;
        function isReadyToRecycle():Boolean;
        function getPrizeTable():Array;

    }
}//package com.sulake.habbo.catalog.recycler

// getSlotContent = "_-06m" (String#3697, DoABC#2)
// placeObjectAtSlot = "_-Wq" (String#8345, DoABC#2)
// releaseSlot = "_-1oW" (String#5832, DoABC#2)
// executeRecycler = "_-0VV" (String#4216, DoABC#2)
// isReadyToRecycle = "_-b0" (String#8440, DoABC#2)
// getPrizeTable = "_-17e" (String#5030, DoABC#2)
// IRecycler = "_-0fo" (String#4421, DoABC#2)
// IRecyclerVisualization = "_-2gZ" (String#6880, DoABC#2)
// FurniSlotItem = "_-19d" (String#5069, DoABC#2)


