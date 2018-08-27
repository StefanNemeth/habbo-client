
package com.sulake.habbo.ui.widget.infostand
{
    import com.sulake.habbo.ui.widget.RoomWidgetBase;
    import com.sulake.core.window.IWindowContainer;
    import flash.utils.Timer;
    import com.sulake.habbo.configuration.IHabboConfigurationManager;
    import com.sulake.habbo.catalog.IHabboCatalog;
    import flash.events.TimerEvent;
    import com.sulake.habbo.ui.IRoomWidgetHandler;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.habbo.localization.IHabboLocalizationManager;
    import com.sulake.habbo.ui.handler.InfoStandWidgetHandler;
    import com.sulake.core.window.IWindow;
    import com.sulake.habbo.window.enum.HabboWindowType;
    import com.sulake.habbo.window.enum.HabboWindowStyle;
    import com.sulake.habbo.window.enum.HabboWindowParam;
    import flash.geom.Rectangle;
    import flash.display.BitmapData;
    import com.sulake.core.assets.IAsset;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.habbo.ui.widget.events.RoomWidgetRoomObjectUpdateEvent;
    import com.sulake.habbo.ui.widget.events.RoomWidgetUserInfoUpdateEvent;
    import com.sulake.habbo.ui.widget.events.RoomWidgetFurniInfoUpdateEvent;
    import com.sulake.habbo.ui.widget.events.RoomWidgetUserTagsUpdateEvent;
    import com.sulake.habbo.ui.widget.events.RoomWidgetUserFigureUpdateEvent;
    import com.sulake.habbo.ui.widget.events.RoomWidgetUserBadgesUpdateEvent;
    import com.sulake.habbo.ui.widget.events.RoomWidgetBadgeImageUpdateEvent;
    import com.sulake.habbo.ui.widget.events.RoomWidgetPetInfoUpdateEvent;
    import com.sulake.habbo.ui.widget.events.RoomWidgetPetCommandsUpdateEvent;
    import com.sulake.habbo.ui.widget.events.RoomWidgetSongUpdateEvent;
    import flash.events.IEventDispatcher;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetUserActionMessage;
    import com.sulake.habbo.ui.widget.enums.RoomWidgetInfostandExtraParamEnum;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetRoomObjectMessage;

    public class InfostandWidget extends RoomWidgetBase 
    {

        private const _SafeStr_14071:String = "infostand_user_view";
        private const _SafeStr_14072:String = "infostand_furni_view";
        private const _SafeStr_14073:String = "infostand_pet_view";
        private const _SafeStr_14074:String = "infostand_bot_view";
        private const _SafeStr_14075:String = "infostand_jukebox_view";
        private const _SafeStr_14076:String = "infostand_songdisk_view";
        private const _SafeStr_14077:int = 3000;

        private var _SafeStr_14078:InfoStandFurniView;
        private var _SafeStr_14079:InfoStandUserView;
        private var _SafeStr_14080:InfoStandPetView;
        private var _SafeStr_14081:InfoStandBotView;
        private var _SafeStr_14082:InfoStandJukeboxView;
        private var _SafeStr_14083:InfoStandSongDiskView;
        private var _SafeStr_14084:Array;
        private var _userData:InfostandUserData;
        private var _furniData:InfostandFurniData;
        private var _petData:InfoStandPetData;
        private var _mainContainer:IWindowContainer;
        private var _SafeStr_14086:Timer;
        private var _config:IHabboConfigurationManager;
        private var _catalog:IHabboCatalog;

        public function InfostandWidget(_arg_1:IRoomWidgetHandler, _arg_2:IHabboWindowManager, _arg_3:IAssetLibrary, _arg_4:IHabboLocalizationManager, _arg_5:IHabboConfigurationManager, _arg_6:IHabboCatalog)
        {
            super(_arg_1, _arg_2, _arg_3, _arg_4);
            this._config = _arg_5;
            this._catalog = _arg_6;
            this._SafeStr_14078 = new InfoStandFurniView(this, this._SafeStr_14072, this._catalog);
            this._SafeStr_14079 = new InfoStandUserView(this, this._SafeStr_14071);
            this._SafeStr_14080 = new InfoStandPetView(this, this._SafeStr_14073, this._catalog);
            this._SafeStr_14081 = new InfoStandBotView(this, this._SafeStr_14074);
            this._SafeStr_14082 = new InfoStandJukeboxView(this, this._SafeStr_14075, this._catalog);
            this._SafeStr_14083 = new InfoStandSongDiskView(this, this._SafeStr_14076, this._catalog);
            this._userData = new InfostandUserData();
            this._furniData = new InfostandFurniData();
            this._petData = new InfoStandPetData();
            this._SafeStr_14086 = new Timer(this._SafeStr_14077);
            this._SafeStr_14086.addEventListener(TimerEvent.TIMER, this.onUpdateTimer);
            this.mainContainer.visible = false;
            this.handler.widget = this;
        }
        public function get handler():InfoStandWidgetHandler
        {
            return ((_handler as InfoStandWidgetHandler));
        }
        override public function get mainWindow():IWindow
        {
            return (this.mainContainer);
        }
        public function get config():IHabboConfigurationManager
        {
            return (this._config);
        }
        public function get mainContainer():IWindowContainer
        {
            if (this._mainContainer == null){
                this._mainContainer = (windowManager.createWindow("infostand_main_container", "", HabboWindowType._SafeStr_3728, HabboWindowStyle._SafeStr_4662, HabboWindowParam._SafeStr_4662, new Rectangle(0, 0, 50, 100)) as IWindowContainer);
                this._mainContainer.tags.push("room_widget_infostand");
                this._mainContainer.background = true;
                this._mainContainer.color = 0;
            };
            return (this._mainContainer);
        }
        public function favouriteGroupUpdated(_arg_1:int, _arg_2:int, _arg_3:int):void
        {
            var _local_5:String;
            var _local_6:BitmapData;
            if (((!(this.userData)) || (!((this.userData.userRoomId == _arg_1))))){
                return;
            };
            if (!this.mainContainer){
                return;
            };
            var _local_4:IWindow = this.mainContainer.findChildByName(this._SafeStr_14071);
            if (((!(_local_4)) || (!(_local_4.visible)))){
                return;
            };
            this._SafeStr_14079.clearGroupBadge();
            if (_arg_2 != -1){
                _local_5 = this.handler.container.sessionDataManager.getGroupBadgeId(_arg_2);
                this.userData.groupId = _arg_2;
                this.userData.groupBadgeId = _local_5;
                _local_6 = this.handler.container.sessionDataManager.getGroupBadgeImage(_local_5);
                this._SafeStr_14079.setGroupBadgeImage(_local_6);
            };
        }
        public function getXmlWindow(name:String):IWindow
        {
            var asset:IAsset;
            var xmlAsset:XmlAsset;
            var window:IWindow;
            try {
                asset = assets.getAssetByName(name);
                xmlAsset = XmlAsset(asset);
                window = windowManager.buildFromXML(XML(xmlAsset.content));
            }
            catch(e:Error) {
                Logger.log(("[InfoStandWidget] Missing window XML: " + name));
            };
            return (window);
        }
        override public function dispose():void
        {
            if (this._SafeStr_14086){
                this._SafeStr_14086.stop();
            };
            this._SafeStr_14086 = null;
            if (this._SafeStr_14079){
                this._SafeStr_14079.dispose();
            };
            this._SafeStr_14079 = null;
            if (this._SafeStr_14078){
                this._SafeStr_14078.dispose();
            };
            this._SafeStr_14078 = null;
            if (this._SafeStr_14081){
                this._SafeStr_14081.dispose();
            };
            this._SafeStr_14081 = null;
            if (this._SafeStr_14080){
                this._SafeStr_14080.dispose();
            };
            this._SafeStr_14080 = null;
            if (this._SafeStr_14082){
                this._SafeStr_14082.dispose();
            };
            this._SafeStr_14082 = null;
            if (this._SafeStr_14083){
                this._SafeStr_14083.dispose();
            };
            this._SafeStr_14083 = null;
            super.dispose();
        }
        override public function registerUpdateEvents(_arg_1:IEventDispatcher):void
        {
            if (_arg_1 == null){
                return;
            };
            _arg_1.addEventListener(RoomWidgetRoomObjectUpdateEvent.RWROUE_OBJECT_SELECTED, this.onRoomObjectSelected);
            _arg_1.addEventListener(RoomWidgetRoomObjectUpdateEvent.RWROUE_OBJECT_DESELECTED, this.onClose);
            _arg_1.addEventListener(RoomWidgetRoomObjectUpdateEvent.RWROUE_USER_REMOVED, this.onRoomObjectRemoved);
            _arg_1.addEventListener(RoomWidgetRoomObjectUpdateEvent.RWROUE_FURNI_REMOVED, this.onRoomObjectRemoved);
            _arg_1.addEventListener(RoomWidgetUserInfoUpdateEvent.RWUIUE_OWN_USER, this.onUserInfo);
            _arg_1.addEventListener(RoomWidgetUserInfoUpdateEvent.RWUIUE_PEER, this.onUserInfo);
            _arg_1.addEventListener(RoomWidgetUserInfoUpdateEvent.BOT, this.onBotInfo);
            _arg_1.addEventListener(RoomWidgetFurniInfoUpdateEvent.RWFIUE_FURNI, this.onFurniInfo);
            _arg_1.addEventListener(RoomWidgetUserTagsUpdateEvent.RWUTUE_USER_TAGS, this.onUserTags);
            _arg_1.addEventListener(RoomWidgetUserFigureUpdateEvent.RWUTUE_USER_FIGURE, this.onUserFigureUpdate);
            _arg_1.addEventListener(RoomWidgetUserBadgesUpdateEvent.RWUBUE_USER_BADGES, this.onUserBadges);
            _arg_1.addEventListener(RoomWidgetBadgeImageUpdateEvent.RWBIUE_BADGE_IMAGE, this.onBadgeImage);
            _arg_1.addEventListener(RoomWidgetPetInfoUpdateEvent.PET_INFO, this.onPetInfo);
            _arg_1.addEventListener(RoomWidgetPetCommandsUpdateEvent.PET_COMMANDS, this.onPetCommands);
            _arg_1.addEventListener(RoomWidgetSongUpdateEvent.RWSUE_PLAYING_CHANGED, this.onSongUpdate);
            _arg_1.addEventListener(RoomWidgetSongUpdateEvent.RWSUE_DATA_RECEIVED, this.onSongUpdate);
            super.registerUpdateEvents(_arg_1);
        }
        override public function unregisterUpdateEvents(_arg_1:IEventDispatcher):void
        {
            if (_arg_1 == null){
                return;
            };
            _arg_1.removeEventListener(RoomWidgetRoomObjectUpdateEvent.RWROUE_OBJECT_SELECTED, this.onRoomObjectSelected);
            _arg_1.removeEventListener(RoomWidgetRoomObjectUpdateEvent.RWROUE_OBJECT_DESELECTED, this.onClose);
            _arg_1.removeEventListener(RoomWidgetRoomObjectUpdateEvent.RWROUE_USER_REMOVED, this.onRoomObjectRemoved);
            _arg_1.removeEventListener(RoomWidgetRoomObjectUpdateEvent.RWROUE_FURNI_REMOVED, this.onRoomObjectRemoved);
            _arg_1.removeEventListener(RoomWidgetUserInfoUpdateEvent.RWUIUE_OWN_USER, this.onUserInfo);
            _arg_1.removeEventListener(RoomWidgetUserInfoUpdateEvent.RWUIUE_PEER, this.onUserInfo);
            _arg_1.removeEventListener(RoomWidgetUserInfoUpdateEvent.BOT, this.onBotInfo);
            _arg_1.removeEventListener(RoomWidgetFurniInfoUpdateEvent.RWFIUE_FURNI, this.onFurniInfo);
            _arg_1.removeEventListener(RoomWidgetUserTagsUpdateEvent.RWUTUE_USER_TAGS, this.onUserTags);
            _arg_1.removeEventListener(RoomWidgetUserFigureUpdateEvent.RWUTUE_USER_FIGURE, this.onUserFigureUpdate);
            _arg_1.removeEventListener(RoomWidgetUserBadgesUpdateEvent.RWUBUE_USER_BADGES, this.onUserBadges);
            _arg_1.removeEventListener(RoomWidgetBadgeImageUpdateEvent.RWBIUE_BADGE_IMAGE, this.onBadgeImage);
            _arg_1.removeEventListener(RoomWidgetPetInfoUpdateEvent.PET_INFO, this.onPetInfo);
            _arg_1.removeEventListener(RoomWidgetPetCommandsUpdateEvent.PET_COMMANDS, this.onPetCommands);
            _arg_1.removeEventListener(RoomWidgetSongUpdateEvent.RWSUE_PLAYING_CHANGED, this.onSongUpdate);
            _arg_1.removeEventListener(RoomWidgetSongUpdateEvent.RWSUE_DATA_RECEIVED, this.onSongUpdate);
        }
        public function get userData():InfostandUserData
        {
            return (this._userData);
        }
        public function get furniData():InfostandFurniData
        {
            return (this._furniData);
        }
        public function get petData():InfoStandPetData
        {
            return (this._petData);
        }
        private function onUpdateTimer(_arg_1:TimerEvent):void
        {
            if (this._SafeStr_14080 == null){
                return;
            };
            messageListener.processWidgetMessage(new RoomWidgetUserActionMessage(RoomWidgetUserActionMessage.RWUAM_REQUEST_PET_UPDATE, this._SafeStr_14080.getCurrentPetId()));
        }
        private function onUserInfo(_arg_1:RoomWidgetUserInfoUpdateEvent):void
        {
            this.userData.setData(_arg_1);
            this._SafeStr_14079.update(_arg_1);
            this.selectView(this._SafeStr_14071);
            if (this._SafeStr_14086){
                this._SafeStr_14086.stop();
            };
        }
        private function onBotInfo(_arg_1:RoomWidgetUserInfoUpdateEvent):void
        {
            this.userData.setData(_arg_1);
            this._SafeStr_14081.update(_arg_1);
            this.selectView(this._SafeStr_14074);
            if (this._SafeStr_14086){
                this._SafeStr_14086.stop();
            };
        }
        private function onFurniInfo(_arg_1:RoomWidgetFurniInfoUpdateEvent):void
        {
            this.furniData.setData(_arg_1);
            if (_arg_1.extraParam == RoomWidgetInfostandExtraParamEnum.RWEIEP_JUKEBOX){
                this._SafeStr_14082.update(_arg_1);
                this.selectView(this._SafeStr_14075);
            }
            else {
                if (_arg_1.extraParam.indexOf(RoomWidgetInfostandExtraParamEnum.RWEIEP_SONGDISK) != -1){
                    this._SafeStr_14083.update(_arg_1);
                    this.selectView(this._SafeStr_14076);
                }
                else {
                    this._SafeStr_14078.update(_arg_1);
                    this.selectView(this._SafeStr_14072);
                };
            };
            if (this._SafeStr_14086){
                this._SafeStr_14086.stop();
            };
        }
        private function onPetInfo(_arg_1:RoomWidgetPetInfoUpdateEvent):void
        {
            this.petData.setData(_arg_1);
            this.userData.petRespectLeft = _arg_1.petRespectLeft;
            this._SafeStr_14080.update(this.petData);
            this.selectView(this._SafeStr_14073);
            if (this._SafeStr_14086){
                this._SafeStr_14086.start();
            };
        }
        private function onPetCommands(_arg_1:RoomWidgetPetCommandsUpdateEvent):void
        {
            this._SafeStr_14080.updateEnabledTrainingCommands(_arg_1.id, new CommandConfiguration(_arg_1.allCommands, _arg_1.enabledCommands));
        }
        private function onUserTags(_arg_1:RoomWidgetUserTagsUpdateEvent):void
        {
            if (_arg_1.isOwnUser){
                this._SafeStr_14084 = _arg_1.tags;
            };
            if (_arg_1.userId != this.userData.userId){
                return;
            };
            if (_arg_1.isOwnUser){
                this._SafeStr_14079.setTags(_arg_1.tags);
            }
            else {
                this._SafeStr_14079.setTags(_arg_1.tags, this._SafeStr_14084);
            };
        }
        private function onUserFigureUpdate(_arg_1:RoomWidgetUserFigureUpdateEvent):void
        {
            if (_arg_1.userId != this.userData.userId){
                return;
            };
            if (this.userData.isBot()){
                this._SafeStr_14081.image = _arg_1.image;
            }
            else {
                this._SafeStr_14079.image = _arg_1.image;
                this._SafeStr_14079.setMotto(_arg_1.customInfo, _arg_1.isOwnUser);
                this._SafeStr_14079.achievementScore = _arg_1.achievementScore;
            };
        }
        private function onUserBadges(_arg_1:RoomWidgetUserBadgesUpdateEvent):void
        {
            if (_arg_1.userId != this.userData.userId){
                return;
            };
            this.userData.badges = _arg_1.badges;
            this._SafeStr_14079.clearBadges();
        }
        private function onBadgeImage(_arg_1:RoomWidgetBadgeImageUpdateEvent):void
        {
            var _local_2:int = this.userData.badges.indexOf(_arg_1.badgeID);
            if (_local_2 >= 0){
                if (this.userData.isBot()){
                    this._SafeStr_14081.setBadgeImage(_local_2, _arg_1.badgeImage);
                }
                else {
                    this._SafeStr_14079.setBadgeImage(_local_2, _arg_1.badgeImage);
                };
                return;
            };
            if (_arg_1.badgeID == this.userData.groupBadgeId){
                this._SafeStr_14079.setGroupBadgeImage(_arg_1.badgeImage);
            };
        }
        private function onRoomObjectSelected(_arg_1:RoomWidgetRoomObjectUpdateEvent):void
        {
            var _local_2:RoomWidgetRoomObjectMessage = new RoomWidgetRoomObjectMessage(RoomWidgetRoomObjectMessage.RWROM_GET_OBJECT_INFO, _arg_1.id, _arg_1.category);
            messageListener.processWidgetMessage(_local_2);
        }
        private function onRoomObjectRemoved(_arg_1:RoomWidgetRoomObjectUpdateEvent):void
        {
            var _local_2:Boolean;
            switch (_arg_1.type){
                case RoomWidgetRoomObjectUpdateEvent.RWROUE_FURNI_REMOVED:
                    _local_2 = (_arg_1.id == this._furniData.id);
                    break;
                case RoomWidgetRoomObjectUpdateEvent.RWROUE_USER_REMOVED:
                    if (((((!((this._SafeStr_14079 == null))) && (!((this._SafeStr_14079.window == null))))) && (this._SafeStr_14079.window.visible))){
                        _local_2 = (_arg_1.id == this._userData.userRoomId);
                        break;
                    };
                    if (((((!((this._SafeStr_14080 == null))) && (!((this._SafeStr_14080.window == null))))) && (this._SafeStr_14080.window.visible))){
                        _local_2 = (_arg_1.id == this._petData.roomIndex);
                        break;
                    };
                    if (((((!((this._SafeStr_14081 == null))) && (!((this._SafeStr_14081.window == null))))) && (this._SafeStr_14081.window.visible))){
                        _local_2 = (_arg_1.id == this._userData.userRoomId);
                        break;
                    };
            };
            if (_local_2){
                this.close();
            };
        }
        private function onSongUpdate(_arg_1:RoomWidgetSongUpdateEvent):void
        {
            this._SafeStr_14082.updateSongInfo(_arg_1);
            this._SafeStr_14083.updateSongInfo(_arg_1);
        }
        public function close():void
        {
            this.hideChildren();
            if (this._SafeStr_14086){
                this._SafeStr_14086.stop();
            };
        }
        private function onClose(_arg_1:RoomWidgetRoomObjectUpdateEvent):void
        {
            this.close();
            if (this._SafeStr_14086){
                this._SafeStr_14086.stop();
            };
        }
        private function hideChildren():void
        {
            var _local_1:int;
            if (this._mainContainer != null){
                _local_1 = 0;
                while (_local_1 < this._mainContainer.numChildren) {
                    this._mainContainer.getChildAt(_local_1).visible = false;
                    _local_1++;
                };
            };
        }
        private function selectView(_arg_1:String):void
        {
            this.hideChildren();
            var _local_2:IWindow = (this.mainContainer.getChildByName(_arg_1) as IWindow);
            if (_local_2 == null){
                return;
            };
            _local_2.visible = true;
            this.mainContainer.visible = true;
            this.mainContainer.width = _local_2.width;
            this.mainContainer.height = _local_2.height;
        }
        public function refreshContainer():void
        {
            var _local_1:IWindow;
            var _local_2:int;
            while (_local_2 < this.mainContainer.numChildren) {
                _local_1 = this.mainContainer.getChildAt(_local_2);
                if (_local_1.visible){
                    this.mainContainer.width = _local_1.width;
                    this.mainContainer.height = _local_1.height;
                };
                _local_2++;
            };
        }

    }
}//package com.sulake.habbo.ui.widget.infostand

// setData = "_-1x" (String#18846, DoABC#2)
// RWBIUE_BADGE_IMAGE = "_-1qO" (String#18558, DoABC#2)
// refreshContainer = "_-Ez" (String#22811, DoABC#2)
// getCurrentPetId = "_-01n" (String#14121, DoABC#2)
// updateEnabledTrainingCommands = "_-1L2" (String#17315, DoABC#2)
// updateSongInfo = "_-oi" (String#24223, DoABC#2)
// setMotto = "_-1cu" (String#18008, DoABC#2)
// setTags = "_-37K" (String#21781, DoABC#2)
// setBadgeImage = "_-2Nw" (String#19961, DoABC#2)
// clearBadges = "_-6H" (String#22477, DoABC#2)
// clearGroupBadge = "_-1XP" (String#17793, DoABC#2)
// setGroupBadgeImage = "_-Rl" (String#23314, DoABC#2)
// isBot = "_-14m" (String#16645, DoABC#2)
// _SafeStr_14071 = "_-35y" (String#21727, DoABC#2)
// _SafeStr_14072 = "_-2Rj" (String#20109, DoABC#2)
// _SafeStr_14073 = "_-2GZ" (String#19664, DoABC#2)
// _SafeStr_14074 = "_-1Q5" (String#17514, DoABC#2)
// _SafeStr_14075 = "_-35G" (String#21703, DoABC#2)
// _SafeStr_14076 = "_-2JP" (String#19785, DoABC#2)
// _SafeStr_14077 = "_-6l" (String#22489, DoABC#2)
// _SafeStr_14078 = "_-38O" (String#21818, DoABC#2)
// _SafeStr_14079 = "_-3Fs" (String#22110, DoABC#2)
// _SafeStr_14080 = "_-1-U" (String#16447, DoABC#2)
// _SafeStr_14081 = "_-0FA" (String#14650, DoABC#2)
// _SafeStr_14082 = "_-0E3" (String#14610, DoABC#2)
// _SafeStr_14083 = "_-2dc" (String#20588, DoABC#2)
// _SafeStr_14084 = "_-1BX" (String#16920, DoABC#2)
// _userData = "_-1LW" (String#17334, DoABC#2)
// _SafeStr_14086 = "_-ck" (String#8468, DoABC#2)
// onUpdateTimer = "_-25g" (String#19245, DoABC#2)
// onRoomObjectSelected = "_-1W3" (String#17746, DoABC#2)
// onBotInfo = "_-9s" (String#22613, DoABC#2)
// onFurniInfo = "_-1is" (String#18240, DoABC#2)
// onUserFigureUpdate = "_-aE" (String#23642, DoABC#2)
// onSongUpdate = "_-0Iy" (String#14797, DoABC#2)
// HabboWindowParam = "_-29D" (String#6233, DoABC#2)
// HabboWindowStyle = "_-0E1" (String#14608, DoABC#2)
// HabboWindowType = "_-29U" (String#19384, DoABC#2)
// IHabboCatalog = "_-1fJ" (String#5651, DoABC#2)
// RoomWidgetBase = "_-0eQ" (String#4398, DoABC#2)
// RoomWidgetInfostandExtraParamEnum = "_-2ru" (String#7121, DoABC#2)
// InfoStandWidgetHandler = "_-2fW" (String#6859, DoABC#2)
// RoomWidgetRoomObjectUpdateEvent = "_-37T" (String#7457, DoABC#2)
// RoomWidgetUserInfoUpdateEvent = "_-28z" (String#6226, DoABC#2)
// InfoStandPetView = "_-3CN" (String#7558, DoABC#2)
// CommandConfiguration = "_-2sa" (String#21184, DoABC#2)
// InfoStandFurniView = "_-1e5" (String#5631, DoABC#2)
// InfoStandSongDiskView = "_-03l" (String#3641, DoABC#2)
// InfoStandUserView = "_-5X" (String#7772, DoABC#2)
// RoomWidgetUserBadgesUpdateEvent = "_-18I" (String#16786, DoABC#2)
// InfostandFurniData = "_-2iT" (String#20787, DoABC#2)
// RoomWidgetFurniInfoUpdateEvent = "_-1V1" (String#5455, DoABC#2)
// RoomWidgetPetCommandsUpdateEvent = "_-0xD" (String#16321, DoABC#2)
// RoomWidgetUserTagsUpdateEvent = "_-006" (String#14057, DoABC#2)
// RoomWidgetPetInfoUpdateEvent = "_-KB" (String#8087, DoABC#2)
// InfoStandJukeboxView = "_-3Fa" (String#7621, DoABC#2)
// RoomWidgetBadgeImageUpdateEvent = "_-1Sg" (String#17609, DoABC#2)
// InfoStandBotView = "_-0DT" (String#3817, DoABC#2)
// InfoStandPetData = "_-1oA" (String#5821, DoABC#2)
// RoomWidgetUserActionMessage = "_-22U" (String#19109, DoABC#2)
// RoomWidgetUserFigureUpdateEvent = "_-3DM" (String#22010, DoABC#2)
// RoomWidgetSongUpdateEvent = "_-0rz" (String#16120, DoABC#2)
// InfostandUserData = "_-nJ" (String#8664, DoABC#2)
// RWUAM_REQUEST_PET_UPDATE = "_-0Ro" (String#15130, DoABC#2)
// RWROM_GET_OBJECT_INFO = "_-cp" (String#23747, DoABC#2)
// registerUpdateEvents = "_-1yD" (String#1787, DoABC#2)
// RWROUE_FURNI_REMOVED = "_-2L6" (String#19851, DoABC#2)
// onRoomObjectRemoved = "_-1GC" (String#842, DoABC#2)
// unregisterUpdateEvents = "_-0-c" (String#3556, DoABC#2)
// _SafeStr_3728 = "_-1IW" (String#5215, DoABC#2)
// achievementScore = "_-16Z" (String#5005, DoABC#2)
// customInfo = "_-2Mk" (String#19916, DoABC#2)
// petRespectLeft = "_-0wV" (String#4782, DoABC#2)
// widget = "_-1yo" (String#18920, DoABC#2)
// handler = "_-06s" (String#1404, DoABC#2)
// _handler = "_-1Eb" (String#5153, DoABC#2)
// mainWindow = "_-2Lh" (String#1862, DoABC#2)
// RWROUE_OBJECT_DESELECTED = "_-8G" (String#22552, DoABC#2)
// RWUIUE_OWN_USER = "_-13K" (String#16592, DoABC#2)
// onUserInfo = "_-2pH" (String#623, DoABC#2)
// RWEIEP_JUKEBOX = "_-2Bo" (String#19475, DoABC#2)
// RWEIEP_SONGDISK = "_-0eV" (String#15606, DoABC#2)
// hideChildren = "_-14q" (String#1615, DoABC#2)
// _SafeStr_4662 = "_-0g1" (String#15673, DoABC#2)
// badgeImage = "_-250" (String#19222, DoABC#2)
// RWUBUE_USER_BADGES = "_-21B" (String#19059, DoABC#2)
// allCommands = "_-2QF" (String#20056, DoABC#2)
// enabledCommands = "_-0yX" (String#16375, DoABC#2)
// RWUTUE_USER_FIGURE = "_-0QV" (String#15081, DoABC#2)
// RWUTUE_USER_TAGS = "_-1la" (String#18357, DoABC#2)
// extraParam = "_-AM" (String#7874, DoABC#2)
// sessionDataManager = "_-0pX" (String#4623, DoABC#2)
// onClose = "_-2Ts" (String#54, DoABC#2)
// badgeID = "_-Cm" (String#22716, DoABC#2)
// _furniData = "_-13M" (String#1612, DoABC#2)
// RWUIUE_PEER = "_-2Tv" (String#20195, DoABC#2)
// onUserBadges = "_-8z" (String#2063, DoABC#2)
// onPetInfo = "_-0dE" (String#1512, DoABC#2)
// RWROUE_USER_REMOVED = "_-02u" (String#14156, DoABC#2)
// selectView = "_-1-8" (String#1597, DoABC#2)
// RWROUE_OBJECT_SELECTED = "_-0Yn" (String#15392, DoABC#2)
// RWFIUE_FURNI = "_-U0" (String#23409, DoABC#2)
// isOwnUser = "_-Je" (String#22991, DoABC#2)
// onUserTags = "_-T6" (String#2113, DoABC#2)
// onBadgeImage = "_-0fM" (String#1522, DoABC#2)
// RWSUE_PLAYING_CHANGED = "_-3LG" (String#22337, DoABC#2)
// RWSUE_DATA_RECEIVED = "_-0BQ" (String#14503, DoABC#2)
// getGroupBadgeId = "_-3Cg" (String#2022, DoABC#2)
// groupBadgeId = "_-s" (String#24362, DoABC#2)
// getGroupBadgeImage = "_-KC" (String#2087, DoABC#2)
// favouriteGroupUpdated = "_-X4" (String#23525, DoABC#2)


