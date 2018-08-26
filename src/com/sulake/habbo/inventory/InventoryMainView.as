
package com.sulake.habbo.inventory
{
    import flash.geom.Point;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.core.window.components.IFrameWindow;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.toolbar.IHabboToolbar;
    import com.sulake.core.assets.IAsset;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.core.window.enum.WindowState;
    import com.sulake.habbo.toolbar.events.HabboToolbarEvent;
    import com.sulake.core.window.IWindow;
    import com.sulake.habbo.utils.WindowToggle;
    import com.sulake.habbo.inventory.enum.InventoryCategory;
    import com.sulake.core.window.components.ITabContextWindow;
    import com.sulake.habbo.toolbar.HabboToolbarIconEnum;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.events.WindowMouseEvent;

    public class InventoryMainView 
    {

        private static const _SafeStr_11641:int = 3;

        private const _SafeStr_4231:Point = new Point(120, 150);

        private var _windowManager:IHabboWindowManager;
        private var _assetLibrary:IAssetLibrary;
        private var _InventoryMainView:IFrameWindow;
        private var _SafeStr_11642:String;
        private var _SafeStr_11643:IWindowContainer;
        private var _SafeStr_11644:String;
        private var _SafeStr_11645:IWindowContainer;
        private var _controller:HabboInventory;
        private var _toolbar:IHabboToolbar;
        private var _SafeStr_11646:IWindowContainer;
        private var _SafeStr_11647:IWindowContainer;

        public function InventoryMainView(_arg_1:HabboInventory, _arg_2:IHabboWindowManager, _arg_3:IAssetLibrary)
        {
            this._controller = _arg_1;
            this._assetLibrary = _arg_3;
            this._windowManager = _arg_2;
            var _local_4:IAsset = this._assetLibrary.getAssetByName("inventory_xml");
            var _local_5:XmlAsset = XmlAsset(_local_4);
            this._InventoryMainView = (this._windowManager.buildFromXML(XML(_local_5.content)) as IFrameWindow);
            if (this._InventoryMainView != null){
                this._InventoryMainView.position = this._SafeStr_4231;
                this._InventoryMainView.visible = false;
                this._InventoryMainView.procedure = this.windowEventProc;
                this.setCreditBalance(0);
                this.setPixelBalance(0);
                this.HabboInventory(0, 0);
            };
        }
        public function get isVisible():Boolean
        {
            return (((this._InventoryMainView) ? this._InventoryMainView.visible : false));
        }
        public function get isActive():Boolean
        {
            return (((this._InventoryMainView) ? this._InventoryMainView.WindowController(WindowState._SafeStr_4586) : false));
        }
        public function dispose():void
        {
            this._SafeStr_11646 = null;
            this._controller = null;
            this._SafeStr_11643 = null;
            this._SafeStr_11645 = null;
            if (this._InventoryMainView){
                this._InventoryMainView.dispose();
                this._InventoryMainView = null;
            };
            if (this._toolbar){
                if (this._toolbar.events){
                    this._toolbar.events.removeEventListener(HabboToolbarEvent.HTE_TOOLBAR_CLICK, this.onHabboToolbarEvent);
                };
                this._toolbar = null;
            };
            this._windowManager = null;
            this._assetLibrary = null;
        }
        public function getWindow():IFrameWindow
        {
            return (this._InventoryMainView);
        }
        public function HabboInventory():String
        {
            return (this._SafeStr_11642);
        }
        public function HabboInventory():String
        {
            return (this._SafeStr_11644);
        }
        public function hideInventory():void
        {
            this._controller.TradingModel();
            var _local_1:IWindow = this.getWindow();
            if (_local_1 == null){
                return;
            };
            _local_1.visible = false;
        }
        public function showInventory():void
        {
            var _local_1:IWindow = this.getWindow();
            if (_local_1 == null){
                return;
            };
            _local_1.visible = true;
            this._controller.HabboInventory(this._SafeStr_11644);
        }
        public function toggleCategoryView(_arg_1:String, _arg_2:Boolean=true, _arg_3:Boolean=false):void
        {
            var _local_4:IWindow = this.getWindow();
            if (_local_4 == null){
                return;
            };
            if (_local_4.visible){
                if (this._SafeStr_11642 == _arg_1){
                    if (_arg_2){
                        if (WindowToggle.WindowToggle(_local_4)){
                            _local_4.activate();
                        }
                        else {
                            this.hideInventory();
                        };
                    };
                }
                else {
                    this.setViewToCategory(_arg_1);
                };
            }
            else {
                if (((((_arg_3) && (!((this._SafeStr_11642 == null))))) && (!((this._SafeStr_11642 == _arg_1))))){
                    this.setViewToCategory(_arg_1);
                    return;
                };
                _local_4.visible = true;
                _local_4.activate();
                if (((!((_arg_1 == this._SafeStr_11642))) || (!(this._controller.HabboInventory(_arg_1))))){
                    this.setViewToCategory(_arg_1);
                };
                this._controller.HabboInventory(_arg_1);
            };
        }
        public function toggleSubCategoryView(_arg_1:String, _arg_2:Boolean=true):void
        {
            var _local_3:IWindow = this.getWindow();
            if (_local_3 == null){
                return;
            };
            if (_local_3.visible){
                if (this._SafeStr_11644 == _arg_1){
                    if (_arg_2){
                        _local_3.visible = false;
                    };
                }
                else {
                    this.setSubViewToCategory(_arg_1);
                };
            }
            else {
                _local_3.visible = true;
                if (_arg_1 != this._SafeStr_11644){
                    this.setSubViewToCategory(_arg_1);
                };
            };
        }
        public function updateSubCategoryView():void
        {
            if (this._SafeStr_11644 == null){
                return;
            };
            this.setSubViewToCategory(this._SafeStr_11644);
        }
        public function setCreditBalance(_arg_1:int):void
        {
            this._windowManager.registerLocalizationParameter("inventory.purse.creditbalance", "balance", String(_arg_1));
        }
        public function setPixelBalance(_arg_1:int):void
        {
            this._windowManager.registerLocalizationParameter("inventory.purse.pixelbalance", "balance", String(_arg_1));
        }
        public function HabboInventory(_arg_1:int, _arg_2:int):void
        {
            this._windowManager.registerLocalizationParameter("inventory.purse.clubdays", "months", String(_arg_1));
            this._windowManager.registerLocalizationParameter("inventory.purse.clubdays", "days", String(_arg_2));
        }
        public function setToolbar(_arg_1:IHabboToolbar):void
        {
            this._toolbar = _arg_1;
            this._toolbar.events.addEventListener(HabboToolbarEvent.HTE_TOOLBAR_CLICK, this.onHabboToolbarEvent);
        }
        private function resetUnseenCounters(_arg_1:String):void
        {
            switch (_arg_1){
                case InventoryCategory._SafeStr_5995:
                    this._controller.furniModel.resetUnseenItems();
                    return;
                case InventoryCategory._SafeStr_5996:
                    this._controller.petsModel.resetUnseenItems();
                    return;
                case InventoryCategory._SafeStr_7061:
                    this._controller.badgesModel.resetUnseenItems();
                    return;
            };
        }
        private function setViewToCategory(_arg_1:String):void
        {
            if (_arg_1 == null){
                return;
            };
            if (_arg_1 == ""){
                return;
            };
            if (_arg_1 != this._SafeStr_11642){
                this.resetUnseenCounters(this._SafeStr_11642);
            };
            this._controller.HabboInventory(_arg_1);
            var _local_2:ITabContextWindow = (this._InventoryMainView.findChildByName("contentArea") as ITabContextWindow);
            if (_local_2 == null){
                return;
            };
            _local_2.container.removeChild(this._SafeStr_11643);
            _local_2.invalidate();
            var _local_3:IWindowContainer = this._controller.HabboInventory(_arg_1);
            if (_local_3 == null){
                return;
            };
            _local_3.visible = true;
            _local_2.container.addChild(_local_3);
            this._SafeStr_11643 = _local_3;
            this._SafeStr_11642 = _arg_1;
            _local_2.selector.setSelected(_local_2.selector.ISelectorWindow(_arg_1));
        }
        private function setSubViewToCategory(_arg_1:String):void
        {
            if ((((_arg_1 == null)) || ((_arg_1 == "")))){
                return;
            };
            this._controller.HabboInventory(_arg_1);
            var _local_2:IWindowContainer = (this._InventoryMainView.findChildByName("subContentArea") as IWindowContainer);
            while (_local_2.numChildren > 0) {
                _local_2.removeChildAt(0);
            };
            var _local_3:IWindowContainer = this._controller.HabboInventory(_arg_1);
            if (_local_3 != null){
                _local_2.visible = true;
                _local_3.visible = true;
                _local_2.height = _local_3.height;
                _local_2.addChild(_local_3);
            }
            else {
                _local_2.visible = false;
                _local_2.height = 0;
            };
            this._InventoryMainView.IFrameWindow();
            if (this._InventoryMainView.parent != null){
                if ((this._InventoryMainView.x + this._InventoryMainView.width) > this._InventoryMainView.parent.width){
                    this._InventoryMainView.x = (this._InventoryMainView.parent.width - this._InventoryMainView.width);
                };
                if ((this._InventoryMainView.y + this._InventoryMainView.height) > this._InventoryMainView.parent.height){
                    this._InventoryMainView.y = (this._InventoryMainView.parent.height - this._InventoryMainView.height);
                };
            };
            this._SafeStr_11645 = _local_3;
            this._SafeStr_11644 = _arg_1;
        }
        private function onHabboToolbarEvent(_arg_1:HabboToolbarEvent):void
        {
            if (_arg_1.iconId != HabboToolbarIconEnum.INVENTORY){
                return;
            };
            if (_arg_1.type == HabboToolbarEvent.HTE_TOOLBAR_CLICK){
                if (this._SafeStr_11642 == InventoryCategory._SafeStr_5996){
                    this.toggleCategoryView(InventoryCategory._SafeStr_5996);
                }
                else {
                    if (this._SafeStr_11642 == InventoryCategory._SafeStr_5995){
                        this.toggleCategoryView(InventoryCategory._SafeStr_5995);
                    }
                    else {
                        if (this._controller != null){
                            this._controller.HabboInventory(InventoryCategory._SafeStr_5995);
                        };
                    };
                };
            };
        }
        public function windowEventProc(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            var _local_3:String;
            if (_arg_1.type == WindowEvent.WE_SELECTED){
                _local_3 = ITabContextWindow(_arg_2).selector.ISelectorWindow().name;
                if (_local_3 != this._SafeStr_11642){
                    this._controller.HabboInventory(_local_3);
                };
            }
            else {
                if (_arg_1.type == WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK){
                    if (_arg_2.name == "header_button_close"){
                        this.hideInventory();
                    };
                };
            };
        }
        public function HabboInventory():void
        {
            this.updateUnseenFurniCount();
            this.updateUnseenBadgeCount();
        }
        private function updateUnseenFurniCount():void
        {
            if (!this._SafeStr_11646){
                this._SafeStr_11646 = this.createCounter("furni");
            };
            var _local_1:int = (this._controller.furniModel.getUnseenItemCount() + this._controller.petsModel.getUnseenItemCount());
            this.updateCounter(this._SafeStr_11646, _local_1);
            this._controller.furniModel.ProgressBar();
            this._controller.petsModel.ProgressBar();
        }
        private function updateUnseenBadgeCount():void
        {
            if (!this._SafeStr_11647){
                this._SafeStr_11647 = this.createCounter("badges");
            };
            var _local_1:int = this._controller.badgesModel.getUnseenItemCount();
            this.updateCounter(this._SafeStr_11647, _local_1);
            this._controller.badgesModel.ProgressBar();
        }
        private function createCounter(_arg_1:String):IWindowContainer
        {
            var _local_2:XmlAsset = (this._assetLibrary.getAssetByName("unseen_items_counter_xml") as XmlAsset);
            var _local_3:IWindowContainer = (this._windowManager.buildFromXML((_local_2.content as XML)) as IWindowContainer);
            var _local_4:IWindowContainer = (this._InventoryMainView.findChildByName(_arg_1) as IWindowContainer);
            if (_local_4){
                _local_4.addChild(_local_3);
                _local_3.x = ((_local_4.width - _local_3.width) - _SafeStr_11641);
                _local_3.y = _SafeStr_11641;
            };
            return (_local_3);
        }
        private function updateCounter(_arg_1:IWindowContainer, _arg_2:int):void
        {
            _arg_1.findChildByName("count").caption = _arg_2.toString();
            _arg_1.visible = (_arg_2 > 0);
        }

    }
}//package com.sulake.habbo.inventory

// setViewToCategory = "_-211" (String#6066, DoABC#2)
// toggleCategoryView = "_-wV" (String#24553, DoABC#2)
// HabboInventory = "_-1yQ" (String#18906, DoABC#2)
// HabboInventory = "_-0VB" (String#15251, DoABC#2)
// badgesModel = "_-mf" (String#24135, DoABC#2)
// HabboInventory = "_-3Jx" (String#22282, DoABC#2)
// _SafeStr_11641 = "_-1xb" (String#5983, DoABC#2)
// _SafeStr_11642 = "_-1ln" (String#18366, DoABC#2)
// _SafeStr_11643 = "_-04q" (String#14234, DoABC#2)
// _SafeStr_11644 = "_-1Wz" (String#17776, DoABC#2)
// _SafeStr_11645 = "_-1Tq" (String#17659, DoABC#2)
// _SafeStr_11646 = "_-0W4" (String#15280, DoABC#2)
// _SafeStr_11647 = "_-1zD" (String#18935, DoABC#2)
// setCreditBalance = "_-2kx" (String#20881, DoABC#2)
// setPixelBalance = "_-38m" (String#21833, DoABC#2)
// HabboInventory = "_-2Yl" (String#20385, DoABC#2)
// hideInventory = "_-2bi" (String#20512, DoABC#2)
// showInventory = "_-0xY" (String#16334, DoABC#2)
// HabboInventory = "_-zv" (String#24680, DoABC#2)
// toggleSubCategoryView = "_-1KC" (String#17281, DoABC#2)
// setSubViewToCategory = "_-1lK" (String#18344, DoABC#2)
// updateSubCategoryView = "_-37w" (String#21802, DoABC#2)
// setToolbar = "_-zP" (String#24669, DoABC#2)
// resetUnseenCounters = "_-181" (String#16777, DoABC#2)
// HabboInventory = "_-SM" (String#23340, DoABC#2)
// updateUnseenFurniCount = "_-0Cd" (String#14554, DoABC#2)
// updateUnseenBadgeCount = "_-1pT" (String#18523, DoABC#2)
// createCounter = "_-24F" (String#19187, DoABC#2)
// updateCounter = "_-21F" (String#19062, DoABC#2)
// WindowEvent = "_-Jh" (String#2085, DoABC#2)
// InventoryCategory = "_-04Y" (String#14224, DoABC#2)
// WindowToggle = "_-1Ud" (String#17689, DoABC#2)
// WindowState = "_-1Kt" (String#5262, DoABC#2)
// ITabContextWindow = "_-0L6" (String#1455, DoABC#2)
// InventoryMainView = "_-kQ" (String#8610, DoABC#2)
// _controller = "_-18D" (String#59, DoABC#2)
// _InventoryMainView = "_-1P" (String#361, DoABC#2)
// WindowToggle = "_-1OQ" (String#17449, DoABC#2)
// isActive = "_-0q4" (String#4638, DoABC#2)
// _SafeStr_4231 = "_-37t" (String#2006, DoABC#2)
// ISelectorWindow = "_-88" (String#7825, DoABC#2)
// WE_SELECTED = "_-17F" (String#16745, DoABC#2)
// WindowController = "_-1nM" (String#5804, DoABC#2)
// _SafeStr_4586 = "_-22X" (String#19111, DoABC#2)
// furniModel = "_-Sp" (String#23358, DoABC#2)
// TradingModel = "_-0Lx" (String#4000, DoABC#2)
// HabboInventory = "_-1MK" (String#5280, DoABC#2)
// _SafeStr_5995 = "_-2qT" (String#21102, DoABC#2)
// _SafeStr_5996 = "_-Jg" (String#22993, DoABC#2)
// _toolbar = "_-1LG" (String#93, DoABC#2)
// ProgressBar = "_-1Js" (String#847, DoABC#2)
// _SafeStr_7061 = "_-3KY" (String#22306, DoABC#2)
// HTE_TOOLBAR_CLICK = "_-22-" (String#19089, DoABC#2)
// onHabboToolbarEvent = "_-0Ve" (String#435, DoABC#2)
// iconId = "_-2di" (String#20590, DoABC#2)
// petsModel = "_-227" (String#19096, DoABC#2)
// isVisible = "_-1rE" (String#18592, DoABC#2)
// HabboInventory = "_-vi" (String#24517, DoABC#2)
// resetUnseenItems = "_-0qm" (String#16077, DoABC#2)
// HabboInventory = "_-p7" (String#24238, DoABC#2)
// getUnseenItemCount = "_-133" (String#16582, DoABC#2)
// HabboInventory = "_-ik" (String#23988, DoABC#2)
// ISelectorWindow = "_-0EO" (String#3836, DoABC#2)
// IHabboToolbar = "_-0Wr" (String#4245, DoABC#2)
// IFrameWindow = "_-09S" (String#3746, DoABC#2)


