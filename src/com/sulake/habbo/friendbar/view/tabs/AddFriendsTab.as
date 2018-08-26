
package com.sulake.habbo.friendbar.view.tabs
{
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.components.IRegionWindow;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import flash.display.BitmapData;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.components.ITextWindow;

    public class AddFriendsTab extends Tab 
    {

        protected static const ICON:String = "icon";
        protected static const TEXT:String = "text";
        protected static const _SafeStr_7540:String = "header";
        protected static const _SafeStr_7515:String = "label";
        protected static const BUTTON:String = "button";
        private static const _SafeStr_11048:String = "add_friends_tab_xml";
        private static const _SafeStr_11049:String = "find_friends_icon_png";
        private static var _SafeStr_11050:int = -1;
        private static const _SafeStr_4861:uint = 6907230;
        private static const _SafeStr_11032:uint = 9209986;
        private static const POOL:Array = [];
        private static const _SafeStr_11051:Array = [];

        public static function allocate():AddFriendsTab
        {
            var _local_1:AddFriendsTab = (((POOL.length > 0)) ? POOL.pop() : new (AddFriendsTab)());
            _local_1._recycled = false;
            _local_1._window = _local_1.allocateEntityWindow();
            return (_local_1);
        }

        public function allocateEntityWindow():IWindowContainer
        {
            var _local_1:IWindowContainer = (((_SafeStr_11051.length > 0)) ? _SafeStr_11051.pop() : (WINDOWING.buildFromXML((ASSETS.getAssetByName(_SafeStr_11048).content as XML)) as IWindowContainer));
            var _local_2:IRegionWindow = IRegionWindow(_local_1.findChildByName(_SafeStr_7540));
            _local_1.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, WelcomeScreenController);
            _local_1.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_OVER, ClubGiftNotification);
            _local_1.addEventListener(WindowMouseEvent.WME_OUT, ClubGiftNotification);
            _local_2.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, WelcomeScreenController);
            _local_2.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_OVER, ClubGiftNotification);
            _local_2.addEventListener(WindowMouseEvent.WME_OUT, ClubGiftNotification);
            if (_SafeStr_11050 < 0){
                _SafeStr_11050 = _local_1.height;
            };
            _local_1.height = _SafeStr_9008;
            var _local_3:IBitmapWrapperWindow = (_local_1.findChildByName(ICON) as IBitmapWrapperWindow);
            _local_3.disposesBitmap = false;
            _local_3.bitmap = (ASSETS.getAssetByName(_SafeStr_11049).content as BitmapData);
            var _local_4:IWindow = _local_1.findChildByName(BUTTON);
            _local_4.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onButtonClick);
            var _local_5:IWindow = _local_1.findChildByName(TEXT);
            _local_5.visible = false;
            return (_local_1);
        }
        private function releaseEntityWindow(_arg_1:IWindowContainer):void
        {
            var _local_2:IRegionWindow;
            if (((_arg_1) && (!(_arg_1.disposed)))){
                _arg_1.procedure = null;
                _arg_1.removeEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, WelcomeScreenController);
                _arg_1.removeEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_OVER, ClubGiftNotification);
                _arg_1.removeEventListener(WindowMouseEvent.WME_OUT, ClubGiftNotification);
                _local_2 = IRegionWindow(_arg_1.findChildByName(_SafeStr_7540));
                _local_2.removeEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, WelcomeScreenController);
                _local_2.removeEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_OVER, ClubGiftNotification);
                _local_2.removeEventListener(WindowMouseEvent.WME_OUT, ClubGiftNotification);
                _arg_1.findChildByName(BUTTON).removeEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onButtonClick);
                _arg_1.findChildByName(TEXT).visible = false;
                _arg_1.width = _SafeStr_9007;
                _arg_1.height = _SafeStr_9008;
                if (_SafeStr_11051.indexOf(_arg_1) == -1){
                    _SafeStr_11051.push(_arg_1);
                };
            };
        }
        override public function select(_arg_1:Boolean):void
        {
            if (!selected){
                _window.height = _SafeStr_11050;
                _window.y = (_window.y - (_window.height - _SafeStr_9008));
                _window.findChildByName(TEXT).visible = true;
                super.select(_arg_1);
            };
        }
        override public function ITab(_arg_1:Boolean):void
        {
            if (selected){
                _window.y = 0;
                _window.height = _SafeStr_9008;
                _window.findChildByName(TEXT).visible = false;
                super.ITab(_arg_1);
            };
        }
        override public function recycle():void
        {
            if (!disposed){
                if (!_recycled){
                    if (_window){
                        this.releaseEntityWindow(_window);
                        _window = null;
                    };
                    _recycled = true;
                    POOL.push(this);
                };
            };
        }
        override protected function expose():void
        {
            super.expose();
            ITextWindow(_window.findChildByTag(_SafeStr_7515)).underline = exposed;
            _window.color = ((exposed) ? _SafeStr_11032 : _SafeStr_4861);
        }
        override protected function conceal():void
        {
            super.conceal();
            ITextWindow(_window.findChildByTag(_SafeStr_7515)).underline = exposed;
            _window.color = ((exposed) ? _SafeStr_11032 : _SafeStr_4861);
        }
        private function onButtonClick(_arg_1:WindowMouseEvent):void
        {
            if (((!(disposed)) && (!(recycled)))){
                _SafeStr_11013.findNewFriends();
                this.ITab(true);
            };
        }

    }
}//package com.sulake.habbo.friendbar.view.tabs

// ASSETS = "_-391" (String#21846, DoABC#2)
// recycled = "_-0Zq" (String#4294, DoABC#2)
// WINDOWING = "_-03b" (String#14186, DoABC#2)
// _SafeStr_11013 = "_-1BC" (String#16905, DoABC#2)
// exposed = "_-Gs" (String#22885, DoABC#2)
// conceal = "_-zo" (String#644, DoABC#2)
// expose = "_-3K" (String#634, DoABC#2)
// _SafeStr_11032 = "_-28d" (String#878, DoABC#2)
// _SafeStr_11048 = "_-8Q" (String#22559, DoABC#2)
// _SafeStr_11049 = "_-IM" (String#22944, DoABC#2)
// _SafeStr_11050 = "_-00U" (String#14073, DoABC#2)
// _SafeStr_11051 = "_-01" (String#14094, DoABC#2)
// allocateEntityWindow = "_-0XA" (String#15321, DoABC#2)
// releaseEntityWindow = "_-1I2" (String#17194, DoABC#2)
// IRegionWindow = "_-dg" (String#2146, DoABC#2)
// Tab = "_-Cd" (String#930, DoABC#2)
// AddFriendsTab = "_-3e" (String#7741, DoABC#2)
// WME_OUT = "_-0h2" (String#15712, DoABC#2)
// ClubGiftNotification = "_-21W" (String#613, DoABC#2)
// ClubGiftNotification = "_-1ap" (String#608, DoABC#2)
// WelcomeScreenController = "_-0Kd" (String#584, DoABC#2)
// _SafeStr_4861 = "_-0CJ" (String#582, DoABC#2)
// disposesBitmap = "_-03U" (String#3637, DoABC#2)
// ITab = "_-05I" (String#3671, DoABC#2)
// _SafeStr_7515 = "_-1xV" (String#871, DoABC#2)
// _SafeStr_7540 = "_-1l4" (String#444, DoABC#2)
// onButtonClick = "_-1S0" (String#1689, DoABC#2)
// _SafeStr_9007 = "_-iG" (String#2163, DoABC#2)
// _SafeStr_9008 = "_-hz" (String#2162, DoABC#2)
// allocate = "_-08G" (String#14374, DoABC#2)
// _recycled = "_-2vB" (String#1963, DoABC#2)


