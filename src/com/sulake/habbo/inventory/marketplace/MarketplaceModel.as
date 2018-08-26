
package com.sulake.habbo.inventory.marketplace
{
    import com.sulake.habbo.inventory.IInventoryModel;
    import com.sulake.habbo.inventory.HabboInventory;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.habbo.room.IRoomEngine;
    import com.sulake.habbo.communication.IHabboCommunicationManager;
    import com.sulake.habbo.inventory.items.IItem;
    import com.sulake.habbo.localization.IHabboLocalizationManager;
    import com.sulake.habbo.configuration.IHabboConfigurationManager;
    import com.sulake.habbo.inventory.furni.FurniModel;
    import com.sulake.core.communication.connection.IConnection;
    import com.sulake.habbo.communication.messages.outgoing.marketplace.GetMarketplaceCanMakeOfferComposer;
    import com.sulake.habbo.communication.messages.outgoing.marketplace.BuyMarketplaceTokensMessageComposer;
    import com.sulake.habbo.inventory.items.FloorItem;
    import com.sulake.habbo.communication.messages.outgoing.marketplace.MakeOfferMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.marketplace.GetMarketplaceItemStatsComposer;
    import com.sulake.habbo.communication.messages.outgoing.marketplace.GetMarketplaceConfigurationMessageComposer;
    import com.sulake.core.window.IWindowContainer;

    public class MarketplaceModel implements IInventoryModel 
    {

        private var _controller:HabboInventory;
        private var _assets:IAssetLibrary;
        private var _windowManager:IHabboWindowManager;
        private var _roomEngine:IRoomEngine;
        private var _communication:IHabboCommunicationManager;
        private var _disposed:Boolean = false;
        private var _SafeStr_3764:IItem;
        private var _isEnabled:Boolean;
        private var _commission:int;
        private var _tokenBatchPrice:int;
        private var _tokenBatchSize:int;
        private var _offerMinPrice:int;
        private var _offerMaxPrice:int;
        private var _expirationHours:int;
        private var _averagePricePeriod:int;
        private var _SafeStr_8572:int;
        private var _SafeStr_8573:int;
        private var _view:MarketplaceView;
        private var _SafeStr_8574:Boolean = false;

        public function MarketplaceModel(_arg_1:HabboInventory, _arg_2:IHabboWindowManager, _arg_3:IHabboCommunicationManager, _arg_4:IAssetLibrary, _arg_5:IRoomEngine, _arg_6:IHabboLocalizationManager, _arg_7:IHabboConfigurationManager)
        {
            this._controller = _arg_1;
            this._communication = _arg_3;
            this._windowManager = _arg_2;
            this._assets = _arg_4;
            this._roomEngine = _arg_5;
            this._view = new MarketplaceView(this, this._windowManager, this._assets, _arg_5, _arg_6, _arg_7);
        }
        public function set isEnabled(_arg_1:Boolean):void
        {
            this._isEnabled = _arg_1;
        }
        public function set commission(_arg_1:int):void
        {
            this._commission = _arg_1;
        }
        public function set tokenBatchPrice(_arg_1:int):void
        {
            this._tokenBatchPrice = _arg_1;
        }
        public function set tokenBatchSize(_arg_1:int):void
        {
            this._tokenBatchSize = _arg_1;
        }
        public function set offerMinPrice(_arg_1:int):void
        {
            this._offerMinPrice = _arg_1;
        }
        public function set offerMaxPrice(_arg_1:int):void
        {
            this._offerMaxPrice = _arg_1;
        }
        public function set expirationHours(_arg_1:int):void
        {
            this._expirationHours = _arg_1;
        }
        public function set averagePricePeriod(_arg_1:int):void
        {
            this._averagePricePeriod = _arg_1;
        }
        public function get isEnabled():Boolean
        {
            return (this._isEnabled);
        }
        public function get commission():int
        {
            return (this._commission);
        }
        public function get tokenBatchPrice():int
        {
            return (this._tokenBatchPrice);
        }
        public function get tokenBatchSize():int
        {
            return (this._tokenBatchSize);
        }
        public function get offerMinPrice():int
        {
            return (this._offerMinPrice);
        }
        public function get offerMaxPrice():int
        {
            return (this._offerMaxPrice);
        }
        public function get expirationHours():int
        {
            return (this._expirationHours);
        }
        public function get disposed():Boolean
        {
            return (this._disposed);
        }
        public function dispose():void
        {
            this._controller = null;
            this._communication = null;
            this._windowManager = null;
            this._assets = null;
            this._roomEngine = null;
        }
        public function MarketplaceModel():void
        {
            if (((((!((this._controller == null))) && (!((this._controller.furniModel == null))))) && (!((this._SafeStr_3764 == null))))){
                this._controller.furniModel.GroupItem(this._SafeStr_3764.id);
                this._SafeStr_3764 = null;
            };
        }
        public function MarketplaceModel(_arg_1:IItem):void
        {
            if (((!((this._SafeStr_3764 == null))) || ((_arg_1 == null)))){
                return;
            };
            if (this._controller == null){
                return;
            };
            var _local_2:FurniModel = this._controller.furniModel;
            if (_local_2 == null){
                return;
            };
            this._SafeStr_3764 = _arg_1;
            _local_2.GroupItem(_arg_1.id);
            var _local_3:IConnection = this._communication.HabboCommunicationManager(null);
            if (_local_3 == null){
                return;
            };
            _local_3.send(new GetMarketplaceCanMakeOfferComposer());
        }
        public function MarketplaceModel():void
        {
            var _local_1:IConnection = this._communication.HabboCommunicationManager(null);
            if (_local_1 == null){
                return;
            };
            _local_1.send(new BuyMarketplaceTokensMessageComposer());
            this._SafeStr_8574 = true;
        }
        public function MarketplaceModel(_arg_1:int):void
        {
            if (this._SafeStr_3764 == null){
                return;
            };
            var _local_2:IConnection = this._communication.HabboCommunicationManager(null);
            if (_local_2 == null){
                return;
            };
            var _local_3:int = (((this._SafeStr_3764 is FloorItem)) ? 1 : 2);
            _local_2.send(new MakeOfferMessageComposer(_arg_1, _local_3, this._SafeStr_3764.ref));
            this.MarketplaceModel();
        }
        public function MarketplaceModel():void
        {
            if (this._SafeStr_3764 == null){
                return;
            };
            var _local_1:IConnection = this._communication.HabboCommunicationManager(null);
            if (_local_1 == null){
                return;
            };
            var _local_2:int = (((this._SafeStr_3764 is FloorItem)) ? 1 : 2);
            this._SafeStr_8572 = _local_2;
            this._SafeStr_8573 = this._SafeStr_3764.type;
            _local_1.send(new GetMarketplaceItemStatsComposer(_local_2, this._SafeStr_3764.type));
        }
        public function MarketplaceModel(_arg_1:int, _arg_2:int):void
        {
            this._SafeStr_8574 = false;
            switch (_arg_1){
                case 1:
                    this._view.MarketplaceView(this._SafeStr_3764);
                    return;
                case 2:
                    this._view.MarketplaceView(("$" + "{inventory.marketplace.no_trading_privilege.title}"), ("$" + "{inventory.marketplace.no_trading_privilege.info}"));
                    return;
                case 3:
                    this._view.MarketplaceView(("$" + "{inventory.marketplace.no_trading_pass.title}"), ("$" + "{inventory.marketplace.no_trading_pass.info}"));
                    return;
                case 4:
                    this._view.MarketplaceView(this._tokenBatchPrice, this._tokenBatchSize);
                    return;
            };
        }
        public function _SafeStr_8583(_arg_1:int):void
        {
            if (!this._view){
                return;
            };
            this._view.MarketplaceView(_arg_1);
        }
        public function MarketplaceModel(_arg_1:int, _arg_2:int, _arg_3:int):void
        {
            if (((!((_arg_1 == this._SafeStr_8572))) || (!((_arg_2 == this._SafeStr_8573))))){
                return;
            };
            if (!this._view){
                return;
            };
            this._view.MarketplaceView(_arg_3, this._averagePricePeriod);
        }
        public function onNotEnoughCredits():void
        {
            if (this._SafeStr_8574){
                this._SafeStr_8574 = false;
                this.MarketplaceModel();
            };
        }
        public function TradingModel(_arg_1:int=0):void
        {
            var _local_2:IConnection = this._communication.HabboCommunicationManager(null);
            if (_local_2 == null){
                return;
            };
            _local_2.send(new GetMarketplaceConfigurationMessageComposer());
        }
        public function TradingModel():IWindowContainer
        {
            return (null);
        }
        public function categorySwitch(_arg_1:String):void
        {
        }
        public function TradingModel(_arg_1:String):void
        {
        }
        public function TradingModel():void
        {
        }

    }
}//package com.sulake.habbo.inventory.marketplace

// GetMarketplaceItemStatsComposer = "_-DI" (String#22741, DoABC#2)
// IItem = "_-1-k" (String#4863, DoABC#2)
// IInventoryModel = "_-Fh" (String#7987, DoABC#2)
// FurniModel = "_-1ur" (String#5936, DoABC#2)
// MarketplaceModel = "_-2M1" (String#6484, DoABC#2)
// GetMarketplaceConfigurationMessageComposer = "_-K-" (String#23005, DoABC#2)
// FloorItem = "_-2DW" (String#19547, DoABC#2)
// BuyMarketplaceTokensMessageComposer = "_-1v3" (String#18758, DoABC#2)
// MakeOfferMessageComposer = "_-0pb" (String#16038, DoABC#2)
// GetMarketplaceCanMakeOfferComposer = "_-25I" (String#19229, DoABC#2)
// MarketplaceView = "_-Z7" (String#8395, DoABC#2)
// _controller = "_-18D" (String#59, DoABC#2)
// _SafeStr_3764 = "_-1eS" (String#609, DoABC#2)
// HabboCommunicationManager = "_-0AQ" (String#809, DoABC#2)
// TradingModel = "_-v8" (String#313, DoABC#2)
// isEnabled = "_-2ri" (String#21145, DoABC#2)
// _isEnabled = "_-2au" (String#895, DoABC#2)
// furniModel = "_-Sp" (String#23358, DoABC#2)
// GroupItem = "_-2FC" (String#19612, DoABC#2)
// TradingModel = "_-0Lx" (String#4000, DoABC#2)
// TradingModel = "_-2eX" (String#6842, DoABC#2)
// categorySwitch = "_-3Ad" (String#7526, DoABC#2)
// TradingModel = "_-1Gu" (String#5187, DoABC#2)
// IHabboCommunicationManager = "_-0ls" (String#4545, DoABC#2)
// GroupItem = "_-oD" (String#24199, DoABC#2)
// ref = "_-Jx" (String#8081, DoABC#2)
// MarketplaceModel = "_-0bY" (String#15497, DoABC#2)
// _commission = "_-05d" (String#3678, DoABC#2)
// _tokenBatchPrice = "_-0eg" (String#4404, DoABC#2)
// _tokenBatchSize = "_-Jn" (String#8079, DoABC#2)
// _offerMaxPrice = "_-2RC" (String#6585, DoABC#2)
// _offerMinPrice = "_-0F" (String#3849, DoABC#2)
// _expirationHours = "_-1w7" (String#5961, DoABC#2)
// _averagePricePeriod = "_-2nH" (String#1940, DoABC#2)
// tokenBatchPrice = "_-wK" (String#24546, DoABC#2)
// tokenBatchSize = "_-2Aa" (String#19429, DoABC#2)
// offerMinPrice = "_-026" (String#14129, DoABC#2)
// offerMaxPrice = "_-2pR" (String#21056, DoABC#2)
// expirationHours = "_-0xj" (String#16342, DoABC#2)
// averagePricePeriod = "_-0lE" (String#4528, DoABC#2)
// _SafeStr_8572 = "_-0Xo" (String#4263, DoABC#2)
// _SafeStr_8573 = "_-1Hw" (String#5205, DoABC#2)
// _SafeStr_8574 = "_-09a" (String#14430, DoABC#2)
// MarketplaceModel = "_-0DN" (String#14585, DoABC#2)
// MarketplaceModel = "_-3Fc" (String#22102, DoABC#2)
// MarketplaceModel = "_-1Ap" (String#16895, DoABC#2)
// MarketplaceModel = "_-sH" (String#24372, DoABC#2)
// MarketplaceModel = "_-11Q" (String#16513, DoABC#2)
// MarketplaceView = "_-0GY" (String#14701, DoABC#2)
// MarketplaceView = "_-0F1" (String#14646, DoABC#2)
// MarketplaceView = "_-eW" (String#23823, DoABC#2)
// _SafeStr_8583 = "try" (String#10537, DoABC#2)
// MarketplaceView = "_-3Fu" (String#22112, DoABC#2)
// MarketplaceModel = "_-1q8" (String#18550, DoABC#2)
// MarketplaceView = "_-0TT" (String#15190, DoABC#2)
// onNotEnoughCredits = "_-0xN" (String#4799, DoABC#2)


