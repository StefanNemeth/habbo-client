
package com.sulake.core.window.utils
{
    import flash.utils.Proxy;
    import com.sulake.core.window.WindowController;
    import com.sulake.core.window.components.ITabContextWindow;
    import com.sulake.core.window.components.IItemGridWindow;
    import com.sulake.core.window.components.IItemListWindow;
    import com.sulake.core.window.components.ISelectorWindow;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.components.ITabButtonWindow;
    import com.sulake.core.window.components.ISelectableWindow;
    import com.sulake.core.window.IWindow;
    import flash.utils.flash_proxy; 
    use namespace flash.utils.flash_proxy;

    public class Iterator extends Proxy implements IIterator 
    {

        private static const _SafeStr_9762:uint = 0;
        private static const _SafeStr_9763:uint = 1;
        private static const _SafeStr_9764:uint = 2;
        private static const _SafeStr_9765:uint = 3;
        private static const _SafeStr_9766:uint = 4;
        private static const _SafeStr_9767:uint = 5;

        private var _SafeStr_9768:WindowController;
        private var _type:uint;

        public function Iterator(_arg_1:WindowController)
        {
            this._SafeStr_9768 = _arg_1;
            if ((this._SafeStr_9768 is ITabContextWindow)){
                this._type = Iterator._SafeStr_9767;
            }
            else {
                if ((this._SafeStr_9768 is IItemGridWindow)){
                    this._type = Iterator._SafeStr_9766;
                }
                else {
                    if ((this._SafeStr_9768 is IItemListWindow)){
                        this._type = Iterator._SafeStr_9765;
                    }
                    else {
                        if ((this._SafeStr_9768 is ISelectorWindow)){
                            this._type = Iterator._SafeStr_9764;
                        }
                        else {
                            if ((this._SafeStr_9768 is IWindowContainer)){
                                this._type = Iterator._SafeStr_9763;
                            }
                            else {
                                this._type = Iterator._SafeStr_9762;
                            };
                        };
                    };
                };
            };
        }
        public function get length():uint
        {
            switch (this._type){
                case Iterator._SafeStr_9767:
                    return (ITabContextWindow(this._SafeStr_9768).numTabItems);
                case Iterator._SafeStr_9764:
                    return (ISelectorWindow(this._SafeStr_9768).numSelectables);
                case Iterator._SafeStr_9765:
                    return (IItemListWindow(this._SafeStr_9768).numListItems);
                case Iterator._SafeStr_9766:
                    return (IItemGridWindow(this._SafeStr_9768).numGridItems);
                case Iterator._SafeStr_9763:
                    return (IWindowContainer(this._SafeStr_9768).numChildren);
            };
            return (0);
        }
        public function indexOf(_arg_1:*):int
        {
            switch (this._type){
                case Iterator._SafeStr_9767:
                    return (ITabContextWindow(this._SafeStr_9768).TabContextController(_arg_1));
                case Iterator._SafeStr_9764:
                    return (ISelectorWindow(this._SafeStr_9768).ISelectorWindow(_arg_1));
                case Iterator._SafeStr_9765:
                    return (IItemListWindow(this._SafeStr_9768).IItemListWindow(_arg_1));
                case Iterator._SafeStr_9766:
                    return (IItemGridWindow(this._SafeStr_9768).getGridItemIndex(_arg_1));
                case Iterator._SafeStr_9763:
                    return (IWindowContainer(this._SafeStr_9768).getChildIndex(_arg_1));
            };
            return (-1);
        }
        override flash_proxy function getProperty(_arg_1:*)
        {
            switch (this._type){
                case Iterator._SafeStr_9767:
                    return (ITabContextWindow(this._SafeStr_9768).TabContextController(uint(_arg_1)));
                case Iterator._SafeStr_9764:
                    return (this._SafeStr_9768.getChildAt(uint(_arg_1)));
                case Iterator._SafeStr_9765:
                    return (IItemListWindow(this._SafeStr_9768).getListItemAt(uint(_arg_1)));
                case Iterator._SafeStr_9766:
                    return (IItemGridWindow(this._SafeStr_9768).IItemGridWindow(uint(_arg_1)));
                case Iterator._SafeStr_9763:
                    return (IWindowContainer(this._SafeStr_9768).getChildAt(uint(_arg_1)));
            };
            return (null);
        }
        override flash_proxy function setProperty(_arg_1:*, _arg_2:*):void
        {
            var _local_3:ITabButtonWindow;
            var _local_4:ITabContextWindow;
            var _local_5:ISelectableWindow;
            var _local_6:ISelectorWindow;
            var _local_7:IItemListWindow;
            var _local_8:IWindow;
            var _local_9:IItemGridWindow;
            var _local_10:IWindow;
            var _local_11:IWindowContainer;
            var _local_12:IWindow;
            switch (this._type){
                case Iterator._SafeStr_9767:
                    _local_3 = (_arg_2 as ITabButtonWindow);
                    _local_4 = (this._SafeStr_9768 as ITabContextWindow);
                    if (_local_4.TabContextController(_local_3) > -1){
                        _local_4.TabContextController(_local_3);
                    };
                    _local_4.TabContextController(_local_3, uint(_arg_1));
                    return;
                case Iterator._SafeStr_9764:
                    _local_5 = (_arg_2 as ISelectableWindow);
                    _local_6 = (this._SafeStr_9768 as ISelectorWindow);
                    if (_local_5){
                        if (_local_6.ISelectorWindow(_local_5) > -1){
                            _local_6.ISelectorWindow(_local_5);
                        };
                        _local_6.ISelectorWindow(_local_5, uint(_arg_1));
                    }
                    else {
                        this._SafeStr_9768.addChildAt(_arg_2, uint(_arg_1));
                    };
                    return;
                case Iterator._SafeStr_9765:
                    _local_7 = (this._SafeStr_9768 as IItemListWindow);
                    _local_8 = (_arg_2 as IWindow);
                    if (_local_7.IItemListWindow(_local_8) > -1){
                        _local_7.removeListItem(_local_8);
                    };
                    _local_7.IItemListWindow(_local_8, uint(_arg_1));
                    return;
                case Iterator._SafeStr_9766:
                    _local_9 = (this._SafeStr_9768 as IItemGridWindow);
                    _local_10 = (_arg_2 as IWindow);
                    if (_local_9.getGridItemIndex(_local_10) > -1){
                        _local_9.IItemGridWindow(_local_10);
                    };
                    _local_9.IItemGridWindow(_local_10, uint(_arg_1));
                    return;
                case Iterator._SafeStr_9763:
                    _local_11 = (this._SafeStr_9768 as IWindowContainer);
                    _local_12 = (_arg_2 as IWindow);
                    if (_local_11.getChildIndex(_local_12) > -1){
                        _local_11.removeChild(_local_12);
                    };
                    _local_11.addChildAt(_local_12, uint(_arg_1));
                    return;
            };
        }
        override flash_proxy function nextNameIndex(_arg_1:int):int
        {
            var _local_2:uint;
            switch (this._type){
                case Iterator._SafeStr_9767:
                    _local_2 = ITabContextWindow(this._SafeStr_9768).numTabItems;
                    break;
                case Iterator._SafeStr_9764:
                    _local_2 = ISelectorWindow(this._SafeStr_9768).numSelectables;
                    break;
                case Iterator._SafeStr_9765:
                    _local_2 = IItemListWindow(this._SafeStr_9768).numListItems;
                    break;
                case Iterator._SafeStr_9766:
                    _local_2 = IItemGridWindow(this._SafeStr_9768).numGridItems;
                    break;
                case Iterator._SafeStr_9763:
                    _local_2 = IWindowContainer(this._SafeStr_9768).numChildren;
                    break;
            };
            if (_arg_1 < _local_2){
                return ((_arg_1 + 1));
            };
            return (0);
        }
        override flash_proxy function nextValue(_arg_1:int)
        {
            switch (this._type){
                case Iterator._SafeStr_9767:
                    return (ITabContextWindow(this._SafeStr_9768).TabContextController((uint(_arg_1) - 1)));
                case Iterator._SafeStr_9764:
                    return (ISelectorWindow(this._SafeStr_9768).ISelectorWindow((uint(_arg_1) - 1)));
                case Iterator._SafeStr_9765:
                    return (IItemListWindow(this._SafeStr_9768).getListItemAt((uint(_arg_1) - 1)));
                case Iterator._SafeStr_9766:
                    return (IItemGridWindow(this._SafeStr_9768).IItemGridWindow((uint(_arg_1) - 1)));
                case Iterator._SafeStr_9763:
                    return (IWindowContainer(this._SafeStr_9768).getChildAt((uint(_arg_1) - 1)));
            };
            return (null);
        }

    }
}//package com.sulake.core.window.utils

// ISelectableWindow = "_-nA" (String#2188, DoABC#2)
// ITabButtonWindow = "_-1Gf" (String#1649, DoABC#2)
// ISelectorWindow = "_-1aY" (String#1714, DoABC#2)
// IItemGridWindow = "_-265" (String#1809, DoABC#2)
// ITabContextWindow = "_-0L6" (String#1455, DoABC#2)
// IIterator = "_-6K" (String#7788, DoABC#2)
// Iterator = "_-G2" (String#7994, DoABC#2)
// IItemListWindow = "_-2CT" (String#6293, DoABC#2)
// IItemListWindow = "_-6Q" (String#7792, DoABC#2)
// IItemGridWindow = "_-B9" (String#7890, DoABC#2)
// IItemGridWindow = "_-1Xz" (String#5519, DoABC#2)
// IItemGridWindow = "_-3CS" (String#7563, DoABC#2)
// numSelectables = "_-1pQ" (String#5845, DoABC#2)
// ISelectorWindow = "_-0Vv" (String#4227, DoABC#2)
// ISelectorWindow = "_-2Vc" (String#6675, DoABC#2)
// ISelectorWindow = "_-2bS" (String#6782, DoABC#2)
// ISelectorWindow = "_-i9" (String#8555, DoABC#2)
// numTabItems = "_-2Dt" (String#6317, DoABC#2)
// TabContextController = "_-I4" (String#8041, DoABC#2)
// TabContextController = "_-9k" (String#7858, DoABC#2)
// TabContextController = "_-0XL" (String#4256, DoABC#2)
// TabContextController = "_-2kP" (String#6964, DoABC#2)
// _SafeStr_9762 = "_-2GO" (String#19657, DoABC#2)
// _SafeStr_9763 = "_-3Co" (String#21987, DoABC#2)
// _SafeStr_9764 = "_-1UH" (String#17678, DoABC#2)
// _SafeStr_9765 = "_-1F1" (String#17072, DoABC#2)
// _SafeStr_9766 = "_-R6" (String#23287, DoABC#2)
// _SafeStr_9767 = "_-0ck" (String#15543, DoABC#2)
// _SafeStr_9768 = "_-30e" (String#7318, DoABC#2)


