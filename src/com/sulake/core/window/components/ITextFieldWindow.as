
package com.sulake.core.window.components
{
    public interface ITextFieldWindow extends ITextWindow, IFocusWindow, IInteractiveWindow 
    {

        function get editable():Boolean;
        function set editable(_arg_1:Boolean):void;
        function get selectable():Boolean;
        function set selectable(_arg_1:Boolean):void;
        function get displayAsPassword():Boolean;
        function set displayAsPassword(_arg_1:Boolean):void;
        function setSelection(_arg_1:int, _arg_2:int):void;
        function get selectionBeginIndex():int;
        function get selectionEndIndex():int;
        function get restrict():String;
        function set restrict(_arg_1:String):void;

    }
}//package com.sulake.core.window.components

// IFocusWindow = "_-1Ty" (String#5431, DoABC#2)
// IInteractiveWindow = "_-0KX" (String#1454, DoABC#2)
// ITextFieldWindow = "_-3EL" (String#2027, DoABC#2)


