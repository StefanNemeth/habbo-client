
package com.sulake.core.window.components
{
    import com.sulake.core.window.IWindow;

    public interface ISelectorWindow extends IWindow 
    {

        function get numSelectables():uint;
        function getSelected():ISelectableWindow;
        function setSelected(_arg_1:ISelectableWindow):void;
        function addSelectable(_arg_1:ISelectableWindow):ISelectableWindow;
        function addSelectableAt(_arg_1:ISelectableWindow, _arg_2:int):ISelectableWindow;
        function getSelectableAt(_arg_1:int):ISelectableWindow;
        function getSelectableByID(_arg_1:uint):ISelectableWindow;
        function getSelectableByTag(_arg_1:String):ISelectableWindow;
        function getSelectableByName(_arg_1:String):ISelectableWindow;
        function getSelectableIndex(_arg_1:ISelectableWindow):int;
        function removeSelectable(_arg_1:ISelectableWindow):ISelectableWindow;

    }
}//package com.sulake.core.window.components

// ISelectableWindow = "_-nA" (String#2188, DoABC#2)
// ISelectorWindow = "_-1aY" (String#1714, DoABC#2)
// getSelected = "_-88" (String#7825, DoABC#2)
// getSelectableByName = "_-0EO" (String#3836, DoABC#2)
// numSelectables = "_-1pQ" (String#5845, DoABC#2)
// addSelectable = "_-1uz" (String#5941, DoABC#2)
// addSelectableAt = "_-0Vv" (String#4227, DoABC#2)
// getSelectableAt = "_-2Vc" (String#6675, DoABC#2)
// getSelectableByID = "_-lI" (String#8633, DoABC#2)
// getSelectableByTag = "_-06i" (String#3695, DoABC#2)
// getSelectableIndex = "_-2bS" (String#6782, DoABC#2)
// removeSelectable = "_-i9" (String#8555, DoABC#2)


