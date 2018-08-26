
package com.sulake.habbo.catalog.viewer
{
    public interface IPageLocalization 
    {

        function get imageCount():int;
        function get textCount():int;
        function getTextElementName(_arg_1:int, _arg_2:String):String;
        function getImageElementName(_arg_1:int, _arg_2:String):String;
        function getTextElementContent(_arg_1:int):String;
        function getImageElementContent(_arg_1:int):String;
        function dispose():void;
        function hasLinks(_arg_1:String):Boolean;
        function PageLocalization(_arg_1:String):Array;
        function hasColors(_arg_1:String):Boolean;
        function getColorTargets(_arg_1:String):Array;
        function getColorSources(_arg_1:String):Array;
        function getColorUintFromText(_arg_1:int):uint;

    }
}//package com.sulake.habbo.catalog.viewer

// IPageLocalization = "_-0gS" (String#4433, DoABC#2)
// PageLocalization = "_-Eu" (String#7970, DoABC#2)


