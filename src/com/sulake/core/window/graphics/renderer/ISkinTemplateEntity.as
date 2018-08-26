
package com.sulake.core.window.graphics.renderer
{
    import com.sulake.core.window.utils.IChildEntity;
    import flash.geom.Rectangle;

    public interface ISkinTemplateEntity extends IChildEntity 
    {

        function get type():String;
        function get region():Rectangle;
        function getProperty(_arg_1:String):Object;
        function setProperty(_arg_1:String, _arg_2:Object):void;

    }
}//package com.sulake.core.window.graphics.renderer

// IChildEntity = "_-1NX" (String#5302, DoABC#2)
// ISkinTemplateEntity = "_-27h" (String#1819, DoABC#2)


