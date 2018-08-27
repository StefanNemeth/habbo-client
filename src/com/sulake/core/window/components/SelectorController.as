
package com.sulake.core.window.components
{
    import com.sulake.core.window.utils.IIterable;
    import com.sulake.core.window.WindowContext;
    import flash.geom.Rectangle;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.utils.Iterator;
    import com.sulake.core.window.utils.IIterator;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.WindowController;

    public class SelectorController extends InteractiveController implements ISelectorWindow, IIterable 
    {

        private var _selected:ISelectableWindow;
        protected var _SafeStr_9419:Boolean = true;

        public function SelectorController(_arg_1:String, _arg_2:uint, _arg_3:uint, _arg_4:uint, _arg_5:WindowContext, _arg_6:Rectangle, _arg_7:IWindow, _arg_8:Function=null, _arg_9:Array=null, _arg_10:Array=null, _arg_11:uint=0)
        {
            super(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5, _arg_6, _arg_7, _arg_8, _arg_9, _arg_10, _arg_11);
        }
        public function get iterator():IIterator
        {
            return (new Iterator(this));
        }
        override public function update(_arg_1:WindowController, _arg_2:WindowEvent):Boolean
        {
            if (_arg_2.type == WindowEvent.WE_CHILD_ACTIVATED){
                if ((_arg_1 is ISelectableWindow)){
                    this.setSelected((_arg_1 as ISelectableWindow));
                };
            };
            return (super.update(_arg_1, _arg_2));
        }
        public function get numSelectables():uint
        {
            return (numChildren);
        }
        public function getSelected():ISelectableWindow
        {
            return ((this._selected as ISelectableWindow));
        }
        public function setSelected(_arg_1:ISelectableWindow):void
        {
            if (_arg_1 != null){
                if (_arg_1 != this._selected){
                    if (this._selected != null){
                        this._selected.unselect();
                    };
                    this._selected = _arg_1;
                    this._selected.select();
                    if (getChildIndex(_arg_1) > -1){
                        if (this._SafeStr_9419){
                            if (getChildIndex(_arg_1) != (numChildren - 1)){
                                setChildIndex(_arg_1, (numChildren - 1));
                            };
                        };
                    };
                };
            };
        }
        public function addSelectable(_arg_1:ISelectableWindow):ISelectableWindow
        {
            return (ISelectableWindow(addChild(_arg_1)));
        }
        public function addSelectableAt(_arg_1:ISelectableWindow, _arg_2:int):ISelectableWindow
        {
            return (ISelectableWindow(addChildAt(_arg_1, _arg_2)));
        }
        public function getSelectableAt(_arg_1:int):ISelectableWindow
        {
            return ((getChildAt(_arg_1) as ISelectableWindow));
        }
        public function getSelectableByID(_arg_1:uint):ISelectableWindow
        {
            return ((getChildByID(_arg_1) as ISelectableWindow));
        }
        public function getSelectableByTag(_arg_1:String):ISelectableWindow
        {
            return ((getChildByTag(_arg_1) as ISelectableWindow));
        }
        public function getSelectableByName(_arg_1:String):ISelectableWindow
        {
            return ((getChildByName(_arg_1) as ISelectableWindow));
        }
        public function getSelectableIndex(_arg_1:ISelectableWindow):int
        {
            return (getChildIndex(_arg_1));
        }
        public function removeSelectable(_arg_1:ISelectableWindow):ISelectableWindow
        {
            var _local_2:int = getChildIndex(_arg_1);
            if (_local_2 > -1){
                if (_arg_1 == this._selected){
                    if (this.numSelectables > 1){
                        this.setSelected(this.getSelectableAt((((_local_2 == 0)) ? 1 : 0)));
                    }
                    else {
                        this._selected = null;
                    };
                };
                return (ISelectableWindow(removeChild(_arg_1)));
            };
            return (null);
        }

    }
}//package com.sulake.core.window.components

// WindowEvent = "_-Jh" (String#2085, DoABC#2)
// IIterable = "_-2BO" (String#6275, DoABC#2)
// WindowContext = "_-2K8" (String#6447, DoABC#2)
// ISelectableWindow = "_-nA" (String#2188, DoABC#2)
// ISelectorWindow = "_-1aY" (String#1714, DoABC#2)
// IIterator = "_-6K" (String#7788, DoABC#2)
// InteractiveController = "_-25D" (String#6146, DoABC#2)
// SelectorController = "_-0GX" (String#3886, DoABC#2)
// Iterator = "_-G2" (String#7994, DoABC#2)
// getSelected = "_-88" (String#7825, DoABC#2)
// unselect = "_-2aK" (String#6764, DoABC#2)
// getSelectableByName = "_-0EO" (String#3836, DoABC#2)
// numSelectables = "_-1pQ" (String#5845, DoABC#2)
// addSelectable = "_-1uz" (String#5941, DoABC#2)
// addSelectableAt = "_-0Vv" (String#4227, DoABC#2)
// getSelectableAt = "_-2Vc" (String#6675, DoABC#2)
// getSelectableByID = "_-lI" (String#8633, DoABC#2)
// getSelectableByTag = "_-06i" (String#3695, DoABC#2)
// getSelectableIndex = "_-2bS" (String#6782, DoABC#2)
// removeSelectable = "_-i9" (String#8555, DoABC#2)
// WE_CHILD_ACTIVATED = "_-f-" (String#23845, DoABC#2)
// getChildByID = "_-y3" (String#2226, DoABC#2)
// getChildByTag = "_-tP" (String#2212, DoABC#2)
// _SafeStr_9419 = "_-2b5" (String#20491, DoABC#2)


