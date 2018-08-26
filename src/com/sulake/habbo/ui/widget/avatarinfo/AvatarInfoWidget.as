
package com.sulake.habbo.ui.widget.avatarinfo
{
    import com.sulake.habbo.ui.widget.RoomWidgetBase;
    import com.sulake.core.runtime.IUpdateReceiver;
    import com.sulake.core.runtime.Component;
    import com.sulake.habbo.configuration.IHabboConfigurationManager;
    import com.sulake.core.utils.Map;
    import com.sulake.habbo.room.events.RoomEngineObjectEvent;
    import com.sulake.habbo.inventory.events.HabboInventoryEffectsEvent;
    import com.sulake.habbo.ui.IRoomWidgetHandler;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.habbo.localization.IHabboLocalizationManager;
    import com.sulake.habbo.ui.handler.AvatarInfoWidgetHandler;
    import com.sulake.habbo.session.IUserData;
    import com.sulake.habbo.room.object.RoomObjectCategoryEnum;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetRoomObjectMessage;
    import com.sulake.habbo.ui.widget.events.RoomWidgetAvatarInfoEvent;
    import com.sulake.habbo.ui.widget.events.RoomWidgetUserInfoUpdateEvent;
    import com.sulake.habbo.ui.widget.events.RoomWidgetRoomObjectUpdateEvent;
    import com.sulake.habbo.ui.widget.events.RoomWidgetFurniInfoUpdateEvent;
    import com.sulake.habbo.ui.widget.events.RoomWidgetPetInfoUpdateEvent;
    import com.sulake.habbo.ui.widget.events.RoomWidgetUserDataUpdateEvent;
    import com.sulake.habbo.ui.widget.events.RoomWidgetRoomEngineUpdateEvent;
    import com.sulake.habbo.ui.widget.events.RoomWidgetRoomObjectNameEvent;
    import flash.events.IEventDispatcher;
    import com.sulake.habbo.room.object.RoomObjectTypeEnum;
    import com.sulake.habbo.ui.widget.events.RoomWidgetUpdateEvent;
    import com.sulake.habbo.ui.widget.events.RoomWidgetUserLocationUpdateEvent;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetGetUserLocationMessage;
    import com.sulake.habbo.avatar.enum.AvatarEditorInstanceId;
    import com.sulake.habbo.session.HabboClubLevelEnum;
    import com.sulake.habbo.ui.widget.memenu.IWidgetAvatarEffect;

    public class AvatarInfoWidget extends RoomWidgetBase implements IUpdateReceiver 
    {

        private static const _useMinimizedOwnAvatarMenu:String = "use_minimized_own_avatar_menu";

        private var _component:Component;
        private var _configuration:IHabboConfigurationManager;
        private var _view:AvatarInfoView;
        private var _isInitialized:Boolean = false;
        private var _SafeStr_3876:Boolean = false;
        private var _SafeStr_6772:AvatarInfoData;
        private var _SafeStr_6773:Boolean;
        private var _SafeStr_3877:Boolean;
        private var _SafeStr_6774:int = -1;
        private var _SafeStr_6775:Boolean;
        private var _SafeStr_6776:AvatarInfoView;
        private var _SafeStr_6777:OwnAvatarMenuView;
        private var _SafeStr_6778:AvatarMenuView;
        private var _SafeStr_6779:Map;
        private var _isDancing:Boolean = false;
        private var _handlePetInfo:Boolean = true;

        public function AvatarInfoWidget(_arg_1:IRoomWidgetHandler, _arg_2:IHabboWindowManager, _arg_3:IAssetLibrary, _arg_4:IHabboConfigurationManager, _arg_5:IHabboLocalizationManager, _arg_6:Component)
        {
            super(_arg_1, _arg_2, _arg_3, _arg_5);
            this._component = _arg_6;
            this._configuration = _arg_4;
            this._SafeStr_6772 = new AvatarInfoData();
            this._SafeStr_6773 = ((this._configuration.getBoolean("menu.avatar.enabled", false)) || (false));
            this._SafeStr_3877 = this._configuration.getBoolean("menu.own_avatar.enabled", false);
            this._SafeStr_6779 = new Map();
            this.handler.roomEngine.events.addEventListener(RoomEngineObjectEvent.REOB_OBJECT_ADDED, this.onRoomObjectAdded);
            this.handler.roomEngine.events.addEventListener(RoomEngineObjectEvent.REOE_OBJECT_REMOVED, this.InfostandWidget);
            this.handler.container.inventory.events.addEventListener(HabboInventoryEffectsEvent.HIEE_EFFECTS_CHANGED, this.EffectsWidgetHandler);
            this.handler.widget = this;
        }
        public function get handler():AvatarInfoWidgetHandler
        {
            return ((_handler as AvatarInfoWidgetHandler));
        }
        public function get configuration():IHabboConfigurationManager
        {
            return (this._configuration);
        }
        public function set handlePetInfo(_arg_1:Boolean):void
        {
            this._handlePetInfo = _arg_1;
        }
        private function onRoomObjectAdded(_arg_1:RoomEngineObjectEvent):void
        {
            var _local_2:IUserData;
            if (_arg_1.category == RoomObjectCategoryEnum.OBJECT_CATEGORY_USER){
                _local_2 = this.handler.roomSession.userDataManager.getUserDataByIndex(_arg_1.objectId);
                if (_local_2){
                    if (this.handler.friendList.HabboFriendList().indexOf(_local_2.name) > -1){
                        this.showFriendName(_local_2, _arg_1.objectId);
                    };
                };
            };
        }
        private function InfostandWidget(_arg_1:RoomEngineObjectEvent):void
        {
            var _local_2:FriendNameView;
            if (_arg_1.category == RoomObjectCategoryEnum.OBJECT_CATEGORY_USER){
                for each (_local_2 in this._SafeStr_6779) {
                    if (_local_2.objectId == _arg_1.objectId){
                        this.removeView(_local_2, false);
                    };
                };
            };
        }
        private function EffectsWidgetHandler(_arg_1:HabboInventoryEffectsEvent):void
        {
            if ((this._view is OwnAvatarMenuView)){
                (this._view as OwnAvatarMenuView).InfoStandUserView();
            };
        }
        private function getOwnCharacterInfo():void
        {
            messageListener.processWidgetMessage(new RoomWidgetRoomObjectMessage(RoomWidgetRoomObjectMessage.RWROM_GET_OWN_CHARACTER_INFO, 0, 0));
        }
        override public function dispose():void
        {
            var _local_1:FriendNameView;
            if (disposed){
                return;
            };
            for each (_local_1 in this._SafeStr_6779) {
                _local_1.dispose();
            };
            this._SafeStr_6779 = null;
            if (this._component){
                this._component.removeUpdateReceiver(this);
                this._component = null;
            };
            if (this._SafeStr_6776){
                this._SafeStr_6776.dispose();
                this._SafeStr_6776 = null;
            };
            if (this._SafeStr_6778){
                this._SafeStr_6778.dispose();
                this._SafeStr_6778 = null;
            };
            if (this._SafeStr_6777){
                this._SafeStr_6777.dispose();
                this._SafeStr_6777 = null;
            };
            if (this._view){
                if (!this._view.disposed){
                    this._view.dispose();
                    this._view = null;
                };
            };
            this.handler.roomEngine.events.removeEventListener(RoomEngineObjectEvent.REOB_OBJECT_ADDED, this.onRoomObjectAdded);
            this.handler.roomEngine.events.removeEventListener(RoomEngineObjectEvent.REOE_OBJECT_REMOVED, this.InfostandWidget);
            this.handler.container.inventory.events.removeEventListener(HabboInventoryEffectsEvent.HIEE_EFFECTS_CHANGED, this.EffectsWidgetHandler);
            this._view = null;
            this._configuration = null;
            super.dispose();
        }
        public function close():void
        {
            this.removeView(this._view, false);
        }
        override public function RoomChatWidget(_arg_1:IEventDispatcher):void
        {
            if (!_arg_1){
                return;
            };
            _arg_1.addEventListener(RoomWidgetAvatarInfoEvent.RWAIE_AVATAR_INFO, this.updateEventHandler);
            _arg_1.addEventListener(RoomWidgetUserInfoUpdateEvent.RWUIUE_OWN_USER, this.updateEventHandler);
            _arg_1.addEventListener(RoomWidgetUserInfoUpdateEvent.RWUIUE_PEER, this.updateEventHandler);
            _arg_1.addEventListener(RoomWidgetRoomObjectUpdateEvent.RWROUE_OBJECT_SELECTED, this.updateEventHandler);
            _arg_1.addEventListener(RoomWidgetRoomObjectUpdateEvent.RWROUE_OBJECT_DESELECTED, this.updateEventHandler);
            _arg_1.addEventListener(RoomWidgetFurniInfoUpdateEvent.RWFIUE_FURNI, this.updateEventHandler);
            _arg_1.addEventListener(RoomWidgetUserInfoUpdateEvent.BOT, this.updateEventHandler);
            _arg_1.addEventListener(RoomWidgetPetInfoUpdateEvent.PET_INFO, this.updateEventHandler);
            _arg_1.addEventListener(RoomWidgetUserDataUpdateEvent._SafeStr_4720, this.updateEventHandler);
            _arg_1.addEventListener(RoomWidgetRoomObjectUpdateEvent.RWROUE_USER_REMOVED, this.updateEventHandler);
            _arg_1.addEventListener(RoomWidgetRoomEngineUpdateEvent.RWREUE_NORMAL_MODE, this.updateEventHandler);
            _arg_1.addEventListener(RoomWidgetRoomEngineUpdateEvent._SafeStr_3911, this.updateEventHandler);
            _arg_1.addEventListener(RoomWidgetRoomObjectNameEvent.RWONE_TYPE, this.updateEventHandler);
            _arg_1.addEventListener(RoomWidgetRoomObjectUpdateEvent.RWROUE_OBJECT_ROLL_OVER, this.updateEventHandler);
            _arg_1.addEventListener(RoomWidgetRoomObjectUpdateEvent.RWROUE_OBJECT_ROLL_OUT, this.updateEventHandler);
            super.RoomChatWidget(_arg_1);
        }
        override public function RoomChatWidget(_arg_1:IEventDispatcher):void
        {
            if (_arg_1 == null){
                return;
            };
            _arg_1.removeEventListener(RoomWidgetAvatarInfoEvent.RWAIE_AVATAR_INFO, this.updateEventHandler);
            _arg_1.removeEventListener(RoomWidgetUserInfoUpdateEvent.RWUIUE_OWN_USER, this.updateEventHandler);
            _arg_1.removeEventListener(RoomWidgetUserInfoUpdateEvent.RWUIUE_PEER, this.updateEventHandler);
            _arg_1.removeEventListener(RoomWidgetRoomObjectUpdateEvent.RWROUE_OBJECT_SELECTED, this.updateEventHandler);
            _arg_1.removeEventListener(RoomWidgetRoomObjectUpdateEvent.RWROUE_OBJECT_DESELECTED, this.updateEventHandler);
            _arg_1.removeEventListener(RoomWidgetFurniInfoUpdateEvent.RWFIUE_FURNI, this.updateEventHandler);
            _arg_1.removeEventListener(RoomWidgetUserInfoUpdateEvent.BOT, this.updateEventHandler);
            _arg_1.removeEventListener(RoomWidgetPetInfoUpdateEvent.PET_INFO, this.updateEventHandler);
            _arg_1.removeEventListener(RoomWidgetUserDataUpdateEvent._SafeStr_4720, this.updateEventHandler);
            _arg_1.removeEventListener(RoomWidgetRoomObjectUpdateEvent.RWROUE_USER_REMOVED, this.updateEventHandler);
            _arg_1.removeEventListener(RoomWidgetRoomEngineUpdateEvent.RWREUE_NORMAL_MODE, this.updateEventHandler);
            _arg_1.removeEventListener(RoomWidgetRoomEngineUpdateEvent._SafeStr_3911, this.updateEventHandler);
            _arg_1.removeEventListener(RoomWidgetRoomObjectNameEvent.RWONE_TYPE, this.updateEventHandler);
            _arg_1.removeEventListener(RoomWidgetRoomObjectUpdateEvent.RWROUE_OBJECT_ROLL_OUT, this.updateEventHandler);
            _arg_1.removeEventListener(RoomWidgetRoomObjectUpdateEvent.RWROUE_OBJECT_ROLL_OUT, this.updateEventHandler);
        }
        private function updateEventHandler(_arg_1:RoomWidgetUpdateEvent):void
        {
            var _local_2:RoomWidgetAvatarInfoEvent;
            var _local_3:RoomWidgetUserInfoUpdateEvent;
            var _local_4:RoomWidgetUserInfoUpdateEvent;
            var _local_5:RoomWidgetRoomObjectUpdateEvent;
            var _local_6:RoomWidgetPetInfoUpdateEvent;
            var _local_7:FriendNameView;
            switch (_arg_1.type){
                case RoomWidgetAvatarInfoEvent.RWAIE_AVATAR_INFO:
                    _local_2 = (_arg_1 as RoomWidgetAvatarInfoEvent);
                    if (((this._SafeStr_3877) && (_local_2.allowNameChange))){
                        this.useMinimizedOwnAvatarMenu = true;
                        this.selectOwnAvatar();
                    }
                    else {
                        this.ProgressBar(_local_2.userId, _local_2.userName, _local_2.roomIndex, RoomObjectTypeEnum._SafeStr_3740, _local_2.allowNameChange, null);
                    };
                    this._isInitialized = true;
                    break;
                case RoomWidgetRoomObjectNameEvent.RWONE_TYPE:
                    if (RoomWidgetRoomObjectNameEvent(_arg_1).category == RoomObjectCategoryEnum.OBJECT_CATEGORY_USER){
                        this.ProgressBar(RoomWidgetRoomObjectNameEvent(_arg_1).userId, RoomWidgetRoomObjectNameEvent(_arg_1).userName, RoomWidgetRoomObjectNameEvent(_arg_1).roomIndex, RoomObjectTypeEnum._SafeStr_3740, false, null);
                    };
                    break;
                case RoomWidgetRoomObjectUpdateEvent.RWROUE_OBJECT_SELECTED:
                    this._handlePetInfo = true;
                    break;
                case RoomWidgetRoomObjectUpdateEvent.RWROUE_OBJECT_DESELECTED:
                case RoomWidgetFurniInfoUpdateEvent.RWFIUE_FURNI:
                    if (this._view){
                        this.removeView(this._view, false);
                    };
                    break;
                case RoomWidgetRoomObjectUpdateEvent.RWROUE_OBJECT_ROLL_OVER:
                    if (!(((this._view is AvatarMenuView)) || ((this._view is OwnAvatarMenuView)))){
                        this._SafeStr_6774 = RoomWidgetRoomObjectUpdateEvent(_arg_1).id;
                        messageListener.processWidgetMessage(new RoomWidgetRoomObjectMessage(RoomWidgetRoomObjectMessage.RWROM_GET_OBJECT_NAME, RoomWidgetRoomObjectUpdateEvent(_arg_1).id, RoomWidgetRoomObjectUpdateEvent(_arg_1).category));
                    };
                    break;
                case RoomWidgetRoomObjectUpdateEvent.RWROUE_OBJECT_ROLL_OUT:
                    if (!(((this._view is AvatarMenuView)) || ((this._view is OwnAvatarMenuView)))){
                        if (RoomWidgetRoomObjectUpdateEvent(_arg_1).id == this._SafeStr_6774){
                            if (((this._view) && (!(this._view.allowNameChange)))){
                                this.removeView(this._view, false);
                                this._SafeStr_6774 = -1;
                            };
                        };
                    };
                    break;
                case RoomWidgetUserInfoUpdateEvent.RWUIUE_OWN_USER:
                case RoomWidgetUserInfoUpdateEvent.RWUIUE_PEER:
                    _local_3 = (_arg_1 as RoomWidgetUserInfoUpdateEvent);
                    this.storeUserInfo(_local_3);
                    this.ProgressBar(_local_3.webID, _local_3.name, _local_3.userRoomId, RoomObjectTypeEnum._SafeStr_3740, false, ((_local_3.isSpectatorMode) ? null : this._SafeStr_6772));
                    break;
                case RoomWidgetUserInfoUpdateEvent.BOT:
                    _local_4 = (_arg_1 as RoomWidgetUserInfoUpdateEvent);
                    this.ProgressBar(_local_4.webID, _local_4.name, _local_4.userRoomId, RoomObjectTypeEnum._SafeStr_3749, false, null);
                    break;
                case RoomWidgetPetInfoUpdateEvent.PET_INFO:
                    if (this._handlePetInfo){
                        _local_6 = (_arg_1 as RoomWidgetPetInfoUpdateEvent);
                        this.ProgressBar(_local_6.id, _local_6.name, _local_6.roomIndex, RoomObjectTypeEnum._SafeStr_3747, false, null);
                    };
                    break;
                case RoomWidgetUserDataUpdateEvent._SafeStr_4720:
                    if (!this._isInitialized){
                        this.getOwnCharacterInfo();
                    };
                    break;
                case RoomWidgetRoomObjectUpdateEvent.RWROUE_USER_REMOVED:
                    _local_5 = (_arg_1 as RoomWidgetRoomObjectUpdateEvent);
                    if (((this._view) && ((this._view.roomIndex == _local_5.id)))){
                        this.removeView(this._view, false);
                    };
                    for each (_local_7 in this._SafeStr_6779) {
                        if (_local_7.objectId == _local_5.id){
                            this.removeView(_local_7, false);
                            break;
                        };
                    };
                    break;
                case RoomWidgetRoomEngineUpdateEvent.RWREUE_NORMAL_MODE:
                    this._SafeStr_3876 = false;
                    break;
                case RoomWidgetRoomEngineUpdateEvent._SafeStr_3911:
                    this._SafeStr_3876 = true;
                    break;
            };
            this.checkUpdateNeed();
        }
        public function selectOwnAvatar():void
        {
            var _local_3:RoomWidgetRoomObjectMessage;
            if (((((!(this.handler)) || (!(this.handler.container)))) || (!(this.handler.roomSession)))){
                return;
            };
            var _local_1:int = this.handler.container.sessionDataManager.userId;
            var _local_2:IUserData = this.handler.roomSession.userDataManager.getUserData(_local_1);
            if (!_local_2){
                return;
            };
            _local_3 = new RoomWidgetRoomObjectMessage(RoomWidgetRoomObjectMessage.RWROM_SELECT_OBJECT, _local_2.id, RoomObjectCategoryEnum.OBJECT_CATEGORY_USER);
            this.handler.container.processWidgetMessage(_local_3);
        }
        private function storeUserInfo(_arg_1:RoomWidgetUserInfoUpdateEvent):void
        {
            this._SafeStr_6772.amIAnyRoomController = _arg_1.amIAnyRoomController;
            this._SafeStr_6772.amIController = _arg_1.amIController;
            this._SafeStr_6772.amIOwner = _arg_1.amIOwner;
            this._SafeStr_6772.canBeAskedAsFriend = _arg_1.canBeAskedAsFriend;
            this._SafeStr_6772.canBeKicked = _arg_1.canBeKicked;
            this._SafeStr_6772.canTrade = _arg_1.canTrade;
            this._SafeStr_6772.canTradeReason = _arg_1.canTradeReason;
            this._SafeStr_6772.hasFlatControl = _arg_1.hasFlatControl;
            this._SafeStr_6772.isIgnored = _arg_1.isIgnored;
            this._SafeStr_6772.respectLeft = _arg_1.respectLeft;
            this._SafeStr_6772.isOwnUser = (_arg_1.type == RoomWidgetUserInfoUpdateEvent.RWUIUE_OWN_USER);
            this._SafeStr_6772.allowNameChange = _arg_1.allowNameChange;
        }
        private function ProgressBar(_arg_1:int, _arg_2:String, _arg_3:int, _arg_4:int, _arg_5:Boolean, _arg_6:AvatarInfoData):void
        {
            var _local_8:FriendNameView;
            var _local_7:Boolean;
            if (_arg_6){
                _local_7 = ((_arg_6.isOwnUser) ? this._SafeStr_3877 : this._SafeStr_6773);
            };
            if (((((_local_7) && (this._view))) && (!((((this._view is AvatarMenuView)) || ((this._view is OwnAvatarMenuView))))))){
                this.removeView(this._view, false);
            };
            if ((((((((((((this._view == null)) || (!((this._view.userId == _arg_1))))) || (!((this._view.userName == _arg_2))))) || (!((this._view.roomIndex == _arg_3))))) || (!((this._view.userType == _arg_4))))) || (_arg_5))){
                if (this._view){
                    this.removeView(this._view, false);
                };
                if (!this._SafeStr_3876){
                    if (_local_7){
                        if (_arg_6.isOwnUser){
                            if (!this._SafeStr_6777){
                                this._SafeStr_6777 = new OwnAvatarMenuView(this);
                            };
                            this._view = this._SafeStr_6777;
                            OwnAvatarMenuView.setup((this._view as OwnAvatarMenuView), _arg_1, _arg_2, _arg_3, _arg_4, _arg_6);
                        }
                        else {
                            if (!this._SafeStr_6778){
                                this._SafeStr_6778 = new AvatarMenuView(this);
                            };
                            this._view = this._SafeStr_6778;
                            AvatarMenuView.setup((this._view as AvatarMenuView), _arg_1, _arg_2, _arg_3, _arg_4, _arg_6);
                            for each (_local_8 in this._SafeStr_6779) {
                                if (_local_8.userId == _arg_1){
                                    this.removeView(_local_8, false);
                                    break;
                                };
                            };
                        };
                    }
                    else {
                        if (!this._SafeStr_6776){
                            this._SafeStr_6776 = new AvatarInfoView(this);
                        };
                        this._view = this._SafeStr_6776;
                        AvatarInfoView.setup(this._view, _arg_1, _arg_2, _arg_3, _arg_4, _arg_5);
                    };
                };
            }
            else {
                if ((((this._view is AvatarMenuView)) || ((this._view is OwnAvatarMenuView)))){
                    if (this._view.userName == _arg_2){
                        this.removeView(this._view, false);
                    };
                };
            };
        }
        public function removeView(_arg_1:AvatarInfoView, _arg_2:Boolean):void
        {
            if (_arg_1){
                if (this._SafeStr_6775){
                    _arg_1.hide(_arg_2);
                }
                else {
                    _arg_1.dispose();
                    this._SafeStr_6776 = null;
                    this._SafeStr_6778 = null;
                    this._SafeStr_6777 = null;
                };
                if (_arg_1 == this._view){
                    this._view = null;
                };
                if ((_arg_1 is FriendNameView)){
                    this._SafeStr_6779.remove(_arg_1.userName);
                    _arg_1.dispose();
                    this.checkUpdateNeed();
                };
            };
        }
        private function showFriendName(_arg_1:IUserData, _arg_2:int):void
        {
            var _local_3:FriendNameView;
            if (this._SafeStr_6779[_arg_1.name] == null){
                _local_3 = new FriendNameView(this);
                FriendNameView.setup(_local_3, _arg_1.webID, _arg_1.name, -1, RoomObjectTypeEnum._SafeStr_3740, _arg_2);
                this._SafeStr_6779[_arg_1.name] = _local_3;
                this.checkUpdateNeed();
            };
        }
        public function checkUpdateNeed():void
        {
            if (!this._component){
                return;
            };
            if (((this._view) || ((this._SafeStr_6779.length > 0)))){
                this._component.IContext(this, 10);
            }
            else {
                this._component.removeUpdateReceiver(this);
            };
        }
        public function update(_arg_1:uint):void
        {
            var _local_2:RoomWidgetUserLocationUpdateEvent;
            var _local_3:FriendNameView;
            if (this._view){
                _local_2 = (messageListener.processWidgetMessage(new RoomWidgetGetUserLocationMessage(this._view.userId, this._view.userType)) as RoomWidgetUserLocationUpdateEvent);
                if (!_local_2){
                    return;
                };
                this._view.update(_local_2.rectangle, _local_2.screenLocation, _arg_1);
            };
            for each (_local_3 in this._SafeStr_6779) {
                _local_2 = (messageListener.processWidgetMessage(new RoomWidgetGetUserLocationMessage(_local_3.userId, _local_3.userType)) as RoomWidgetUserLocationUpdateEvent);
                if (_local_2){
                    _local_3.update(_local_2.rectangle, _local_2.screenLocation, _arg_1);
                };
            };
        }
        public function openAvatarEditor():void
        {
            this.handler.container.avatarEditor.openEditor(AvatarEditorInstanceId._SafeStr_6812, null, null, true);
            this.handler.container.avatarEditor.loadOwnAvatarInEditor(AvatarEditorInstanceId._SafeStr_6812);
        }
        public function get hasClub():Boolean
        {
            return (this.handler.container.sessionDataManager.hasUserRight(null, HabboClubLevelEnum._SafeStr_3943));
        }
        public function get hasEffectOn():Boolean
        {
            var _local_2:IWidgetAvatarEffect;
            var _local_1:Array = this.handler.container.inventory.HabboInventory();
            for each (_local_2 in _local_1) {
                if (_local_2.isInUse){
                    return (true);
                };
            };
            return (false);
        }
        public function set isDancing(_arg_1:Boolean):void
        {
            this._isDancing = _arg_1;
        }
        public function get isDancing():Boolean
        {
            return (this._isDancing);
        }
        public function get useMinimizedOwnAvatarMenu():Boolean
        {
            return (this.handler.container.config.getBoolean(_useMinimizedOwnAvatarMenu, true));
        }
        public function set useMinimizedOwnAvatarMenu(_arg_1:Boolean):void
        {
            this.handler.container.config.setKey(_useMinimizedOwnAvatarMenu, ((_arg_1) ? "1" : "0"));
        }

    }
}//package com.sulake.habbo.ui.widget.avatarinfo

// RoomEngineObjectEvent = "_-10r" (String#16492, DoABC#2)
// HabboInventoryEffectsEvent = "_-0Us" (String#15238, DoABC#2)
// HabboClubLevelEnum = "_-1ZP" (String#17867, DoABC#2)
// RoomWidgetBase = "_-0eQ" (String#4398, DoABC#2)
// AvatarInfoWidget = "_-3Bt" (String#7549, DoABC#2)
// AvatarEditorInstanceId = "_-3Bn" (String#21953, DoABC#2)
// IUserData = "_-0n7" (String#4570, DoABC#2)
// IWidgetAvatarEffect = "_-uw" (String#8782, DoABC#2)
// RoomObjectTypeEnum = "_-2hK" (String#20744, DoABC#2)
// RoomWidgetUpdateEvent = "_-0ZP" (String#4289, DoABC#2)
// AvatarInfoWidgetHandler = "_-26a" (String#6178, DoABC#2)
// RoomWidgetRoomEngineUpdateEvent = "_-x9" (String#8828, DoABC#2)
// RoomWidgetRoomObjectUpdateEvent = "_-37T" (String#7457, DoABC#2)
// RoomWidgetGetUserLocationMessage = "_-2z-" (String#7262, DoABC#2)
// RoomWidgetUserLocationUpdateEvent = "_-2ox" (String#7058, DoABC#2)
// RoomWidgetUserInfoUpdateEvent = "_-28z" (String#6226, DoABC#2)
// RoomWidgetFurniInfoUpdateEvent = "_-1V1" (String#5455, DoABC#2)
// RoomWidgetPetInfoUpdateEvent = "_-KB" (String#8087, DoABC#2)
// AvatarInfoView = "_-1fg" (String#5659, DoABC#2)
// OwnAvatarMenuView = "_-3Aa" (String#7525, DoABC#2)
// RoomWidgetUserDataUpdateEvent = "_-1IM" (String#5212, DoABC#2)
// AvatarMenuView = "_-Oi" (String#8178, DoABC#2)
// RoomWidgetAvatarInfoEvent = "_-2sQ" (String#7129, DoABC#2)
// FriendNameView = "_-zr" (String#8880, DoABC#2)
// AvatarInfoData = "_-2Wz" (String#20322, DoABC#2)
// RoomWidgetRoomObjectNameEvent = "_-0gJ" (String#15686, DoABC#2)
// userType = "_-0Dh" (String#14596, DoABC#2)
// RWROM_GET_OBJECT_NAME = "_-1vl" (String#18788, DoABC#2)
// RWROM_SELECT_OBJECT = "_-1RI" (String#17557, DoABC#2)
// RWROM_GET_OWN_CHARACTER_INFO = "_-1C2" (String#16944, DoABC#2)
// RoomChatWidget = "_-1yD" (String#1787, DoABC#2)
// InfostandWidget = "_-1GC" (String#842, DoABC#2)
// RoomChatWidget = "_-0-c" (String#3556, DoABC#2)
// webID = "_-2uI" (String#7166, DoABC#2)
// _SafeStr_3740 = "_-39-" (String#21844, DoABC#2)
// _SafeStr_3747 = "_-gF" (String#23903, DoABC#2)
// _SafeStr_3749 = "_-1aR" (String#17911, DoABC#2)
// respectLeft = "_-2Yo" (String#6743, DoABC#2)
// _isDancing = "_-38" (String#7470, DoABC#2)
// _SafeStr_3876 = "_-1T8" (String#5416, DoABC#2)
// _SafeStr_3877 = "_-I9" (String#8043, DoABC#2)
// widget = "_-1yo" (String#18920, DoABC#2)
// handler = "_-06s" (String#1404, DoABC#2)
// _handler = "_-1Eb" (String#5153, DoABC#2)
// RWROUE_OBJECT_DESELECTED = "_-8G" (String#22552, DoABC#2)
// RWUIUE_OWN_USER = "_-13K" (String#16592, DoABC#2)
// RWREUE_NORMAL_MODE = "_-w-" (String#24530, DoABC#2)
// _SafeStr_3911 = "native" (String#46040, DoABC#2)
// isInUse = "_-2LN" (String#6469, DoABC#2)
// _SafeStr_3943 = "_-xn" (String#24604, DoABC#2)
// RWAIE_AVATAR_INFO = "_-2QK" (String#20059, DoABC#2)
// IContext = "_-35P" (String#7415, DoABC#2)
// _SafeStr_4720 = "_-XT" (String#23542, DoABC#2)
// REOB_OBJECT_ADDED = "_-rY" (String#24341, DoABC#2)
// onRoomObjectAdded = "_-wW" (String#8812, DoABC#2)
// sessionDataManager = "_-0pX" (String#4623, DoABC#2)
// REOE_OBJECT_REMOVED = "_-2ma" (String#20945, DoABC#2)
// _component = "_-2cU" (String#305, DoABC#2)
// checkUpdateNeed = "_-21r" (String#19084, DoABC#2)
// RWUIUE_PEER = "_-2Tv" (String#20195, DoABC#2)
// getUserData = "_-1-1" (String#4848, DoABC#2)
// userDataManager = "_-lZ" (String#8636, DoABC#2)
// getUserDataByIndex = "_-1XZ" (String#5510, DoABC#2)
// isSpectatorMode = "_-10C" (String#4874, DoABC#2)
// RWROUE_USER_REMOVED = "_-02u" (String#14156, DoABC#2)
// _useMinimizedOwnAvatarMenu = "_-0dL" (String#15562, DoABC#2)
// _SafeStr_6772 = "_-1r1" (String#18583, DoABC#2)
// _SafeStr_6773 = "_-2Q" (String#20041, DoABC#2)
// _SafeStr_6774 = "_-Qb" (String#23271, DoABC#2)
// _SafeStr_6775 = "_-207" (String#19016, DoABC#2)
// _SafeStr_6776 = "_-Eo" (String#22805, DoABC#2)
// _SafeStr_6777 = "_-N7" (String#23128, DoABC#2)
// _SafeStr_6778 = "_-1Rw" (String#17580, DoABC#2)
// _SafeStr_6779 = "_-2dL" (String#20577, DoABC#2)
// _handlePetInfo = "_-Z8" (String#23605, DoABC#2)
// HIEE_EFFECTS_CHANGED = "_-9W" (String#22600, DoABC#2)
// EffectsWidgetHandler = "_-1tP" (String#5909, DoABC#2)
// handlePetInfo = "_-0im" (String#15783, DoABC#2)
// roomSession = "_-0cq" (String#4363, DoABC#2)
// HabboFriendList = "_-3BP" (String#7538, DoABC#2)
// showFriendName = "_-vw" (String#24525, DoABC#2)
// InfoStandUserView = "_-i5" (String#942, DoABC#2)
// getOwnCharacterInfo = "_-3LI" (String#22339, DoABC#2)
// updateEventHandler = "_-et" (String#8495, DoABC#2)
// RWROUE_OBJECT_SELECTED = "_-0Yn" (String#15392, DoABC#2)
// RWFIUE_FURNI = "_-U0" (String#23409, DoABC#2)
// RWONE_TYPE = "_-34N" (String#21673, DoABC#2)
// RWROUE_OBJECT_ROLL_OVER = "_-2vE" (String#21287, DoABC#2)
// RWROUE_OBJECT_ROLL_OUT = "_-2K0" (String#19807, DoABC#2)
// allowNameChange = "_-KQ" (String#23022, DoABC#2)
// selectOwnAvatar = "_-1mU" (String#18400, DoABC#2)
// ProgressBar = "_-1Js" (String#847, DoABC#2)
// storeUserInfo = "_-31s" (String#21573, DoABC#2)
// amIAnyRoomController = "_-09r" (String#14441, DoABC#2)
// amIController = "_-01W" (String#14111, DoABC#2)
// amIOwner = "_-15r" (String#16691, DoABC#2)
// canBeAskedAsFriend = "_-0c9" (String#15521, DoABC#2)
// canBeKicked = "_-34-" (String#21658, DoABC#2)
// canTrade = "_-07S" (String#14342, DoABC#2)
// canTradeReason = "_-01A" (String#14098, DoABC#2)
// hasFlatControl = "_-282" (String#19332, DoABC#2)
// isIgnored = "_-0NV" (String#4031, DoABC#2)
// isOwnUser = "_-Je" (String#22991, DoABC#2)
// screenLocation = "_-bK" (String#23684, DoABC#2)
// openEditor = "_-86" (String#2059, DoABC#2)
// avatarEditor = "_-1mJ" (String#5786, DoABC#2)
// _SafeStr_6812 = "_-2OT" (String#19984, DoABC#2)
// loadOwnAvatarInEditor = "_-ae" (String#2135, DoABC#2)
// HabboInventory = "_-33d" (String#1992, DoABC#2)
// setKey = "_-0sz" (String#1567, DoABC#2)
// Component = "_-19A" (String#5060, DoABC#2)
// IUpdateReceiver = "_-Qe" (String#8218, DoABC#2)
// RoomObjectCategoryEnum = "_-1eh" (String#5639, DoABC#2)


