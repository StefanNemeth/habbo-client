
package com.sulake.habbo.friendbar.view.utils
{
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.core.assets.BitmapDataAsset;
    import com.sulake.core.window.components.IBitmapWrapperWindow;

    public class StreamIcon extends Icon 
    {

        private static const _SafeStr_5304:int = 500;

        private var _assets:IAssetLibrary;

        public function StreamIcon(_arg_1:IAssetLibrary, _arg_2:IBitmapWrapperWindow)
        {
            this._assets = _arg_1;
            alignment = (_SafeStr_5290 | _SafeStr_5293);
            image = (_arg_1.getAssetByName("icon_stream_png") as BitmapDataAsset);
            canvas = _arg_2;
        }
        override public function dispose():void
        {
            if (!disposed){
                this._assets = null;
                super.dispose();
            };
        }
        override public function hover(_arg_1:Boolean):void
        {
            if (_arg_1){
                image = (this._assets.getAssetByName(((_SafeStr_5299) ? "icon_stream_new_hover_png" : "icon_stream_hover_png")) as BitmapDataAsset);
            }
            else {
                image = (this._assets.getAssetByName(((_SafeStr_5299) ? "icon_stream_new_png" : "icon_stream_png")) as BitmapDataAsset);
            };
            super.hover(_arg_1);
        }
        override public function notify(_arg_1:Boolean):void
        {
            super.notify(_arg_1);
            image = (this._assets.getAssetByName(((_arg_1) ? "icon_stream_new_png" : "icon_stream_png")) as BitmapDataAsset);
        }

    }
}//package com.sulake.habbo.friendbar.view.utils

// BitmapDataAsset = "_-0PB" (String#4074, DoABC#2)
// Icon = "_-2AV" (String#6254, DoABC#2)
// StreamIcon = "_-2tp" (String#21232, DoABC#2)
// _SafeStr_5290 = "_-1mA" (String#18386, DoABC#2)
// _SafeStr_5293 = "_-275" (String#19295, DoABC#2)
// _SafeStr_5299 = "_-mi" (String#24137, DoABC#2)
// alignment = "_-2Dg" (String#19553, DoABC#2)
// hover = "_-27m" (String#19322, DoABC#2)
// _SafeStr_5304 = "_-35C" (String#1996, DoABC#2)


