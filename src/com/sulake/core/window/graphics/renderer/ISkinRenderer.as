
package com.sulake.core.window.graphics.renderer
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.core.assets.IAsset;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.core.window.IWindow;
    import flash.display.IBitmapDrawable;
    import flash.geom.Rectangle;

    public interface ISkinRenderer extends IDisposable 
    {

        function get name():String;
        function parse(_arg_1:IAsset, _arg_2:XMLList, _arg_3:IAssetLibrary):void;
        function draw(_arg_1:IWindow, _arg_2:IBitmapDrawable, _arg_3:Rectangle, _arg_4:uint, _arg_5:Boolean):void;
        function isStateDrawable(_arg_1:uint):Boolean;
        function addLayout(_arg_1:ISkinLayout):ISkinLayout;
        function getLayoutByName(_arg_1:String):ISkinLayout;
        function removeLayout(_arg_1:ISkinLayout):ISkinLayout;
        function getLayoutByState(_arg_1:uint):ISkinLayout;
        function registerLayoutForRenderState(_arg_1:uint, _arg_2:String):void;
        function removeLayoutFromRenderState(_arg_1:uint):void;
        function hasLayoutForState(_arg_1:uint):Boolean;
        function addTemplate(_arg_1:ISkinTemplate):ISkinTemplate;
        function getTemplateByName(_arg_1:String):ISkinTemplate;
        function removeTemplate(_arg_1:ISkinTemplate):ISkinTemplate;
        function getTemplateByState(_arg_1:uint):ISkinTemplate;
        function registerTemplateForRenderState(_arg_1:uint, _arg_2:String):void;
        function removeTemplateFromRenderState(_arg_1:uint):void;
        function hasTemplateForState(_arg_1:uint):Boolean;

    }
}//package com.sulake.core.window.graphics.renderer

// ISkinLayout = "_-m8" (String#2182, DoABC#2)
// ISkinRenderer = "_-1uJ" (String#1780, DoABC#2)
// ISkinTemplate = "_-31I" (String#1988, DoABC#2)
// IDisposable = "_-0dY" (String#4382, DoABC#2)
// isStateDrawable = "_-0hI" (String#4452, DoABC#2)
// addLayout = "_-2RX" (String#6597, DoABC#2)
// getLayoutByName = "_-2lX" (String#6993, DoABC#2)
// removeLayout = "_-1Kq" (String#5260, DoABC#2)
// getLayoutByState = "_-AQ" (String#7876, DoABC#2)
// registerLayoutForRenderState = "_-ZK" (String#8402, DoABC#2)
// removeLayoutFromRenderState = "_-bY" (String#8447, DoABC#2)
// hasLayoutForState = "_-0pf" (String#4625, DoABC#2)
// addTemplate = "_-1FX" (String#5163, DoABC#2)
// getTemplateByName = "_-3Bh" (String#7544, DoABC#2)
// removeTemplate = "_-2qc" (String#7088, DoABC#2)
// getTemplateByState = "_-1Lf" (String#5271, DoABC#2)
// registerTemplateForRenderState = "_-U7" (String#8289, DoABC#2)
// removeTemplateFromRenderState = "_-tc" (String#8760, DoABC#2)
// hasTemplateForState = "_-2E6" (String#6323, DoABC#2)


