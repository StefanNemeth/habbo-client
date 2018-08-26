
package com.sulake.habbo.friendbar.view.tabs
{
    import com.sulake.habbo.friendbar.data.IHabboFriendBarData;
    import com.sulake.habbo.friendbar.view.IHabboFriendBarView;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.habbo.localization.IHabboLocalizationManager;
    import com.sulake.habbo.friendbar.view.utils.TextCropper;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.events.WindowMouseEvent;
    import flash.geom.Point;

    public class Tab implements ITab 
    {

        public static var _SafeStr_9007:int = 127;
        public static var _SafeStr_9008:int = 36;
        public static var _SafeStr_11013:IHabboFriendBarData;
        public static var _SafeStr_11014:IHabboFriendBarView;
        public static var ASSETS:IAssetLibrary;
        public static var WINDOWING:IHabboWindowManager;
        public static var _SafeStr_11015:IHabboLocalizationManager;
        public static var _SafeStr_11016:TextCropper;

        protected var _window:IWindowContainer;
        protected var _recycled:Boolean;
        private var _exposed:Boolean;
        private var _selected:Boolean;
        private var _disposed:Boolean;

        public function get window():IWindowContainer
        {
            return (this._window);
        }
        public function get selected():Boolean
        {
            return (this._selected);
        }
        public function get recycled():Boolean
        {
            return (this._recycled);
        }
        public function get disposed():Boolean
        {
            return (this._disposed);
        }
        protected function get exposed():Boolean
        {
            return (this._exposed);
        }
        public function select(_arg_1:Boolean):void
        {
            this.conceal();
            this._selected = true;
        }
        public function ITab(_arg_1:Boolean):void
        {
            this._selected = false;
        }
        public function recycle():void
        {
            this.conceal();
            this._recycled = true;
        }
        public function dispose():void
        {
            if (!this._disposed){
                if (this._window){
                    this._window.dispose();
                    this._window = null;
                };
                this._disposed = true;
            };
        }
        protected function expose():void
        {
            this._exposed = true;
        }
        protected function conceal():void
        {
            this._exposed = false;
        }
        protected function WelcomeScreenController(_arg_1:WindowMouseEvent):void
        {
            if (((this.disposed) || (this.recycled))){
                return;
            };
            if (this.selected){
                _SafeStr_11014.deSelect(true);
            }
            else {
                _SafeStr_11014.selectTab(this, true);
            };
        }
        protected function ClubGiftNotification(_arg_1:WindowMouseEvent):void
        {
            if (((this.disposed) || (this.recycled))){
                return;
            };
            if (!this.selected){
                this.expose();
            };
        }
        protected function ClubGiftNotification(_arg_1:WindowMouseEvent):void
        {
            if (((((this.disposed) || (this.recycled))) || ((this._window == null)))){
                return;
            };
            if (!this.selected){
                if (!this._window.hitTestGlobalPoint(new Point(_arg_1.stageX, _arg_1.stageY))){
                    this.conceal();
                };
            };
        }

    }
}//package com.sulake.habbo.friendbar.view.tabs

// ASSETS = "_-391" (String#21846, DoABC#2)
// recycled = "_-0Zq" (String#4294, DoABC#2)
// WINDOWING = "_-03b" (String#14186, DoABC#2)
// _SafeStr_11013 = "_-1BC" (String#16905, DoABC#2)
// _SafeStr_11014 = "_-CV" (String#22705, DoABC#2)
// _SafeStr_11015 = "_-2ci" (String#20552, DoABC#2)
// _SafeStr_11016 = "_-1px" (String#18540, DoABC#2)
// _exposed = "_-0G3" (String#14686, DoABC#2)
// exposed = "_-Gs" (String#22885, DoABC#2)
// conceal = "_-zo" (String#644, DoABC#2)
// expose = "_-3K" (String#634, DoABC#2)
// selectTab = "_-F0" (String#2077, DoABC#2)
// IHabboFriendBarView = "_-0n8" (String#4571, DoABC#2)
// IHabboFriendBarData = "_-1hC" (String#5689, DoABC#2)
// Tab = "_-Cd" (String#930, DoABC#2)
// TextCropper = "_-58" (String#22425, DoABC#2)
// ClubGiftNotification = "_-21W" (String#613, DoABC#2)
// ClubGiftNotification = "_-1ap" (String#608, DoABC#2)
// WelcomeScreenController = "_-0Kd" (String#584, DoABC#2)
// ITab = "_-05I" (String#3671, DoABC#2)
// _SafeStr_9007 = "_-iG" (String#2163, DoABC#2)
// _SafeStr_9008 = "_-hz" (String#2162, DoABC#2)
// _recycled = "_-2vB" (String#1963, DoABC#2)


