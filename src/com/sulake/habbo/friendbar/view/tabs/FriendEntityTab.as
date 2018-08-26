
package com.sulake.habbo.friendbar.view.tabs
{
    import __AS3__.vec.Vector;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.friendbar.data.IFriendEntity;
    import com.sulake.habbo.friendbar.view.tabs.tokens.Token;
    import com.sulake.habbo.friendbar.data.FriendNotification;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.components.IItemListWindow;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import com.sulake.core.window.components.ITextWindow;
    import flash.display.BitmapData;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.habbo.tracking.HabboTracking;
    import com.sulake.core.window.components.IRegionWindow;
    import com.sulake.habbo.friendbar.view.tabs.tokens.RoomEventToken;
    import com.sulake.habbo.friendbar.view.tabs.tokens.AchievementToken;
    import com.sulake.habbo.friendbar.view.tabs.tokens.QuestToken;
    import com.sulake.habbo.friendbar.view.tabs.tokens.MessengerToken;
    import flash.utils.getQualifiedClassName;
    import __AS3__.vec.*;

    public class FriendEntityTab extends Tab 
    {

        private static const _SafeStr_11054:String = "entity_xml";
        private static const _SafeStr_11055:String = "facebook_piece_xml";
        private static const _SafeStr_11056:String = "controls_piece_xml";
        protected static const _SafeStr_11057:String = "pieces";
        protected static const _SafeStr_11047:String = "icons";
        protected static const _SafeStr_7540:String = "header";
        protected static const _SafeStr_11058:String = "facebook";
        protected static const _SafeStr_11059:String = "controls";
        protected static const _SafeStr_10988:String = "canvas";
        protected static const _SafeStr_8785:String = "name";
        protected static const _SafeStr_10986:String = "btn_message";
        protected static const _SafeStr_11060:String = "icon_message";
        protected static const _SafeStr_11061:String = "btn_visit";
        protected static const ICON:String = "icon";
        protected static const _SafeStr_7515:String = "label";
        protected static const RWUNE_NOTIFICATION:String = "notification";
        private static const _SafeStr_4861:uint = 10338138;
        private static const _SafeStr_11032:uint = 13891476;
        private static const _SafeStr_11062:String = null;
        private static const _SafeStr_11063:String = "icon_tag_notify";
        private static const _SafeStr_11064:String = "icon_tag_message";
        private static const POOL:Vector.<FriendEntityTab> = new Vector.<FriendEntityTab>();
        private static const _SafeStr_11065:Vector.<IWindowContainer> = new Vector.<IWindowContainer>();

        protected var _friend:IFriendEntity;
        protected var _SafeStr_11066:Vector.<Token>;

        public static function allocate(_arg_1:IFriendEntity):FriendEntityTab
        {
            var _local_3:FriendNotification;
            var _local_2:FriendEntityTab = (((POOL.length > 0)) ? POOL.pop() : new (FriendEntityTab)());
            _local_2._recycled = false;
            _local_2.friend = _arg_1;
            if (_arg_1.notifications.length > 0){
                for each (_local_3 in _arg_1.notifications) {
                    _local_2.addNotificationToken(_local_3, false);
                };
            };
            return (_local_2);
        }
        private static function purgeEntityPieces(_arg_1:IWindowContainer):void
        {
            var _local_3:IWindowContainer;
            var _local_5:IWindow;
            var _local_2:IItemListWindow = IItemListWindow(_arg_1.getChildByName(_SafeStr_11057));
            _local_3 = (_local_2.getListItemByName(_SafeStr_11058) as IWindowContainer);
            if (_local_3){
                _local_3.dispose();
            };
            _local_3 = (_local_2.getListItemByName(_SafeStr_11059) as IWindowContainer);
            if (_local_3){
                _local_3.dispose();
            };
            var _local_4:Array = [];
            _local_2.IItemListWindow(RWUNE_NOTIFICATION, _local_4);
            if (_local_4.length > 0){
                for each (_local_5 in _local_4) {
                    _local_5.parent = null;
                };
            };
            _arg_1.height = _SafeStr_9008;
            _arg_1.y = 0;
        }

        public function set friend(_arg_1:IFriendEntity):void
        {
            this._friend = _arg_1;
            this.refresh();
        }
        public function get friend():IFriendEntity
        {
            return (this._friend);
        }
        override public function recycle():void
        {
            if (!disposed){
                if (!_recycled){
                    if (_window){
                        this.releaseFriendTabWindow(_window);
                        _window = null;
                    };
                    if (this._SafeStr_11066){
                        while (this._SafeStr_11066.length > 0) {
                            this._SafeStr_11066.pop().dispose();
                        };
                        this._SafeStr_11066 = null;
                    };
                    this._friend = null;
                    _recycled = true;
                    POOL.push(this);
                };
            };
        }
        override public function select(_arg_1:Boolean):void
        {
            var _local_2:IItemListWindow;
            var _local_3:IWindowContainer;
            var _local_4:IBitmapWrapperWindow;
            var _local_5:Boolean;
            var _local_6:ITextWindow;
            var _local_7:Token;
            var _local_8:IWindow;
            if (!selected){
                _local_2 = IItemListWindow(window.getChildByName(_SafeStr_11057));
                _local_5 = false;
                if (((!((this.friend.realName == null))) && (!((this.friend.realName == ""))))){
                    _local_3 = (WINDOWING.buildFromXML((ASSETS.getAssetByName(_SafeStr_11055).content as XML)) as IWindowContainer);
                    _local_3.name = _SafeStr_11058;
                    _local_6 = (_local_3.getChildByName(_SafeStr_8785) as ITextWindow);
                    _local_6.caption = this.friend.realName;
                    if (!_local_6.wordWrap){
                        _SafeStr_11016.crop(_local_6);
                    };
                    _local_4 = IBitmapWrapperWindow(_local_3.getChildByName(ICON));
                    _local_4.bitmap = (ASSETS.getAssetByName(_local_4.bitmapAssetName).content as BitmapData);
                    _local_4.width = _local_4.bitmap.width;
                    _local_4.height = _local_4.bitmap.height;
                    _local_2.addListItem(_local_3);
                    _local_5 = true;
                };
                if (this._SafeStr_11066){
                    for each (_local_7 in this._SafeStr_11066) {
                        _local_2.addListItem(_local_7.windowElement);
                        _local_5 = true;
                    };
                };
                if (this.friend.online){
                    _local_3 = (WINDOWING.buildFromXML((ASSETS.getAssetByName(_SafeStr_11056).content as XML)) as IWindowContainer);
                    _local_3.name = _SafeStr_11059;
                    _local_8 = _local_3.getChildByName(_SafeStr_10986);
                    if (_local_8){
                        _local_8.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onButtonClick);
                    };
                    _local_8 = _local_3.getChildByName(_SafeStr_11061);
                    if (_local_8){
                        if (this.friend.allowFollow){
                            _local_8.visible = true;
                            _local_8.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onButtonClick);
                        }
                        else {
                            _local_8.visible = false;
                        };
                    };
                    _local_2.addListItem(_local_3);
                    _local_5 = true;
                };
                if (_local_5){
                    window.height = _local_2.height;
                };
                window.y = (_SafeStr_9008 - window.height);
                super.select(_arg_1);
                if (_arg_1){
                    HabboTracking.getInstance().trackEventLog("FriendBar", "", "clicked", "", (((this.friend.logEventId > 0)) ? this.friend.logEventId : 0));
                    this.friend.logEventId = -1;
                };
            };
        }
        override public function ITab(_arg_1:Boolean):void
        {
            var _local_2:int;
            var _local_3:Token;
            if (selected){
                if (_window){
                    purgeEntityPieces(_window);
                    if (this._SafeStr_11066){
                        _local_2 = (this._SafeStr_11066.length - 1);
                        while (_local_2 > -1) {
                            _local_3 = this._SafeStr_11066[_local_2];
                            if (_local_3.viewOnce){
                                this.removeNotificationToken(_local_3.typeCode, _arg_1);
                            };
                            _local_2--;
                        };
                    };
                };
                super.ITab(_arg_1);
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
        protected function refresh():void
        {
            var _local_1:IWindowContainer;
            var _local_2:IBitmapWrapperWindow;
            if (!_window){
                _window = this.allocateFriendTabWindow();
            };
            if (this._friend){
                _window.id = this._friend.id;
                _local_1 = (IItemListWindow(_window.getChildByName(_SafeStr_11057)).getListItemByName(_SafeStr_7540) as IWindowContainer);
                _local_1.findChildByName(_SafeStr_8785).caption = this._friend.name;
                _SafeStr_11016.crop((_local_1.getChildByName(_SafeStr_8785) as ITextWindow));
                _local_2 = IBitmapWrapperWindow(_local_1.findChildByName(_SafeStr_10988));
                _local_2.bitmap = _SafeStr_11014.getAvatarFaceBitmap(this._friend.figure);
                _local_2.width = _local_2.bitmap.width;
                _local_2.height = _local_2.bitmap.height;
            };
        }
        private function allocateFriendTabWindow():IWindowContainer
        {
            var _local_1:IWindowContainer = (((_SafeStr_11065.length > 0)) ? _SafeStr_11065.pop() : (WINDOWING.buildFromXML((ASSETS.getAssetByName(_SafeStr_11054).content as XML)) as IWindowContainer));
            var _local_2:IBitmapWrapperWindow = IBitmapWrapperWindow(_local_1.findChildByName(_SafeStr_10988));
            var _local_3:IRegionWindow = IRegionWindow(_local_1.findChildByName(_SafeStr_7540));
            var _local_4:IWindow = _local_1.findChildByName(_SafeStr_11047);
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
            return (_local_1);
        }
        private function releaseFriendTabWindow(_arg_1:IWindowContainer):void
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
                purgeEntityPieces(_arg_1);
                if (_SafeStr_11065.indexOf(_arg_1) == -1){
                    _SafeStr_11065.push(_arg_1);
                };
            };
        }
        private function onButtonClick(_arg_1:WindowMouseEvent):void
        {
            if (((!(disposed)) && (!(recycled)))){
                switch (_arg_1.window.name){
                    case _SafeStr_10986:
                    case _SafeStr_11060:
                        this.removeNotificationToken(FriendNotification._SafeStr_10917, true);
                        if (((_SafeStr_11013) && (this._friend))){
                            _SafeStr_11013.startConversation(this._friend.id);
                            this.ITab(true);
                            if (_arg_1.window.name == _SafeStr_11060){
                                _SafeStr_11014.setMessengerIconNotify(false);
                            };
                        };
                        return;
                    case _SafeStr_11061:
                        if (((_SafeStr_11013) && (this._friend))){
                            _SafeStr_11013.followToRoom(this._friend.id);
                            this.ITab(true);
                        };
                        return;
                };
            };
        }
        public function addNotificationToken(_arg_1:FriendNotification, _arg_2:Boolean):void
        {
            var _local_4:Token;
            var _local_6:Vector.<Token>;
            var _local_7:IItemListWindow;
            var _local_8:IWindow;
            this.removeNotificationToken(_arg_1.typeCode, false);
            if (!this._SafeStr_11066){
                this._SafeStr_11066 = new Vector.<Token>();
            };
            var _local_3:Boolean = selected;
            if (_local_3){
                _local_6 = this._SafeStr_11066;
                this._SafeStr_11066 = null;
                this.ITab(false);
                this._SafeStr_11066 = _local_6;
            };
            var _local_5:String = _SafeStr_11062;
            switch (_arg_1.typeCode){
                case FriendNotification._SafeStr_10926:
                    _local_4 = new RoomEventToken(this.friend, _arg_1, _arg_2);
                    _local_4.iconElement.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, WelcomeScreenController);
                    _local_5 = _SafeStr_11063;
                    break;
                case FriendNotification.TYPE_ACHIEVEMENT:
                    _local_4 = new AchievementToken(this.friend, _arg_1, _arg_2, _SafeStr_11015);
                    _local_4.iconElement.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, WelcomeScreenController);
                    _local_5 = _SafeStr_11063;
                    break;
                case FriendNotification._SafeStr_10927:
                    _local_4 = new QuestToken(this.friend, _arg_1, _arg_2, _SafeStr_11015);
                    _local_4.iconElement.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, WelcomeScreenController);
                    _local_5 = _SafeStr_11063;
                    break;
                case FriendNotification._SafeStr_10917:
                    _local_4 = new MessengerToken(this.friend, _arg_1, _arg_2);
                    _local_4.iconElement.name = _SafeStr_11060;
                    _local_4.iconElement.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onButtonClick);
                    _local_5 = _SafeStr_11064;
                    break;
                default:
                    throw (new Error((("Unknown friend notification type: " + _arg_1.typeCode) + "!")));
            };
            if (_local_4){
                this._SafeStr_11066.push(_local_4);
                if (_local_5 != _SafeStr_11062){
                    _local_7 = IItemListWindow(_window.findChildByName(_SafeStr_11047));
                    if (!_local_7.IItemListWindow(_local_5)){
                        _local_8 = _local_4.iconElement;
                        if (_local_8.tags.indexOf(_local_5) == -1){
                            _local_8.tags.push(_local_5);
                        };
                        _local_7.IItemListWindow(_local_8, 0);
                    };
                };
            };
            if (_local_3){
                this.select(false);
            };
        }
        public function removeNotificationToken(_arg_1:int, _arg_2:Boolean):void
        {
            var _local_4:Token;
            if (!this._SafeStr_11066){
                return;
            };
            var _local_3:int = (this._SafeStr_11066.length - 1);
            while (_local_3 > -1) {
                _local_4 = this._SafeStr_11066[_local_3];
                if (_local_4.typeCode == _arg_1){
                    this._SafeStr_11066.splice(_local_3, 1);
                    if (_arg_2){
                        this._friend.notifications.splice(this._friend.notifications.indexOf(_local_4.notification), 1);
                    };
                    _local_4.dispose();
                    return;
                };
                _local_3--;
            };
        }
        public function toString():String
        {
            return (((getQualifiedClassName(this) + " ") + this._friend.name));
        }

    }
}//package com.sulake.habbo.friendbar.view.tabs

// allowFollow = "_-1Va" (String#5466, DoABC#2)
// _SafeStr_10917 = "_-0Pj" (String#15051, DoABC#2)
// notifications = "_-1zJ" (String#1789, DoABC#2)
// viewOnce = "_-3JO" (String#22260, DoABC#2)
// logEventId = "_-Vm" (String#8316, DoABC#2)
// _SafeStr_10926 = "_-hv" (String#23961, DoABC#2)
// _SafeStr_10927 = "_-0RU" (String#15120, DoABC#2)
// ASSETS = "_-391" (String#21846, DoABC#2)
// _SafeStr_10986 = "_-34f" (String#629, DoABC#2)
// _SafeStr_10988 = "_-IE" (String#933, DoABC#2)
// recycled = "_-0Zq" (String#4294, DoABC#2)
// WINDOWING = "_-03b" (String#14186, DoABC#2)
// iconElement = "_-W3" (String#23495, DoABC#2)
// windowElement = "_-0VI" (String#15255, DoABC#2)
// _SafeStr_11013 = "_-1BC" (String#16905, DoABC#2)
// _SafeStr_11014 = "_-CV" (String#22705, DoABC#2)
// _SafeStr_11015 = "_-2ci" (String#20552, DoABC#2)
// _SafeStr_11016 = "_-1px" (String#18540, DoABC#2)
// exposed = "_-Gs" (String#22885, DoABC#2)
// conceal = "_-zo" (String#644, DoABC#2)
// expose = "_-3K" (String#634, DoABC#2)
// _SafeStr_11032 = "_-28d" (String#878, DoABC#2)
// _friend = "_-0mY" (String#15919, DoABC#2)
// _SafeStr_11047 = "_-0IQ" (String#14777, DoABC#2)
// _SafeStr_11054 = "_-m1" (String#24112, DoABC#2)
// _SafeStr_11055 = "_-1G4" (String#17117, DoABC#2)
// _SafeStr_11056 = "_-1Bh" (String#16929, DoABC#2)
// _SafeStr_11057 = "_-276" (String#6186, DoABC#2)
// _SafeStr_11058 = "_-NS" (String#23143, DoABC#2)
// _SafeStr_11059 = "_-0Jx" (String#14838, DoABC#2)
// _SafeStr_11060 = "_-0AG" (String#14458, DoABC#2)
// _SafeStr_11061 = "_-0no" (String#15969, DoABC#2)
// _SafeStr_11062 = "_-jW" (String#24019, DoABC#2)
// _SafeStr_11063 = "_-2Bz" (String#19481, DoABC#2)
// _SafeStr_11064 = "_-2e" (String#20602, DoABC#2)
// _SafeStr_11065 = "_-WL" (String#23504, DoABC#2)
// _SafeStr_11066 = "_-1uH" (String#18728, DoABC#2)
// addNotificationToken = "_-0Wf" (String#15303, DoABC#2)
// purgeEntityPieces = "_-0b6" (String#15479, DoABC#2)
// releaseFriendTabWindow = "_-2jY" (String#20827, DoABC#2)
// removeNotificationToken = "_-yA" (String#24621, DoABC#2)
// allocateFriendTabWindow = "_-116" (String#16502, DoABC#2)
// IRegionWindow = "_-dg" (String#2146, DoABC#2)
// Tab = "_-Cd" (String#930, DoABC#2)
// IFriendEntity = "_-2nQ" (String#7031, DoABC#2)
// MessengerToken = "_-1ao" (String#5574, DoABC#2)
// RoomEventToken = "_-2wU" (String#7213, DoABC#2)
// AchievementToken = "_-2Zn" (String#6755, DoABC#2)
// QuestToken = "_-8N" (String#7829, DoABC#2)
// realName = "_-3HH" (String#922, DoABC#2)
// IItemListWindow = "_-2CT" (String#6293, DoABC#2)
// trackEventLog = "_-0ML" (String#14927, DoABC#2)
// getInstance = "_-n5" (String#24157, DoABC#2)
// WME_OUT = "_-0h2" (String#15712, DoABC#2)
// refresh = "_-s9" (String#189, DoABC#2)
// ClubGiftNotification = "_-21W" (String#613, DoABC#2)
// ClubGiftNotification = "_-1ap" (String#608, DoABC#2)
// WelcomeScreenController = "_-0Kd" (String#584, DoABC#2)
// typeCode = "_-vq" (String#24522, DoABC#2)
// _SafeStr_4861 = "_-0CJ" (String#582, DoABC#2)
// disposesBitmap = "_-03U" (String#3637, DoABC#2)
// IItemListWindow = "_-0gQ" (String#4432, DoABC#2)
// ITab = "_-05I" (String#3671, DoABC#2)
// RWUNE_NOTIFICATION = "_-0Vj" (String#4221, DoABC#2)
// _SafeStr_7515 = "_-1xV" (String#871, DoABC#2)
// _SafeStr_7540 = "_-1l4" (String#444, DoABC#2)
// onButtonClick = "_-1S0" (String#1689, DoABC#2)
// _SafeStr_8785 = "_-1OX" (String#605, DoABC#2)
// _SafeStr_9007 = "_-iG" (String#2163, DoABC#2)
// _SafeStr_9008 = "_-hz" (String#2162, DoABC#2)
// allocate = "_-08G" (String#14374, DoABC#2)
// bitmapAssetName = "_-1XS" (String#5507, DoABC#2)
// IItemListWindow = "_-Ml" (String#8136, DoABC#2)
// _recycled = "_-2vB" (String#1963, DoABC#2)


