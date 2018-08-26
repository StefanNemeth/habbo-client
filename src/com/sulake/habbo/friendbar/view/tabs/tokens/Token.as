
package com.sulake.habbo.friendbar.view.tabs.tokens
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.core.assets.IAssetLibrary;
    import flash.geom.Rectangle;
    import com.sulake.core.window.components.IRegionWindow;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.friendbar.data.FriendNotification;
    import com.sulake.habbo.friendbar.view.utils.DropAnimation;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.assets.BitmapDataAsset;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import flash.display.BitmapData;
    import com.sulake.core.window.enum.WindowType;
    import com.sulake.core.window.enum.WindowStyle;
    import com.sulake.core.window.enum.WindowParam;

    public class Token implements IDisposable 
    {

        protected static var _SafeStr_11006:IHabboWindowManager;
        protected static var _SafeStr_11007:IAssetLibrary;
        protected static const ICON:String = "icon";
        protected static const _SafeStr_10985:String = "title";
        protected static const _SafeStr_10986:String = "message";
        protected static const _SafeStr_11008:Rectangle = new Rectangle(0, 0, 25, 25);

        protected var _icon:IRegionWindow;
        protected var _window:IWindowContainer;
        protected var _disposed:Boolean;
        protected var _notification:FriendNotification;
        protected var _animation:DropAnimation;

        public function Token(_arg_1:FriendNotification)
        {
            this._notification = _arg_1;
        }
        public static function set WINDOWING(_arg_1:IHabboWindowManager):void
        {
            _SafeStr_11006 = _arg_1;
        }
        public static function set ASSETS(_arg_1:IAssetLibrary):void
        {
            _SafeStr_11007 = _arg_1;
        }

        public function get typeCode():int
        {
            return (this._notification.typeCode);
        }
        public function get viewOnce():Boolean
        {
            return (this._notification.viewOnce);
        }
        public function get notification():FriendNotification
        {
            return (this._notification);
        }
        public function get iconElement():IWindow
        {
            return (this._icon);
        }
        public function get windowElement():IWindow
        {
            return (this._window);
        }
        public function get disposed():Boolean
        {
            return (this._disposed);
        }
        public function dispose():void
        {
            if (this._window){
                this._window.dispose();
                this._window = null;
            };
            if (this._icon){
                this._icon.dispose();
                this._icon = null;
            };
            if (this._animation){
                this._animation.dispose();
                this._animation = null;
            };
            this._notification = null;
            this._disposed = true;
        }
        protected function prepare(_arg_1:String, _arg_2:String, _arg_3:String, _arg_4:String, _arg_5:String, _arg_6:Boolean):void
        {
            var _local_7:BitmapDataAsset;
            this._window = (_SafeStr_11006.buildFromXML((_SafeStr_11007.getAssetByName(_arg_3).content as XML)) as IWindowContainer);
            this._window.findChildByName(_SafeStr_10985).caption = _arg_1;
            this._window.findChildByName(_SafeStr_10986).caption = ((_arg_2) ? _arg_2 : "");
            _local_7 = (_SafeStr_11007.getAssetByName(_arg_5) as BitmapDataAsset);
            if (_local_7){
                IBitmapWrapperWindow(this._window.findChildByName(ICON)).bitmap = (_local_7.content as BitmapData);
            };
            this._icon = (_SafeStr_11006.create(("ICON_" + this.typeCode), WindowType._SafeStr_6090, WindowStyle._SafeStr_9310, WindowParam._SafeStr_7434, Token._SafeStr_11008) as IRegionWindow);
            this._icon.mouseThreshold = 0;
            var _local_8:IBitmapWrapperWindow = (_SafeStr_11006.create(("BITMAP_" + this.typeCode), WindowType._SafeStr_7569, WindowStyle._SafeStr_9310, WindowParam._SafeStr_7433, Token._SafeStr_11008) as IBitmapWrapperWindow);
            _local_8.disposesBitmap = false;
            _local_7 = (_SafeStr_11007.getAssetByName(_arg_4) as BitmapDataAsset);
            if (_local_7){
                _local_8.bitmap = (_local_7.content as BitmapData);
            };
            this._icon.addChild(_local_8);
            if (this._animation){
                this._animation.dispose();
            };
            if (_arg_6){
                this._animation = new DropAnimation(this._icon, 600, 32);
            };
        }

    }
}//package com.sulake.habbo.friendbar.view.tabs.tokens

// viewOnce = "_-3JO" (String#22260, DoABC#2)
// ASSETS = "_-391" (String#21846, DoABC#2)
// _SafeStr_10985 = "_-0rO" (String#4672, DoABC#2)
// _SafeStr_10986 = "_-34f" (String#629, DoABC#2)
// _SafeStr_11006 = "_-cx" (String#23753, DoABC#2)
// _SafeStr_11007 = "_-1E8" (String#17034, DoABC#2)
// _SafeStr_11008 = "_-2nh" (String#20987, DoABC#2)
// _notification = "_-1TE" (String#17634, DoABC#2)
// WINDOWING = "_-03b" (String#14186, DoABC#2)
// iconElement = "_-W3" (String#23495, DoABC#2)
// windowElement = "_-0VI" (String#15255, DoABC#2)
// BitmapDataAsset = "_-0PB" (String#4074, DoABC#2)
// WindowType = "_-1yl" (String#6008, DoABC#2)
// WindowStyle = "_-10b" (String#4885, DoABC#2)
// IRegionWindow = "_-dg" (String#2146, DoABC#2)
// IDisposable = "_-0dY" (String#4382, DoABC#2)
// DropAnimation = "_-2du" (String#20598, DoABC#2)
// typeCode = "_-vq" (String#24522, DoABC#2)
// _SafeStr_6090 = "_-34m" (String#21687, DoABC#2)
// mouseThreshold = "_-0OA" (String#4051, DoABC#2)
// disposesBitmap = "_-03U" (String#3637, DoABC#2)
// _SafeStr_7433 = "_-222" (String#19092, DoABC#2)
// _SafeStr_7434 = "_-2xA" (String#21356, DoABC#2)
// _SafeStr_7569 = "_-2vP" (String#21293, DoABC#2)
// _animation = "_-jv" (String#8600, DoABC#2)
// _SafeStr_9310 = "_-2-h" (String#19000, DoABC#2)


