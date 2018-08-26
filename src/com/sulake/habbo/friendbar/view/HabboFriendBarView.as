
package com.sulake.habbo.friendbar.view
{
    import com.sulake.habbo.avatar.IAvatarImageListener;
    import com.sulake.habbo.friendbar.data.IHabboFriendBarData;
    import com.sulake.core.window.IWindowContainer;
    import __AS3__.vec.Vector;
    import com.sulake.habbo.friendbar.view.tabs.ITab;
    import com.sulake.habbo.friendbar.view.utils.TextCropper;
    import com.sulake.habbo.friendbar.view.utils.FriendListIcon;
    import com.sulake.habbo.friendbar.view.utils.MessengerIcon;
    import com.sulake.habbo.friendbar.view.utils.StreamIcon;
    import com.sulake.iid.IIDHabboFriendBarData;
    import com.sulake.habbo.friendbar.HabboFriendBar;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.habbo.friendbar.events.FriendBarUpdateEvent;
    import com.sulake.habbo.friendbar.events.FindFriendsNotificationEvent;
    import com.sulake.habbo.friendbar.events.FriendRequestUpdateEvent;
    import com.sulake.habbo.friendbar.events.NewMessageEvent;
    import com.sulake.habbo.friendbar.events.NotificationEvent;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.habbo.friendbar.data.FriendRequest;
    import com.sulake.habbo.friendbar.data.IFriendEntity;
    import com.sulake.habbo.friendbar.view.tabs.Tab;
    import com.sulake.core.window.components.IItemListWindow;
    import com.sulake.habbo.friendbar.view.tabs.FriendRequestTab;
    import com.sulake.habbo.friendbar.view.tabs.FriendRequestsTab;
    import com.sulake.habbo.friendbar.view.tabs.FriendEntityTab;
    import com.sulake.habbo.friendbar.view.tabs.AddFriendsTab;
    import com.sulake.core.runtime.IID;
    import com.sulake.core.runtime.IUnknown;
    import com.sulake.habbo.friendbar.view.tabs.tokens.Token;
    import com.sulake.core.assets.IAsset;
    import com.sulake.core.window.enum.WindowParam;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import flash.display.BitmapData;
    import com.sulake.habbo.avatar.IAvatarImage;
    import com.sulake.habbo.avatar.enum.AvatarScaleType;
    import com.sulake.habbo.avatar.enum.AvatarSetType;
    import flash.events.Event;
    import com.sulake.habbo.window.utils.IAlertDialog;
    import com.sulake.habbo.window.enum.HabboAlertDialogFlag;
    import com.sulake.core.window.IWindow;
    import com.sulake.habbo.friendbar.view.utils.Icon;
    import __AS3__.vec.*;

    public class HabboFriendBarView extends AbstractView implements IHabboFriendBarView, IAvatarImageListener 
    {

        private static const _SafeStr_11078:int = 127;
        private static const _SafeStr_11079:int = 1;
        private static const _SafeStr_11080:int = 2;
        private static const _SafeStr_11081:int = 3;
        private static const _SafeStr_11082:int = 3;
        private static const _SafeStr_11083:Boolean = false;
        private static const _SafeStr_11084:int = 3;
        private static const _SafeStr_11085:String = "arrow";
        private static const _SafeStr_11086:String = "left";
        private static const _SafeStr_11087:String = "right";
        private static const _SafeStr_11088:String = "bar_xml";
        private static const _SafeStr_11089:String = "toggle_xml";
        private static const _SafeStr_3728:String = "container";
        private static const _SafeStr_11090:String = "wrapper";
        private static const _SafeStr_7574:String = "border";
        private static const _SafeStr_10932:String = "list";
        private static const _SafeStr_7540:String = "header";
        private static const _SafeStr_10988:String = "canvas";
        private static const ICON:String = "icon";
        private static const _SafeStr_11057:String = "pieces";
        private static const _SafeStr_11091:String = "button_left";
        private static const BUTTON_RIGHT_SINGLE:String = "button_right";
        private static const _SafeStr_11092:String = "button_left_page";
        private static const _SafeStr_11093:String = "button_right_page";
        private static const _SafeStr_11094:String = "button_left_end";
        private static const _SafeStr_11095:String = "button_right_end";
        private static const _SafeStr_11027:String = "button_close";
        private static const _SafeStr_11096:String = "button_open";
        private static const _SafeStr_11097:String = "link_friendlist";
        private static const _SafeStr_11098:String = "messenger";
        private static const _SafeStr_11099:String = "friendlist";
        private static const _SafeStr_11100:String = "stream";
        private static const _SafeStr_11101:String = "stream_new_label";

        private var _SafeStr_11102:IHabboFriendBarData;
        private var _SafeStr_11103:IWindowContainer;
        private var _SafeStr_11104:IWindowContainer;
        private var _SafeStr_11105:Vector.<ITab>;
        private var _SafeStr_11106:ITab;
        private var _SafeStr_11107:int = -1;
        private var _startIndex:int = 0;
        private var _SafeStr_11108:TextCropper;
        private var _SafeStr_11109:FriendListIcon;
        private var _SafeStr_11110:MessengerIcon;
        private var _SafeStr_11111:StreamIcon;
        private var _SafeStr_11112:Boolean = true;

        public function HabboFriendBarView(_arg_1:HabboFriendBar, _arg_2:uint, _arg_3:IAssetLibrary)
        {
            super(_arg_1, _arg_2, _arg_3);
            this._SafeStr_11108 = new TextCropper();
            this._SafeStr_11105 = new Vector.<ITab>();
            queueInterface(new IIDHabboFriendBarData(), this.HabboFriendBarView);
        }
        public function setMessengerIconNotify(_arg_1:Boolean):void
        {
            if (this._SafeStr_11110){
                this._SafeStr_11110.notify(_arg_1);
            };
        }
        public function setFriendListIconNotify(_arg_1:Boolean):void
        {
            if (this._SafeStr_11109){
                this._SafeStr_11109.notify(_arg_1);
            };
        }
        public function setStreamIconNotify(_arg_1:Boolean):void
        {
            if (this._SafeStr_11111){
                this._SafeStr_11111.notify(_arg_1);
            };
        }
        public function refreshEventStream():void
        {
            this._SafeStr_11102.refreshOfflineStream();
        }
        override public function dispose():void
        {
            if (!disposed){
                if (this._SafeStr_11110){
                    this._SafeStr_11110.dispose();
                    this._SafeStr_11110 = null;
                };
                if (this._SafeStr_11109){
                    this._SafeStr_11109.dispose();
                    this._SafeStr_11109 = null;
                };
                if (this._SafeStr_11111){
                    this._SafeStr_11111.dispose();
                    this._SafeStr_11111 = null;
                };
                if (this._SafeStr_11104){
                    this._SafeStr_11104.dispose();
                    this._SafeStr_11104 = null;
                };
                if (this._SafeStr_11103){
                    this._SafeStr_11103.dispose();
                    this._SafeStr_11103 = null;
                };
                while (this._SafeStr_11105.length > 0) {
                    ITab(this._SafeStr_11105.pop()).dispose();
                };
                if (this._SafeStr_11102){
                    if (!this._SafeStr_11102.disposed){
                        if (this._SafeStr_11102.events){
                            this._SafeStr_11102.events.removeEventListener(FriendBarUpdateEvent.FBE_UPDATED, this.HabboFriendBarView);
                            this._SafeStr_11102.events.removeEventListener(FindFriendsNotificationEvent.TYPE, this.HabboFriendBarView);
                            this._SafeStr_11102.events.removeEventListener(FriendRequestUpdateEvent.FBE_REQUESTS, this.HabboFriendBarView);
                            this._SafeStr_11102.events.removeEventListener(NewMessageEvent.FBE_MESSAGE, this.HabboFriendBarView);
                            this._SafeStr_11102.events.removeEventListener(NotificationEvent.FBE_NOTIFICATION_EVENT, this.HabboFriendBarView);
                        };
                        this._SafeStr_11102.release(new IIDHabboFriendBarData());
                        this._SafeStr_11102 = null;
                    };
                };
                if (_windowManager){
                    if (!_windowManager.disposed){
                        _windowManager.getWindowContext(_SafeStr_11079).getDesktopWindow().removeEventListener(WindowEvent.WE_RESIZED, this.HabboFriendBarView);
                    };
                };
                this._SafeStr_11108.dispose();
                this._SafeStr_11108 = null;
                super.dispose();
            };
        }
        public function set visible(_arg_1:Boolean):void
        {
            if (this._SafeStr_11103){
                this._SafeStr_11103.visible = _arg_1;
                this._SafeStr_11103.activate();
            };
            if (this._SafeStr_11104){
                this._SafeStr_11104.visible = !(_arg_1);
                if (this._SafeStr_11103){
                    this._SafeStr_11104.x = this._SafeStr_11103.x;
                    this._SafeStr_11104.y = this._SafeStr_11103.y;
                    this._SafeStr_11104.activate();
                };
            };
        }
        public function get visible():Boolean
        {
            return (((this._SafeStr_11103) && (this._SafeStr_11103.visible)));
        }
        public function populate():void
        {
            var _local_5:int;
            var _local_12:FriendRequest;
            var _local_13:IFriendEntity;
            var _local_14:Tab;
            var _local_15:int;
            var _local_16:Tab;
            var _local_1:int = this._SafeStr_11107;
            this.deSelect(false);
            var _local_2:IWindowContainer = (this._SafeStr_11103.findChildByName(_SafeStr_3728) as IWindowContainer);
            var _local_3:IItemListWindow = (_local_2.findChildByName(_SafeStr_10932) as IItemListWindow);
            _local_3.autoArrangeItems = false;
            var _local_4:int = _local_3.numListItems;
            _local_5 = _local_4;
            while (_local_5 > 0) {
                _local_3.IItemListWindow((_local_5 - 1));
                _local_5--;
            };
            while (this._SafeStr_11105.length > 0) {
                this._SafeStr_11105.pop().recycle();
            };
            var _local_6:int = this._SafeStr_11102.numFriends;
            var _local_7:int = this._SafeStr_11102.numFriendRequests;
            var _local_8:int = this.maxNumOfTabsVisible;
            var _local_9:int = ((_local_6 + ((this._SafeStr_11112) ? 1 : 0)) + (((_local_7 > 0)) ? 1 : 0));
            var _local_10:int = Math.min(_local_8, _local_9);
            if ((this._startIndex + _local_10) > _local_9){
                this._startIndex = Math.max(0, (this._startIndex - ((this._startIndex + _local_10) - _local_9)));
            };
            var _local_11:int = this._startIndex;
            if (_local_7 > 0){
                if (this._startIndex == 0){
                    if (this._SafeStr_11105.length < _local_8){
                        if (_local_7 == 1){
                            _local_12 = this._SafeStr_11102.HabboFriendBarData(0);
                            _local_14 = FriendRequestTab.allocate(_local_12);
                            this._SafeStr_11105.push(_local_14);
                            _local_3.addListItem(_local_14.window);
                        }
                        else {
                            if (_local_7 > 1){
                                _local_14 = FriendRequestsTab.allocate(this._SafeStr_11102.HabboFriendBarData());
                                this._SafeStr_11105.push(_local_14);
                                _local_3.addListItem(_local_14.window);
                            };
                        };
                    };
                }
                else {
                    _local_11--;
                };
            };
            _local_5 = _local_11;
            while (_local_5 < (_local_6 + _local_11)) {
                if (_local_5 >= _local_6) break;
                if (this._SafeStr_11105.length >= _local_8) break;
                _local_13 = this._SafeStr_11102.HabboFriendBarData(_local_5);
                _local_14 = FriendEntityTab.allocate(_local_13);
                this._SafeStr_11105.push(_local_14);
                _local_3.addListItem(_local_14.window);
                _local_5++;
            };
            if (this._SafeStr_11112){
                if (this._SafeStr_11105.length < _local_8){
                    _local_15 = 1;
                    if ((this._SafeStr_11105.length + _local_15) < _SafeStr_11084){
                        _local_15 = Math.min((_local_8 - this._SafeStr_11105.length), (_SafeStr_11084 - this._SafeStr_11105.length));
                    };
                    _local_9 = ((_local_6 + _local_15) + (((_local_7 > 0)) ? 1 : 0));
                    while (_local_15-- > 0) {
                        _local_16 = AddFriendsTab.allocate();
                        _local_3.addListItem(_local_16.window);
                        this._SafeStr_11105.push(_local_16);
                    };
                };
            };
            _local_3.autoArrangeItems = true;
            if (_local_1 > -1){
                this.HabboFriendBarView(_local_1);
            };
            _local_2.visible = (this._SafeStr_11105.length > 0);
            this.HabboFriendBarView((this._SafeStr_11105.length < _local_9), !((this._startIndex == 0)), ((this._startIndex + this._SafeStr_11105.length) < _local_9));
        }
        private function HabboFriendBarView(_arg_1:int):FriendEntityTab
        {
            var _local_2:FriendEntityTab;
            var _local_3:int = this._SafeStr_11105.length;
            var _local_4:int;
            while (_local_4 < _local_3) {
                _local_2 = (this._SafeStr_11105[_local_4] as FriendEntityTab);
                if (_local_2){
                    if (_local_2.friend.id == _arg_1){
                        return (_local_2);
                    };
                };
                _local_4++;
            };
            return (null);
        }
        private function HabboFriendBarView(_arg_1:IID, _arg_2:IUnknown):void
        {
            this._SafeStr_11102 = (_arg_2 as IHabboFriendBarData);
            this._SafeStr_11102.events.addEventListener(FriendBarUpdateEvent.FBE_UPDATED, this.HabboFriendBarView);
            this._SafeStr_11102.events.addEventListener(FindFriendsNotificationEvent.TYPE, this.HabboFriendBarView);
            this._SafeStr_11102.events.addEventListener(FriendRequestUpdateEvent.FBE_REQUESTS, this.HabboFriendBarView);
            this._SafeStr_11102.events.addEventListener(NewMessageEvent.FBE_MESSAGE, this.HabboFriendBarView);
            this._SafeStr_11102.events.addEventListener(NotificationEvent.FBE_NOTIFICATION_EVENT, this.HabboFriendBarView);
        }
        private function HabboFriendBarView():Boolean
        {
            return (((this._SafeStr_11103) && (!(this._SafeStr_11103.disposed))));
        }
        private function HabboFriendBarView():void
        {
            var _local_2:IWindowContainer;
            Tab._SafeStr_11013 = this._SafeStr_11102;
            Tab._SafeStr_11014 = this;
            Tab.ASSETS = assets;
            Tab.WINDOWING = _windowManager;
            Tab._SafeStr_11015 = _localization;
            Tab._SafeStr_11016 = this._SafeStr_11108;
            Token.WINDOWING = _windowManager;
            Token.ASSETS = assets;
            var _local_1:IAsset = assets.getAssetByName(_SafeStr_11088);
            this._SafeStr_11103 = (_windowManager.buildFromXML((_local_1.content as XML), _SafeStr_11079) as IWindowContainer);
            this._SafeStr_11103.x = _SafeStr_11081;
            this._SafeStr_11103.y = (this._SafeStr_11103.parent.height - (this._SafeStr_11103.height + _SafeStr_11080));
            this._SafeStr_11103.width = (this._SafeStr_11103.parent.width - (_SafeStr_11081 + _SafeStr_11082));
            this._SafeStr_11103.setParamFlag(WindowParam._SafeStr_7458, true);
            this._SafeStr_11103.procedure = this.HabboFriendBarView;
            if (_SafeStr_11083){
                _local_1 = assets.getAssetByName(_SafeStr_11089);
                this._SafeStr_11104 = (_windowManager.buildFromXML((_local_1.content as XML), _SafeStr_11079) as IWindowContainer);
                this._SafeStr_11104.x = this._SafeStr_11103.x;
                this._SafeStr_11104.y = this._SafeStr_11103.y;
                this._SafeStr_11104.setParamFlag(WindowParam._SafeStr_7458, true);
                this._SafeStr_11104.visible = false;
                this._SafeStr_11104.procedure = this.HabboFriendBarView;
            };
            _local_2 = IWindowContainer(this._SafeStr_11103.findChildByName(_SafeStr_11099));
            _local_2.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.ToolbarView);
            _local_2.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_OVER, this.ToolbarView);
            _local_2.addEventListener(WindowMouseEvent.WME_OUT, this.ToolbarView);
            this._SafeStr_11109 = new FriendListIcon(assets, (_local_2.getChildByName(ICON) as IBitmapWrapperWindow));
            _local_2 = IWindowContainer(this._SafeStr_11103.findChildByName(_SafeStr_11098));
            _local_2.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.ToolbarView);
            _local_2.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_OVER, this.ToolbarView);
            _local_2.addEventListener(WindowMouseEvent.WME_OUT, this.ToolbarView);
            this._SafeStr_11110 = new MessengerIcon(assets, (_local_2.getChildByName(ICON) as IBitmapWrapperWindow));
            this._SafeStr_11110.enable(false);
            this.visible = true;
            _windowManager.getWindowContext(_SafeStr_11079).getDesktopWindow().addEventListener(WindowEvent.WE_RESIZED, this.HabboFriendBarView);
            this._SafeStr_11103.findChildByName(_SafeStr_11100).visible = (_SafeStr_10977.getBoolean("friendbar.stream.enabled", false) == true);
            _local_2 = IWindowContainer(this._SafeStr_11103.findChildByName(_SafeStr_11100));
            _local_2.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.ToolbarView);
            _local_2.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_OVER, this.ToolbarView);
            _local_2.addEventListener(WindowMouseEvent.WME_OUT, this.ToolbarView);
            this._SafeStr_11111 = new StreamIcon(assets, (_local_2.getChildByName(ICON) as IBitmapWrapperWindow));
        }
        public function getAvatarFaceBitmap(_arg_1:String):BitmapData
        {
            var _local_2:BitmapData;
            var _local_3:IAvatarImage;
            if (_SafeStr_11072){
                _local_3 = _SafeStr_11072.createAvatarImage(_arg_1, AvatarScaleType._SafeStr_4336, null, this);
                if (_local_3){
                    _local_2 = _local_3.getCroppedImage(AvatarSetType._SafeStr_4458);
                    _local_3.dispose();
                };
            };
            return (_local_2);
        }
        public function avatarImageReady(_arg_1:String):void
        {
            var _local_2:IFriendEntity;
            var _local_7:FriendRequest;
            var _local_8:BitmapData;
            var _local_9:IWindowContainer;
            var _local_10:IItemListWindow;
            var _local_11:IWindowContainer;
            var _local_12:IBitmapWrapperWindow;
            var _local_13:Tab;
            var _local_3:IItemListWindow = (this._SafeStr_11103.findChildByName(_SafeStr_10932) as IItemListWindow);
            var _local_4:int = this._SafeStr_11102.numFriends;
            var _local_5:int;
            while (_local_5 < _local_4) {
                _local_2 = this._SafeStr_11102.HabboFriendBarData(_local_5);
                if (_local_2.figure == _arg_1){
                    _local_8 = this.getAvatarFaceBitmap(_arg_1);
                    if (_local_8){
                        _local_9 = (_local_3.IItemListWindow(_local_2.id) as IWindowContainer);
                        if (_local_9){
                            _local_10 = (_local_9.getChildByName(_SafeStr_11057) as IItemListWindow);
                            if (_local_10){
                                _local_11 = IWindowContainer(_local_10.getListItemByName(_SafeStr_7540));
                                if (_local_11){
                                    _local_12 = (_local_11.findChildByName(_SafeStr_10988) as IBitmapWrapperWindow);
                                    _local_12.bitmap = _local_8;
                                    _local_12.width = _local_8.width;
                                    _local_12.height = _local_8.height;
                                };
                            };
                        };
                    };
                    return;
                };
                _local_5++;
            };
            var _local_6:Array = this._SafeStr_11102.HabboFriendBarData();
            for each (_local_7 in _local_6) {
                if (_local_7.figure == _arg_1){
                    for each (_local_13 in this._SafeStr_11105) {
                        if ((_local_13 is FriendRequestTab)){
                            FriendRequestTab(_local_13).avatarImageReady(_local_7, this.getAvatarFaceBitmap(_arg_1));
                            return;
                        };
                        if ((_local_13 is FriendRequestsTab)){
                            FriendRequestsTab(_local_13).avatarImageReady(_local_7, this.getAvatarFaceBitmap(_arg_1));
                            return;
                        };
                    };
                };
            };
        }
        public function HabboFriendBarView(_arg_1:BitmapData):void
        {
        }
        private function HabboFriendBarView(_arg_1:IFriendEntity):Boolean
        {
            return ((this._SafeStr_11107 == _arg_1.id));
        }
        public function selectTab(_arg_1:ITab, _arg_2:Boolean):void
        {
            if (!_arg_1.selected){
                if (this._SafeStr_11106){
                    this.deSelect(true);
                };
                _arg_1.select(_arg_2);
                this._SafeStr_11106 = _arg_1;
                if ((_arg_1 is FriendEntityTab)){
                    this._SafeStr_11107 = FriendEntityTab(_arg_1).friend.id;
                };
            };
        }
        public function HabboFriendBarView(_arg_1:int):void
        {
            if (this._SafeStr_11107 == _arg_1){
                return;
            };
            var _local_2:FriendEntityTab = this.HabboFriendBarView(_arg_1);
            if (_local_2){
                this.selectTab(_local_2, false);
                this._SafeStr_11107 = _arg_1;
            };
        }
        public function deSelect(_arg_1:Boolean):void
        {
            if (this._SafeStr_11106){
                this._SafeStr_11106.ITab(_arg_1);
                this._SafeStr_11106 = null;
                this._SafeStr_11107 = -1;
            };
        }
        private function HabboFriendBarView(_arg_1:Event):void
        {
            if (!this.HabboFriendBarView()){
                this.HabboFriendBarView();
            };
            this.HabboFriendBarView(true);
        }
        private function HabboFriendBarView(event:FindFriendsNotificationEvent):void
        {
            var title:String = ((event.success) ? "${friendbar.find.success.title}" : "${friendbar.find.error.title}");
            var text:String = ((event.success) ? "${friendbar.find.success.text}" : "${friendbar.find.error.text}");
            _windowManager.notify(title, text, function (_arg_1:IAlertDialog, _arg_2:WindowEvent):void
            {
                _arg_1.dispose();
            }, HabboAlertDialogFlag._SafeStr_7586);
        }
        private function HabboFriendBarView(_arg_1:FriendRequestUpdateEvent):void
        {
            if (this._SafeStr_11109){
                this._SafeStr_11109.notify((this._SafeStr_11102.numFriendRequests > 0));
            };
            this.populate();
        }
        private function HabboFriendBarView(_arg_1:NewMessageEvent):void
        {
            if (this._SafeStr_11110){
                if (_arg_1.notify){
                    this._SafeStr_11110.notify(true);
                }
                else {
                    this._SafeStr_11110.enable(true);
                };
            };
        }
        private function HabboFriendBarView(_arg_1:NotificationEvent):void
        {
            var _local_2:FriendEntityTab = this.HabboFriendBarView(_arg_1.friendId);
            if (!_local_2){
                return;
            };
            _local_2.addNotificationToken(_arg_1.notification, true);
        }
        private function HabboFriendBarView(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            var _local_3:int;
            var _local_4:int;
            if (_arg_1.type == WindowMouseEvent.WME_DOWN){
                _local_3 = this._startIndex;
                _local_4 = ((this._SafeStr_11102.numFriends + ((this._SafeStr_11112) ? 1 : 0)) + (((this._SafeStr_11102.numFriendRequests > 0)) ? 1 : 0));
                switch (_arg_2.name){
                    case _SafeStr_11091:
                        _local_3 = Math.max(0, (this._startIndex - 1));
                        break;
                    case _SafeStr_11092:
                        _local_3 = Math.max(0, (this._startIndex - this.maxNumOfTabsVisible));
                        break;
                    case _SafeStr_11094:
                        _local_3 = 0;
                        break;
                    case BUTTON_RIGHT_SINGLE:
                        _local_3 = Math.max(0, Math.min((_local_4 - this.maxNumOfTabsVisible), (this._startIndex + 1)));
                        break;
                    case _SafeStr_11093:
                        _local_3 = Math.max(0, Math.min((_local_4 - this.maxNumOfTabsVisible), (this._startIndex + this.maxNumOfTabsVisible)));
                        break;
                    case _SafeStr_11095:
                        _local_3 = Math.max(0, (_local_4 - this.maxNumOfTabsVisible));
                        break;
                    case _SafeStr_11027:
                        this.visible = false;
                        break;
                    case _SafeStr_7574:
                        this.deSelect(true);
                        break;
                    case _SafeStr_11097:
                        this._SafeStr_11102.toggleFriendList();
                        break;
                };
                if (_local_3 != this._startIndex){
                    this.deSelect(true);
                    this._startIndex = _local_3;
                    this.HabboFriendBarView(true);
                };
            };
            if (_arg_1.type == WindowEvent.WE_DEACTIVATED){
                this.deSelect(true);
            };
        }
        private function ToolbarView(_arg_1:WindowMouseEvent):void
        {
            var _local_2:Icon;
            switch (_arg_1.window.name){
                case _SafeStr_11099:
                    _local_2 = this._SafeStr_11109;
                    break;
                case _SafeStr_11098:
                    _local_2 = this._SafeStr_11110;
                    break;
                case _SafeStr_11100:
                    _local_2 = this._SafeStr_11111;
                    break;
            };
            if (_local_2 == null){
                return;
            };
            switch (_arg_1.type){
                case WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK:
                    if ((_local_2 is FriendListIcon)){
                        this._SafeStr_11102.toggleFriendList();
                        _local_2.notify(false);
                    }
                    else {
                        if ((_local_2 is MessengerIcon)){
                            this._SafeStr_11102.toggleMessenger();
                            _local_2.notify(false);
                        }
                        else {
                            if ((_local_2 is StreamIcon)){
                                this._SafeStr_11102.toggleOfflineStream();
                                _local_2.notify(false);
                            };
                        };
                    };
                    return;
                case WindowMouseEvent.WINDOW_EVENT_MOUSE_OVER:
                    _local_2.hover(true);
                    return;
                case WindowMouseEvent.WME_OUT:
                    _local_2.hover(false);
                    return;
            };
        }
        private function HabboFriendBarView(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (this._SafeStr_11104.visible){
                if (_arg_1.type == WindowMouseEvent.WME_DOWN){
                    switch (_arg_2.name){
                        case _SafeStr_11096:
                            this.visible = true;
                            return;
                    };
                };
            };
        }
        private function HabboFriendBarView(_arg_1:Boolean, _arg_2:Boolean, _arg_3:Boolean):void
        {
            var _local_4:IWindow;
            var _local_5:Array;
            var _local_6:IWindowContainer = (this._SafeStr_11103.findChildByName(_SafeStr_11090) as IWindowContainer);
            _local_5 = [];
            _local_6.WindowController(_SafeStr_11085, _local_5);
            for each (_local_4 in _local_5) {
                _local_4.visible = _arg_1;
            };
            _local_5 = [];
            _local_6.WindowController(_SafeStr_11086, _local_5);
            for each (_local_4 in _local_5) {
                if (_arg_2){
                    _local_4.enable();
                }
                else {
                    _local_4.disable();
                };
            };
            _local_5 = [];
            _local_6.WindowController(_SafeStr_11087, _local_5);
            for each (_local_4 in _local_5) {
                if (_arg_3){
                    _local_4.enable();
                }
                else {
                    _local_4.disable();
                };
            };
        }
        private function HabboFriendBarView(_arg_1:Boolean=false):void
        {
            var _local_2:int;
            if (!disposed){
                if (this._SafeStr_11103){
                    this._SafeStr_11103.width = (this._SafeStr_11103.parent.width - (_SafeStr_11081 + _SafeStr_11082));
                    if (!_arg_1){
                        _local_2 = this.maxNumOfTabsVisible;
                        if (_local_2 < this._SafeStr_11105.length){
                            _arg_1 = true;
                        }
                        else {
                            if (_local_2 > this._SafeStr_11105.length){
                                if (this._SafeStr_11105.length < _SafeStr_11084){
                                    _arg_1 = true;
                                }
                                else {
                                    if (this._SafeStr_11105.length < (this._SafeStr_11102.numFriends + ((this._SafeStr_11112) ? 1 : 0))){
                                        _arg_1 = true;
                                    }
                                    else {
                                        if (this.numFriendEntityTabsVisible < this._SafeStr_11102.numFriends){
                                            _arg_1 = true;
                                        };
                                    };
                                };
                            };
                        };
                    };
                    if (_arg_1){
                        this.populate();
                    };
                };
            };
        }
        private function get numFriendEntityTabsVisible():int
        {
            var _local_1:int;
            var _local_2:int = this._SafeStr_11105.length;
            while (_local_2-- > 0) {
                if ((this._SafeStr_11105[_local_2] is FriendEntityTab)){
                    _local_1++;
                };
            };
            return (_local_1);
        }
        private function get maxNumOfTabsVisible():int
        {
            var _local_1:IWindowContainer = (this._SafeStr_11103.findChildByName(_SafeStr_3728) as IWindowContainer);
            var _local_2:IWindowContainer = (_local_1.getChildByName(_SafeStr_11090) as IWindowContainer);
            var _local_3:IItemListWindow = (_local_2.findChildByName(_SafeStr_10932) as IItemListWindow);
            var _local_4:int = (_local_2.width - _local_3.width);
            return (((_local_1.width - _local_4) / (_SafeStr_11078 + _local_3.spacing)));
        }
        private function HabboFriendBarView(_arg_1:WindowEvent):void
        {
            this.HabboFriendBarView(false);
        }

    }
}//package com.sulake.habbo.friendbar.view

// IID = "_-3KV" (String#7712, DoABC#2)
// numFriends = "_-nN" (String#8666, DoABC#2)
// HabboFriendBarData = "_-1K4" (String#5244, DoABC#2)
// numFriendRequests = "_-0" (String#3548, DoABC#2)
// HabboFriendBarData = "_-3-l" (String#7299, DoABC#2)
// HabboFriendBarData = "_-0Wl" (String#4243, DoABC#2)
// toggleFriendList = "_-tA" (String#8753, DoABC#2)
// toggleMessenger = "_-2E7" (String#1838, DoABC#2)
// toggleOfflineStream = "_-2ED" (String#6325, DoABC#2)
// refreshOfflineStream = "_-ul" (String#8779, DoABC#2)
// refreshEventStream = "_-1Zw" (String#1711, DoABC#2)
// HabboFriendBarView = "_-Mx" (String#8141, DoABC#2)
// _SafeStr_10932 = "_-1bg" (String#5593, DoABC#2)
// ASSETS = "_-391" (String#21846, DoABC#2)
// _localization = "_-07" (String#3703, DoABC#2)
// _SafeStr_10977 = "_-01o" (String#3598, DoABC#2)
// setStreamIconNotify = "_-0YR" (String#4272, DoABC#2)
// _SafeStr_10988 = "_-IE" (String#933, DoABC#2)
// WINDOWING = "_-03b" (String#14186, DoABC#2)
// _SafeStr_11013 = "_-1BC" (String#16905, DoABC#2)
// _SafeStr_11014 = "_-CV" (String#22705, DoABC#2)
// _SafeStr_11015 = "_-2ci" (String#20552, DoABC#2)
// _SafeStr_11016 = "_-1px" (String#18540, DoABC#2)
// selectTab = "_-F0" (String#2077, DoABC#2)
// _SafeStr_11027 = "_-2Zb" (String#894, DoABC#2)
// _SafeStr_11057 = "_-276" (String#6186, DoABC#2)
// addNotificationToken = "_-0Wf" (String#15303, DoABC#2)
// _SafeStr_11072 = "_-2PE" (String#1873, DoABC#2)
// setFriendListIconNotify = "_-pG" (String#8696, DoABC#2)
// _SafeStr_11078 = "_-39X" (String#21864, DoABC#2)
// _SafeStr_11079 = "_-34e" (String#21684, DoABC#2)
// _SafeStr_11080 = "_-XP" (String#23540, DoABC#2)
// _SafeStr_11081 = "_-0Zj" (String#15432, DoABC#2)
// _SafeStr_11082 = "_-0V" (String#15242, DoABC#2)
// _SafeStr_11083 = "_-1rx" (String#18629, DoABC#2)
// _SafeStr_11084 = "_-1TY" (String#17647, DoABC#2)
// _SafeStr_11085 = "_-1zt" (String#18964, DoABC#2)
// _SafeStr_11086 = "_-0c0" (String#15513, DoABC#2)
// _SafeStr_11087 = "_-0D-" (String#14570, DoABC#2)
// _SafeStr_11088 = "_-2YE" (String#20366, DoABC#2)
// _SafeStr_11089 = "_-31N" (String#21553, DoABC#2)
// _SafeStr_11090 = "_-2Ct" (String#19518, DoABC#2)
// _SafeStr_11091 = "_-1iN" (String#18223, DoABC#2)
// _SafeStr_11092 = "_-2Jv" (String#19805, DoABC#2)
// _SafeStr_11093 = "_-1Y3" (String#17816, DoABC#2)
// _SafeStr_11094 = "_-1ol" (String#18488, DoABC#2)
// _SafeStr_11095 = "_-0nE" (String#15946, DoABC#2)
// _SafeStr_11096 = "_-31E" (String#21547, DoABC#2)
// _SafeStr_11097 = "_-34A" (String#21666, DoABC#2)
// _SafeStr_11098 = "_-2sY" (String#21182, DoABC#2)
// _SafeStr_11099 = "_-19n" (String#16848, DoABC#2)
// _SafeStr_11100 = "_-0JF" (String#14811, DoABC#2)
// _SafeStr_11101 = "_-09f" (String#14433, DoABC#2)
// _SafeStr_11102 = "_-343" (String#21660, DoABC#2)
// _SafeStr_11103 = "_-2ey" (String#20643, DoABC#2)
// _SafeStr_11104 = "_-2Li" (String#19873, DoABC#2)
// _SafeStr_11105 = "_-2Yr" (String#20388, DoABC#2)
// _SafeStr_11106 = "_-1a0" (String#17893, DoABC#2)
// _SafeStr_11107 = "_-37W" (String#21786, DoABC#2)
// _SafeStr_11108 = "_-2Ww" (String#20320, DoABC#2)
// _SafeStr_11109 = "_-IQ" (String#22946, DoABC#2)
// _SafeStr_11110 = "_-1jc" (String#18269, DoABC#2)
// _SafeStr_11111 = "_-5L" (String#22436, DoABC#2)
// _SafeStr_11112 = "_-1JU" (String#17256, DoABC#2)
// HabboFriendBarView = "_-0Xk" (String#15345, DoABC#2)
// HabboFriendBarView = "_-OL" (String#23181, DoABC#2)
// HabboFriendBarView = "_-0IE" (String#14767, DoABC#2)
// HabboFriendBarView = "_-aM" (String#23647, DoABC#2)
// HabboFriendBarView = "_-1cr" (String#18006, DoABC#2)
// HabboFriendBarView = "_-2rT" (String#21136, DoABC#2)
// maxNumOfTabsVisible = "_-0sL" (String#16137, DoABC#2)
// HabboFriendBarView = "_-gq" (String#23924, DoABC#2)
// HabboFriendBarView = "_-1IY" (String#17215, DoABC#2)
// HabboFriendBarView = "_-2S7" (String#20124, DoABC#2)
// HabboFriendBarView = "_-0JW" (String#14822, DoABC#2)
// HabboFriendBarView = "_-1fa" (String#18121, DoABC#2)
// HabboFriendBarView = "_-2Ie" (String#19753, DoABC#2)
// HabboFriendBarView = "_-1sH" (String#18643, DoABC#2)
// ToolbarView = "_-1ZI" (String#5547, DoABC#2)
// HabboFriendBarView = "_-2CN" (String#19499, DoABC#2)
// HabboFriendBarView = "_-11N" (String#16512, DoABC#2)
// HabboFriendBarView = "_-0vo" (String#16267, DoABC#2)
// numFriendEntityTabsVisible = "_-2Mq" (String#19920, DoABC#2)
// WindowEvent = "_-Jh" (String#2085, DoABC#2)
// IAlertDialog = "_-2LY" (String#6472, DoABC#2)
// AvatarScaleType = "_-2lF" (String#20893, DoABC#2)
// AbstractView = "_-0VM" (String#4212, DoABC#2)
// IHabboFriendBarView = "_-0n8" (String#4571, DoABC#2)
// HabboFriendBarView = "_-2Ai" (String#6260, DoABC#2)
// IHabboFriendBarData = "_-1hC" (String#5689, DoABC#2)
// FriendRequest = "_-2Nq" (String#887, DoABC#2)
// Tab = "_-Cd" (String#930, DoABC#2)
// HabboAlertDialogFlag = "_-1mF" (String#18390, DoABC#2)
// FriendRequestUpdateEvent = "_-0JS" (String#14820, DoABC#2)
// TextCropper = "_-58" (String#22425, DoABC#2)
// Icon = "_-2AV" (String#6254, DoABC#2)
// MessengerIcon = "_-0iq" (String#15784, DoABC#2)
// FriendRequestsTab = "_-1f2" (String#5644, DoABC#2)
// NotificationEvent = "_-mt" (String#24147, DoABC#2)
// NewMessageEvent = "_-3Cc" (String#21980, DoABC#2)
// IFriendEntity = "_-2nQ" (String#7031, DoABC#2)
// FriendBarUpdateEvent = "_-UZ" (String#23430, DoABC#2)
// FindFriendsNotificationEvent = "_-2xi" (String#21383, DoABC#2)
// StreamIcon = "_-2tp" (String#21232, DoABC#2)
// FriendListIcon = "_-iq" (String#23992, DoABC#2)
// FriendRequestTab = "_-2n8" (String#7023, DoABC#2)
// AddFriendsTab = "_-3e" (String#7741, DoABC#2)
// _SafeStr_3728 = "_-1IW" (String#5215, DoABC#2)
// WME_OUT = "_-0h2" (String#15712, DoABC#2)
// WE_RESIZED = "_-76" (String#22505, DoABC#2)
// WME_DOWN = "_-hL" (String#23944, DoABC#2)
// _SafeStr_4336 = "_-1wM" (String#18815, DoABC#2)
// _SafeStr_4458 = "_-327" (String#21586, DoABC#2)
// hover = "_-27m" (String#19322, DoABC#2)
// getCroppedImage = "_-2Ez" (String#6342, DoABC#2)
// avatarImageReady = "_-i" (String#8553, DoABC#2)
// WE_DEACTIVATED = "_-1oi" (String#18485, DoABC#2)
// ITab = "_-05I" (String#3671, DoABC#2)
// IItemListWindow = "_-Td" (String#8279, DoABC#2)
// IAvatarImageListener = "_-06N" (String#3688, DoABC#2)
// _SafeStr_7458 = "_-cq" (String#23748, DoABC#2)
// _SafeStr_7540 = "_-1l4" (String#444, DoABC#2)
// _SafeStr_7574 = "_-2de" (String#6824, DoABC#2)
// _SafeStr_7586 = "_-2yB" (String#7242, DoABC#2)
// FBE_REQUESTS = "_-011" (String#14096, DoABC#2)
// FBE_NOTIFICATION_EVENT = "_-cr" (String#23749, DoABC#2)
// FBE_MESSAGE = "_-28K" (String#19344, DoABC#2)
// FBE_UPDATED = "_-06G" (String#14296, DoABC#2)
// allocate = "_-08G" (String#14374, DoABC#2)
// WindowController = "_-cU" (String#2141, DoABC#2)
// IItemListWindow = "_-29k" (String#6245, DoABC#2)


