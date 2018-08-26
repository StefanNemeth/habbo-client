
package com.sulake.habbo.friendbar.view.tabs
{
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import com.sulake.habbo.friendbar.data.FriendEntity;
    import com.sulake.habbo.friendbar.data.FriendRequest;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.assets.BitmapDataAsset;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.components.IRegionWindow;
    import com.sulake.core.window.components.IBubbleWindow;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.window.enum.WindowType;
    import com.sulake.core.window.enum.WindowStyle;
    import com.sulake.core.window.enum.WindowParam;
    import flash.geom.Rectangle;
    import flash.display.BitmapData;
    import com.sulake.core.window.components.IItemListWindow;
    import com.sulake.core.window.components.ITextWindow;
    import com.sulake.core.window.events.WindowEvent;

    public class FriendRequestTab extends FriendEntityTab 
    {

        protected static const _SafeStr_11041:String = "friend_request_tab_xml";
        protected static const _SafeStr_7538:String = "bubble";
        protected static const _SafeStr_10986:String = "message";
        protected static const _SafeStr_11028:String = "button_accept";
        protected static const _SafeStr_11027:String = "button_close";
        protected static const _SafeStr_11042:String = "click_region_reject";
        protected static const REGION_REJECT_TEXT:String = "link_reject";
        private static const _SafeStr_4861:uint = 16435481;
        private static const _SafeStr_11032:uint = 16767334;
        private static const REGION_REJECT_COLOR_EXPOSED:uint = 16770666;
        private static const _SafeStr_11035:uint = 0xFFFFFF;
        private static var _SafeStr_11031:FriendRequestTab;

        private var _SafeStr_11043:String;

        public function FriendRequestTab()
        {
            _window = this.allocateRequestTabWindow();
            if (_window){
                _window.findChildByName(_SafeStr_7538).visible = false;
            };
        }
        public static function allocate(_arg_1:FriendRequest):FriendRequestTab
        {
            var _local_3:IBitmapWrapperWindow;
            var _local_2:FriendRequestTab = ((_SafeStr_11031) ? _SafeStr_11031 : new (FriendRequestTab)());
            _local_2._recycled = false;
            if (_local_2.friend){
                if (_local_2.friend.figure != _arg_1.figure){
                    _local_3 = IBitmapWrapperWindow(_local_2._window.findChildByName(_SafeStr_10988));
                    _local_3.bitmap = _SafeStr_11014.getAvatarFaceBitmap(_arg_1.figure);
                };
            };
            _local_2.friend = new FriendEntity(_arg_1.id, _arg_1.name, null, null, -1, false, false, _arg_1.figure, 0, null);
            return (_local_2);
        }

        override public function dispose():void
        {
            if (_window){
                this.releaseRequestTabWindow(_window);
                _window = null;
            };
            super.dispose();
        }
        override public function recycle():void
        {
            if (!disposed){
                if (!_recycled){
                    _friend = null;
                    _recycled = true;
                    _SafeStr_11031 = this;
                };
            };
        }
        override public function select(_arg_1:Boolean):void
        {
            var _local_2:IWindow;
            if (!selected){
                if (_window){
                    _local_2 = _window.findChildByName(_SafeStr_7538);
                    if (_local_2){
                        _local_2.visible = true;
                    };
                };
                super.select(_arg_1);
            };
        }
        override public function ITab(_arg_1:Boolean):void
        {
            var _local_2:IWindow;
            if (selected){
                if (_window){
                    _local_2 = _window.findChildByName(_SafeStr_7538);
                    if (_local_2){
                        _local_2.visible = false;
                    };
                };
                super.ITab(_arg_1);
            };
        }
        override protected function expose():void
        {
            super.expose();
            _window.color = ((exposed) ? _SafeStr_11032 : _SafeStr_4861);
        }
        override protected function conceal():void
        {
            super.conceal();
            _window.color = ((exposed) ? _SafeStr_11032 : _SafeStr_4861);
        }
        private function allocateRequestTabWindow():IWindowContainer
        {
            var _local_6:BitmapDataAsset;
            var _local_1:IWindowContainer = (WINDOWING.buildFromXML((ASSETS.getAssetByName(_SafeStr_11041).content as XML)) as IWindowContainer);
            var _local_2:IBitmapWrapperWindow = IBitmapWrapperWindow(_local_1.findChildByName(_SafeStr_10988));
            var _local_3:IRegionWindow = IRegionWindow(_local_1.findChildByName(_SafeStr_7540));
            var _local_4:IWindow = _local_1.findChildByName(_SafeStr_11047);
            var _local_5:IBubbleWindow = (_local_1.findChildByName(_SafeStr_7538) as IBubbleWindow);
            _local_1.x = 0;
            _local_1.y = 0;
            _local_1.width = _SafeStr_9007;
            _local_1.height = _SafeStr_9008;
            _local_1.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, WelcomeScreenController);
            _local_1.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_OVER, ClubGiftNotification);
            _local_1.addEventListener(WindowMouseEvent.WME_OUT, ClubGiftNotification);
            _local_3.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, WelcomeScreenController);
            _local_3.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_OVER, ClubGiftNotification);
            _local_3.addEventListener(WindowMouseEvent.WME_OUT, ClubGiftNotification);
            _local_4.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, WelcomeScreenController);
            _local_4.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_OVER, ClubGiftNotification);
            _local_4.addEventListener(WindowMouseEvent.WME_OUT, ClubGiftNotification);
            _local_2.disposesBitmap = true;
            _local_5.procedure = this.bubbleEventProc;
            _local_5.y = (-((_local_5.height - (_local_5.height - _local_5.margins.bottom))) - 1);
            var _local_7:IRegionWindow = (WINDOWING.create("ICON", WindowType._SafeStr_6090, WindowStyle._SafeStr_9310, WindowParam._SafeStr_7434, new Rectangle(0, 0, 25, 25)) as IRegionWindow);
            _local_7.mouseThreshold = 0;
            var _local_8:IBitmapWrapperWindow = (WINDOWING.create("BITMAP", WindowType._SafeStr_7569, WindowStyle._SafeStr_9310, WindowParam._SafeStr_7443, new Rectangle(0, 0, 25, 25)) as IBitmapWrapperWindow);
            _local_8.disposesBitmap = false;
            _local_6 = (ASSETS.getAssetByName("plus_friend_icon_png") as BitmapDataAsset);
            if (_local_6){
                _local_8.bitmap = (_local_6.content as BitmapData);
            };
            _local_7.addChild(_local_8);
            IItemListWindow(_local_1.findChildByName(_SafeStr_11047)).IItemListWindow(_local_7, 0);
            return (_local_1);
        }
        private function releaseRequestTabWindow(_arg_1:IWindowContainer):void
        {
            var _local_2:IRegionWindow;
            var _local_3:IWindow;
            var _local_4:IBitmapWrapperWindow;
            if (((_arg_1) && (!(_arg_1.disposed)))){
                _arg_1.procedure = null;
                _arg_1.removeEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, WelcomeScreenController);
                _arg_1.removeEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_OVER, ClubGiftNotification);
                _arg_1.removeEventListener(WindowMouseEvent.WME_OUT, ClubGiftNotification);
                _local_2 = IRegionWindow(_arg_1.findChildByName(_SafeStr_7540));
                _local_2.removeEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, WelcomeScreenController);
                _local_2.removeEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_OVER, ClubGiftNotification);
                _local_2.removeEventListener(WindowMouseEvent.WME_OUT, ClubGiftNotification);
                _local_3 = _arg_1.findChildByName(_SafeStr_11047);
                _local_3.removeEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, WelcomeScreenController);
                _local_3.removeEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_OVER, WelcomeScreenController);
                _local_3.removeEventListener(WindowMouseEvent.WME_OUT, WelcomeScreenController);
                _arg_1.width = _SafeStr_9007;
                _arg_1.height = _SafeStr_9008;
                _arg_1.color = _SafeStr_4861;
                _local_4 = IBitmapWrapperWindow(_arg_1.findChildByName(_SafeStr_10988));
                _local_4.bitmap = null;
                ITextWindow(_arg_1.findChildByTag("label")).underline = false;
            };
        }
        private function bubbleEventProc(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type == WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK){
                switch (_arg_2.name){
                    case _SafeStr_11028:
                        _SafeStr_11013.acceptFriendRequest(_friend.id);
                        break;
                    case _SafeStr_11027:
                        if (selected){
                            _SafeStr_11014.deSelect(true);
                        };
                        break;
                    case _SafeStr_11042:
                        _SafeStr_11013.declineFriendRequest(_friend.id);
                        break;
                };
            }
            else {
                if (_arg_1.type == WindowMouseEvent.WINDOW_EVENT_MOUSE_OVER){
                    if (_arg_2.name == _SafeStr_11042){
                        ITextWindow(IWindowContainer(_arg_2).getChildByName(REGION_REJECT_TEXT)).textColor = REGION_REJECT_COLOR_EXPOSED;
                    };
                }
                else {
                    if (_arg_1.type == WindowMouseEvent.WME_OUT){
                        if (_arg_2.name == _SafeStr_11042){
                            ITextWindow(IWindowContainer(_arg_2).getChildByName(REGION_REJECT_TEXT)).textColor = _SafeStr_11035;
                        };
                    };
                };
            };
        }
        public function avatarImageReady(_arg_1:FriendRequest, _arg_2:BitmapData):void
        {
            var _local_3:IBitmapWrapperWindow;
            var _local_4:BitmapData;
            if (!disposed){
                if (friend){
                    if (friend.figure == _arg_1.figure){
                        _local_3 = (_window.findChildByName(_SafeStr_10988) as IBitmapWrapperWindow);
                        if (_local_3){
                            _local_4 = _SafeStr_11014.getAvatarFaceBitmap(_arg_1.figure);
                            if (_local_4){
                                _local_3.bitmap = _local_4;
                                _local_3.width = _local_4.width;
                                _local_3.height = _local_4.height;
                            };
                        };
                    };
                };
            };
        }

    }
}//package com.sulake.habbo.friendbar.view.tabs

// ASSETS = "_-391" (String#21846, DoABC#2)
// _SafeStr_10986 = "_-34f" (String#629, DoABC#2)
// _SafeStr_10988 = "_-IE" (String#933, DoABC#2)
// WINDOWING = "_-03b" (String#14186, DoABC#2)
// _SafeStr_11013 = "_-1BC" (String#16905, DoABC#2)
// _SafeStr_11014 = "_-CV" (String#22705, DoABC#2)
// exposed = "_-Gs" (String#22885, DoABC#2)
// conceal = "_-zo" (String#644, DoABC#2)
// expose = "_-3K" (String#634, DoABC#2)
// _SafeStr_11027 = "_-2Zb" (String#894, DoABC#2)
// _SafeStr_11028 = "_-zN" (String#8866, DoABC#2)
// _SafeStr_11031 = "_-21i" (String#6077, DoABC#2)
// _SafeStr_11032 = "_-28d" (String#878, DoABC#2)
// _SafeStr_11035 = "_-AK" (String#7873, DoABC#2)
// bubbleEventProc = "_-11r" (String#4913, DoABC#2)
// _SafeStr_11041 = "_-1Ks" (String#17306, DoABC#2)
// _SafeStr_11042 = "_-3G9" (String#22124, DoABC#2)
// _SafeStr_11043 = "_-16S" (String#16716, DoABC#2)
// allocateRequestTabWindow = "_-0yy" (String#16390, DoABC#2)
// releaseRequestTabWindow = "_-1eX" (String#18079, DoABC#2)
// _friend = "_-0mY" (String#15919, DoABC#2)
// _SafeStr_11047 = "_-0IQ" (String#14777, DoABC#2)
// WindowEvent = "_-Jh" (String#2085, DoABC#2)
// BitmapDataAsset = "_-0PB" (String#4074, DoABC#2)
// WindowType = "_-1yl" (String#6008, DoABC#2)
// WindowStyle = "_-10b" (String#4885, DoABC#2)
// IRegionWindow = "_-dg" (String#2146, DoABC#2)
// FriendRequest = "_-2Nq" (String#887, DoABC#2)
// IBubbleWindow = "_-24" (String#6122, DoABC#2)
// FriendRequestTab = "_-2n8" (String#7023, DoABC#2)
// FriendEntity = "_-0R1" (String#15104, DoABC#2)
// IItemListWindow = "_-2CT" (String#6293, DoABC#2)
// WME_OUT = "_-0h2" (String#15712, DoABC#2)
// ClubGiftNotification = "_-21W" (String#613, DoABC#2)
// ClubGiftNotification = "_-1ap" (String#608, DoABC#2)
// WelcomeScreenController = "_-0Kd" (String#584, DoABC#2)
// _SafeStr_4861 = "_-0CJ" (String#582, DoABC#2)
// avatarImageReady = "_-i" (String#8553, DoABC#2)
// _SafeStr_6090 = "_-34m" (String#21687, DoABC#2)
// mouseThreshold = "_-0OA" (String#4051, DoABC#2)
// disposesBitmap = "_-03U" (String#3637, DoABC#2)
// ITab = "_-05I" (String#3671, DoABC#2)
// _SafeStr_7434 = "_-2xA" (String#21356, DoABC#2)
// _SafeStr_7443 = "_-0YX" (String#15382, DoABC#2)
// _SafeStr_7538 = "_-1Ah" (String#1627, DoABC#2)
// _SafeStr_7540 = "_-1l4" (String#444, DoABC#2)
// _SafeStr_7569 = "_-2vP" (String#21293, DoABC#2)
// _SafeStr_9007 = "_-iG" (String#2163, DoABC#2)
// _SafeStr_9008 = "_-hz" (String#2162, DoABC#2)
// allocate = "_-08G" (String#14374, DoABC#2)
// _SafeStr_9310 = "_-2-h" (String#19000, DoABC#2)
// _recycled = "_-2vB" (String#1963, DoABC#2)


