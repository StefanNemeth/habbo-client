
package com.sulake.habbo.configuration
{
    import com.sulake.core.runtime.IUnknown;
    import flash.utils.Dictionary;

    public interface IHabboConfigurationManager extends IUnknown 
    {

        function keyExists(_arg_1:String):Boolean;
        function getKey(_arg_1:String, _arg_2:String="", _arg_3:Dictionary=null):String;
        function getBoolean(_arg_1:String, _arg_2:Boolean):Boolean;
        function setKey(_arg_1:String, _arg_2:String, _arg_3:Boolean=false, _arg_4:Boolean=false):void;

    }
}//package com.sulake.habbo.configuration

// keyExists = "_-2ME" (String#6487, DoABC#2)
// setKey = "_-0sz" (String#1567, DoABC#2)


