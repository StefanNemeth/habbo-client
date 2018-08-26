
package com.sulake.habbo.friendbar.stream
{
    import com.sulake.habbo.friendbar.view.AbstractView;
    import com.sulake.core.window.IWindowContainer;
    import __AS3__.vec.Vector;
    import com.sulake.core.communication.connection.IConnection;
    import flash.utils.Timer;
    import com.sulake.habbo.friendbar.view.IHabboFriendBarView;
    import com.sulake.habbo.communication.IHabboCommunicationManager;
    import com.sulake.core.utils.Map;
    import com.sulake.iid.IIDHabboCommunicationManager;
    import com.sulake.iid.IIDHabboFriendBarView;
    import flash.events.TimerEvent;
    import com.sulake.habbo.friendbar.HabboFriendBar;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.window.components.IItemListWindow;
    import com.sulake.habbo.communication.messages.incoming.friendlist.EventStreamData;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.localization.ILocalization;
    import com.sulake.habbo.friendbar.utils.LinkTarget;
    import flash.display.BitmapData;
    import com.sulake.habbo.session.events.BadgeImageReadyEvent;
    import com.sulake.core.window.components.IScrollbarWindow;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import com.sulake.core.window.enum.WindowParam;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.habbo.utils.HabboWebTools;
    import com.sulake.habbo.communication.messages.outgoing.friendlist.GetEventStreamComposer;
    import com.sulake.habbo.communication.messages.incoming.friendlist.EventStreamEvent;
    import com.sulake.habbo.communication.messages.incoming.handshake.UserObjectEvent;
    import com.sulake.core.runtime.IID;
    import com.sulake.core.runtime.IUnknown;
    import com.sulake.habbo.friendbar.utils.TestMessageWrapper;
    import com.sulake.habbo.communication.messages.outgoing.friendlist.SetEventStreamingAllowedComposer;
    import com.sulake.habbo.communication.messages.outgoing.friendlist.LikeStreamEventMessageComposer;
    import __AS3__.vec.*;
    import com.sulake.habbo.friendbar.view.*;

    public class HabboEventStream extends AbstractView implements IHabboEventStream 
    {

        private static const _SafeStr_10929:String = "page_content";
        private static const _SafeStr_10930:String = "page_welcome";
        private static const _SafeStr_10931:String = "page_empty";
        private static const _SafeStr_10932:String = "list";
        private static const _SafeStr_7540:String = "header";
        private static const _SafeStr_6770:String = "badge";
        private static const CLOSE:String = "close";
        private static const _SafeStr_10933:String = "scroll";
        private static const _SafeStr_10934:String = "image";
        private static const _SafeStr_10935:String = "disable_stream";
        private static const ACTIVATE:String = "activate_stream";
        private static const _SafeStr_10936:String = "see_more";
        private static const _SafeStr_10937:uint = 0;
        private static const _SafeStr_10938:uint = 1;
        private static const _SafeStr_10939:int = 180;//-2
        private static const _SafeStr_10940:int = -3;
        private static const _SafeStr_10941:int = 42;
        private static const _SafeStr_10942:int = (1000 * 60);//60000
        private static const _SafeStr_10943:int = (1000 * 60);//60000
        private static const GENDER_LOCALIZATION_PREFIX:String = "friendbar.stream.";

        private var _window:IWindowContainer;
        private var _SafeStr_10944:Vector.<EventStreamEntity>;
        private var _connection:IConnection;
        private var _initialized:Boolean = false;
        private var _SafeStr_10945:Timer;
        private var _SafeStr_10946:Timer;
        private var _SafeStr_10947:IHabboFriendBarView;
        private var _SafeStr_10883:IHabboCommunicationManager;
        private var _SafeStr_10948:Boolean;
        private var _SafeStr_10949:Vector.<int>;
        private var _SafeStr_10950:Boolean = false;
        private var _SafeStr_10951:Boolean = false;
        private var _SafeStr_10952:Boolean = false;
        private var _SafeStr_10953:int = 1;
        private var _SafeStr_10954:Array;
        private var _SafeStr_10955:Array;
        private var _SafeStr_10956:Map;

        public function HabboEventStream(_arg_1:HabboFriendBar, _arg_2:uint, _arg_3:IAssetLibrary)
        {
            this._SafeStr_10949 = new Vector.<int>();
            this._SafeStr_10954 = ["friend_made", "room_liked", "achievement_earned", "motto_changed", "room_decorated"];
            this._SafeStr_10955 = ["no_link", "open_mini_profile", "visit_room", "open_achievements", "open_motto_changer", "friend_request"];
            this._SafeStr_10956 = new Map();
            super(_arg_1, _arg_2, _arg_3);
            this._SafeStr_10944 = new Vector.<EventStreamEntity>();
            queueInterface(new IIDHabboCommunicationManager(), this.HabboEventStream);
            queueInterface(new IIDHabboFriendBarView(), this.HabboEventStream);
            this._SafeStr_10956.add("m", "his");
            this._SafeStr_10956.add("f", "her");
            if (!this._SafeStr_10946){
                this._SafeStr_10946 = new Timer(_SafeStr_10943);
                this._SafeStr_10946.addEventListener(TimerEvent.TIMER, this.HabboEventStream);
            };
        }
        public function set visible(_arg_1:Boolean):void
        {
            if (!this._window){
                this.HabboEventStream();
            };
            this._window.visible = _arg_1;
            if (_arg_1){
                this._window.x = (this._window.desktop.width - (this._window.width + _SafeStr_10940));
                this._window.y = _SafeStr_10939;
                this._window.height = (this._window.desktop.height - (_SafeStr_10939 + _SafeStr_10941));
                this._window.activate();
                if (this._SafeStr_10948){
                    this.HabboEventStream(this._SafeStr_10953);
                };
            };
        }
        public function get visible():Boolean
        {
            return (((this._window) ? this._window.visible : false));
        }
        override public function dispose():void
        {
            if (!disposed){
                if (this._SafeStr_10945){
                    this._SafeStr_10945.stop();
                    this._SafeStr_10945.removeEventListener(TimerEvent.TIMER, this.HabboEventStream);
                    this._SafeStr_10945 = null;
                };
                if (this._SafeStr_10946){
                    this._SafeStr_10946.stop();
                    this._SafeStr_10946.removeEventListener(TimerEvent.TIMER, this.HabboEventStream);
                    this._SafeStr_10946 = null;
                };
                while (this._SafeStr_10944.length > 0) {
                    this._SafeStr_10944.pop().dispose();
                };
                if (EventStreamEntity._SafeStr_9686){
                    EventStreamEntity._SafeStr_9686.dispose();
                };
                EventStreamEntity._SafeStr_9686 = null;
                EventStreamEntity._SafeStr_10962 = null;
                EventStreamEntity.ASSETS = null;
                EventStreamEntity._SafeStr_10964 = null;
                if (this._window){
                    this._window.removeEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.WelcomeScreenController);
                    this._window.dispose();
                    this._window = null;
                };
                if (this._SafeStr_10883){
                    if (!this._SafeStr_10883.disposed){
                        this._SafeStr_10883.release(new IIDHabboCommunicationManager());
                        this._SafeStr_10883 = null;
                    };
                };
                if (this._SafeStr_10947){
                    if (!this._SafeStr_10947.disposed){
                        this._SafeStr_10947.release(new IIDHabboFriendBarView());
                        this._SafeStr_10947 = null;
                    };
                };
                super.dispose();
            };
        }
        private function HabboEventStream():void
        {
            while (this._SafeStr_10944.length > 0) {
                this._SafeStr_10944.pop().recycle();
            };
        }
        public function populate(_arg_1:Vector.<EventStreamData>):void
        {
            var _local_2:Boolean;
            var _local_3:EventStreamEntity;
            var _local_4:IItemListWindow;
            var _local_5:int;
            var _local_6:EventStreamData;
            var _local_7:IItemListWindow;
            var _local_8:IWindow;
            var _local_9:EventStreamData;
            if (!this._window){
                this.HabboEventStream();
            };
            if (this.visible){
                this.HabboEventStream();
                _local_2 = ((this._SafeStr_10944.length % 2) == 0);
                _local_4 = (this._window.findChildByName(_SafeStr_10932) as IItemListWindow);
                _local_5 = 0;
                for each (_local_6 in _arg_1) {
                    _local_3 = EventStreamEntity.allocate();
                    _local_3.id = _local_6.id;
                    _local_3.title = _local_6.accountName;
                    _local_3.message = this.HabboEventStream(_local_6);
                    _local_3.linkTarget = this.HabboEventStream(_local_6);
                    _local_3.numberOfLikes = _local_6.numberOfLikes;
                    _local_3.isLikingEnabled = this._SafeStr_10952;
                    _local_3.isLikable = ((_local_6.isLikable) && (this._SafeStr_10952));
                    _local_3.minutesElapsed = _local_6.minutesSinceEvent;
                    _local_3.even = _local_2;
                    this.HabboEventStream(_local_3, _local_6);
                    this._SafeStr_10944.push(_local_3);
                    _local_4.addListItem(_local_3.window);
                    _local_2 = !(_local_2);
                    if (this._SafeStr_10949.indexOf(_local_6.id) == -1){
                        _local_5++;
                        this._SafeStr_10949.push(_local_6.id);
                    };
                };
                if (_arg_1.length == 0){
                };
                _local_7 = (this._window.findChildByName(_SafeStr_7540) as IItemListWindow);
                _local_8 = _local_7.getListItemByName(_SafeStr_6770);
                _local_8.visible = false;
                this._SafeStr_10950 = false;
            }
            else {
                for each (_local_9 in _arg_1) {
                    if (this._SafeStr_10949.indexOf(_local_9.id) == -1){
                        this._SafeStr_10950 = true;
                        break;
                    };
                };
            };
            this.HabboEventStream();
        }
        private function HabboEventStream(_arg_1:EventStreamData):String
        {
            var _local_6:ILocalization;
            var _local_2:int = _arg_1.actionId;
            var _local_3:String = ("friendbar.stream.type." + this._SafeStr_10954[_local_2]);
            var _local_4:ILocalization = _localization.getLocalization(_local_3);
            if (!_local_4){
                return (_local_3);
            };
            var _local_5:String = _local_4.raw;
            switch (_local_2){
                case EventStreamData._SafeStr_10771:
                    _local_5 = _local_5.replace("%targetString%", _arg_1.extraDataStruct.friendName);
                    break;
                case EventStreamData._SafeStr_10772:
                    _local_5 = _local_5.replace("%targetString%", _arg_1.extraDataStruct.roomName);
                    break;
                case EventStreamData._SafeStr_10773:
                    _local_5 = _local_5.replace("%targetString%", _localization.getAchievementName(_arg_1.extraDataStruct.achievementCode));
                    break;
                case EventStreamData._SafeStr_10774:
                    _local_6 = _localization.getLocalization((GENDER_LOCALIZATION_PREFIX + this._SafeStr_10956.getValue(_arg_1.accountGender)));
                    _local_5 = _local_5.replace("%gender%", _local_6.value);
                    _local_5 = _local_5.replace("%targetString%", _arg_1.extraDataStruct.motto);
                    break;
                case EventStreamData._SafeStr_10775:
                    break;
            };
            return (_local_5);
        }
        private function HabboEventStream(_arg_1:EventStreamData):LinkTarget
        {
            var _local_3:String;
            var _local_2:String = ("friendbar.stream.link." + this._SafeStr_10955[_arg_1.linkTargetType]);
            var _local_4:uint = LinkTarget.NONE;
            var _local_5:uint;
            var _local_6:String;
            var _local_7:ILocalization = _localization.getLocalization(_local_2);
            _local_3 = ((_local_7) ? _local_7.raw : "");
            switch (_arg_1.linkTargetType){
                case EventStreamData._SafeStr_10776:
                    _local_4 = LinkTarget.NONE;
                    _local_3 = "";
                    break;
                case EventStreamData._SafeStr_10777:
                    _local_3 = _local_3.replace("%targetString%", _arg_1.extraDataStruct.friendName);
                    _local_4 = LinkTarget._SafeStr_10974;
                    _local_5 = _arg_1.extraDataStruct.friendId;
                    break;
                case EventStreamData._SafeStr_10778:
                    _local_4 = LinkTarget.ROOM;
                    _local_5 = _arg_1.extraDataStruct.roomId;
                    break;
                case EventStreamData._SafeStr_10779:
                    _local_4 = LinkTarget.ACHIEVEMENTS;
                    break;
                case EventStreamData.LINK_TARGET_OPEN_MOTTO_CHANGER:
                    _local_4 = LinkTarget._SafeStr_10975;
                    _local_5 = _sessionDataManager.userId;
                    break;
                case EventStreamData._SafeStr_10780:
                    _local_3 = _local_3.replace("%targetString%", _arg_1.extraDataStruct.friendName);
                    _local_4 = LinkTarget.RSFRE_FRIEND_REQUEST;
                    _local_5 = _arg_1.extraDataStruct.friendId;
                    _local_6 = _arg_1.extraDataStruct.friendName;
                    break;
            };
            return (new LinkTarget(_local_3, _local_4, _local_5, _local_6));
        }
        private function HabboEventStream(entity:EventStreamEntity, data:EventStreamData):void
        {
            var image:BitmapData;
            var callback:Function;
            var result:String = data.imageFilePath;
            var action:int = data.actionId;
            switch (action){
                case EventStreamData._SafeStr_10773:
                    image = _sessionDataManager.requestBadgeImage(data.extraDataStruct.achievementCode);
                    if (image){
                        entity.image = image;
                    }
                    else {
                        callback = function (_arg_1:BadgeImageReadyEvent):void
                        {
                            if (_arg_1.badgeId == data.extraDataStruct.achievementCode){
                                entity.image = _arg_1.badgeImage;
                                _sessionDataManager.events.removeEventListener(BadgeImageReadyEvent.BIRE_BADGE_IMAGE_READY, arguments.callee);
                            };
                        };
                        _sessionDataManager.events.addEventListener(BadgeImageReadyEvent.BIRE_BADGE_IMAGE_READY, callback);
                    };
                    return;
                default:
                    entity.imageFilePath = result;
            };
        }
        private function HabboEventStream():void
        {
            var scroll:IScrollbarWindow;
            var page:IWindowContainer;
            var image:IBitmapWrapperWindow;
            var list:IItemListWindow;
            var item:IWindowContainer;
            var icon:IBitmapWrapperWindow;
            if (!this._window){
                this._window = (_windowManager.buildFromXML((assets.getAssetByName("event_stream_display_xml").content as XML)) as IWindowContainer);
                this._window.height = (this._window.desktop.height - (_SafeStr_10939 + _SafeStr_10941));
                this._window.setParamFlag(WindowParam._SafeStr_7449);
                this._window.setParamFlag(WindowParam._SafeStr_7460);
                this._window.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.WelcomeScreenController);
                this._window.findChildByName(CLOSE).addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.WelcomeScreenController);
                this._window.findChildByName(_SafeStr_10935).addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.WelcomeScreenController);
                this._window.findChildByName(ACTIVATE).addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.WelcomeScreenController);
                this._window.findChildByName(_SafeStr_10936).addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.WelcomeScreenController);
                this._window.visible = false;
                scroll = (this._window.findChildByName(_SafeStr_10933) as IScrollbarWindow);
                if (scroll){
                    scroll.addEventListener(WindowEvent.WE_ENABLED, function (_arg_1:WindowEvent):void
                    {
                        var _local_2:IScrollbarWindow = (_arg_1.target as IScrollbarWindow);
                        if (_local_2){
                            _local_2.visible = true;
                            _local_2.scrollable.width = (_local_2.scrollable.parent.width - _local_2.width);
                        };
                    });
                    scroll.addEventListener(WindowEvent.WE_DISABLED, function (_arg_1:WindowEvent):void
                    {
                        scroll.visible = false;
                        scroll.scrollable.width = scroll.scrollable.parent.width;
                    });
                    scroll.visible = false;
                    scroll.scrollable.width = scroll.scrollable.parent.width;
                };
                page = (this._window.findChildByName(_SafeStr_10930) as IWindowContainer);
                image = (page.findChildByName(_SafeStr_10934) as IBitmapWrapperWindow);
                image.bitmap = (assets.getAssetByName(image.bitmapAssetName).content as BitmapData);
                page = (this._window.findChildByName(_SafeStr_10931) as IWindowContainer);
                image = (page.findChildByName(_SafeStr_10934) as IBitmapWrapperWindow);
                image.bitmap = (assets.getAssetByName(image.bitmapAssetName).content as BitmapData);
                this.HabboEventStream();
                list = (this._window.findChildByName(_SafeStr_10932) as IItemListWindow);
                item = (list.IItemListWindow(0) as IWindowContainer);
                icon = (IWindowContainer(item.findChildByName("like")).findChildByName("icon") as IBitmapWrapperWindow);
                icon.bitmap = (assets.getAssetByName("stream_thumb_png").content as BitmapData);
                icon.disposesBitmap = false;
                EventStreamEntity._SafeStr_10964 = this;
                EventStreamEntity._SafeStr_9686 = item;
                EventStreamEntity._SafeStr_10962 = _localization;
                EventStreamEntity.ASSETS = assets;
                if (!this._SafeStr_10945){
                    this._SafeStr_10945 = new Timer(_SafeStr_10942);
                    this._SafeStr_10945.addEventListener(TimerEvent.TIMER, this.HabboEventStream);
                    this._SafeStr_10945.start();
                };
            };
        }
        private function HabboEventStream():void
        {
            var _local_1:IWindow = this._window.findChildByName(_SafeStr_10929);
            var _local_2:IWindow = this._window.findChildByName(_SafeStr_10930);
            var _local_3:IWindow = this._window.findChildByName(_SafeStr_10931);
            if (this._SafeStr_10948){
                _local_1.visible = true;
                _local_2.visible = false;
                _local_3.visible = (this._SafeStr_10944.length == 0);
            }
            else {
                _local_1.visible = false;
                _local_2.visible = true;
                _local_3.visible = false;
            };
        }
        private function WelcomeScreenController(_arg_1:WindowMouseEvent):void
        {
            switch (_arg_1.target.name){
                case CLOSE:
                    this.visible = false;
                    return;
                case _SafeStr_10935:
                    this.HabboEventStream(false);
                    return;
                case ACTIVATE:
                    this.HabboEventStream(true);
                    return;
                case _SafeStr_10936:
                    _windowManager.alert("${catalog.alert.external.link.title}", "${catalog.alert.external.link.desc}", 0, null);
                    HabboWebTools.HTMLTextController(_SafeStr_10977.getKey("link.friendbar.stream.settings.see.more", ""));
                    return;
            };
        }
        private function HabboEventStream(_arg_1:Boolean):void
        {
            this._SafeStr_10948 = _arg_1;
            this.HabboEventStream(_arg_1);
            this.HabboEventStream();
            if (_arg_1){
                this._SafeStr_10946.start();
                this.refreshEventStream();
            }
            else {
                this._SafeStr_10946.stop();
            };
            Logger.log(("Streaming enabled: " + _arg_1));
        }
        private function HabboEventStream(_arg_1:TimerEvent):void
        {
            var _local_2:EventStreamEntity;
            for each (_local_2 in this._SafeStr_10944) {
                _local_2.minutesElapsed = (_local_2.minutesElapsed + 1);
            };
        }
        private function HabboEventStream(_arg_1:TimerEvent):void
        {
            if (((this.visible) || (!(this._SafeStr_10950)))){
                this.HabboEventStream(this._SafeStr_10953);
            };
        }
        private function HabboEventStream(_arg_1:uint):void
        {
            if (((((this._connection) && (this._connection.connected))) && (this._SafeStr_10951))){
                this._connection.send(new GetEventStreamComposer((((_arg_1 == _SafeStr_10937)) ? GetEventStreamComposer._SafeStr_4509 : GetEventStreamComposer._SafeStr_4510)));
                this._initialized = true;
                Logger.log(("Requested stream events in mode " + _arg_1));
            };
        }
        private function HabboEventStream(_arg_1:IID, _arg_2:IUnknown):void
        {
            this._SafeStr_10883 = (_arg_2 as IHabboCommunicationManager);
            this._SafeStr_10883.HabboCommunicationManager(new EventStreamEvent(this.HabboEventStream));
            this._SafeStr_10883.HabboCommunicationManager(new UserObjectEvent(this.HabboEventStream));
            this._connection = this._SafeStr_10883.HabboCommunicationManager(this.HabboEventStream);
        }
        private function HabboEventStream(_arg_1:IConnection):void
        {
            this._connection = _arg_1;
        }
        private function HabboEventStream(_arg_1:EventStreamEvent):void
        {
            this.populate(_arg_1.events);
            this._SafeStr_10947.setStreamIconNotify(((!(this.visible)) && (this._SafeStr_10950)));
        }
        private function HabboEventStream(_arg_1:int=1):void
        {
            var _local_2:Vector.<EventStreamData> = new Vector.<EventStreamData>();
            var _local_3:int;
            while (_local_3 < _arg_1) {
                _local_2.push(new EventStreamData(_local_3, EventStreamData._SafeStr_10771, String((_local_3 * 1000)), ("FooBar" + _local_3), "m", "http://d63.varoke.net/habbo-imaging/badge/b1003Xs05175s05173s091145ec244dcc5eaf54aaabf367665f39c67.gif", _local_3, EventStreamData._SafeStr_10777, 3, true, new TestMessageWrapper(["1234", ("Friend's friend" + _local_3)])));
                _local_3++;
            };
            this.populate(_local_2);
        }
        private function HabboEventStream(_arg_1:IID, _arg_2:IUnknown):void
        {
            this._SafeStr_10947 = (_arg_2 as IHabboFriendBarView);
        }
        override protected function onConfigurationAvailable(_arg_1:IID, _arg_2:IUnknown):void
        {
            super.onConfigurationAvailable(_arg_1, _arg_2);
            this._SafeStr_10951 = _SafeStr_10977.getBoolean("friendbar.stream.enabled", false);
            this._SafeStr_10952 = _SafeStr_10977.getBoolean("friendbar.stream.liking.enabled", false);
        }
        private function HabboEventStream(_arg_1:Boolean):void
        {
            if (((this._connection) && (this._connection.connected))){
                this._connection.send(new SetEventStreamingAllowedComposer(_arg_1));
            };
        }
        private function HabboEventStream(_arg_1:UserObjectEvent):void
        {
            this._SafeStr_10948 = _arg_1.getParser().streamPublishingAllowed;
            if (this._SafeStr_10948){
                this._SafeStr_10946.start();
            };
            Logger.log(("Stream events allowed " + this._SafeStr_10948));
        }
        public function refreshEventStream():void
        {
            if (this._SafeStr_10948){
                this.HabboEventStream(this._SafeStr_10953);
            };
        }
        public function IHabboEventStream(_arg_1:EventStreamEntity):void
        {
            if (((((((this._connection) && (this._connection.connected))) && (this._SafeStr_10951))) && (this._SafeStr_10952))){
                _arg_1.isLikable = false;
                _arg_1.numberOfLikes++;
                this._connection.send(new LikeStreamEventMessageComposer(_arg_1.id, _sessionDataManager.userId));
                Logger.log(("Like event " + _arg_1));
            };
        }

    }
}//package com.sulake.habbo.friendbar.stream

// IID = "_-3KV" (String#7712, DoABC#2)
// _SafeStr_10771 = "_-kc" (String#24054, DoABC#2)
// _SafeStr_10772 = "_-3Ji" (String#22272, DoABC#2)
// _SafeStr_10773 = "_-Rp" (String#23317, DoABC#2)
// _SafeStr_10774 = "_-2Sx" (String#20159, DoABC#2)
// _SafeStr_10775 = "_-1N5" (String#17403, DoABC#2)
// _SafeStr_10776 = "_-QJ" (String#23263, DoABC#2)
// _SafeStr_10777 = "_-SO" (String#23341, DoABC#2)
// _SafeStr_10778 = "_-056" (String#14247, DoABC#2)
// _SafeStr_10779 = "_-0X5" (String#15318, DoABC#2)
// _SafeStr_10780 = "_-16V" (String#16718, DoABC#2)
// actionId = "_-05Y" (String#14265, DoABC#2)
// accountName = "_-0Bf" (String#14514, DoABC#2)
// imageFilePath = "_-18y" (String#16814, DoABC#2)
// minutesSinceEvent = "_-0ik" (String#15782, DoABC#2)
// linkTargetType = "_-26M" (String#19268, DoABC#2)
// numberOfLikes = "_-aS" (String#23651, DoABC#2)
// isLikable = "_-0TJ" (String#15183, DoABC#2)
// accountGender = "_-0Dw" (String#14604, DoABC#2)
// _SafeStr_10883 = "_-0Kv" (String#3975, DoABC#2)
// onConfigurationAvailable = "_-pU" (String#2202, DoABC#2)
// HabboEventStream = "_-1id" (String#5725, DoABC#2)
// refreshEventStream = "_-1Zw" (String#1711, DoABC#2)
// IHabboEventStream = "_-1tw" (String#5918, DoABC#2)
// _SafeStr_10929 = "_-PX" (String#23227, DoABC#2)
// _SafeStr_10930 = "_-3DN" (String#22011, DoABC#2)
// _SafeStr_10931 = "_-2Wc" (String#20308, DoABC#2)
// _SafeStr_10932 = "_-1bg" (String#5593, DoABC#2)
// _SafeStr_10933 = "_-1-7" (String#16434, DoABC#2)
// _SafeStr_10934 = "_-1Pv" (String#17505, DoABC#2)
// _SafeStr_10935 = "_-3J5" (String#22243, DoABC#2)
// _SafeStr_10936 = "_-1mp" (String#18414, DoABC#2)
// _SafeStr_10937 = "_-1qX" (String#18564, DoABC#2)
// _SafeStr_10938 = "_-2mL" (String#20933, DoABC#2)
// _SafeStr_10939 = "_-2w-" (String#21309, DoABC#2)
// _SafeStr_10940 = "_-2k7" (String#20852, DoABC#2)
// _SafeStr_10941 = "_-1CH" (String#16954, DoABC#2)
// _SafeStr_10942 = "_-2C6" (String#19486, DoABC#2)
// _SafeStr_10943 = "_-0NY" (String#14974, DoABC#2)
// _SafeStr_10944 = "_-2cM" (String#20538, DoABC#2)
// _SafeStr_10945 = "_-G9" (String#22859, DoABC#2)
// _SafeStr_10946 = "_-0Rj" (String#15128, DoABC#2)
// _SafeStr_10947 = "_-0iy" (String#15789, DoABC#2)
// _SafeStr_10948 = "_-2Hk" (String#19715, DoABC#2)
// _SafeStr_10949 = "_-kl" (String#24059, DoABC#2)
// _SafeStr_10950 = "_-205" (String#19014, DoABC#2)
// _SafeStr_10951 = "_-Z" (String#23600, DoABC#2)
// _SafeStr_10952 = "_-0Fq" (String#14676, DoABC#2)
// _SafeStr_10953 = "_-0-J" (String#14024, DoABC#2)
// _SafeStr_10954 = "_-0KT" (String#14858, DoABC#2)
// _SafeStr_10955 = "_-2C8" (String#19488, DoABC#2)
// _SafeStr_10956 = "_-2Zg" (String#20427, DoABC#2)
// HabboEventStream = "_-20w" (String#19049, DoABC#2)
// HabboEventStream = "_-29Q" (String#19380, DoABC#2)
// HabboEventStream = "_-3CY" (String#21977, DoABC#2)
// HabboEventStream = "_-xs" (String#24609, DoABC#2)
// HabboEventStream = "_-1jp" (String#18277, DoABC#2)
// _SafeStr_10962 = "_-2hq" (String#20767, DoABC#2)
// ASSETS = "_-391" (String#21846, DoABC#2)
// _SafeStr_10964 = "_-0ri" (String#16110, DoABC#2)
// HabboEventStream = "_-0xR" (String#16330, DoABC#2)
// HabboEventStream = "_-Ki" (String#23033, DoABC#2)
// HabboEventStream = "_-KH" (String#23016, DoABC#2)
// isLikingEnabled = "_-2HJ" (String#19696, DoABC#2)
// minutesElapsed = "_-2S-" (String#20118, DoABC#2)
// even = "_-1TK" (String#17638, DoABC#2)
// HabboEventStream = "_-30a" (String#21525, DoABC#2)
// HabboEventStream = "_-vZ" (String#24511, DoABC#2)
// _localization = "_-07" (String#3703, DoABC#2)
// _SafeStr_10974 = "_-0Ib" (String#14784, DoABC#2)
// _SafeStr_10975 = "_-2Dk" (String#19556, DoABC#2)
// HabboEventStream = "_-1wI" (String#18811, DoABC#2)
// _SafeStr_10977 = "_-01o" (String#3598, DoABC#2)
// HabboEventStream = "_-0hL" (String#15722, DoABC#2)
// HabboEventStream = "_-pc" (String#24258, DoABC#2)
// HabboEventStream = "_-26" (String#19258, DoABC#2)
// HabboEventStream = "_-0Sd" (String#15157, DoABC#2)
// setStreamIconNotify = "_-0YR" (String#4272, DoABC#2)
// HabboEventStream = "_-36E" (String#21739, DoABC#2)
// WindowEvent = "_-Jh" (String#2085, DoABC#2)
// ILocalization = "_-2EY" (String#1839, DoABC#2)
// BadgeImageReadyEvent = "_-03M" (String#14177, DoABC#2)
// HabboWebTools = "_-2pX" (String#21059, DoABC#2)
// IScrollbarWindow = "_-2fP" (String#1920, DoABC#2)
// AbstractView = "_-0VM" (String#4212, DoABC#2)
// IHabboFriendBarView = "_-0n8" (String#4571, DoABC#2)
// IHabboEventStream = "_-2Uk" (String#6661, DoABC#2)
// HabboEventStream = "_-1vJ" (String#5947, DoABC#2)
// UserObjectEvent = "_-1HL" (String#17163, DoABC#2)
// LinkTarget = "_-1HG" (String#1650, DoABC#2)
// TestMessageWrapper = "_-1Bc" (String#16924, DoABC#2)
// LikeStreamEventMessageComposer = "_-23U" (String#19154, DoABC#2)
// EventStreamEvent = "_-0fC" (String#15637, DoABC#2)
// SetEventStreamingAllowedComposer = "_-2Hr" (String#19721, DoABC#2)
// GetEventStreamComposer = "_-01r" (String#14122, DoABC#2)
// badgeId = "_-g6" (String#23896, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// streamPublishingAllowed = "_-3d" (String#22359, DoABC#2)
// RSFRE_FRIEND_REQUEST = "_-2Wu" (String#20318, DoABC#2)
// WelcomeScreenController = "_-0Kd" (String#584, DoABC#2)
// HTMLTextController = "_-27c" (String#6194, DoABC#2)
// _SafeStr_4509 = "_-2aC" (String#20450, DoABC#2)
// _SafeStr_4510 = "_-2n7" (String#20967, DoABC#2)
// HabboCommunicationManager = "_-0r" (String#4663, DoABC#2)
// HabboCommunicationManager = "_-0AQ" (String#809, DoABC#2)
// BIRE_BADGE_IMAGE_READY = "_-38f" (String#21828, DoABC#2)
// badgeImage = "_-250" (String#19222, DoABC#2)
// _initialized = "_-0EY" (String#214, DoABC#2)
// disposesBitmap = "_-03U" (String#3637, DoABC#2)
// _SafeStr_6770 = "_-39Q" (String#7500, DoABC#2)
// IItemListWindow = "_-Td" (String#8279, DoABC#2)
// _SafeStr_7449 = "_-01-" (String#14095, DoABC#2)
// _SafeStr_7460 = "_-ZZ" (String#23619, DoABC#2)
// _SafeStr_7540 = "_-1l4" (String#444, DoABC#2)
// IHabboCommunicationManager = "_-0ls" (String#4545, DoABC#2)
// _sessionDataManager = "_-0kq" (String#149, DoABC#2)
// raw = "_-Xc" (String#8361, DoABC#2)
// allocate = "_-08G" (String#14374, DoABC#2)
// WE_ENABLED = "_-2J1" (String#19767, DoABC#2)
// WE_DISABLED = "_-xm" (String#24603, DoABC#2)
// bitmapAssetName = "_-1XS" (String#5507, DoABC#2)
// _SafeStr_9686 = "_-2XJ" (String#6707, DoABC#2)


