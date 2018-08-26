
package com.sulake.habbo.toolbar
{
    import com.sulake.core.runtime.Component;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.habbo.communication.IHabboCommunicationManager;
    import com.sulake.habbo.configuration.IHabboConfigurationManager;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.habbo.toolbar.extensions.ExtraToolsExtension;
    import com.sulake.core.communication.connection.IConnection;
    import com.sulake.habbo.catalog.IHabboCatalog;
    import com.sulake.habbo.toolbar.extensions.purse.PurseExtension;
    import com.sulake.habbo.toolbar.extensions.ClubDiscountPromoExtension;
    import com.sulake.habbo.toolbar.extensions.VideoOfferExtension;
    import com.sulake.core.localization.ICoreLocalizationManager;
    import com.sulake.habbo.inventory.IHabboInventory;
    import com.sulake.habbo.sound.IHabboSoundManager;
    import com.sulake.iid.IIDHabboCommunicationManager;
    import com.sulake.iid.IIDHabboConfigurationManager;
    import com.sulake.iid.IIDHabboWindowManager;
    import com.sulake.iid.IIDHabboCatalog;
    import com.sulake.iid.IIDCoreLocalizationManager;
    import com.sulake.iid.IIDHabboInventory;
    import com.sulake.iid.IIDHabboSoundManager;
    import com.sulake.core.runtime.IContext;
    import com.sulake.core.runtime.IID;
    import com.sulake.core.runtime.IUnknown;
    import com.sulake.habbo.communication.messages.incoming.handshake.AuthenticationOKMessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.toolbar.events.HabboToolbarEvent;
    import com.sulake.habbo.communication.messages.outgoing.tracking.EventLogMessageComposer;
    import flash.display.BitmapData;
    import flash.geom.Rectangle;

    public class HabboToolbar extends Component implements IHabboToolbar 
    {

        private static const _SafeStr_13779:String = "purse";
        private static const _SafeStr_13780:String = "extra_tools";

        private var _windowManager:IHabboWindowManager;
        private var _communicationManager:IHabboCommunicationManager;
        private var _config:IHabboConfigurationManager;
        private var _view:ToolbarView;
        private var _assetLibrary:IAssetLibrary;
        private var _isInitialized:Boolean;
        private var _SafeStr_13781:ExtraToolsExtension;
        private var _connection:IConnection;
        private var _catalog:IHabboCatalog;
        private var _SafeStr_13782:PurseExtension;
        private var _SafeStr_13783:ClubDiscountPromoExtension;
        private var _SafeStr_13784:VideoOfferExtension;
        private var _localization:ICoreLocalizationManager;
        private var _inventory:IHabboInventory;
        private var _extensionView:ExtensionView;
        private var _soundManager:IHabboSoundManager;

        public function HabboToolbar(_arg_1:IContext, _arg_2:uint=0, _arg_3:IAssetLibrary=null)
        {
            super(_arg_1, _arg_2, _arg_3);
            lock();
            this._assetLibrary = _arg_3;
            queueInterface(new IIDHabboCommunicationManager(), this.onCommunicationManagerReady);
            queueInterface(new IIDHabboConfigurationManager(), this.onConfigurationManagerReady);
            queueInterface(new IIDHabboWindowManager(), this.onWindowManagerReady);
            queueInterface(new IIDHabboCatalog(), this.onCatalogReady);
            queueInterface(new IIDCoreLocalizationManager(), this.onLocalizationManagerReady);
            queueInterface(new IIDHabboInventory(), this.onInventoryReady);
            queueInterface(new IIDHabboSoundManager(), this.onSoundManagerReady);
        }
        override public function dispose():void
        {
            this._isInitialized = false;
            this._connection = null;
            if (this._extensionView){
                this._extensionView.dispose();
                this._extensionView = null;
            };
            if (this._SafeStr_13783){
                this._SafeStr_13783.dispose();
                this._SafeStr_13783 = null;
            };
            if (this._SafeStr_13784){
                this._SafeStr_13784.dispose();
                this._SafeStr_13784 = null;
            };
            if (this._SafeStr_13782){
                this._SafeStr_13782.dispose();
                this._SafeStr_13782 = null;
            };
            if (this._SafeStr_13781){
                this._SafeStr_13781.dispose();
                this._SafeStr_13781 = null;
            };
            if (this._soundManager){
                this._soundManager.release(new IIDHabboSoundManager());
                this._soundManager = null;
            };
            if (this._communicationManager){
                this._communicationManager.release(new IIDHabboCommunicationManager());
                this._communicationManager = null;
            };
            if (this._windowManager){
                this._windowManager.release(new IIDHabboWindowManager());
                this._windowManager = null;
            };
            if (this._config){
                this._config.release(new IIDHabboConfigurationManager());
                this._config = null;
            };
            if (this._catalog != null){
                this._catalog.release(new IIDHabboCatalog());
                this._catalog = null;
            };
            if (this._view != null){
                this._view.dispose();
                this._view = null;
            };
            super.dispose();
        }
        private function onCommunicationManagerReady(_arg_1:IID=null, _arg_2:IUnknown=null):void
        {
            this._communicationManager = IHabboCommunicationManager(_arg_2);
            this._connection = this._communicationManager.HabboCommunicationManager(null);
            this.tryInitialize();
        }
        private function onWindowManagerReady(_arg_1:IID=null, _arg_2:IUnknown=null):void
        {
            this._windowManager = IHabboWindowManager(_arg_2);
            this.tryInitialize();
        }
        private function onConfigurationManagerReady(_arg_1:IID=null, _arg_2:IUnknown=null):void
        {
            this._config = IHabboConfigurationManager(_arg_2);
            this.tryInitialize();
        }
        private function onLocalizationManagerReady(_arg_1:IID=null, _arg_2:IUnknown=null):void
        {
            this._localization = ICoreLocalizationManager(_arg_2);
            this.tryInitialize();
        }
        private function onInventoryReady(_arg_1:IID=null, _arg_2:IUnknown=null):void
        {
            this._inventory = IHabboInventory(_arg_2);
            this.tryInitialize();
        }
        private function onCatalogReady(_arg_1:IID=null, _arg_2:IUnknown=null):void
        {
            this._catalog = (_arg_2 as IHabboCatalog);
            this.tryInitialize();
        }
        private function onSoundManagerReady(_arg_1:IID=null, _arg_2:IUnknown=null):void
        {
            this._soundManager = (_arg_2 as IHabboSoundManager);
            this.tryInitialize();
        }
        private function tryInitialize():void
        {
            if (((((((((((((this._communicationManager) && (this._windowManager))) && (this._config))) && (this._localization))) && (this._inventory))) && (this._catalog))) && (this._soundManager))){
                this._communicationManager.HabboCommunicationManager(new AuthenticationOKMessageEvent(this.onAuthenticationOK));
                unlock();
            };
        }
        private function onAuthenticationOK(_arg_1:IMessageEvent):void
        {
            this._view = new ToolbarView(this, this._windowManager, this._assetLibrary, this._connection, this._catalog, events, this._config);
            if (((this._config) && ((this._config.getKey("client.logout.enabled", "false") == "true")))){
                this._extensionView = new ExtensionView(this._windowManager, this._assetLibrary, this);
                if (this._extensionView){
                    this._SafeStr_13782 = new PurseExtension(this._windowManager, this._assetLibrary, this._config, this._catalog, this._inventory, this._localization);
                    this._SafeStr_13781 = new ExtraToolsExtension(this, this._windowManager, this._assetLibrary, events, this._config);
                    if (((this._config.getBoolean("club.membership.extend.vip.promotion.enabled", false)) || (this._config.getBoolean("club.membership.extend.basic.promotion.enabled", false)))){
                        this._SafeStr_13783 = new ClubDiscountPromoExtension(this, this._windowManager, this._assetLibrary, events, this._config, this._localization, this._inventory, this._catalog, this._connection);
                    };
                    if (this._config.getBoolean("supersaverads.video.promo.enabled", false)){
                        this._SafeStr_13784 = new VideoOfferExtension(this, this._windowManager, this._assetLibrary, events, this._config, this._localization, this._inventory, this._catalog, this._connection);
                    };
                    this._extensionView.ExtensionView(_SafeStr_13779, this._SafeStr_13782.window, ExtensionFixedSlotsEnum._SafeStr_13774);
                    this._extensionView.ExtensionView(_SafeStr_13780, this._SafeStr_13781.window, ExtensionFixedSlotsEnum._SafeStr_13775);
                };
            };
            if (this._view == null){
                Logger.log("Error, toolbar view was not available");
                return;
            };
            this._isInitialized = true;
        }
        public function toggleWindowVisibility(_arg_1:String):void
        {
            var _local_2:String = HabboToolbarIconEnum[_arg_1];
            var _local_3:HabboToolbarEvent = new HabboToolbarEvent(HabboToolbarEvent.HTE_TOOLBAR_CLICK);
            _local_3.iconId = _local_2;
            _local_3.iconName = _arg_1;
            events.dispatchEvent(_local_3);
            var _local_4:EventLogMessageComposer = new EventLogMessageComposer("Toolbar", _arg_1, "client.toolbar.clicked");
            if (this._connection){
                this._connection.send(_local_4);
            };
        }
        public function getIconVerticalLocation(_arg_1:String):int
        {
            return (this._view.getIconVerticalLocation(_arg_1));
        }
        public function setUnseenItemCount(_arg_1:String, _arg_2:int):void
        {
            this._view.setUnseenItemCount(_arg_1, _arg_2);
        }
        public function setToolbarState(_arg_1:String):void
        {
            switch (_arg_1){
                case HabboToolbarEnum.HTE_STATE_HOTEL_VIEW:
                    this.toolbarExtensionVisible(false);
                    break;
                case HabboToolbarEnum.HTE_STATE_ROOM_VIEW:
                    this.toolbarExtensionVisible(true);
                    break;
            };
            if (this._view){
                this._view.setToolbarState(_arg_1);
            };
        }
        private function toolbarExtensionVisible(_arg_1:Boolean):void
        {
            if (!this._SafeStr_13781){
                return;
            };
            if (_arg_1){
                this._SafeStr_13781.ExtraToolsExtension();
            }
            else {
                this._SafeStr_13781.ExtraToolsExtension();
            };
        }
        public function setIconBitmap(_arg_1:String, _arg_2:BitmapData):void
        {
            if (this._view){
                this._view.setIconBitmap(_arg_1, _arg_2);
            };
        }
        public function getRect():Rectangle
        {
            if (this._view){
                return (this._view.window.rectangle.clone());
            };
            return (new Rectangle());
        }
        public function get extensionView():IExtensionView
        {
            return (this._extensionView);
        }
        public function get soundManager():IHabboSoundManager
        {
            return (this._soundManager);
        }

    }
}//package com.sulake.habbo.toolbar

// IID = "_-3KV" (String#7712, DoABC#2)
// onAuthenticationOK = "_-20A" (String#612, DoABC#2)
// getIconVerticalLocation = "_-1P2" (String#5334, DoABC#2)
// onLocalizationManagerReady = "_-Za" (String#936, DoABC#2)
// onConfigurationManagerReady = "_-1OV" (String#604, DoABC#2)
// setUnseenItemCount = "_-1B5" (String#5095, DoABC#2)
// HTE_STATE_HOTEL_VIEW = "_-25X" (String#19240, DoABC#2)
// HTE_STATE_ROOM_VIEW = "_-0lU" (String#15882, DoABC#2)
// setToolbarState = "_-2Gw" (String#6384, DoABC#2)
// _SafeStr_13774 = "_-0Q8" (String#15067, DoABC#2)
// _SafeStr_13775 = "_-nU" (String#24171, DoABC#2)
// _SafeStr_13779 = "_-22H" (String#19103, DoABC#2)
// _SafeStr_13780 = "_-oc" (String#24219, DoABC#2)
// _SafeStr_13781 = "_-03x" (String#14199, DoABC#2)
// _SafeStr_13782 = "_-07v" (String#14361, DoABC#2)
// _SafeStr_13783 = "_-d4" (String#23760, DoABC#2)
// _SafeStr_13784 = "_-1Iq" (String#17230, DoABC#2)
// tryInitialize = "_-w2" (String#24531, DoABC#2)
// toolbarExtensionVisible = "_-1FD" (String#17080, DoABC#2)
// IHabboCatalog = "_-1fJ" (String#5651, DoABC#2)
// IExtensionView = "_-1z2" (String#6016, DoABC#2)
// HabboToolbarEnum = "_-1RO" (String#17561, DoABC#2)
// ExtraToolsExtension = "_-1Ws" (String#5490, DoABC#2)
// ClubDiscountPromoExtension = "_-38a" (String#7484, DoABC#2)
// VideoOfferExtension = "_-2EP" (String#6331, DoABC#2)
// ToolbarView = "_-16z" (String#5015, DoABC#2)
// PurseExtension = "_-0kV" (String#4510, DoABC#2)
// ExtensionFixedSlotsEnum = "_-0tc" (String#16185, DoABC#2)
// ExtensionView = "_-20R" (String#6055, DoABC#2)
// IHabboSoundManager = "_-0vD" (String#4750, DoABC#2)
// HabboCommunicationManager = "_-0r" (String#4663, DoABC#2)
// HabboCommunicationManager = "_-0AQ" (String#809, DoABC#2)
// soundManager = "_-1sN" (String#5892, DoABC#2)
// _inventory = "_-1O" (String#113, DoABC#2)
// IHabboInventory = "_-ud" (String#8776, DoABC#2)
// ExtraToolsExtension = "_-08z" (String#14406, DoABC#2)
// ExtraToolsExtension = "_-1rC" (String#18590, DoABC#2)
// toggleWindowVisibility = "_-0g0" (String#15672, DoABC#2)
// extensionView = "_-qR" (String#8717, DoABC#2)
// ExtensionView = "_-01F" (String#3587, DoABC#2)
// Component = "_-19A" (String#5060, DoABC#2)
// HTE_TOOLBAR_CLICK = "_-22-" (String#19089, DoABC#2)
// setIconBitmap = "_-27Q" (String#1818, DoABC#2)
// iconId = "_-2di" (String#20590, DoABC#2)
// IHabboCommunicationManager = "_-0ls" (String#4545, DoABC#2)
// onWindowManagerReady = "_-34x" (String#94, DoABC#2)
// onCatalogReady = "_-27M" (String#245, DoABC#2)
// onInventoryReady = "_-dE" (String#374, DoABC#2)
// onSoundManagerReady = "_-2hg" (String#369, DoABC#2)
// IHabboToolbar = "_-0Wr" (String#4245, DoABC#2)
// EventLogMessageComposer = "_-2lH" (String#6984, DoABC#2)
// iconName = "_-1Xn" (String#5513, DoABC#2)
// _communicationManager = "_-0-x" (String#432, DoABC#2)
// onCommunicationManagerReady = "_-3A0" (String#914, DoABC#2)


