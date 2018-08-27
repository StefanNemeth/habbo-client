
package com.sulake.core.window.utils
{
    public interface IChildEntityArrayReader 
    {

        function get numChildren():int;
        function getChildAt(_arg_1:int):IChildEntity;
        function getChildByID(_arg_1:uint):IChildEntity;
        function getChildByTag(_arg_1:String):IChildEntity;
        function getChildByName(_arg_1:String):IChildEntity;
        function getChildIndex(_arg_1:IChildEntity):int;
        function groupChildrenWithID(_arg_1:uint, _arg_2:Array):uint;
        function groupChildrenWithTag(_arg_1:String, _arg_2:Array):uint;

    }
}//package com.sulake.core.window.utils

// IChildEntityArrayReader = "_-1kK" (String#5755, DoABC#2)
// IChildEntity = "_-1NX" (String#5302, DoABC#2)
// groupChildrenWithTag = "_-cU" (String#2141, DoABC#2)
// getChildByID = "_-y3" (String#2226, DoABC#2)
// getChildByTag = "_-tP" (String#2212, DoABC#2)
// groupChildrenWithID = "_-2KM" (String#1856, DoABC#2)


