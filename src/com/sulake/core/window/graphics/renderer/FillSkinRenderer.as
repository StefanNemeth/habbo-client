
package com.sulake.core.window.graphics.renderer
{
    import flash.display.BitmapData;
    import com.sulake.core.window.IWindow;
    import flash.display.IBitmapDrawable;
    import flash.geom.Rectangle;

    public class FillSkinRenderer extends SkinRenderer 
    {

        public function FillSkinRenderer(_arg_1:String)
        {
            super(_arg_1);
        }
        override public function draw(_arg_1:IWindow, _arg_2:IBitmapDrawable, _arg_3:Rectangle, _arg_4:uint, _arg_5:Boolean):void
        {
            if ((_arg_2 is BitmapData)){
                BitmapData(_arg_2).fillRect(_arg_3, _arg_1.color);
            };
        }

    }
}//package com.sulake.core.window.graphics.renderer

// SkinRenderer = "_-bE" (String#8445, DoABC#2)
// FillSkinRenderer = "_-08m" (String#3735, DoABC#2)


