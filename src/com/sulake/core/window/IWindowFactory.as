
package com.sulake.core.window
{
    import flash.geom.Rectangle;
    import com.sulake.core.utils.Map;
    import com.sulake.core.window.utils.DefaultAttStruct;

    public interface IWindowFactory 
    {

        function create(_arg_1:String, _arg_2:uint, _arg_3:uint, _arg_4:uint, _arg_5:Rectangle, _arg_6:Function=null, _arg_7:String="", _arg_8:uint=0, _arg_9:Array=null, _arg_10:IWindow=null, _arg_11:Array=null):IWindow;
        function destroy(_arg_1:IWindow):void;
        function buildFromXML(_arg_1:XML, _arg_2:uint=1, _arg_3:Map=null):IWindow;
        function windowToXMLString(_arg_1:IWindow):String;
        function getLayoutByTypeAndStyle(_arg_1:uint, _arg_2:uint):XML;
        function getDefaultsByTypeAndStyle(_arg_1:uint, _arg_2:uint):DefaultAttStruct;

    }
}//package com.sulake.core.window

// DefaultAttStruct = "_-2e0" (String#20604, DoABC#2)
// IWindowFactory = "_-Zd" (String#8408, DoABC#2)
// destroy = "_-25R" (String#615, DoABC#2)
// windowToXMLString = "_-1D-" (String#841, DoABC#2)
// getLayoutByTypeAndStyle = "_-9S" (String#7853, DoABC#2)
// getDefaultsByTypeAndStyle = "_-2ch" (String#6806, DoABC#2)


