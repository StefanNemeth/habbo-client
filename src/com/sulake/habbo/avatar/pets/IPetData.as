
package com.sulake.habbo.avatar.pets
{
    public interface IPetData 
    {

        function get name():String;
        function get species():int;
        function get disableHeadTurn():Boolean;
        function get scale():String;
        function get colors():Array;
        function get breeds():Array;
        function get sellableBreeds():Array;

    }
}//package com.sulake.habbo.avatar.pets

// sellableBreeds = "_-2ie" (String#6923, DoABC#2)
// disableHeadTurn = "_-0aA" (String#4304, DoABC#2)
// IPetData = "_-0mZ" (String#4560, DoABC#2)


