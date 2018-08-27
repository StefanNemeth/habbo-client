
package com.sulake.core.window.components
{
    import com.sulake.core.window.enum.WindowType;
    import com.sulake.core.window.WindowContext;
    import flash.geom.Rectangle;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.window.WindowController;
    import com.sulake.core.window.enum.WindowStyle;
    import com.sulake.core.window.enum.WindowParam;

    public class ItemGridController extends ItemListController implements IItemGridWindow 
    {

        public function ItemGridController(_arg_1:String, _arg_2:uint, _arg_3:uint, _arg_4:uint, _arg_5:WindowContext, _arg_6:Rectangle, _arg_7:IWindow, _arg_8:Function=null, _arg_9:Array=null, _arg_10:Array=null, _arg_11:uint=0)
        {
            super(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5, _arg_6, _arg_7, _arg_8, _arg_9, _arg_10, _arg_11);
            _horizontal = !((_arg_2 == WindowType._SafeStr_7522));
            _scaleToFitItems = true;
            if (!_horizontal){
                throw (new Error("Horizontal item grid not yet implemented!"));
            };
        }
        override public function set spacing(_arg_1:int):void
        {
            var _local_2:uint = numListItems;
            while (_local_2-- > 0) {
                IItemListWindow(getListItemAt(_local_2)).spacing = _arg_1;
            };
            super.spacing = _arg_1;
        }
        override public function set background(_arg_1:Boolean):void
        {
            super.background = _arg_1;
            var _local_2:uint;
            while (_local_2 < numListItems) {
                getListItemAt(_local_2).background = _arg_1;
                _local_2++;
            };
        }
        override public function set color(_arg_1:uint):void
        {
            super.color = _arg_1;
            var _local_2:uint;
            while (_local_2 < numListItems) {
                getListItemAt(_local_2).color = _arg_1;
                _local_2++;
            };
        }
        override public function set autoArrangeItems(_arg_1:Boolean):void
        {
            super.autoArrangeItems = _arg_1;
            var _local_2:int;
            while (_local_2 < this.numColumns) {
                IItemListWindow(getListItemAt(_local_2)).autoArrangeItems = _arg_1;
                _local_2++;
            };
        }
        override public function get scrollStepH():Number
        {
            if (_scrollStepH >= 0){
                return (_scrollStepH);
            };
            return (((_horizontal) ? (0.1 * scrollableRegion.height) : (scrollableRegion.width / this.numColumns)));
        }
        override public function get scrollStepV():Number
        {
            if (_scrollStepV >= 0){
                return (_scrollStepV);
            };
            return (((_horizontal) ? (scrollableRegion.height / this.numRows) : (0.1 * scrollableRegion.width)));
        }
        override public function update(_arg_1:WindowController, _arg_2:WindowEvent):Boolean
        {
            var _local_3:Boolean = super.update(_arg_1, _arg_2);
            switch (_arg_2.type){
                case WindowEvent.WE_RESIZED:
                    this.rebuildGridStructure();
                    break;
                case WindowMouseEvent.WME_WHEEL:
                    if (_horizontal){
                        scrollV = (scrollV - (WindowMouseEvent(_arg_2).delta * 0.01));
                    }
                    else {
                        scrollH = (scrollH - (WindowMouseEvent(_arg_2).delta * 0.01));
                    };
                    _local_3 = true;
                    break;
            };
            return (_local_3);
        }
        public function get numGridItems():uint
        {
            var _local_1:uint = numListItems;
            var _local_2:uint;
            while (_local_1-- > 0) {
                _local_2 = (_local_2 + IItemListWindow(getListItemAt(_local_1)).numListItems);
            };
            return (_local_2);
        }
        public function get numColumns():uint
        {
            return (numListItems);
        }
        public function get numRows():uint
        {
            var _local_1:uint;
            var _local_2:uint = this.numColumns;
            var _local_3:uint;
            while (_local_3 < _local_2) {
                _local_1 = Math.max(_local_1, IItemListWindow(getListItemAt(_local_3)).numListItems);
                _local_3++;
            };
            return (_local_1);
        }
        public function addGridItem(_arg_1:IWindow):IWindow
        {
            var _local_2:IItemListWindow = this.resolveColumnForNextItem(_arg_1);
            return (_arg_1);
        }
        public function addGridItemAt(_arg_1:IWindow, _arg_2:uint):IWindow
        {
            this.offsetGridItemsForwards(_arg_1, Math.min(this.numGridItems, _arg_2));
            return (_arg_1);
        }
        public function getGridItemAt(_arg_1:uint):IWindow
        {
            var _local_2:IItemListWindow = this.resolveColumnByIndex(_arg_1);
            if (_local_2 == null){
                return (null);
            };
            return (_local_2.getListItemAt((_arg_1 / this.numColumns)));
        }
        public function getGridItemByID(_arg_1:uint):IWindow
        {
            var _local_3:IItemListWindow;
            var _local_4:IWindow;
            var _local_5:uint;
            var _local_2:uint = this.numColumns;
            _local_5 = 0;
            while (_local_5 < _local_2) {
                _local_3 = (getChildAt(_local_5) as IItemListWindow);
                _local_4 = _local_3.getListItemByID(_arg_1);
                if (_local_4){
                    return (_local_4);
                };
                _local_5++;
            };
            return (null);
        }
        public function getGridItemByName(_arg_1:String):IWindow
        {
            var _local_3:IItemListWindow;
            var _local_4:IWindow;
            var _local_5:uint;
            var _local_2:uint = this.numColumns;
            _local_5 = 0;
            while (_local_5 < _local_2) {
                _local_3 = (getChildAt(_local_5) as IItemListWindow);
                _local_4 = _local_3.getListItemByName(_arg_1);
                if (_local_4){
                    return (_local_4);
                };
                _local_5++;
            };
            return (null);
        }
        public function getGridItemByTag(_arg_1:String):IWindow
        {
            var _local_3:IItemListWindow;
            var _local_4:IWindow;
            var _local_5:uint;
            var _local_2:uint = this.numColumns;
            _local_5 = 0;
            while (_local_5 < _local_2) {
                _local_3 = (getChildAt(_local_5) as IItemListWindow);
                _local_4 = _local_3.getListItemByTag(_arg_1);
                if (_local_4){
                    return (_local_4);
                };
                _local_5++;
            };
            return (null);
        }
        public function getGridItemIndex(_arg_1:IWindow):int
        {
            var _local_2:IItemListWindow = this.resolveColumnByItem(_arg_1);
            if (_local_2 == null){
                return (-1);
            };
            return (((_local_2.getListItemIndex(_arg_1) * this.numColumns) + this.getColumnIndex(_local_2)));
        }
        public function removeGridItem(_arg_1:IWindow):IWindow
        {
            var _local_2:int = this.getGridItemIndex(_arg_1);
            if (_local_2 == -1){
                return (null);
            };
            if (this.offsetGridItemsBackwards(_local_2) != _arg_1){
                throw (new Error("Item grid is out of order!"));
            };
            var _local_3:IItemListWindow = this.resolveColumnByIndex(_local_2);
            if (!_horizontal){
                _local_3.width = _local_3.scrollableRegion.width;
            }
            else {
                _local_3.height = _local_3.scrollableRegion.height;
            };
            return (_arg_1);
        }
        public function removeGridItemAt(_arg_1:int):IWindow
        {
            return (this.removeGridItem(this.getGridItemAt(_arg_1)));
        }
        public function setGridItemIndex(_arg_1:IWindow, _arg_2:int):void
        {
            if (this.removeGridItem(_arg_1) == null){
                throw (new Error("Item not found in grid!"));
            };
            addListItemAt(_arg_1, _arg_2);
        }
        public function swapGridItems(_arg_1:IWindow, _arg_2:IWindow):void
        {
            throw (new Error("ItemGridWindow / Unimplemented method!"));
        }
        public function swapGridItemsAt(_arg_1:int, _arg_2:int):void
        {
            this.swapGridItems(this.getGridItemAt(_arg_1), this.getGridItemAt(_arg_2));
        }
        public function removeGridItems():void
        {
            var _local_2:IItemListWindow;
            var _local_1:uint = this.numColumns;
            var _local_3:uint;
            while (_local_3 < _local_1) {
                _local_2 = IItemListWindow(getListItemAt(_local_3));
                _local_2.removeListItems();
                if (!_horizontal){
                    _local_2.width = 0;
                }
                else {
                    _local_2.height = 0;
                };
                _local_3++;
            };
        }
        public function destroyGridItems():void
        {
            var _local_2:IItemListWindow;
            var _local_1:uint = this.numColumns;
            var _local_3:uint;
            while (_local_3 < _local_1) {
                _local_2 = IItemListWindow(getListItemAt(_local_3));
                _local_2.destroyListItems();
                if (!_horizontal){
                    _local_2.width = 0;
                }
                else {
                    _local_2.height = 0;
                };
                _local_3++;
            };
        }
        protected function listEventProc(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
        }
        protected function listItemEventHandler(_arg_1:WindowEvent):void
        {
            var _local_2:IWindow;
            if (_arg_1.type == WindowEvent.WE_DESTROYED){
                _local_2 = (_arg_1.target as IWindow);
                this.removeGridItem(_local_2);
            };
        }
        protected function getColumnIndex(_arg_1:IItemListWindow):int
        {
            return (getListItemIndex(_arg_1));
        }
        protected function resolveColumnByIndex(_arg_1:uint):IItemListWindow
        {
            return ((getListItemAt((_arg_1 % this.numColumns)) as IItemListWindow));
        }
        public function getColumnNumberByItemIndex(_arg_1:uint):uint
        {
            return ((_arg_1 % this.numColumns));
        }
        public function getRowNumberByItemIndex(_arg_1:uint):uint
        {
            return ((_arg_1 / this.numColumns));
        }
        protected function resolveColumnByItem(_arg_1:IWindow):IItemListWindow
        {
            var _local_3:IItemListWindow;
            var _local_2:uint = this.numColumns;
            while (_local_2-- > 0) {
                _local_3 = IItemListWindow(getListItemAt(_local_2));
                if (_local_3.getListItemIndex(_arg_1) > -1){
                    return (_local_3);
                };
            };
            return (null);
        }
        protected function resolveColumnForNextItem(_arg_1:IWindow):IItemListWindow
        {
            var _local_3:IItemListWindow;
            var _local_4:IItemListWindow;
            var _local_5:int;
            var _local_6:Boolean;
            if (this.numColumns == 0){
                return (this.addColumnForItem(_arg_1));
            };
            var _local_2:uint = this.numGridItems;
            if (_local_2 > 0){
                _local_4 = this.resolveColumnByIndex((((_local_2 > 0)) ? (_local_2 - 1) : 0));
                _local_5 = getListItemIndex(_local_4);
                _local_6 = (((_local_5 > -1)) ? (_local_5 == (this.numColumns - 1)) : true);
                if (_local_6){
                    if (_local_4.numListItems == 1){
                        if ((_local_4.rectangle.right + _arg_1.width) <= _rectangle.width){
                            return (this.addColumnForItem(_arg_1));
                        };
                    };
                };
                _local_3 = (getListItemAt(((_local_6) ? 0 : (_local_5 + 1))) as IItemListWindow);
            }
            else {
                _local_3 = (getListItemAt(0) as IItemListWindow);
            };
            _local_3.addListItem(_arg_1);
            if (_arg_1.width > _local_3.width){
                _local_3.width = _arg_1.width;
            };
            if (_arg_1.rectangle.bottom > _local_3.height){
                _local_3.height = _arg_1.rectangle.bottom;
            };
            return (_local_3);
        }
        protected function addColumnForItem(_arg_1:IWindow):IItemListWindow
        {
            var _local_2:IItemListWindow = (_context.create(((_name + "_COLUMN_") + numListItems), null, WindowType._SafeStr_7520, WindowStyle._SafeStr_9310, (WindowParam._SafeStr_7443 | WindowParam._SafeStr_7433), new Rectangle(0, 0, Math.max(_arg_1.width, 0), Math.max(_arg_1.height, 0)), this.listEventProc, null, numListItems, null, [WindowController.TAG_INTERNAL, WindowController.TAG_EXCLUDE]) as IItemListWindow);
            _local_2.background = background;
            _local_2.color = color;
            _local_2.spacing = _spacing;
            addListItem(_local_2);
            _local_2.addListItem(_arg_1);
            return (_local_2);
        }
        protected function removeColumnAt(_arg_1:uint):void
        {
            var _local_2:IItemListWindow = (removeChildAt(_arg_1) as IItemListWindow);
            if (_local_2){
                _local_2.dispose();
            };
        }
        protected function offsetGridItemsForwards(_arg_1:IWindow, _arg_2:uint):void
        {
            var _local_5:IItemListWindow;
            var _local_7:IWindow;
            var _local_8:uint;
            var _local_3:uint = this.numGridItems;
            var _local_4:int = (_local_3 - 1);
            var _local_6:uint = this.numColumns;
            var _local_9:int;
            while (_local_9 < _local_6) {
                IItemListWindow(getListItemAt(_local_9)).autoArrangeItems = false;
                _local_9++;
            };
            if (_local_3 <= _arg_2){
                this.resolveColumnForNextItem(_arg_1);
            }
            else {
                if (this.numRows == 1){
                    _local_7 = this.getGridItemAt(_local_4);
                    _local_5 = this.resolveColumnForNextItem(_local_7);
                    _local_4--;
                };
                while (_local_4 >= _arg_2) {
                    _local_7 = this.getGridItemAt(_local_4);
                    _local_8 = this.getRowNumberByItemIndex((_local_4 + 1));
                    _local_5 = this.resolveColumnByIndex((_local_4 + 1));
                    _local_5.addListItemAt(_local_7, _local_8);
                    _local_4--;
                };
                this.resolveColumnByIndex(_arg_2).addListItemAt(_arg_1, (_arg_2 / this.numColumns));
            };
            var _local_10:uint;
            _local_9 = 0;
            while (_local_9 < _local_6) {
                _local_5 = IItemListWindow(getListItemAt(_local_9));
                _local_5.autoArrangeItems = true;
                _local_5.height = _local_5.scrollableRegion.height;
                _local_10 = Math.max(_local_10, _local_5.height);
                _local_9++;
            };
            _container.height = _local_10;
        }
        protected function offsetGridItemsBackwards(_arg_1:uint):IWindow
        {
            var _local_7:IWindow;
            var _local_2:uint = this.getRowNumberByItemIndex(_arg_1);
            var _local_3:IItemListWindow = this.resolveColumnByIndex(_arg_1);
            var _local_4:IWindow = _local_3.removeListItemAt(_local_2);
            var _local_5:uint = this.numGridItems;
            var _local_6:uint = _arg_1;
            if (_local_4 == null){
                return (null);
            };
            var _local_8:int;
            while (_local_8 < this.numColumns) {
                IItemListWindow(getListItemAt(_local_8)).autoArrangeItems = false;
                _local_8++;
            };
            while (_local_6 < _local_5) {
                _local_2 = this.getRowNumberByItemIndex(_local_6);
                _local_7 = this.getGridItemAt((_local_6 + 1));
                _local_3 = this.resolveColumnByIndex(_local_6);
                _local_3.addListItemAt(_local_7, _local_2);
                _local_6++;
            };
            var _local_9:uint;
            _local_8 = 0;
            while (_local_8 < this.numColumns) {
                _local_3 = IItemListWindow(getListItemAt(_local_8));
                _local_3.autoArrangeItems = true;
                _local_3.height = _local_3.scrollableRegion.height;
                _local_9 = Math.max(_local_9, _local_3.height);
                _local_8++;
            };
            _container.height = _local_9;
            return (_local_4);
        }
        protected function rebuildGridStructure():void
        {
            var _local_4:IItemListWindow;
            var _local_5:IWindow;
            var _local_6:int;
            var _local_1:int = this.numGridItems;
            var _local_2:Array = new Array();
            var _local_3:int = this.numColumns;
            while (_local_1 > 0) {
                _local_6 = 0;
                while (_local_6 < _local_3) {
                    _local_4 = (getListItemAt(_local_6) as IItemListWindow);
                    _local_5 = _local_4.removeListItemAt(0);
                    _local_2.push(_local_5);
                    if (--_local_1 < 1) break;
                    _local_6++;
                };
            };
            destroyListItems();
            for each (_local_5 in _local_2) {
                this.addGridItem(_local_5);
            };
        }

    }
}//package com.sulake.core.window.components

// WindowEvent = "_-Jh" (String#2085, DoABC#2)
// WindowContext = "_-2K8" (String#6447, DoABC#2)
// WindowType = "_-1yl" (String#6008, DoABC#2)
// WindowStyle = "_-10b" (String#4885, DoABC#2)
// IItemGridWindow = "_-265" (String#1809, DoABC#2)
// ItemListController = "_-06j" (String#3696, DoABC#2)
// ItemGridController = "_-1hV" (String#5697, DoABC#2)
// addListItemAt = "_-2CT" (String#6293, DoABC#2)
// WE_RESIZED = "_-76" (String#22505, DoABC#2)
// scrollableRegion = "_-2ku" (String#6976, DoABC#2)
// removeGridItems = "_-1Bp" (String#5106, DoABC#2)
// removeGridItemAt = "_-Rm" (String#8243, DoABC#2)
// addGridItem = "_-2vh" (String#7192, DoABC#2)
// destroyListItems = "_-0xF" (String#4796, DoABC#2)
// removeListItems = "_-aG" (String#8425, DoABC#2)
// getListItemIndex = "_-6Q" (String#7792, DoABC#2)
// getGridItemAt = "_-B9" (String#7890, DoABC#2)
// removeListItemAt = "_-Td" (String#8279, DoABC#2)
// _SafeStr_7433 = "_-222" (String#19092, DoABC#2)
// _SafeStr_7443 = "_-0YX" (String#15382, DoABC#2)
// _SafeStr_7520 = "_-0pO" (String#16030, DoABC#2)
// _SafeStr_7522 = "_-2m1" (String#20919, DoABC#2)
// addGridItemAt = "_-1Xz" (String#5519, DoABC#2)
// removeGridItem = "_-3CS" (String#7563, DoABC#2)
// scrollStepH = "_-1Qu" (String#5371, DoABC#2)
// scrollStepV = "_-2Ee" (String#6333, DoABC#2)
// _rectangle = "_-0-q" (String#3560, DoABC#2)
// numColumns = "_-1mX" (String#5789, DoABC#2)
// numRows = "_-2Oy" (String#6542, DoABC#2)
// getGridItemByID = "_-2XX" (String#6712, DoABC#2)
// getGridItemByName = "_-2o" (String#7040, DoABC#2)
// getGridItemByTag = "_-Tt" (String#8282, DoABC#2)
// setGridItemIndex = "_-0VT" (String#4214, DoABC#2)
// swapGridItems = "_-0ny" (String#4590, DoABC#2)
// swapGridItemsAt = "_-Ih" (String#8056, DoABC#2)
// _scrollStepH = "_-1Xl" (String#17806, DoABC#2)
// _scrollStepV = "_-3BL" (String#21937, DoABC#2)
// _scaleToFitItems = "_-1LF" (String#17324, DoABC#2)
// _SafeStr_9310 = "_-2-h" (String#19000, DoABC#2)
// getListItemByID = "_-29k" (String#6245, DoABC#2)
// getListItemByTag = "_-Ml" (String#8136, DoABC#2)
// WME_WHEEL = "_-1Ot" (String#17464, DoABC#2)
// rebuildGridStructure = "_-2Vu" (String#20277, DoABC#2)
// resolveColumnForNextItem = "_-0Hw" (String#14755, DoABC#2)
// offsetGridItemsForwards = "_-2db" (String#20587, DoABC#2)
// resolveColumnByIndex = "_-sR" (String#24378, DoABC#2)
// resolveColumnByItem = "_-2ta" (String#21224, DoABC#2)
// getColumnIndex = "_-21x" (String#19087, DoABC#2)
// offsetGridItemsBackwards = "_-2X7" (String#20328, DoABC#2)
// listEventProc = "_-0iB" (String#15757, DoABC#2)
// listItemEventHandler = "_-16M" (String#16712, DoABC#2)
// WE_DESTROYED = "_-2PT" (String#20021, DoABC#2)
// getColumnNumberByItemIndex = "_-NH" (String#23135, DoABC#2)
// getRowNumberByItemIndex = "_-23r" (String#19171, DoABC#2)
// addColumnForItem = "_-1ZH" (String#17864, DoABC#2)
// removeColumnAt = "_-5J" (String#22434, DoABC#2)


