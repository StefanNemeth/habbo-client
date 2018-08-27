
package com.sulake.habbo.catalog.recycler
{
    public interface IRecyclerVisualization 
    {

        function displayNormalView():void;
        function displayProcessingView():void;
        function displayFinishedView():void;
        function displayDisabledView():void;
        function displayTimeOutView(_arg_1:int):void;
        function updateSlots():void;
        function updateRecycleButton(_arg_1:Boolean):void;
        function get disposed():Boolean;

    }
}//package com.sulake.habbo.catalog.recycler

// displayNormalView = "_-uS" (String#8772, DoABC#2)
// displayDisabledView = "_-0kj" (String#4516, DoABC#2)
// displayTimeOutView = "_-3IN" (String#7676, DoABC#2)
// displayFinishedView = "_-IF" (String#8044, DoABC#2)
// displayProcessingView = "_-1kQ" (String#5758, DoABC#2)
// updateRecycleButton = "_-0qa" (String#4652, DoABC#2)
// IRecyclerVisualization = "_-2gZ" (String#6880, DoABC#2)
// updateSlots = "_-1Dr" (String#5140, DoABC#2)


