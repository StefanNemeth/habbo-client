
package mx.core
{
    public interface IRepeaterClient 
    {

        function get instanceIndices():Array;
        function set instanceIndices(_arg_1:Array):void;
        function get isDocument():Boolean;
        function get repeaterIndices():Array;
        function set repeaterIndices(_arg_1:Array):void;
        function get repeaters():Array;
        function set repeaters(_arg_1:Array):void;
        function initializeRepeaterArrays(_arg_1:IRepeaterClient):void;

    }
}//package mx.core

