
package com.sulake.habbo.ui.widget
{
    import com.sulake.core.runtime.Component;
    import com.sulake.habbo.ui.IRoomWidgetFactory;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.habbo.localization.IHabboLocalizationManager;
    import com.sulake.habbo.configuration.IHabboConfigurationManager;
    import com.sulake.habbo.quest.IHabboQuestEngine;
    import com.sulake.habbo.catalog.IHabboCatalog;
    import com.sulake.habbo.inventory.IHabboInventory;
    import com.sulake.habbo.sound.IHabboSoundManager;
    import com.sulake.habbo.room.IRoomEngine;
    import com.sulake.iid.IIDHabboWindowManager;
    import com.sulake.iid.IIDHabboLocalizationManager;
    import com.sulake.iid.IIDHabboConfigurationManager;
    import com.sulake.iid.IIDHabboCatalog;
    import com.sulake.iid.IIDHabboInventory;
    import com.sulake.iid.IIDHabboSoundManager;
    import com.sulake.iid.IIDHabboQuestEngine;
    import com.sulake.iid.IIDRoomEngine;
    import com.sulake.core.runtime.IContext;
    import com.sulake.core.runtime.IID;
    import com.sulake.core.runtime.IUnknown;
    import com.sulake.habbo.ui.widget.roomchat.RoomChatWidget;
    import com.sulake.habbo.ui.widget.enums.RoomWidgetEnum;
    import com.sulake.habbo.ui.widget.chatinput.RoomChatInputWidget;
    import com.sulake.habbo.ui.widget.infostand.InfostandWidget;
    import com.sulake.habbo.ui.widget.memenu.MeMenuWidget;
    import com.sulake.habbo.ui.widget.furniture.placeholder.PlaceholderWidget;
    import com.sulake.habbo.ui.widget.furniture.credit.CreditFurniWidget;
    import com.sulake.habbo.ui.widget.furniture.stickie.StickieFurniWidget;
    import com.sulake.habbo.ui.widget.furniture.present.PresentFurniWidget;
    import com.sulake.habbo.ui.widget.furniture.trophy.TrophyFurniWidget;
    import com.sulake.habbo.ui.widget.furniture.teaser.TeaserFurniWidget;
    import com.sulake.habbo.ui.widget.furniture.ecotronbox.EcotronBoxFurniWidget;
    import com.sulake.habbo.ui.widget.furniture.petpackage.PetPackageFurniWidget;
    import com.sulake.habbo.ui.widget.doorbell.DoorbellWidget;
    import com.sulake.habbo.ui.widget.loadingbar.LoadingBarWidget;
    import com.sulake.habbo.ui.widget.roomqueue.RoomQueueWidget;
    import com.sulake.habbo.ui.widget.poll.VoteWidget;
    import com.sulake.habbo.ui.widget.poll.PollWidget;
    import com.sulake.habbo.ui.widget.chooser.UserChooserWidget;
    import com.sulake.habbo.ui.widget.chooser.FurniChooserWidget;
    import com.sulake.habbo.ui.widget.furniture.dimmer.DimmerFurniWidget;
    import com.sulake.habbo.ui.widget.friendrequest.FriendRequestWidget;
    import com.sulake.habbo.ui.widget.furniture.clothingchange.ClothingChangeFurnitureWidget;
    import com.sulake.habbo.ui.widget.notification.UserNotificationWidget;
    import com.sulake.habbo.ui.widget.avatarinfo.AvatarInfoWidget;
    import com.sulake.habbo.ui.widget.furniture.welcomegift.WelcomeGiftWidget;
    import com.sulake.habbo.ui.widget.playlisteditor.PlayListEditorWidget;
    import com.sulake.habbo.ui.widget.furniture.stickie.SpamWallPostItFurniWidget;
    import com.sulake.habbo.ui.widget.effects.EffectsWidget;
    import com.sulake.habbo.ui.IRoomWidgetHandler;

    public class RoomWidgetFactory extends Component implements IRoomWidgetFactory 
    {

        private var _windowManager:IHabboWindowManager;
        private var _SafeStr_8016:IAssetLibrary;
        private var _localizations:IHabboLocalizationManager;
        private var _habboConfiguration:IHabboConfigurationManager;
        private var _SafeStr_8017:IHabboQuestEngine;
        private var _catalog:IHabboCatalog;
        private var _inventory:IHabboInventory;
        private var _soundManager:IHabboSoundManager;
        private var _roomEngine:IRoomEngine;
        private var _SafeStr_8018:int = 0;

        public function RoomWidgetFactory(_arg_1:IContext, _arg_2:uint=0, _arg_3:IAssetLibrary=null)
        {
            super(_arg_1, _arg_2, _arg_3);
            this._SafeStr_8016 = _arg_1.root.assets;
            queueInterface(new IIDHabboWindowManager(), this.onWindowManagerReady);
            queueInterface(new IIDHabboLocalizationManager(), this.onLocalizationReady);
            queueInterface(new IIDHabboConfigurationManager(), this.onHabboConfigurationReady);
            queueInterface(new IIDHabboCatalog(), this.onCatalogReady);
            queueInterface(new IIDHabboInventory(), this.onInventoryReady);
            queueInterface(new IIDHabboSoundManager(), this.onSoundManagerReady);
            queueInterface(new IIDHabboQuestEngine(), this.onQuestEngineReady);
            queueInterface(new IIDRoomEngine(), this.onRoomEngineReady);
        }
        override public function dispose():void
        {
            if (this._windowManager){
                this._windowManager.release(new IIDHabboWindowManager());
                this._windowManager = null;
            };
            if (this._localizations){
                this._localizations.release(new IIDHabboLocalizationManager());
                this._localizations = null;
            };
            if (this._habboConfiguration){
                this._habboConfiguration.release(new IIDHabboConfigurationManager());
                this._habboConfiguration = null;
            };
            if (this._soundManager){
                this._soundManager.release(new IIDHabboSoundManager());
                this._soundManager = null;
            };
            if (this._catalog){
                this._catalog.release(new IIDHabboCatalog());
                this._catalog = null;
            };
            if (this._inventory){
                this._inventory.release(new IIDHabboInventory());
                this._inventory = null;
            };
            if (this._SafeStr_8017){
                this._SafeStr_8017.release(new IIDHabboQuestEngine());
                this._SafeStr_8017 = null;
            };
            if (this._roomEngine){
                this._roomEngine.release(new IIDRoomEngine());
                this._roomEngine = null;
            };
            super.dispose();
        }
        private function onWindowManagerReady(_arg_1:IID=null, _arg_2:IUnknown=null):void
        {
            this._windowManager = (_arg_2 as IHabboWindowManager);
        }
        private function onLocalizationReady(_arg_1:IID=null, _arg_2:IUnknown=null):void
        {
            this._localizations = (_arg_2 as IHabboLocalizationManager);
        }
        private function onHabboConfigurationReady(_arg_1:IID=null, _arg_2:IUnknown=null):void
        {
            this._habboConfiguration = (_arg_2 as IHabboConfigurationManager);
        }
        private function onCatalogReady(_arg_1:IID=null, _arg_2:IUnknown=null):void
        {
            if (disposed){
                return;
            };
            this._catalog = (_arg_2 as IHabboCatalog);
        }
        private function onInventoryReady(_arg_1:IID=null, _arg_2:IUnknown=null):void
        {
            if (disposed){
                return;
            };
            this._inventory = (_arg_2 as IHabboInventory);
        }
        private function onSoundManagerReady(_arg_1:IID=null, _arg_2:IUnknown=null):void
        {
            if (disposed){
                return;
            };
            this._soundManager = (_arg_2 as IHabboSoundManager);
        }
        private function onQuestEngineReady(_arg_1:IID=null, _arg_2:IUnknown=null):void
        {
            if (disposed){
                return;
            };
            this._SafeStr_8017 = (_arg_2 as IHabboQuestEngine);
        }
        private function onRoomEngineReady(_arg_1:IID=null, _arg_2:IUnknown=null):void
        {
            if (disposed){
                return;
            };
            this._roomEngine = (_arg_2 as IRoomEngine);
        }
        public function createWidget(_arg_1:String, _arg_2:IRoomWidgetHandler):IRoomWidget
        {
            var _local_3:IRoomWidget;
            if (this._windowManager == null){
                return (null);
            };
            switch (_arg_1){
                case RoomWidgetEnum.RWE_CHAT_WIDGET:
                    _local_3 = new RoomChatWidget(_arg_2, this._windowManager, assets, this._localizations, this._habboConfiguration, this._SafeStr_8018++, this);
                    break;
                case RoomWidgetEnum.RWE_CHAT_INPUT_WIDGET:
                    _local_3 = new RoomChatInputWidget(_arg_2, this._windowManager, assets, this._localizations, this._habboConfiguration, this);
                    break;
                case RoomWidgetEnum.RWE_INFOSTAND:
                    _local_3 = new InfostandWidget(_arg_2, this._windowManager, assets, this._localizations, this._habboConfiguration, this._catalog);
                    break;
                case RoomWidgetEnum.RWE_ME_MENU:
                    _local_3 = new MeMenuWidget(_arg_2, this._windowManager, assets, this._localizations, events, this._habboConfiguration);
                    break;
                case RoomWidgetEnum.RWE_FURNI_PLACEHOLDER:
                    _local_3 = new PlaceholderWidget(_arg_2, this._windowManager, assets, this._localizations);
                    break;
                case RoomWidgetEnum.RWE_FURNI_CREDIT_WIDGET:
                    _local_3 = new CreditFurniWidget(_arg_2, this._windowManager, assets, this._localizations);
                    break;
                case RoomWidgetEnum.RWE_FURNI_STICKIE_WIDGET:
                    _local_3 = new StickieFurniWidget(_arg_2, this._windowManager, assets);
                    break;
                case RoomWidgetEnum.RWE_FURNI_PRESENT_WIDGET:
                    _local_3 = new PresentFurniWidget(_arg_2, this._windowManager, assets);
                    break;
                case RoomWidgetEnum.RWE_FURNI_TROPHY_WIDGET:
                    _local_3 = new TrophyFurniWidget(_arg_2, this._windowManager, assets);
                    break;
                case RoomWidgetEnum.RWE_FURNI_TEASER_WIDGET:
                    _local_3 = new TeaserFurniWidget(_arg_2, this._windowManager, assets, this._localizations, this._habboConfiguration, this._inventory);
                    break;
                case RoomWidgetEnum.RWE_FURNI_ECOTRONBOX_WIDGET:
                    _local_3 = new EcotronBoxFurniWidget(_arg_2, this._windowManager, assets);
                    break;
                case RoomWidgetEnum.RWE_FURNI_PET_PACKAGE_WIDGET:
                    _local_3 = new PetPackageFurniWidget(_arg_2, this._windowManager, assets, this._localizations);
                    break;
                case RoomWidgetEnum.RSDE_DOORBELL:
                    _local_3 = new DoorbellWidget(_arg_2, this._windowManager, assets, this._localizations);
                    break;
                case RoomWidgetEnum.RWE_LOADINGBAR:
                    _local_3 = new LoadingBarWidget(_arg_2, this._windowManager, assets, this._localizations, this._habboConfiguration);
                    break;
                case RoomWidgetEnum.RWE_ROOM_QUEUE:
                    _local_3 = new RoomQueueWidget(_arg_2, this._windowManager, assets, this._localizations, this._habboConfiguration);
                    break;
                case RoomWidgetEnum.RWE_ROOM_VOTE:
                    _local_3 = new VoteWidget(_arg_2, this._windowManager, assets, this._localizations, this._habboConfiguration);
                    break;
                case RoomWidgetEnum.RWE_ROOM_POLL:
                    _local_3 = new PollWidget(_arg_2, this._windowManager, assets, this._localizations);
                    break;
                case RoomWidgetEnum.RWE_USER_CHOOSER:
                    _local_3 = new UserChooserWidget(_arg_2, this._windowManager, assets, this._localizations);
                    break;
                case RoomWidgetEnum.RWE_FURNI_CHOOSER:
                    _local_3 = new FurniChooserWidget(_arg_2, this._windowManager, assets, this._localizations);
                    break;
                case RoomWidgetEnum.RWE_ROOM_DIMMER:
                    _local_3 = new DimmerFurniWidget(_arg_2, this._windowManager, assets, this._localizations);
                    break;
                case RoomWidgetEnum.RSFRE_FRIEND_REQUEST:
                    _local_3 = new FriendRequestWidget(_arg_2, this._windowManager, assets, this._localizations, this);
                    break;
                case RoomWidgetEnum.RWE_CLOTHING_CHANGE:
                    _local_3 = new ClothingChangeFurnitureWidget(_arg_2, this._windowManager, assets, this._localizations);
                    break;
                case RoomWidgetEnum.RWE_CONVERSION_TRACKING:
                    _local_3 = new RoomWidgetBase(_arg_2, this._windowManager);
                    break;
                case RoomWidgetEnum.RSUN_USER_NOTIFICATION:
                    _local_3 = new UserNotificationWidget(_arg_2, this._windowManager, assets, this._localizations);
                    break;
                case RoomWidgetEnum.RWAIE_AVATAR_INFO:
                    _local_3 = new AvatarInfoWidget(_arg_2, this._windowManager, assets, this._habboConfiguration, this._localizations, this);
                    break;
                case RoomWidgetEnum.RWE_WELCOME_GIFT:
                    _local_3 = new WelcomeGiftWidget(_arg_2, this._windowManager, assets, this._localizations);
                    break;
                case RoomWidgetEnum.RWE_PLAYLIST_EDITOR_WIDGET:
                    _local_3 = new PlayListEditorWidget(_arg_2, this._windowManager, this._soundManager, assets, this._localizations, this._habboConfiguration, this._catalog);
                    break;
                case RoomWidgetEnum.RWE_SPAMWALL_POSTIT_WIDGET:
                    _local_3 = new SpamWallPostItFurniWidget(_arg_2, this._windowManager, assets);
                    break;
                case RoomWidgetEnum.RWE_EFFECTS:
                    _local_3 = new EffectsWidget(_arg_2, this._windowManager, assets);
                    break;
            };
            return (_local_3);
        }
        public function get windowManager():IHabboWindowManager
        {
            return (this._windowManager);
        }
        public function get localizations():IHabboLocalizationManager
        {
            return (this._localizations);
        }
        public function get config():IHabboConfigurationManager
        {
            return (this._habboConfiguration);
        }

    }
}//package com.sulake.habbo.ui.widget

// IID = "_-3KV" (String#7712, DoABC#2)
// IHabboCatalog = "_-1fJ" (String#5651, DoABC#2)
// IRoomWidget = "_-1r4" (String#5876, DoABC#2)
// RoomWidgetBase = "_-0eQ" (String#4398, DoABC#2)
// FurniChooserWidget = "_-0WS" (String#4236, DoABC#2)
// UserChooserWidget = "_-2hs" (String#6903, DoABC#2)
// PlayListEditorWidget = "_-1O-" (String#5310, DoABC#2)
// FriendRequestWidget = "_-1-w" (String#4866, DoABC#2)
// TeaserFurniWidget = "_-1kW" (String#5761, DoABC#2)
// EffectsWidget = "_-ds" (String#8482, DoABC#2)
// WelcomeGiftWidget = "_-1Jh" (String#5235, DoABC#2)
// StickieFurniWidget = "_-2ud" (String#7171, DoABC#2)
// PresentFurniWidget = "_-0WM" (String#4234, DoABC#2)
// EcotronBoxFurniWidget = "_-2cg" (String#6805, DoABC#2)
// CreditFurniWidget = "_-0Lg" (String#3996, DoABC#2)
// PetPackageFurniWidget = "_-2bM" (String#6779, DoABC#2)
// RoomQueueWidget = "_-09m" (String#3754, DoABC#2)
// VoteWidget = "_-qq" (String#8722, DoABC#2)
// DoorbellWidget = "_-1Qv" (String#5372, DoABC#2)
// RoomChatInputWidget = "_-1Oc" (String#5326, DoABC#2)
// PollWidget = "_-0pz" (String#4635, DoABC#2)
// RoomChatWidget = "_-Yb" (String#8385, DoABC#2)
// PlaceholderWidget = "_-0Ea" (String#3840, DoABC#2)
// UserNotificationWidget = "_-25q" (String#6157, DoABC#2)
// ClothingChangeFurnitureWidget = "_-0hZ" (String#4458, DoABC#2)
// TrophyFurniWidget = "_-0HP" (String#3903, DoABC#2)
// LoadingBarWidget = "_-21L" (String#6072, DoABC#2)
// SpamWallPostItFurniWidget = "_-x1" (String#8825, DoABC#2)
// DimmerFurniWidget = "_-1-P" (String#4856, DoABC#2)
// MeMenuWidget = "_-02H" (String#3610, DoABC#2)
// AvatarInfoWidget = "_-3Bt" (String#7549, DoABC#2)
// RWE_ROOM_VOTE = "_-1yq" (String#18921, DoABC#2)
// RWE_CHAT_WIDGET = "_-2dZ" (String#20586, DoABC#2)
// RWE_INFOSTAND = "_-0SA" (String#15142, DoABC#2)
// RWE_ME_MENU = "_-1P1" (String#17469, DoABC#2)
// RWE_CHAT_INPUT_WIDGET = "_-L1" (String#23048, DoABC#2)
// RWE_FURNI_PLACEHOLDER = "_-A-" (String#22617, DoABC#2)
// RWE_FURNI_CREDIT_WIDGET = "_-2b9" (String#20495, DoABC#2)
// RWE_FURNI_STICKIE_WIDGET = "_-05M" (String#14258, DoABC#2)
// RWE_FURNI_TROPHY_WIDGET = "_-2lt" (String#20911, DoABC#2)
// RWE_FURNI_TEASER_WIDGET = "_-2Qe" (String#20070, DoABC#2)
// RWE_FURNI_PRESENT_WIDGET = "_-2S0" (String#20119, DoABC#2)
// RWE_FURNI_ECOTRONBOX_WIDGET = "_-0R8" (String#15107, DoABC#2)
// RWE_FURNI_PET_PACKAGE_WIDGET = "_-0tQ" (String#16176, DoABC#2)
// RWE_PLAYLIST_EDITOR_WIDGET = "_-0b8" (String#15481, DoABC#2)
// RSDE_DOORBELL = "_-0bt" (String#15507, DoABC#2)
// RWE_LOADINGBAR = "_-3IO" (String#22216, DoABC#2)
// RWE_ROOM_QUEUE = "_-0WD" (String#15288, DoABC#2)
// RWE_ROOM_POLL = "_-Y" (String#23560, DoABC#2)
// RWE_USER_CHOOSER = "_-1-0" (String#16430, DoABC#2)
// RWE_FURNI_CHOOSER = "_-0aa" (String#15458, DoABC#2)
// RWE_ROOM_DIMMER = "_-2cE" (String#20532, DoABC#2)
// RSFRE_FRIEND_REQUEST = "_-2Wu" (String#20318, DoABC#2)
// RWE_CLOTHING_CHANGE = "_-1Q2" (String#17511, DoABC#2)
// RWE_CONVERSION_TRACKING = "_-30V" (String#21521, DoABC#2)
// RSUN_USER_NOTIFICATION = "_-0ni" (String#15964, DoABC#2)
// RWAIE_AVATAR_INFO = "_-2QK" (String#20059, DoABC#2)
// RWE_WELCOME_GIFT = "_-OF" (String#23177, DoABC#2)
// RWE_SPAMWALL_POSTIT_WIDGET = "_-SH" (String#23335, DoABC#2)
// RWE_EFFECTS = "_-mU" (String#24127, DoABC#2)
// IHabboSoundManager = "_-0vD" (String#4750, DoABC#2)
// createWidget = "_-2kN" (String#1932, DoABC#2)
// _inventory = "_-1O" (String#113, DoABC#2)
// IHabboInventory = "_-ud" (String#8776, DoABC#2)
// _habboConfiguration = "_-Mv" (String#637, DoABC#2)
// _localizations = "_-0il" (String#358, DoABC#2)
// Component = "_-19A" (String#5060, DoABC#2)
// _SafeStr_8016 = "_-2jR" (String#20823, DoABC#2)
// _SafeStr_8017 = "_-1jf" (String#150, DoABC#2)
// _SafeStr_8018 = "_-0d9" (String#15556, DoABC#2)
// onWindowManagerReady = "_-34x" (String#94, DoABC#2)
// onLocalizationReady = "_-uK" (String#167, DoABC#2)
// onHabboConfigurationReady = "_-1P4" (String#1679, DoABC#2)
// onCatalogReady = "_-27M" (String#245, DoABC#2)
// onInventoryReady = "_-dE" (String#374, DoABC#2)
// onSoundManagerReady = "_-2hg" (String#369, DoABC#2)
// onQuestEngineReady = "_-2bt" (String#20518, DoABC#2)
// IHabboQuestEngine = "_-2tn" (String#7154, DoABC#2)
// RoomWidgetFactory = "_-1pj" (String#18533, DoABC#2)


