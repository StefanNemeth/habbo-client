
package com.sulake.habbo.ui.handler
{
    import com.sulake.habbo.ui.IRoomWidgetHandler;
    import com.sulake.habbo.avatar.IAvatarImageListener;
    import com.sulake.habbo.ui.IRoomWidgetHandlerContainer;
    import com.sulake.habbo.inventory.IHabboInventory;
    import com.sulake.habbo.toolbar.IHabboToolbar;
    import com.sulake.habbo.catalog.IHabboCatalog;
    import flash.display.BitmapData;
    import com.sulake.habbo.ui.widget.memenu.MeMenuWidget;
    import com.sulake.habbo.avatar.enum.AvatarEditorInstanceId;
    import com.sulake.habbo.ui.widget.enums.RoomWidgetEnum;
    import com.sulake.habbo.session.events.HabboSessionFigureUpdatedEvent;
    import com.sulake.habbo.inventory.events.HabboInventoryEffectsEvent;
    import com.sulake.habbo.inventory.events.HabboInventoryHabboClubEvent;
    import com.sulake.habbo.toolbar.events.HabboToolbarEvent;
    import com.sulake.habbo.help.enum.HabboHelpTutorialEvent;
    import com.sulake.habbo.catalog.purse.PurseEvent;
    import com.sulake.habbo.avatar.IAvatarImage;
    import flash.geom.Rectangle;
    import com.sulake.habbo.avatar.enum.AvatarScaleType;
    import com.sulake.habbo.avatar.enum.AvatarSetType;
    import flash.geom.Point;
    import com.sulake.habbo.toolbar.HabboToolbarIconEnum;
    import com.sulake.habbo.ui.widget.events.RoomWidgetToolbarClickedUpdateEvent;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetWaveMessage;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetDanceMessage;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetGetEffectsMessage;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetSelectEffectMessage;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetOpenInventoryMessage;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetOpenCatalogMessage;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetStopEffectMessage;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetNavigateToRoomMessage;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetAvatarEditorMessage;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetSelectOutfitMessage;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetShowOwnRoomsMessage;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetRequestWidgetMessage;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetMeMenuMessage;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetGetSettingsMessage;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetStoreSettingsMessage;
    import com.sulake.habbo.session.IUserData;
    import com.sulake.habbo.ui.widget.events.RoomWidgetUpdateEffectsUpdateEvent;
    import com.sulake.habbo.catalog.enum.CatalogPageName;
    import com.sulake.habbo.inventory.enum.InventoryCategory;
    import com.sulake.habbo.session.HabboClubLevelEnum;
    import com.sulake.habbo.ui.widget.events.RoomWidgetHabboClubUpdateEvent;
    import com.sulake.habbo.ui.widget.events.RoomWidgetPurseUpdateEvent;
    import com.sulake.habbo.ui.widget.events.RoomWidgetSettingsUpdateEvent;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetMessage;
    import com.sulake.habbo.ui.widget.events.RoomWidgetUpdateEvent;
    import flash.events.Event;
    import com.sulake.habbo.ui.widget.events.RoomWidgetTutorialEvent;

    public class MeMenuWidgetHandler implements IRoomWidgetHandler, IAvatarImageListener 
    {

        private static const _SafeStr_7260:int = 50;
        private static const _SafeStr_7261:int = 3;

        private var _disposed:Boolean = false;
        private var _container:IRoomWidgetHandlerContainer = null;
        private var _inventory:IHabboInventory;
        private var _toolbar:IHabboToolbar;
        private var _catalog:IHabboCatalog;
        private var _SafeStr_7262:String;
        private var _SafeStr_7263:BitmapData;
        private var _MeMenuWidgetHandler:BitmapData;
        private var _widget:MeMenuWidget;

        public function MeMenuWidgetHandler()
        {
            Logger.log("[MeMenuWidgetHandler]");
        }
        public function set widget(_arg_1:MeMenuWidget):void
        {
            this._widget = _arg_1;
        }
        public function dispose():void
        {
            if (((this._container) && (this._container.avatarEditor))){
                this._container.avatarEditor.close(AvatarEditorInstanceId._SafeStr_6812);
            };
            this._disposed = true;
            this.container = null;
            this._inventory = null;
            this._toolbar = null;
            this._catalog = null;
            this._SafeStr_7262 = null;
            this._SafeStr_7263 = null;
            this._MeMenuWidgetHandler = null;
        }
        public function get disposed():Boolean
        {
            return (this._disposed);
        }
        public function get type():String
        {
            return (RoomWidgetEnum.RWE_ME_MENU);
        }
        public function set container(_arg_1:IRoomWidgetHandlerContainer):void
        {
            if (this._container != null){
                if (((((this._container.sessionDataManager) && (!(this._container.sessionDataManager.disposed)))) && (this._container.sessionDataManager.events))){
                    this._container.sessionDataManager.events.removeEventListener(HabboSessionFigureUpdatedEvent.HABBO_SESSION_FIGURE_UPDATE, this.onFigureUpdate);
                };
                if (((((this._inventory) && (!(this._inventory.disposed)))) && (this._inventory.events))){
                    this._inventory.events.removeEventListener(HabboInventoryEffectsEvent.HIEE_EFFECTS_CHANGED, this.MeMenuWidgetHandler);
                    this._inventory.events.removeEventListener(HabboInventoryHabboClubEvent.HIHCE_HABBO_CLUB_CHANGED, this.MeMenuWidgetHandler);
                };
                if (((((this._toolbar) && (!(this._toolbar.disposed)))) && (this._toolbar.events))){
                    this._toolbar.events.removeEventListener(HabboToolbarEvent.HTE_TOOLBAR_CLICK, this.onHabboToolbarEvent);
                };
                if (((((this._container.habboHelp) && (!(this._container.habboHelp.disposed)))) && (this._container.habboHelp.events))){
                    this._container.habboHelp.events.removeEventListener(HabboHelpTutorialEvent.HHTPNUFWE_LIGHT_CLOTHES_ICON, this.MeMenuWidgetHandler);
                    this._container.habboHelp.events.removeEventListener(HabboHelpTutorialEvent.HHTPNUFWE_AE_STARTED, this.MeMenuWidgetHandler);
                };
                if (((((this._container.catalog) && (!(this._container.catalog.disposed)))) && (this._container.catalog.events))){
                    this._container.catalog.events.removeEventListener(PurseEvent.RWPUE_CREDIT_BALANCE, this.onCreditBalance);
                };
            };
            this._container = _arg_1;
            if (this._container == null){
                return;
            };
            if (this._container.sessionDataManager != null){
                this._container.sessionDataManager.events.addEventListener(HabboSessionFigureUpdatedEvent.HABBO_SESSION_FIGURE_UPDATE, this.onFigureUpdate);
            };
            this._inventory = this._container.inventory;
            if (this._inventory != null){
                this._inventory.events.addEventListener(HabboInventoryEffectsEvent.HIEE_EFFECTS_CHANGED, this.MeMenuWidgetHandler);
                this._inventory.events.addEventListener(HabboInventoryHabboClubEvent.HIHCE_HABBO_CLUB_CHANGED, this.MeMenuWidgetHandler);
            };
            this._toolbar = this._container.toolbar;
            if (((this._toolbar) && (this._toolbar.events))){
                this._toolbar.events.addEventListener(HabboToolbarEvent.HTE_TOOLBAR_CLICK, this.onHabboToolbarEvent);
                this.MeMenuWidgetHandler();
            };
            if (this._container.habboHelp != null){
                this._container.habboHelp.events.addEventListener(HabboHelpTutorialEvent.HHTPNUFWE_LIGHT_CLOTHES_ICON, this.MeMenuWidgetHandler);
                this._container.habboHelp.events.addEventListener(HabboHelpTutorialEvent.HHTPNUFWE_AE_STARTED, this.MeMenuWidgetHandler);
            };
            this._catalog = this._container.catalog;
            if (this._container.catalog != null){
                this._container.catalog.events.addEventListener(PurseEvent.RWPUE_CREDIT_BALANCE, this.onCreditBalance);
            };
        }
        public function get container():IRoomWidgetHandlerContainer
        {
            return (this._container);
        }
        private function MeMenuWidgetHandler():void
        {
            var _local_1:BitmapData;
            var _local_2:BitmapData;
            var _local_3:String;
            var _local_4:String;
            var _local_5:IAvatarImage;
            var _local_6:BitmapData;
            var _local_7:BitmapData;
            var _local_8:Rectangle;
            if (this._container.avatarRenderManager != null){
                _local_3 = this._container.sessionDataManager.figure;
                if (_local_3 != this._SafeStr_7262){
                    _local_4 = this._container.sessionDataManager.gender;
                    _local_5 = this._container.avatarRenderManager.createAvatarImage(_local_3, AvatarScaleType._SafeStr_4336, _local_4, this);
                    if (_local_5 != null){
                        _local_5.setDirection(AvatarSetType._SafeStr_4457, 2);
                        _local_1 = _local_5.getCroppedImage(AvatarSetType._SafeStr_4457);
                        _local_2 = _local_5.getCroppedImage(AvatarSetType._SafeStr_4458);
                        _local_5.dispose();
                    };
                    this._SafeStr_7262 = _local_3;
                    this._SafeStr_7263 = _local_1;
                    this._MeMenuWidgetHandler = _local_2;
                }
                else {
                    _local_1 = this._SafeStr_7263;
                    _local_2 = this._MeMenuWidgetHandler;
                };
            };
            if (this._toolbar != null){
                if (((!((_local_1 == null))) && (!((_local_2 == null))))){
                    if (_local_1.height > _SafeStr_7260){
                        _local_7 = new BitmapData(_local_1.width, _SafeStr_7260, true, 0);
                        _local_8 = _local_7.rect.clone();
                        if (_local_2.height > (_SafeStr_7260 - _SafeStr_7261)){
                            _local_8.offset(0, ((_local_2.height - _SafeStr_7260) + _SafeStr_7261));
                        };
                        _local_7.copyPixels(_local_1, _local_8, new Point(0, 0));
                        _local_6 = _local_7;
                    }
                    else {
                        _local_6 = _local_1;
                    };
                };
                this._toolbar.setIconBitmap(HabboToolbarIconEnum.MEMENU, _local_6);
            };
        }
        private function onHabboToolbarEvent(_arg_1:HabboToolbarEvent):void
        {
            if (((((this.disposed) || (!(this._container)))) || (!(this._container.events)))){
                return;
            };
            if (_arg_1.type == HabboToolbarEvent.HTE_TOOLBAR_CLICK){
                switch (_arg_1.iconId){
                    case HabboToolbarIconEnum.MEMENU:
                        this._container.events.dispatchEvent(new RoomWidgetToolbarClickedUpdateEvent(RoomWidgetToolbarClickedUpdateEvent.ICON_TYPE_ME_MENU));
                        return;
                };
            };
        }
        public function IRoomWidgetHandler():Array
        {
            var _local_1:Array = [];
            _local_1.push(RoomWidgetWaveMessage.RWCM_MESSAGE_WAVE);
            _local_1.push(RoomWidgetDanceMessage.RWCM_MESSAGE_DANCE);
            _local_1.push(RoomWidgetGetEffectsMessage.RWCM_MESSAGE_GET_EFFECTS);
            _local_1.push(RoomWidgetSelectEffectMessage.RWCM_MESSAGE_SELECT_EFFECT);
            _local_1.push(RoomWidgetSelectEffectMessage.RWCM_MESSAGE_UNSELECT_EFFECT);
            _local_1.push(RoomWidgetSelectEffectMessage.RWCM_MESSAGE_UNSELECT_ALL_EFFECTS);
            _local_1.push(RoomWidgetOpenInventoryMessage.RWGOI_MESSAGE_OPEN_INVENTORY);
            _local_1.push(RoomWidgetOpenCatalogMessage.RWGOI_MESSAGE_OPEN_CATALOG);
            _local_1.push(RoomWidgetStopEffectMessage.RWGOI_MESSAGE_STOP_EFFECT);
            _local_1.push(RoomWidgetNavigateToRoomMessage.RWGOI_MESSAGE_NAVIGATE_TO_ROOM);
            _local_1.push(RoomWidgetNavigateToRoomMessage.RWGOI_MESSAGE_NAVIGATE_HOME);
            _local_1.push(RoomWidgetAvatarEditorMessage.RWCM_OPEN_AVATAR_EDITOR);
            _local_1.push(RoomWidgetAvatarEditorMessage.RWCM_GET_WARDROBE);
            _local_1.push(RoomWidgetSelectOutfitMessage._SafeStr_3580);
            _local_1.push(RoomWidgetShowOwnRoomsMessage.RWSORM_SHOW_OWN_ROOMS);
            _local_1.push(RoomWidgetRequestWidgetMessage.RWRWM_ME_MENU);
            _local_1.push(RoomWidgetMeMenuMessage.RWMMM_MESSAGE_ME_MENU_OPENED);
            _local_1.push(RoomWidgetGetSettingsMessage.RWGSM_GET_SETTINGS);
            _local_1.push(RoomWidgetStoreSettingsMessage.RWSSM_STORE_SETTINGS);
            _local_1.push(RoomWidgetStoreSettingsMessage.RWSSM_STORE_SOUND);
            _local_1.push(RoomWidgetStoreSettingsMessage.RWSSM_PREVIEW_SOUND);
            _local_1.push(RoomWidgetAvatarEditorMessage.RWAEM_AVATAR_EDITOR_VIEW_DISPOSED);
            _local_1.push(RoomWidgetRequestWidgetMessage.RWRWM_EFFECTS);
            return (_local_1);
        }
        public function processWidgetMessage(_arg_1:RoomWidgetMessage):RoomWidgetUpdateEvent
        {
            var _local_2:RoomWidgetOpenCatalogMessage;
            var _local_3:RoomWidgetOpenInventoryMessage;
            var _local_4:RoomWidgetMeMenuMessage;
            var _local_5:HabboToolbarEvent;
            var _local_6:RoomWidgetDanceMessage;
            var _local_7:Array;
            var _local_8:RoomWidgetSelectEffectMessage;
            var _local_9:RoomWidgetSelectEffectMessage;
            var _local_10:Boolean;
            var _local_11:int;
            var _local_12:IUserData;
            var _local_13:int;
            var _local_14:int;
            if (!_arg_1){
                return (null);
            };
            switch (_arg_1.type){
                case RoomWidgetRequestWidgetMessage.RWRWM_ME_MENU:
                    if (((((!((this._container == null))) && (!((this._container.toolbar == null))))) && (!((this._container.toolbar.events == null))))){
                        _local_5 = new HabboToolbarEvent(HabboToolbarEvent.HTE_TOOLBAR_CLICK);
                        _local_5.iconId = HabboToolbarIconEnum.MEMENU;
                        if (((((((!(this.disposed)) && (this._container))) && (this._container.toolbar))) && (this._container.toolbar.events))){
                            this._container.toolbar.events.dispatchEvent(_local_5);
                        };
                    };
                    break;
                case RoomWidgetWaveMessage.RWCM_MESSAGE_WAVE:
                    if (((!((this._container == null))) && (!((this._container.roomSession == null))))){
                        this._container.roomSession.RoomSession();
                    };
                    break;
                case RoomWidgetDanceMessage.RWCM_MESSAGE_DANCE:
                    if (((!((this._container == null))) && (!((this._container.roomSession == null))))){
                        _local_6 = (_arg_1 as RoomWidgetDanceMessage);
                        if (_local_6 != null){
                            this._container.roomSession.RoomSession(_local_6.style);
                        };
                    };
                    break;
                case RoomWidgetGetEffectsMessage.RWCM_MESSAGE_GET_EFFECTS:
                    if (this._inventory != null){
                        _local_7 = this._inventory.HabboInventory();
                        this._container.events.dispatchEvent(new RoomWidgetUpdateEffectsUpdateEvent(_local_7));
                    };
                    break;
                case RoomWidgetSelectEffectMessage.RWCM_MESSAGE_SELECT_EFFECT:
                    if (this._inventory != null){
                        _local_8 = (_arg_1 as RoomWidgetSelectEffectMessage);
                        this._inventory.HabboInventory(_local_8.effectType);
                    };
                    break;
                case RoomWidgetSelectEffectMessage.RWCM_MESSAGE_UNSELECT_EFFECT:
                    if (this._inventory != null){
                        _local_9 = (_arg_1 as RoomWidgetSelectEffectMessage);
                        this._inventory.HabboInventory(_local_9.effectType);
                    };
                    break;
                case RoomWidgetOpenCatalogMessage.RWGOI_MESSAGE_OPEN_CATALOG:
                    _local_2 = (_arg_1 as RoomWidgetOpenCatalogMessage);
                    if (((!((this._catalog == null))) && ((_local_2.pageKey == RoomWidgetOpenCatalogMessage.RWOCM_CLUB_MAIN)))){
                        this._catalog.openCatalogPage(CatalogPageName._SafeStr_5382, true);
                    };
                    break;
                case RoomWidgetOpenInventoryMessage.RWGOI_MESSAGE_OPEN_INVENTORY:
                    _local_3 = (_arg_1 as RoomWidgetOpenInventoryMessage);
                    if (this._inventory != null){
                        Logger.log(("MeMenuWidgetHandler open inventory: " + _local_3.inventoryType));
                        switch (_local_3.inventoryType){
                            case RoomWidgetOpenInventoryMessage._SafeStr_3550:
                                this._catalog.openCatalogPage(CatalogPageName._SafeStr_6005, true);
                                break;
                            case RoomWidgetOpenInventoryMessage._SafeStr_3551:
                                this._inventory.HabboInventory(InventoryCategory._SafeStr_7061);
                                break;
                            case RoomWidgetOpenInventoryMessage._SafeStr_3553:
                                this._inventory.HabboInventory(InventoryCategory._SafeStr_5995);
                                break;
                            case RoomWidgetOpenInventoryMessage._SafeStr_3552:
                                break;
                            default:
                                Logger.log(("MeMenuWidgetHandler: unknown inventory type: " + _local_3.inventoryType));
                        };
                    };
                    break;
                case RoomWidgetSelectEffectMessage.RWCM_MESSAGE_UNSELECT_ALL_EFFECTS:
                case RoomWidgetStopEffectMessage.RWGOI_MESSAGE_STOP_EFFECT:
                    Logger.log("STOP ALL EFFECTS");
                    if (this._inventory != null){
                        this._inventory.HabboInventory();
                    };
                    break;
                case RoomWidgetNavigateToRoomMessage.RWGOI_MESSAGE_NAVIGATE_HOME:
                    Logger.log("MeMenuWidgetHandler: GO HOME");
                    if (this._container != null){
                        this._container.navigator.goToHomeRoom();
                    };
                    break;
                case RoomWidgetShowOwnRoomsMessage.RWSORM_SHOW_OWN_ROOMS:
                    if (this._container != null){
                        this._container.navigator.showOwnRooms();
                    };
                    break;
                case RoomWidgetMeMenuMessage.RWMMM_MESSAGE_ME_MENU_OPENED:
                    _local_4 = (_arg_1 as RoomWidgetMeMenuMessage);
                    if (((((!(_local_4)) || (!(this._container)))) || (!(this._container.events)))){
                        return (null);
                    };
                    if (this._inventory != null){
                        _local_10 = false;
                        if (((!((this._container == null))) && (!((this._container.sessionDataManager == null))))){
                            _local_10 = this._container.sessionDataManager.hasUserRight("fuse_use_club_dance", HabboClubLevelEnum._SafeStr_3943);
                        };
                        this._container.events.dispatchEvent(new RoomWidgetHabboClubUpdateEvent(this._inventory.clubDays, this._inventory.clubPeriods, this._inventory.clubPastPeriods, _local_10, this._inventory.clubLevel));
                    };
                    if (((!((this._catalog == null))) && (!((this._catalog.getPurse() == null))))){
                        this._container.events.dispatchEvent(new RoomWidgetPurseUpdateEvent(RoomWidgetPurseUpdateEvent.RWPUE_CREDIT_BALANCE, this._catalog.getPurse().credits));
                    };
                    if (((((this._container.roomSession) && (this._container.roomSession.userDataManager))) && (this._container.roomEngine))){
                        _local_11 = (((this._container.sessionDataManager)!=null) ? this._container.sessionDataManager.userId : -1);
                        _local_12 = this._container.roomSession.userDataManager.getUserData(_local_11);
                        if (!_local_12){
                            return (null);
                        };
                        _local_13 = 0;
                        _local_14 = 0;
                        this._container.roomEngine.RoomEngine(_local_13, _local_14, _local_12.id);
                    };
                    break;
                case RoomWidgetAvatarEditorMessage.RWCM_OPEN_AVATAR_EDITOR:
                    Logger.log("MeMenuWidgetHandler: Open avatar editor...");
                    if (this._container){
                        this._container.avatarEditor.openEditor(AvatarEditorInstanceId._SafeStr_6812, null, null, true);
                        this._container.avatarEditor.loadOwnAvatarInEditor(AvatarEditorInstanceId._SafeStr_6812);
                        if (((this._container.habboHelp) && (this._container.habboHelp.events))){
                            this._container.habboHelp.events.dispatchEvent(new HabboHelpTutorialEvent(HabboHelpTutorialEvent.HHTE_DONE_AVATAR_EDITOR_OPENING));
                        };
                    };
                    break;
                case RoomWidgetGetSettingsMessage.RWGSM_GET_SETTINGS:
                    this._container.events.dispatchEvent(new RoomWidgetSettingsUpdateEvent(RoomWidgetSettingsUpdateEvent.RWSUE_SETTINGS, this._container.soundManager.volume));
                    break;
                case RoomWidgetStoreSettingsMessage.RWSSM_STORE_SOUND:
                    this._container.soundManager.volume = (_arg_1 as RoomWidgetStoreSettingsMessage).volume;
                    this._container.events.dispatchEvent(new RoomWidgetSettingsUpdateEvent(RoomWidgetSettingsUpdateEvent.RWSUE_SETTINGS, this._container.soundManager.volume));
                    break;
                case RoomWidgetStoreSettingsMessage.RWSSM_PREVIEW_SOUND:
                    this._container.soundManager.previewVolume = (_arg_1 as RoomWidgetStoreSettingsMessage).volume;
                    this._container.events.dispatchEvent(new RoomWidgetSettingsUpdateEvent(RoomWidgetSettingsUpdateEvent.RWSUE_SETTINGS, this._container.soundManager.volume));
                    break;
                case RoomWidgetAvatarEditorMessage.RWAEM_AVATAR_EDITOR_VIEW_DISPOSED:
                    if (((this._container.habboHelp) && (this._container.habboHelp.events))){
                        this._container.habboHelp.events.dispatchEvent(new HabboHelpTutorialEvent(HabboHelpTutorialEvent.HHTE_DONE_AVATAR_EDITOR_CLOSING));
                    };
                    break;
                default:
                    Logger.log(("Unhandled message in MeMenuWidgetHandler: " + _arg_1.type));
            };
            return (null);
        }
        public function IRoomWidgetHandler():Array
        {
            return ([]);
        }
        public function IRoomWidgetHandler(_arg_1:Event):void
        {
        }
        public function update():void
        {
        }
        private function MeMenuWidgetHandler(_arg_1:Event=null):void
        {
            var _local_2:Array;
            if (this._container == null){
                return;
            };
            Logger.log("[MeMenuWidgetHandler] Received Avatar Effects Have Changed Event...\t");
            if (this._inventory != null){
                _local_2 = this._inventory.HabboInventory();
                this._container.events.dispatchEvent(new RoomWidgetUpdateEffectsUpdateEvent(_local_2));
            };
        }
        private function MeMenuWidgetHandler(_arg_1:Event=null):void
        {
            var _local_2:Boolean;
            if (this._inventory != null){
                _local_2 = false;
                if (((!((this._container == null))) && (!((this._container.sessionDataManager == null))))){
                    _local_2 = this._container.sessionDataManager.hasUserRight("fuse_use_club_dance", HabboClubLevelEnum._SafeStr_3943);
                };
                this._container.events.dispatchEvent(new RoomWidgetHabboClubUpdateEvent(this._inventory.clubDays, this._inventory.clubPeriods, this._inventory.clubPastPeriods, _local_2, this._inventory.clubLevel));
            };
        }
        private function onFigureUpdate(_arg_1:HabboSessionFigureUpdatedEvent):void
        {
            if (this._container == null){
                return;
            };
            if (_arg_1 == null){
                return;
            };
            var _local_2 = (_arg_1.userId == this._container.sessionDataManager.userId);
            if (_local_2){
                this.MeMenuWidgetHandler();
            };
            if (((!((this._container == null))) && (!((this._container.events == null))))){
            };
        }
        private function onCreditBalance(_arg_1:PurseEvent):void
        {
            if ((((((_arg_1 == null)) || ((this._container == null)))) || ((this._container.events == null)))){
                return;
            };
            this._container.events.dispatchEvent(new RoomWidgetPurseUpdateEvent(RoomWidgetPurseUpdateEvent.RWPUE_CREDIT_BALANCE, _arg_1.balance));
        }
        private function MeMenuWidgetHandler(_arg_1:HabboHelpTutorialEvent):void
        {
            if (this._container == null){
                return;
            };
            switch (_arg_1.type){
                case HabboHelpTutorialEvent.HHTPNUFWE_AE_STARTED:
                    this._container.events.dispatchEvent(new RoomWidgetTutorialEvent(RoomWidgetTutorialEvent.HHTPNUFWE_AE_STARTED));
                    return;
                case HabboHelpTutorialEvent.HHTPNUFWE_LIGHT_CLOTHES_ICON:
                    this._container.events.dispatchEvent(new RoomWidgetTutorialEvent(RoomWidgetTutorialEvent.HHTPNUFWE_AE_HIGHLIGHT));
                    return;
            };
        }
        public function avatarImageReady(_arg_1:String):void
        {
            this._SafeStr_7262 = "";
            this.MeMenuWidgetHandler();
        }

    }
}//package com.sulake.habbo.ui.handler

// InventoryCategory = "_-04Y" (String#14224, DoABC#2)
// AvatarScaleType = "_-2lF" (String#20893, DoABC#2)
// CatalogPageName = "_-mv" (String#24149, DoABC#2)
// PurseEvent = "_-kO" (String#24049, DoABC#2)
// HabboInventoryEffectsEvent = "_-0Us" (String#15238, DoABC#2)
// HabboClubLevelEnum = "_-1ZP" (String#17867, DoABC#2)
// IHabboCatalog = "_-1fJ" (String#5651, DoABC#2)
// RoomWidgetMessage = "_-04U" (String#3654, DoABC#2)
// MeMenuWidget = "_-02H" (String#3610, DoABC#2)
// HabboSessionFigureUpdatedEvent = "_-1Yz" (String#17851, DoABC#2)
// AvatarEditorInstanceId = "_-3Bn" (String#21953, DoABC#2)
// IUserData = "_-0n7" (String#4570, DoABC#2)
// HabboInventoryHabboClubEvent = "_-0Pe" (String#15048, DoABC#2)
// HabboHelpTutorialEvent = "_-TD" (String#23373, DoABC#2)
// RoomWidgetUpdateEvent = "_-0ZP" (String#4289, DoABC#2)
// MeMenuWidgetHandler = "_-1dd" (String#5625, DoABC#2)
// RoomWidgetRequestWidgetMessage = "_-XQ" (String#8356, DoABC#2)
// RoomWidgetToolbarClickedUpdateEvent = "_-2PS" (String#6551, DoABC#2)
// RoomWidgetSettingsUpdateEvent = "_-1WG" (String#5478, DoABC#2)
// RoomWidgetPurseUpdateEvent = "_-2mA" (String#7009, DoABC#2)
// RoomWidgetTutorialEvent = "_-1LH" (String#5266, DoABC#2)
// RoomWidgetMeMenuMessage = "_-0Ow" (String#4069, DoABC#2)
// RoomWidgetHabboClubUpdateEvent = "_-2ZL" (String#6751, DoABC#2)
// RoomWidgetUpdateEffectsUpdateEvent = "_-14K" (String#4965, DoABC#2)
// RoomWidgetOpenInventoryMessage = "_-1bT" (String#5586, DoABC#2)
// RoomWidgetStopEffectMessage = "_-2VQ" (String#6671, DoABC#2)
// RoomWidgetNavigateToRoomMessage = "_-26Z" (String#6177, DoABC#2)
// RoomWidgetWaveMessage = "_-OB" (String#8167, DoABC#2)
// RoomWidgetAvatarEditorMessage = "_-2-5" (String#6031, DoABC#2)
// RoomWidgetStoreSettingsMessage = "_-33h" (String#7379, DoABC#2)
// RoomWidgetSelectEffectMessage = "_-382" (String#7474, DoABC#2)
// RoomWidgetGetSettingsMessage = "_-2lr" (String#7003, DoABC#2)
// RoomWidgetGetEffectsMessage = "_-0B9" (String#3781, DoABC#2)
// RoomWidgetShowOwnRoomsMessage = "_-1xI" (String#5978, DoABC#2)
// RoomWidgetDanceMessage = "_-1CY" (String#5117, DoABC#2)
// RoomWidgetSelectOutfitMessage = "_-2cP" (String#6801, DoABC#2)
// RoomWidgetOpenCatalogMessage = "_-2Cg" (String#6297, DoABC#2)
// RWRWM_ME_MENU = "_-2Ka" (String#19826, DoABC#2)
// RWRWM_EFFECTS = "_-9y" (String#22615, DoABC#2)
// RWMMM_MESSAGE_ME_MENU_OPENED = "_-1vk" (String#18787, DoABC#2)
// RWGOI_MESSAGE_OPEN_INVENTORY = "_-2J7" (String#19772, DoABC#2)
// _SafeStr_3550 = "_-13C" (String#16588, DoABC#2)
// _SafeStr_3551 = "_-2cL" (String#20537, DoABC#2)
// _SafeStr_3552 = "_-sk" (String#24390, DoABC#2)
// _SafeStr_3553 = "_-Hu" (String#22925, DoABC#2)
// inventoryType = "_-0tH" (String#16170, DoABC#2)
// RWGOI_MESSAGE_STOP_EFFECT = "_-33c" (String#21647, DoABC#2)
// RWGOI_MESSAGE_NAVIGATE_TO_ROOM = "_-1et" (String#18093, DoABC#2)
// RWGOI_MESSAGE_NAVIGATE_HOME = "_-0g" (String#15670, DoABC#2)
// RWCM_MESSAGE_WAVE = "_-Vl" (String#23483, DoABC#2)
// RWCM_OPEN_AVATAR_EDITOR = "_-1Sk" (String#17613, DoABC#2)
// RWCM_GET_WARDROBE = "_-21R" (String#19070, DoABC#2)
// RWAEM_AVATAR_EDITOR_VIEW_DISPOSED = "_-sK" (String#24374, DoABC#2)
// RWSSM_STORE_SETTINGS = "_-01B" (String#14099, DoABC#2)
// RWSSM_STORE_SOUND = "_-1fr" (String#18131, DoABC#2)
// RWSSM_PREVIEW_SOUND = "_-1Z6" (String#17856, DoABC#2)
// volume = "_-0SB" (String#1473, DoABC#2)
// RWCM_MESSAGE_SELECT_EFFECT = "_-LY" (String#23065, DoABC#2)
// RWCM_MESSAGE_UNSELECT_EFFECT = "_-0rJ" (String#16097, DoABC#2)
// RWCM_MESSAGE_UNSELECT_ALL_EFFECTS = "_-1nv" (String#18458, DoABC#2)
// effectType = "_-30t" (String#21534, DoABC#2)
// RWGSM_GET_SETTINGS = "_-065" (String#14285, DoABC#2)
// RWCM_MESSAGE_GET_EFFECTS = "_-0IG" (String#14769, DoABC#2)
// RWSORM_SHOW_OWN_ROOMS = "_-34J" (String#21671, DoABC#2)
// RWCM_MESSAGE_DANCE = "_-3In" (String#22229, DoABC#2)
// _SafeStr_3580 = "_-30-" (String#21501, DoABC#2)
// RWGOI_MESSAGE_OPEN_CATALOG = "_-1a6" (String#17899, DoABC#2)
// RWOCM_CLUB_MAIN = "_-1FR" (String#17091, DoABC#2)
// pageKey = "_-2Wl" (String#20314, DoABC#2)
// widget = "_-1yo" (String#18920, DoABC#2)
// RWSUE_SETTINGS = "_-HH" (String#22902, DoABC#2)
// HHTPNUFWE_AE_STARTED = "_-0Le" (String#14899, DoABC#2)
// HHTPNUFWE_AE_HIGHLIGHT = "_-06p" (String#14317, DoABC#2)
// RWPUE_CREDIT_BALANCE = "_-31Q" (String#21556, DoABC#2)
// onCreditBalance = "_-2Mm" (String#886, DoABC#2)
// _SafeStr_3943 = "_-xn" (String#24604, DoABC#2)
// RWE_ME_MENU = "_-1P1" (String#17469, DoABC#2)
// _SafeStr_4336 = "_-1wM" (String#18815, DoABC#2)
// _disposed = "_-6m" (String#31, DoABC#2)
// _SafeStr_4457 = "_-2mY" (String#20943, DoABC#2)
// _SafeStr_4458 = "_-327" (String#21586, DoABC#2)
// clubPastPeriods = "_-U4" (String#8286, DoABC#2)
// HABBO_SESSION_FIGURE_UPDATE = "_-0yO" (String#16368, DoABC#2)
// sessionDataManager = "_-0pX" (String#4623, DoABC#2)
// soundManager = "_-1sN" (String#5892, DoABC#2)
// _inventory = "_-1O" (String#113, DoABC#2)
// HIHCE_HABBO_CLUB_CHANGED = "_-36p" (String#21757, DoABC#2)
// _SafeStr_5382 = "_-lc" (String#24094, DoABC#2)
// getCroppedImage = "_-2Ez" (String#6342, DoABC#2)
// avatarImageReady = "_-i" (String#8553, DoABC#2)
// IHabboInventory = "_-ud" (String#8776, DoABC#2)
// HabboInventory = "_-1MK" (String#5280, DoABC#2)
// _SafeStr_5995 = "_-2qT" (String#21102, DoABC#2)
// _SafeStr_6005 = "_-25o" (String#19251, DoABC#2)
// _toolbar = "_-1LG" (String#93, DoABC#2)
// getUserData = "_-1-1" (String#4848, DoABC#2)
// userDataManager = "_-lZ" (String#8636, DoABC#2)
// HIEE_EFFECTS_CHANGED = "_-9W" (String#22600, DoABC#2)
// roomSession = "_-0cq" (String#4363, DoABC#2)
// openEditor = "_-86" (String#2059, DoABC#2)
// avatarEditor = "_-1mJ" (String#5786, DoABC#2)
// _SafeStr_6812 = "_-2OT" (String#19984, DoABC#2)
// loadOwnAvatarInEditor = "_-ae" (String#2135, DoABC#2)
// _SafeStr_7061 = "_-3KY" (String#22306, DoABC#2)
// IRoomWidgetHandler = "_-1dr" (String#5626, DoABC#2)
// IRoomWidgetHandler = "_-0gb" (String#4436, DoABC#2)
// IRoomWidgetHandler = "_-xT" (String#2223, DoABC#2)
// IAvatarImageListener = "_-06N" (String#3688, DoABC#2)
// RoomSession = "_-3BE" (String#7533, DoABC#2)
// RoomEngine = "_-1aj" (String#5572, DoABC#2)
// _SafeStr_7260 = "_-0oq" (String#16005, DoABC#2)
// _SafeStr_7261 = "_-1SQ" (String#17597, DoABC#2)
// _SafeStr_7262 = "_-17s" (String#16768, DoABC#2)
// _SafeStr_7263 = "_-xH" (String#24579, DoABC#2)
// _MeMenuWidgetHandler = "_-13N" (String#16593, DoABC#2)
// onFigureUpdate = "_-2uZ" (String#1961, DoABC#2)
// MeMenuWidgetHandler = "_-386" (String#21807, DoABC#2)
// MeMenuWidgetHandler = "_-1tT" (String#18696, DoABC#2)
// HTE_TOOLBAR_CLICK = "_-22-" (String#19089, DoABC#2)
// onHabboToolbarEvent = "_-0Ve" (String#435, DoABC#2)
// habboHelp = "_-015" (String#3584, DoABC#2)
// HHTPNUFWE_LIGHT_CLOTHES_ICON = "_-Ft" (String#22847, DoABC#2)
// MeMenuWidgetHandler = "_-0Yy" (String#15400, DoABC#2)
// MeMenuWidgetHandler = "_-2fH" (String#20658, DoABC#2)
// setIconBitmap = "_-27Q" (String#1818, DoABC#2)
// iconId = "_-2di" (String#20590, DoABC#2)
// RoomSession = "_-1SB" (String#5401, DoABC#2)
// HabboInventory = "_-aN" (String#2133, DoABC#2)
// HabboInventory = "_-1Ct" (String#1634, DoABC#2)
// HabboInventory = "_-2rY" (String#1952, DoABC#2)
// HabboInventory = "_-0tu" (String#4721, DoABC#2)
// goToHomeRoom = "_-LH" (String#8108, DoABC#2)
// showOwnRooms = "_-0Z5" (String#4281, DoABC#2)
// HHTE_DONE_AVATAR_EDITOR_OPENING = "_-2Gq" (String#19675, DoABC#2)
// previewVolume = "_-1fh" (String#5660, DoABC#2)
// HHTE_DONE_AVATAR_EDITOR_CLOSING = "_-0NU" (String#14972, DoABC#2)
// IHabboToolbar = "_-0Wr" (String#4245, DoABC#2)


