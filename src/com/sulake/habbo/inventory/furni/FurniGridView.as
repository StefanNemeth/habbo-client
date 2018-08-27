
package com.sulake.habbo.inventory.furni
{
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.room.IRoomEngine;
    import com.sulake.core.window.components.IItemGridWindow;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.window.events.WindowEvent;

    public class FurniGridView 
    {

        private var _windowManager:IHabboWindowManager;
        private var _assetLibrary:IAssetLibrary;
        private var _view:IWindowContainer;
        private var _SafeStr_4830:FurniModel;
        private var _roomEngine:IRoomEngine;
        private var _category:String;
        private var _grid:IItemGridWindow;
        private var _SafeStr_5001:IWindow;

        public function FurniGridView(_arg_1:FurniModel, _arg_2:String, _arg_3:IHabboWindowManager, _arg_4:IAssetLibrary, _arg_5:IRoomEngine)
        {
            this._SafeStr_4830 = _arg_1;
            this._category = _arg_2;
            this._assetLibrary = _arg_4;
            this._windowManager = _arg_3;
            this._roomEngine = _arg_5;
            var _local_6:XmlAsset = (this._assetLibrary.getAssetByName("inventory_furni_grid_xml") as XmlAsset);
            this._view = (this._windowManager.buildFromXML((_local_6.content as XML)) as IWindowContainer);
            if (this._view != null){
                this._grid = (this._view.findChildByName("item_grid") as IItemGridWindow);
            };
        }
        public function dispose():void
        {
            this._SafeStr_4830 = null;
            this._windowManager = null;
            this._assetLibrary = null;
            this._roomEngine = null;
            this._grid = null;
            this._SafeStr_5001 = null;
            if (this._view){
                this._view.dispose();
                this._view = null;
            };
        }
        public function get window():IWindowContainer
        {
            if (this._view == null){
                return (null);
            };
            if (this._view.disposed){
                return (null);
            };
            return (this._view);
        }
        public function clearGrid():void
        {
            if (this._grid != null){
                this._grid.removeGridItems();
            };
        }
        public function updateItem(_arg_1:int, _arg_2:IWindowContainer):void
        {
            var _local_3:IWindow = this._grid.getGridItemAt(_arg_1);
            if (_local_3){
                _local_3 = _arg_2;
            };
        }
        public function addItemToBottom(_arg_1:IWindowContainer):void
        {
            this._grid.addGridItem(_arg_1);
            _arg_1.procedure = this.itemEventProc;
        }
        public function addItemAt(_arg_1:IWindowContainer, _arg_2:int):void
        {
            this._grid.addGridItemAt(_arg_1, _arg_2);
            _arg_1.procedure = this.itemEventProc;
        }
        public function removeItem(_arg_1:int):IWindow
        {
            return (this._grid.removeGridItemAt(_arg_1));
        }
        public function moveItemTo(_arg_1:IWindowContainer, _arg_2:int):void
        {
            this._grid.removeGridItem(_arg_1);
            this._grid.addGridItemAt(_arg_1, _arg_2);
        }
        public function setLock(_arg_1:Boolean):void
        {
            if (_arg_1){
                this._grid.autoArrangeItems = false;
                this._grid.lock();
            }
            else {
                this._grid.autoArrangeItems = true;
                this._grid.unlock();
            };
        }
        private function itemEventProc(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            var _local_3:Boolean;
            if (_arg_1.type == WindowMouseEvent.WME_UP){
                this._SafeStr_5001 = null;
                this._SafeStr_4830.cancelFurniInMover();
            }
            else {
                if (_arg_1.type == WindowMouseEvent.WME_DOWN){
                    if (_arg_2 == null){
                        return;
                    };
                    this._SafeStr_4830.toggleItemSelection(this._category, this._grid.getGridItemIndex(_arg_1.window));
                    this._SafeStr_5001 = _arg_2;
                }
                else {
                    if ((((((((_arg_1.type == WindowMouseEvent.WME_OUT)) && (!((this._SafeStr_5001 == null))))) && ((this._SafeStr_5001 == _arg_2)))) && (!(this._SafeStr_4830.isTradingOpen)))){
                        _local_3 = this._SafeStr_4830.requestSelectedFurniPlacement(true);
                        if (_local_3){
                            this._SafeStr_5001 = null;
                        };
                    }
                    else {
                        if (_arg_1.type == WindowMouseEvent.WME_UP){
                            this._SafeStr_5001 = null;
                        }
                        else {
                            if (_arg_1.type == WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK){
                                this._SafeStr_5001 = null;
                            }
                            else {
                                if (_arg_1.type == WindowMouseEvent.WME_DOUBLE_CLICK){
                                    this._SafeStr_4830.requestCurrentActionOnSelection();
                                    this._SafeStr_5001 = null;
                                };
                            };
                        };
                    };
                };
            };
        }

    }
}//package com.sulake.habbo.inventory.furni

// WindowEvent = "_-Jh" (String#2085, DoABC#2)
// IItemGridWindow = "_-265" (String#1809, DoABC#2)
// FurniModel = "_-1ur" (String#5936, DoABC#2)
// FurniGridView = "_-z3" (String#8862, DoABC#2)
// WME_OUT = "_-0h2" (String#15712, DoABC#2)
// WME_DOWN = "_-hL" (String#23944, DoABC#2)
// WME_UP = "_-0Cs" (String#14566, DoABC#2)
// _SafeStr_4830 = "_-0XB" (String#112, DoABC#2)
// removeGridItems = "_-1Bp" (String#5106, DoABC#2)
// removeGridItemAt = "_-Rm" (String#8243, DoABC#2)
// addGridItem = "_-2vh" (String#7192, DoABC#2)
// _grid = "_-CU" (String#2073, DoABC#2)
// _SafeStr_5001 = "_-1CR" (String#1632, DoABC#2)
// WME_DOUBLE_CLICK = "_-Y3" (String#23564, DoABC#2)
// getGridItemAt = "_-B9" (String#7890, DoABC#2)
// removeItem = "_-2gu" (String#6888, DoABC#2)
// itemEventProc = "_-2KN" (String#6453, DoABC#2)
// toggleItemSelection = "_-Qk" (String#23275, DoABC#2)
// addItemAt = "_-SJ" (String#23337, DoABC#2)
// addItemToBottom = "_-3AS" (String#21898, DoABC#2)
// cancelFurniInMover = "_-1Xa" (String#17797, DoABC#2)
// requestSelectedFurniPlacement = "_-17E" (String#16744, DoABC#2)
// isTradingOpen = "_-0Yq" (String#15394, DoABC#2)
// requestCurrentActionOnSelection = "_-14j" (String#16642, DoABC#2)
// moveItemTo = "_-3JU" (String#22263, DoABC#2)
// clearGrid = "_-1n7" (String#18429, DoABC#2)
// setLock = "_-2VO" (String#20257, DoABC#2)
// addGridItemAt = "_-1Xz" (String#5519, DoABC#2)
// removeGridItem = "_-3CS" (String#7563, DoABC#2)


