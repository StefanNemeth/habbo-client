
package com.sulake.habbo.friendbar.view.utils
{
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.core.assets.BitmapDataAsset;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import flash.events.TimerEvent;

    public class FriendListIcon extends Icon 
    {

        private static const _SafeStr_5305:int = 200;
        private static const _SafeStr_5304:int = 500;

        private var _assets:IAssetLibrary;

        public function FriendListIcon(_arg_1:IAssetLibrary, _arg_2:IBitmapWrapperWindow)
        {
            this._assets = _arg_1;
            alignment = (_SafeStr_5290 | _SafeStr_5293);
            image = (_arg_1.getAssetByName("icon_friendlist_png") as BitmapDataAsset);
            canvas = _arg_2;
        }
        override public function dispose():void
        {
            if (!disposed){
                this._assets = null;
                super.dispose();
            };
        }
        override public function notify(_arg_1:Boolean):void
        {
            super.notify(_arg_1);
            this.enable(_arg_1);
            toggleTimer(((_arg_1) || (_hover)), ((_hover) ? _SafeStr_5305 : _SafeStr_5304));
            if (((!(_SafeStr_5299)) && (!(_hover)))){
                image = (this._assets.getAssetByName("icon_friendlist_png") as BitmapDataAsset);
            };
        }
        override public function hover(_arg_1:Boolean):void
        {
            super.hover(_arg_1);
            toggleTimer(((_arg_1) || (_SafeStr_5299)), ((_hover) ? _SafeStr_5305 : _SafeStr_5304));
            if (((!(_SafeStr_5299)) && (!(_hover)))){
                image = (this._assets.getAssetByName("icon_friendlist_png") as BitmapDataAsset);
            };
        }
        override public function enable(_arg_1:Boolean):void
        {
            canvas.blend = ((disabled) ? 0.5 : 1);
        }
        override protected function onTimerEvent(_arg_1:TimerEvent):void
        {
            if (_hover){
                _frame = (++_frame % 4);
                image = (this._assets.getAssetByName((("icon_friendlist_hover_" + _frame) + "_png")) as BitmapDataAsset);
            }
            else {
                if (_SafeStr_5299){
                    _frame = (++_frame % 2);
                    image = (this._assets.getAssetByName((("icon_friendlist_notify_" + _frame) + "_png")) as BitmapDataAsset);
                };
            };
        }

    }
}//package com.sulake.habbo.friendbar.view.utils

// BitmapDataAsset = "_-0PB" (String#4074, DoABC#2)
// Icon = "_-2AV" (String#6254, DoABC#2)
// FriendListIcon = "_-iq" (String#23992, DoABC#2)
// _SafeStr_5290 = "_-1mA" (String#18386, DoABC#2)
// _SafeStr_5293 = "_-275" (String#19295, DoABC#2)
// _SafeStr_5299 = "_-mi" (String#24137, DoABC#2)
// alignment = "_-2Dg" (String#19553, DoABC#2)
// toggleTimer = "_-0Lc" (String#14898, DoABC#2)
// hover = "_-27m" (String#19322, DoABC#2)
// _SafeStr_5304 = "_-35C" (String#1996, DoABC#2)
// _SafeStr_5305 = "_-0uA" (String#16211, DoABC#2)


