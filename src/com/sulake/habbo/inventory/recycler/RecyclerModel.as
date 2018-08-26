
package com.sulake.habbo.inventory.recycler
{
    import com.sulake.habbo.inventory.IInventoryModel;
    import com.sulake.habbo.inventory.HabboInventory;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.habbo.room.IRoomEngine;
    import com.sulake.habbo.communication.IHabboCommunicationManager;
    import com.sulake.habbo.localization.IHabboLocalizationManager;
    import com.sulake.core.utils.Map;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.habbo.inventory.items.IItem;
    import com.sulake.habbo.inventory.furni.FurniModel;
    import com.sulake.core.window.IWindowContainer;

    public class RecyclerModel implements IInventoryModel 
    {

        public static const _SafeStr_5891:uint = 0;
        public static const STATE_ACTIVE:uint = 1;

        private var _inventory:HabboInventory;
        private var _assetLibrary:IAssetLibrary;
        private var _roomEngine:IRoomEngine;
        private var _communication:IHabboCommunicationManager;
        private var _localization:IHabboLocalizationManager;
        private var _disposed:Boolean = false;
        private var _running:Boolean = false;
        private var _state:uint = 0;
        private var _itemList:Map;

        public function RecyclerModel(_arg_1:HabboInventory, _arg_2:IHabboWindowManager, _arg_3:IHabboCommunicationManager, _arg_4:IAssetLibrary, _arg_5:IRoomEngine, _arg_6:IHabboLocalizationManager)
        {
            this._inventory = _arg_1;
            this._communication = _arg_3;
            this._assetLibrary = _arg_4;
            this._roomEngine = _arg_5;
            this._localization = _arg_6;
        }
        public function get running():Boolean
        {
            return ((this._state == STATE_ACTIVE));
        }
        public function get state():uint
        {
            return (this._state);
        }
        public function get disposed():Boolean
        {
            return (this._disposed);
        }
        public function set state(_arg_1:uint):void
        {
            this._state = _arg_1;
        }
        public function dispose():void
        {
            if (!this._disposed){
                this._inventory = null;
                this._communication = null;
                this._assetLibrary = null;
                this._roomEngine = null;
                this._localization = null;
                this._disposed = true;
            };
            this.RecyclerModel();
        }
        public function RecyclerModel():void
        {
            if ((((this._inventory == null)) || ((this._inventory.furniModel == null)))){
                return;
            };
            this._state = STATE_ACTIVE;
            this._itemList = new Map();
            this._inventory.furniModel.showRecyclable(true);
        }
        public function RecyclerModel():void
        {
            var _local_2:int;
            if ((((((this._itemList == null)) || ((this._inventory == null)))) || ((this._inventory.furniModel == null)))){
                return;
            };
            this._state = _SafeStr_5891;
            this._inventory.furniModel.showRecyclable(false);
            var _local_1:int;
            while (_local_1 < this._itemList.length) {
                _local_2 = this._itemList.getKey(_local_1);
                this._inventory.furniModel.GroupItem(_local_2);
                _local_1++;
            };
            this._itemList = null;
        }
        public function lockSelectedFurni():int
        {
            if ((((((this._itemList == null)) || ((this._inventory == null)))) || ((this._inventory.furniModel == null)))){
                return (0);
            };
            var _local_1:IItem = this._inventory.furniModel.HabboInventory();
            if (_local_1 == null){
                return (0);
            };
            if (this._itemList.getValue(_local_1.id) == null){
                this._itemList.add(_local_1.id, _local_1);
            };
            return (_local_1.id);
        }
        public function releaseFurni(_arg_1:int):Boolean
        {
            if (this._itemList == null){
                return (true);
            };
            var _local_2:IItem = this._itemList.getValue(_arg_1);
            if (_local_2 == null){
                return (false);
            };
            var _local_3:FurniModel = this._inventory.furniModel;
            if (_local_3 == null){
                return (false);
            };
            _local_3.GroupItem(_arg_1);
            this._itemList.remove(_arg_1);
            return (true);
        }
        public function getOwnItemsInRecycler():Array
        {
            var _local_1:Array = new Array();
            if (this._itemList == null){
                return ([]);
            };
            var _local_2:int;
            while (_local_2 < this._itemList.length) {
                _local_1.push(this._itemList.getKey(_local_2));
                _local_2++;
            };
            return (_local_1);
        }
        public function TradingModel():void
        {
        }
        public function TradingModel(_arg_1:int=0):void
        {
        }
        public function categorySwitch(_arg_1:String):void
        {
        }
        public function TradingModel(_arg_1:String):void
        {
        }
        public function TradingModel():IWindowContainer
        {
            return (null);
        }

    }
}//package com.sulake.habbo.inventory.recycler

// IItem = "_-1-k" (String#4863, DoABC#2)
// IInventoryModel = "_-Fh" (String#7987, DoABC#2)
// FurniModel = "_-1ur" (String#5936, DoABC#2)
// RecyclerModel = "_-25-" (String#6140, DoABC#2)
// TradingModel = "_-v8" (String#313, DoABC#2)
// _inventory = "_-1O" (String#113, DoABC#2)
// _SafeStr_5891 = "_-1Ny" (String#852, DoABC#2)
// _running = "_-00c" (String#353, DoABC#2)
// _itemList = "_-Tp" (String#310, DoABC#2)
// RecyclerModel = "_-0jK" (String#15803, DoABC#2)
// RecyclerModel = "_-1Am" (String#16893, DoABC#2)
// furniModel = "_-Sp" (String#23358, DoABC#2)
// showRecyclable = "_-38g" (String#21829, DoABC#2)
// GroupItem = "_-2FC" (String#19612, DoABC#2)
// lockSelectedFurni = "_-32j" (String#21607, DoABC#2)
// HabboInventory = "_-2P" (String#6543, DoABC#2)
// releaseFurni = "_-Vk" (String#23482, DoABC#2)
// getOwnItemsInRecycler = "_-cW" (String#23733, DoABC#2)
// TradingModel = "_-0Lx" (String#4000, DoABC#2)
// TradingModel = "_-2eX" (String#6842, DoABC#2)
// categorySwitch = "_-3Ad" (String#7526, DoABC#2)
// TradingModel = "_-1Gu" (String#5187, DoABC#2)
// IHabboCommunicationManager = "_-0ls" (String#4545, DoABC#2)


