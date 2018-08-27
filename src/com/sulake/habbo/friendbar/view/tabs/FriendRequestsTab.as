
package com.sulake.habbo.friendbar.view.tabs
{
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.components.IBubbleWindow;
    import com.sulake.core.window.components.IItemListWindow;
    import com.sulake.habbo.friendbar.data.FriendRequest;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import flash.display.BitmapData;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.components.ITextWindow;
    import com.sulake.core.assets.BitmapDataAsset;
    import com.sulake.core.window.components.IRegionWindow;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.window.events.WindowEvent;

    public class FriendRequestsTab extends Tab 
    {

        protected static const _SafeStr_11022:String = "friend_requests_tab_xml";
        protected static const ICON:String = "icon";
        protected static const _SafeStr_7515:String = "label";
        protected static const _SafeStr_7540:String = "header";
        protected static const _SafeStr_10988:String = "canvas";
        protected static const _SafeStr_7538:String = "bubble";
        protected static const _SafeStr_11023:String = "request_entity_list";
        protected static const _SafeStr_8785:String = "name";
        protected static const _SafeStr_11024:String = "badge_counter";
        protected static const _SafeStr_11025:String = "button_accept_all";
        protected static const _SafeStr_11026:String = "click_area_discard_all";
        protected static const _SafeStr_11027:String = "button_close";
        protected static const _SafeStr_11028:String = "button_accept";
        protected static const _SafeStr_11029:String = "click_area_discard";
        protected static const _SafeStr_11030:String = "text_discard";
        private static var _SafeStr_11031:FriendRequestsTab;
        private static const _SafeStr_4861:uint = 4294625561;
        private static const _SafeStr_11032:uint = 0xFFFFD966;
        private static const _SafeStr_11033:uint = 4289431312;
        private static const _SafeStr_11034:uint = 4290616362;
        private static const REGION_REJECT_COLOR_EXPOSED:uint = 16770666;
        private static const _SafeStr_11035:uint = 0xFFFFFF;

        private var _requests:Array;
        private var _SafeStr_11036:Boolean = false;
        private var _SafeStr_11037:IWindowContainer;

        public function FriendRequestsTab()
        {
            _window = this.allocateRequestsTabWindow();
        }
        public static function allocate(_arg_1:Array):FriendRequestsTab
        {
            var _local_2:FriendRequestsTab = ((_SafeStr_11031) ? _SafeStr_11031 : new (FriendRequestsTab)());
            _local_2._recycled = false;
            _local_2._requests = _arg_1;
            _local_2._window.findChildByName(_SafeStr_11024).caption = String(_arg_1.length);
            return (_local_2);
        }

        override public function dispose():void
        {
            if (_window){
                this.releaseRequestsTabWindow(_window);
                _window = null;
            };
            if (this._SafeStr_11037){
                this._SafeStr_11037.dispose();
                this._SafeStr_11037 = null;
            };
            super.dispose();
        }
        override public function recycle():void
        {
            var _local_1:IBubbleWindow;
            var _local_2:IItemListWindow;
            if (!disposed){
                if (!_recycled){
                    if (_window){
                        _local_1 = (_window.findChildByName(_SafeStr_7538) as IBubbleWindow);
                        if (_local_1){
                            _local_2 = (_local_1.content.getChildByName(_SafeStr_11023) as IItemListWindow);
                            if (_local_2){
                                while (_local_2.numListItems > 0) {
                                    _local_2.removeListItemAt(0).dispose();
                                };
                            };
                        };
                    };
                    this._SafeStr_11036 = false;
                    this._requests = null;
                    _recycled = true;
                    _SafeStr_11031 = this;
                };
            };
        }
        override public function select(_arg_1:Boolean):void
        {
            var _local_2:IBubbleWindow;
            var _local_3:IItemListWindow;
            var _local_4:IWindowContainer;
            var _local_5:FriendRequest;
            var _local_6:IBitmapWrapperWindow;
            var _local_7:int;
            var _local_8:int;
            var _local_9:BitmapData;
            if (!selected){
                if (_window){
                    _local_2 = (_window.findChildByName(_SafeStr_7538) as IBubbleWindow);
                    if (_local_2){
                        _local_2.visible = true;
                        if (!this._SafeStr_11036){
                            _local_3 = (_local_2.content.getChildByName(_SafeStr_11023) as IItemListWindow);
                            if (_local_3){
                                _local_7 = 0;
                                _local_8 = 0;
                                while (_local_8 < this._requests.length) {
                                    _local_4 = (this._SafeStr_11037.clone() as IWindowContainer);
                                    _local_4.color = ((((_local_8 % 2) == 0)) ? _SafeStr_11033 : _SafeStr_11034);
                                    _local_5 = this._requests[_local_8];
                                    _local_4.id = _local_5.id;
                                    _local_4.getChildByName(_SafeStr_8785).caption = _local_5.name;
                                    _local_6 = (_local_4.getChildByName(_SafeStr_10988) as IBitmapWrapperWindow);
                                    _local_9 = _SafeStr_11014.getAvatarFaceBitmap(_local_5.figure);
                                    if (_local_9){
                                        _local_6.disposesBitmap = false;
                                        _local_6.bitmap = _local_9;
                                        _local_6.width = _local_9.width;
                                        _local_6.height = _local_9.height;
                                        _local_6.disposesBitmap = true;
                                    };
                                    _local_3.addListItem(_local_4);
                                    _local_7 = (_local_7 + (_local_4.height + _local_3.spacing));
                                    _local_8++;
                                };
                                _local_3.height = _local_7;
                            };
                        };
                        this._SafeStr_11036 = true;
                    };
                };
                super.select(_arg_1);
            };
        }
        override public function deselect(_arg_1:Boolean):void
        {
            var _local_2:IWindow;
            if (selected){
                if (_window){
                    _local_2 = _window.findChildByName(_SafeStr_7538);
                    if (_local_2){
                        _local_2.visible = false;
                    };
                };
                super.deselect(_arg_1);
            };
        }
        override protected function expose():void
        {
            super.expose();
            _window.color = ((exposed) ? _SafeStr_11032 : _SafeStr_4861);
            ITextWindow(_window.findChildByTag(_SafeStr_7515)).underline = exposed;
        }
        override protected function conceal():void
        {
            super.conceal();
            _window.color = ((exposed) ? _SafeStr_11032 : _SafeStr_4861);
            ITextWindow(_window.findChildByTag(_SafeStr_7515)).underline = exposed;
        }
        private function allocateRequestsTabWindow():IWindowContainer
        {
            var _local_5:BitmapDataAsset;
            var _local_1:IWindowContainer = (WINDOWING.buildFromXML((ASSETS.getAssetByName(_SafeStr_11022).content as XML)) as IWindowContainer);
            var _local_2:IBitmapWrapperWindow = IBitmapWrapperWindow(_local_1.findChildByName(_SafeStr_10988));
            var _local_3:IRegionWindow = IRegionWindow(_local_1.findChildByName(_SafeStr_7540));
            var _local_4:IBubbleWindow = (_local_1.findChildByName(_SafeStr_7538) as IBubbleWindow);
            _local_1.x = 0;
            _local_1.y = 0;
            _local_1.width = _SafeStr_9007;
            _local_1.height = _SafeStr_9008;
            _local_1.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, onMouseClick);
            _local_1.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_OVER, onMouseOver);
            _local_1.addEventListener(WindowMouseEvent.WME_OUT, onMouseOut);
            _local_3.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, onMouseClick);
            _local_3.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_OVER, onMouseOver);
            _local_3.addEventListener(WindowMouseEvent.WME_OUT, onMouseOut);
            _local_2.disposesBitmap = true;
            _local_4.visible = false;
            _local_4.y = (-((_local_4.height - (_local_4.height - _local_4.margins.bottom))) - 1);
            _local_4.procedure = this.bubbleEventProc;
            _local_5 = (ASSETS.getAssetByName("add_friends_icon_png") as BitmapDataAsset);
            var _local_6:IBitmapWrapperWindow = (_local_1.findChildByName(ICON) as IBitmapWrapperWindow);
            _local_6.disposesBitmap = false;
            _local_6.bitmap = (_local_5.content as BitmapData);
            var _local_7:IItemListWindow = (_local_4.content.getChildByName(_SafeStr_11023) as IItemListWindow);
            this._SafeStr_11037 = (_local_7.removeListItemAt(0) as IWindowContainer);
            return (_local_1);
        }
        private function releaseRequestsTabWindow(_arg_1:IWindowContainer):void
        {
            var _local_2:IRegionWindow;
            var _local_3:IBitmapWrapperWindow;
            if (((_arg_1) && (!(_arg_1.disposed)))){
                _arg_1.procedure = null;
                _arg_1.removeEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, onMouseClick);
                _arg_1.removeEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_OVER, onMouseOver);
                _arg_1.removeEventListener(WindowMouseEvent.WME_OUT, onMouseOut);
                _local_2 = IRegionWindow(_arg_1.findChildByName(_SafeStr_7540));
                _local_2.removeEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, onMouseClick);
                _local_2.removeEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_OVER, onMouseOver);
                _local_2.removeEventListener(WindowMouseEvent.WME_OUT, onMouseOut);
                _arg_1.width = _SafeStr_9007;
                _arg_1.height = _SafeStr_9008;
                _arg_1.color = _SafeStr_4861;
                _local_3 = IBitmapWrapperWindow(_arg_1.findChildByName(_SafeStr_10988));
                _local_3.bitmap = null;
                ITextWindow(_arg_1.findChildByTag(_SafeStr_7515)).underline = false;
            };
        }
        private function bubbleEventProc(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type == WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK){
                switch (_arg_2.name){
                    case _SafeStr_11027:
                        if (selected){
                            _SafeStr_11014.deSelect(true);
                        };
                        break;
                    case _SafeStr_11025:
                        _SafeStr_11013.acceptAllFriendRequests();
                        break;
                    case _SafeStr_11026:
                        _SafeStr_11013.declineAllFriendRequests();
                        break;
                    case _SafeStr_11028:
                        _SafeStr_11013.acceptFriendRequest(_arg_2.parent.id);
                        break;
                    case _SafeStr_11029:
                        _SafeStr_11013.declineFriendRequest(_arg_2.parent.id);
                        break;
                };
            }
            else {
                if (_arg_1.type == WindowMouseEvent.WINDOW_EVENT_MOUSE_OVER){
                    if (_arg_2.name == _SafeStr_11029){
                        ITextWindow(IWindowContainer(_arg_2).getChildByName(_SafeStr_11030)).textColor = REGION_REJECT_COLOR_EXPOSED;
                    };
                }
                else {
                    if (_arg_1.type == WindowMouseEvent.WME_OUT){
                        if (_arg_2.name == _SafeStr_11029){
                            ITextWindow(IWindowContainer(_arg_2).getChildByName(_SafeStr_11030)).textColor = _SafeStr_11035;
                        };
                    };
                };
            };
        }
        public function avatarImageReady(_arg_1:FriendRequest, _arg_2:BitmapData):void
        {
            var _local_4:IItemListWindow;
            var _local_5:IWindowContainer;
            var _local_6:int;
            var _local_7:IBitmapWrapperWindow;
            if (disposed){
                return;
            };
            var _local_3:IBubbleWindow = (_window.findChildByName(_SafeStr_7538) as IBubbleWindow);
            if (_local_3){
                _local_4 = (_local_3.content.getChildByName(_SafeStr_11023) as IItemListWindow);
                if (_local_4){
                    _local_6 = 0;
                    while (_local_6 < _local_4.numListItems) {
                        _local_5 = (_local_4.getListItemAt(_local_6) as IWindowContainer);
                        if (_local_5.id == _arg_1.id){
                            _local_7 = (_local_5.getChildByName(_SafeStr_10988) as IBitmapWrapperWindow);
                            _local_7.disposesBitmap = true;
                            _local_7.bitmap = _arg_2;
                            _local_7.width = _arg_2.width;
                            _local_7.height = _arg_2.height;
                            return;
                        };
                        _local_6++;
                    };
                };
            };
        }

    }
}//package com.sulake.habbo.friendbar.view.tabs

// ASSETS = "_-391" (String#21846, DoABC#2)
// _SafeStr_10988 = "_-IE" (String#933, DoABC#2)
// WINDOWING = "_-03b" (String#14186, DoABC#2)
// _SafeStr_11013 = "_-1BC" (String#16905, DoABC#2)
// _SafeStr_11014 = "_-CV" (String#22705, DoABC#2)
// exposed = "_-Gs" (String#22885, DoABC#2)
// conceal = "_-zo" (String#644, DoABC#2)
// expose = "_-3K" (String#634, DoABC#2)
// _SafeStr_11022 = "_-2jn" (String#20838, DoABC#2)
// _SafeStr_11023 = "_-0kc" (String#15853, DoABC#2)
// _SafeStr_11024 = "_-2sZ" (String#21183, DoABC#2)
// _SafeStr_11025 = "_-06e" (String#14312, DoABC#2)
// _SafeStr_11026 = "_-NC" (String#23132, DoABC#2)
// _SafeStr_11027 = "_-2Zb" (String#894, DoABC#2)
// _SafeStr_11028 = "_-zN" (String#8866, DoABC#2)
// _SafeStr_11029 = "_-00E" (String#14064, DoABC#2)
// _SafeStr_11030 = "_-c" (String#23712, DoABC#2)
// _SafeStr_11031 = "_-21i" (String#6077, DoABC#2)
// _SafeStr_11032 = "_-28d" (String#878, DoABC#2)
// _SafeStr_11033 = "_-2Na" (String#19947, DoABC#2)
// _SafeStr_11034 = "_-MA" (String#23090, DoABC#2)
// _SafeStr_11035 = "_-AK" (String#7873, DoABC#2)
// _SafeStr_11036 = "_-2x9" (String#21355, DoABC#2)
// _SafeStr_11037 = "_-2yb" (String#21413, DoABC#2)
// allocateRequestsTabWindow = "_-0uM" (String#16215, DoABC#2)
// releaseRequestsTabWindow = "_-07u" (String#14360, DoABC#2)
// bubbleEventProc = "_-11r" (String#4913, DoABC#2)
// WindowEvent = "_-Jh" (String#2085, DoABC#2)
// BitmapDataAsset = "_-0PB" (String#4074, DoABC#2)
// IRegionWindow = "_-dg" (String#2146, DoABC#2)
// FriendRequest = "_-2Nq" (String#887, DoABC#2)
// Tab = "_-Cd" (String#930, DoABC#2)
// IBubbleWindow = "_-24" (String#6122, DoABC#2)
// FriendRequestsTab = "_-1f2" (String#5644, DoABC#2)
// WME_OUT = "_-0h2" (String#15712, DoABC#2)
// onMouseOver = "_-21W" (String#613, DoABC#2)
// onMouseOut = "_-1ap" (String#608, DoABC#2)
// onMouseClick = "_-0Kd" (String#584, DoABC#2)
// _SafeStr_4861 = "_-0CJ" (String#582, DoABC#2)
// avatarImageReady = "_-i" (String#8553, DoABC#2)
// disposesBitmap = "_-03U" (String#3637, DoABC#2)
// deselect = "_-05I" (String#3671, DoABC#2)
// removeListItemAt = "_-Td" (String#8279, DoABC#2)
// _SafeStr_7515 = "_-1xV" (String#871, DoABC#2)
// _SafeStr_7538 = "_-1Ah" (String#1627, DoABC#2)
// _SafeStr_7540 = "_-1l4" (String#444, DoABC#2)
// _SafeStr_8785 = "_-1OX" (String#605, DoABC#2)
// _SafeStr_9007 = "_-iG" (String#2163, DoABC#2)
// _SafeStr_9008 = "_-hz" (String#2162, DoABC#2)
// allocate = "_-08G" (String#14374, DoABC#2)
// _recycled = "_-2vB" (String#1963, DoABC#2)


