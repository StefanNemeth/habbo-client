
package com.sulake.habbo.inventory.items
{
    public interface IItem 
    {

        function get id():int;
        function get ref():int;
        function get type():int;
        function get stuffData():String;
        function get extra():Number;
        function get category():int;
        function get recyclable():Boolean;
        function get tradeable():Boolean;
        function get groupable():Boolean;
        function get sellable():Boolean;
        function get locked():Boolean;
        function set locked(_arg_1:Boolean):void;

    }
}//package com.sulake.habbo.inventory.items

// recyclable = "_-A8" (String#7868, DoABC#2)
// IItem = "_-1-k" (String#4863, DoABC#2)
// extra = "_-2We" (String#6693, DoABC#2)
// stuffData = "_-0vz" (String#1580, DoABC#2)
// groupable = "_-1YM" (String#5527, DoABC#2)
// ref = "_-Jx" (String#8081, DoABC#2)
// tradeable = "_-3E5" (String#7597, DoABC#2)


