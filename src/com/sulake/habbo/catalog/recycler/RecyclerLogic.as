
package com.sulake.habbo.catalog.recycler
{
    import com.sulake.habbo.catalog.IHabboCatalog;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.habbo.communication.messages.incoming.recycler.RecyclerStatusMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.recycler.RecyclerFinishedMessageEvent;
    import com.sulake.habbo.window.utils.IAlertDialog;
    import com.sulake.core.window.events.WindowEvent;

    public class RecyclerLogic implements IRecycler 
    {

        public static const _SafeStr_10336:int = 5;
        private static const _SafeStr_10337:int = 0;
        private static const _SafeStr_10338:int = 1;
        private static const _SafeStr_10339:int = 2;

        private var _SafeStr_10340:int = 0;
        private var _SafeStr_10341:int;
        private var _SafeStr_10342:Array;
        private var _catalog:IHabboCatalog;
        private var _windowManager:IHabboWindowManager;
        private var _view:IRecyclerVisualization;
        private var _RecyclerLogic:Array;

        public function RecyclerLogic(_arg_1:IHabboCatalog, _arg_2:IHabboWindowManager)
        {
            this._SafeStr_10342 = new Array();
            super();
            this._catalog = _arg_1;
            this._windowManager = _arg_2;
        }
        private function get statusActive():Boolean
        {
            return (!((this._SafeStr_10340 == _SafeStr_10337)));
        }
        private function get systemActive():Boolean
        {
            return (!((this._SafeStr_10341 == RecyclerStatusMessageEvent._SafeStr_8290)));
        }
        private function get ready():Boolean
        {
            return (((this.active) && ((this._SafeStr_10340 == _SafeStr_10338))));
        }
        public function get active():Boolean
        {
            return (((this.statusActive) && (this.systemActive)));
        }
        public function dispose():void
        {
            this._SafeStr_10342 = null;
            this._catalog = null;
        }
        public function init(_arg_1:IRecyclerVisualization=null):void
        {
            this._SafeStr_10340 = _SafeStr_10339;
            this._SafeStr_10342 = new Array(_SafeStr_10336);
            if (_arg_1 == null){
                return;
            };
            this._view = _arg_1;
            this._catalog.getRecyclerStatus();
        }
        public function activate():void
        {
            if (this.systemActive){
                this._SafeStr_10340 = _SafeStr_10338;
            };
        }
        public function cancel():void
        {
            this._catalog.setupInventoryForRecycler(false);
            var _local_1:int;
            while (_local_1 < _SafeStr_10336) {
                this.RecyclerLogic(_local_1);
                _local_1++;
            };
            this._SafeStr_10340 = _SafeStr_10337;
        }
        public function empty():void
        {
            var _local_1:int;
            while (_local_1 < _SafeStr_10336) {
                this.RecyclerLogic(_local_1);
                _local_1++;
            };
            this.RecyclerLogic();
            this.RecyclerLogic();
        }
        public function RecyclerLogic(_arg_1:int, _arg_2:int):void
        {
            this._SafeStr_10341 = _arg_1;
            if (!this.systemActive){
                return;
            };
            switch (this._SafeStr_10341){
                case RecyclerStatusMessageEvent._SafeStr_8289:
                    this._SafeStr_10340 = _SafeStr_10338;
                    if ((((this._view == null)) || (this._view.disposed))){
                        return;
                    };
                    this._view.RecyclerCatalogWidget();
                    this._catalog.setupInventoryForRecycler(true);
                    this.RecyclerLogic();
                    this.RecyclerLogic();
                    this.RecyclerLogic();
                    return;
                case RecyclerStatusMessageEvent._SafeStr_8290:
                    if ((((this._view == null)) || (this._view.disposed))){
                        return;
                    };
                    this._view.RecyclerCatalogWidget();
                    this._catalog.setupInventoryForRecycler(false);
                    return;
                case RecyclerStatusMessageEvent._SafeStr_8291:
                    if ((((this._view == null)) || (this._view.disposed))){
                        return;
                    };
                    this._view.RecyclerCatalogWidget(_arg_2);
                    this._catalog.setupInventoryForRecycler(false);
                    return;
            };
        }
        public function RecyclerLogic(status:int, prizeId:int):void
        {
            if (!this.statusActive){
                return;
            };
            this._SafeStr_10340 = _SafeStr_10338;
            if (!this.systemActive){
                return;
            };
            switch (status){
                case RecyclerFinishedMessageEvent._SafeStr_8287:
                    if (this._view != null){
                        this._view.RecyclerCatalogWidget();
                    };
                    break;
                case RecyclerFinishedMessageEvent._SafeStr_8288:
                    Logger.log("* Recycler finished with FAILURE");
                    this._windowManager.alert("${generic.alert.title}", "${recycler.info.closed}", 0, function (_arg_1:IAlertDialog, _arg_2:WindowEvent):void
                    {
                        _arg_1.dispose();
                    });
                    if (this._view != null){
                        this._view.RecyclerCatalogWidget();
                    };
                    break;
            };
            this._catalog.setupInventoryForRecycler(false);
        }
        public function RecyclerLogic(_arg_1:int):FurniSlotItem
        {
            if (this._SafeStr_10342 == null){
                return (null);
            };
            if (_arg_1 >= this._SafeStr_10342.length){
                return (null);
            };
            return (this._SafeStr_10342[_arg_1]);
        }
        public function RecyclerLogic(slotId:int, id:int, category:int, typeId:int, xxxExtra:String):void
        {
            var oldObjectData:FurniSlotItem;
            var newSlotId:int;
            if (!this.ready){
                return;
            };
            if (this._SafeStr_10342.length > 0){
                oldObjectData = this._SafeStr_10342[0];
                newSlotId = 0;
                while (((!((oldObjectData == null))) && ((newSlotId < _SafeStr_10336)))) {
                    oldObjectData = this._SafeStr_10342[newSlotId];
                    if (oldObjectData != null){
                        newSlotId = (newSlotId + 1);
                    };
                };
                if (oldObjectData == null){
                    slotId = newSlotId;
                }
                else {
                    return;
                };
            };
            var itemId:int = this._catalog.HabboCatalog();
            if (itemId == 0){
                this._windowManager.alert("${generic.alert.title}", "${recycler.alert.non.recyclable}", 0, function (_arg_1:IAlertDialog, _arg_2:WindowEvent):void
                {
                    _arg_1.dispose();
                });
                return;
            };
            this._SafeStr_10342[slotId] = new FurniSlotItem(itemId, category, typeId, xxxExtra);
            this.RecyclerLogic();
            this.RecyclerLogic();
        }
        public function RecyclerLogic(_arg_1:int):void
        {
            if (!this.ready){
                return;
            };
            if (this._SafeStr_10342[_arg_1] == null){
                return;
            };
            if (!this._catalog.HabboInventory(this._SafeStr_10342[_arg_1].id)){
                return;
            };
            this._SafeStr_10342[_arg_1] = null;
            this.RecyclerLogic();
            this.RecyclerLogic();
        }
        public function RecyclerLogic():void
        {
            var _local_3:FurniSlotItem;
            if (!this.RecyclerLogic()){
                return;
            };
            this._SafeStr_10340 = _SafeStr_10339;
            this.RecyclerLogic();
            var _local_1:Array = new Array();
            var _local_2:int;
            while (_local_2 < this._SafeStr_10342.length) {
                _local_3 = this._SafeStr_10342[_local_2];
                if (_local_3 == null){
                    return;
                };
                _local_1.push(_local_3.id);
                _local_2++;
            };
            this._catalog.sendRecycleItems(_local_1);
            this._view.RecyclerCatalogWidget();
        }
        public function RecyclerLogic():Boolean
        {
            if (((!(this.ready)) || (!(this._catalog.privateRoomSessionActive)))){
                return (false);
            };
            if (this.RecyclerLogic()){
                this._windowManager.alert("${generic.alert.title}", "${recycler.alert.trading}", 0, function (_arg_1:IAlertDialog, _arg_2:WindowEvent):void
                {
                    _arg_1.dispose();
                });
                return (false);
            };
            return (this.RecyclerLogic());
        }
        public function RecyclerLogic(_arg_1:Boolean):void
        {
            if (_arg_1 == false){
                this.empty();
                this.RecyclerLogic();
            };
            this.RecyclerLogic();
        }
        private function RecyclerLogic():void
        {
            if (((!(this._catalog.privateRoomSessionActive)) && (this.ready))){
                this._windowManager.alert("${generic.alert.title}", "${recycler.alert.privateroom}", 0, function (_arg_1:IAlertDialog, _arg_2:WindowEvent):void
                {
                    _arg_1.dispose();
                });
            };
        }
        private function RecyclerLogic():void
        {
            if ((((this._view == null)) || (!(this.statusActive)))){
                return;
            };
            this._view.RecyclerCatalogWidget();
        }
        private function RecyclerLogic():void
        {
            if ((((this._view == null)) || (!(this.statusActive)))){
                return;
            };
            this._view.RecyclerCatalogWidget(this.RecyclerLogic());
        }
        private function RecyclerLogic():Boolean
        {
            if (this._SafeStr_10342 == null){
                return (false);
            };
            if (this._SafeStr_10342.length < _SafeStr_10336){
                return (false);
            };
            var _local_1:int;
            while (_local_1 < this._SafeStr_10342.length) {
                if (this._SafeStr_10342[_local_1] == null){
                    return (false);
                };
                _local_1++;
            };
            return (true);
        }
        private function RecyclerLogic():Boolean
        {
            return (this._catalog.tradingActive);
        }
        public function RecyclerLogic(_arg_1:Array):void
        {
            var _local_3:PrizeLevelContainer;
            this._RecyclerLogic = new Array();
            var _local_2:int;
            while (_local_2 < _arg_1.length) {
                _local_3 = new PrizeLevelContainer(_arg_1[_local_2], this._catalog);
                this._RecyclerLogic.push(_local_3);
                _local_2++;
            };
        }
        public function RecyclerLogic():Array
        {
            if (this._RecyclerLogic == null){
                this._catalog.getRecyclerPrizes();
                return (null);
            };
            return (this._RecyclerLogic);
        }

    }
}//package com.sulake.habbo.catalog.recycler

// RecyclerLogic = "_-06m" (String#3697, DoABC#2)
// RecyclerLogic = "_-Wq" (String#8345, DoABC#2)
// RecyclerLogic = "_-1oW" (String#5832, DoABC#2)
// RecyclerLogic = "_-0VV" (String#4216, DoABC#2)
// RecyclerLogic = "_-b0" (String#8440, DoABC#2)
// RecyclerLogic = "_-17e" (String#5030, DoABC#2)
// _SafeStr_10336 = "_-0g8" (String#15677, DoABC#2)
// _SafeStr_10337 = "_-3Lc" (String#22350, DoABC#2)
// _SafeStr_10338 = "_-0Ii" (String#14788, DoABC#2)
// _SafeStr_10339 = "_-1VG" (String#17712, DoABC#2)
// _SafeStr_10340 = "_-2Si" (String#20146, DoABC#2)
// _SafeStr_10341 = "_-1F9" (String#17076, DoABC#2)
// _SafeStr_10342 = "_-lS" (String#24087, DoABC#2)
// statusActive = "_-2dO" (String#20580, DoABC#2)
// getRecyclerStatus = "_-2YN" (String#6734, DoABC#2)
// setupInventoryForRecycler = "_-0uu" (String#4742, DoABC#2)
// RecyclerLogic = "_-JT" (String#22982, DoABC#2)
// RecyclerLogic = "_-YN" (String#23576, DoABC#2)
// RecyclerLogic = "_-0f-" (String#15628, DoABC#2)
// RecyclerCatalogWidget = "_-uS" (String#8772, DoABC#2)
// RecyclerLogic = "_-2e5" (String#20606, DoABC#2)
// RecyclerCatalogWidget = "_-0kj" (String#4516, DoABC#2)
// RecyclerCatalogWidget = "_-3IN" (String#7676, DoABC#2)
// RecyclerLogic = "_-6w" (String#22497, DoABC#2)
// RecyclerCatalogWidget = "_-IF" (String#8044, DoABC#2)
// HabboCatalog = "_-0Vk" (String#4222, DoABC#2)
// HabboInventory = "_-81" (String#2057, DoABC#2)
// sendRecycleItems = "_-3GL" (String#7633, DoABC#2)
// RecyclerCatalogWidget = "_-1kQ" (String#5758, DoABC#2)
// privateRoomSessionActive = "_-2CC" (String#6289, DoABC#2)
// RecyclerLogic = "_-1Ku" (String#17307, DoABC#2)
// RecyclerLogic = "_-2Ia" (String#19750, DoABC#2)
// RecyclerLogic = "_-H3" (String#22892, DoABC#2)
// RecyclerCatalogWidget = "_-0qa" (String#4652, DoABC#2)
// tradingActive = "_-1-4" (String#1595, DoABC#2)
// RecyclerLogic = "_-ZN" (String#23611, DoABC#2)
// getRecyclerPrizes = "_-iN" (String#8565, DoABC#2)
// RecyclerFinishedMessageEvent = "_-Iu" (String#22964, DoABC#2)
// WindowEvent = "_-Jh" (String#2085, DoABC#2)
// IAlertDialog = "_-2LY" (String#6472, DoABC#2)
// IRecycler = "_-0fo" (String#4421, DoABC#2)
// RecyclerStatusMessageEvent = "_-8f" (String#22567, DoABC#2)
// RecyclerLogic = "_-21p" (String#6082, DoABC#2)
// IHabboCatalog = "_-1fJ" (String#5651, DoABC#2)
// IRecyclerVisualization = "_-2gZ" (String#6880, DoABC#2)
// FurniSlotItem = "_-19d" (String#5069, DoABC#2)
// PrizeLevelContainer = "_-0wZ" (String#4783, DoABC#2)
// _SafeStr_8287 = "_-Qo" (String#23277, DoABC#2)
// _SafeStr_8288 = "_-2lB" (String#20889, DoABC#2)
// _SafeStr_8289 = "_-30N" (String#21516, DoABC#2)
// _SafeStr_8290 = "_-0Oe" (String#15014, DoABC#2)
// _SafeStr_8291 = "_-2kW" (String#20866, DoABC#2)
// _RecyclerLogic = "_-1ct" (String#855, DoABC#2)
// RecyclerCatalogWidget = "_-1Dr" (String#5140, DoABC#2)


