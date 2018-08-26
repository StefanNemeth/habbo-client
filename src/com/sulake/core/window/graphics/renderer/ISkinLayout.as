
package com.sulake.core.window.graphics.renderer
{
    import com.sulake.core.window.utils.IChildEntityArray;
    import com.sulake.core.window.utils.IChildEntityArrayReader;
    import flash.geom.Rectangle;

    public interface ISkinLayout extends IChildEntityArray 
    {

        function get name():String;
        function get width():uint;
        function get height():uint;
        function get blendMode():String;
        function get transparent():Boolean;
        function get placeholders():IChildEntityArrayReader;
        function dispose():void;
        function ISkinLayout():Boolean;
        function ISkinLayout():Boolean;
        function ISkinLayout(_arg_1:String, _arg_2:Rectangle):void;

    }
}//package com.sulake.core.window.graphics.renderer

// IChildEntityArrayReader = "_-1kK" (String#5755, DoABC#2)
// IChildEntityArray = "_-2oU" (String#7047, DoABC#2)
// ISkinLayout = "_-m8" (String#2182, DoABC#2)
// placeholders = "_-b7" (String#8444, DoABC#2)
// ISkinLayout = "_-CN" (String#7923, DoABC#2)
// ISkinLayout = "_-3By" (String#7551, DoABC#2)
// ISkinLayout = "_-1Bw" (String#5109, DoABC#2)


