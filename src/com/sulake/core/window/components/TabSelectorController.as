
package com.sulake.core.window.components
{
    import com.sulake.core.window.WindowContext;
    import flash.geom.Rectangle;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.WindowController;
    import com.sulake.core.window.utils.PropertyDefaults;
    import com.sulake.core.window.utils.PropertyStruct;

    public class TabSelectorController extends SelectorController implements ITabSelectorWindow 
    {

        protected var _spacing:int = 0;
        private var _SafeStr_9420:Boolean = false;

        public function TabSelectorController(_arg_1:String, _arg_2:uint, _arg_3:uint, _arg_4:uint, _arg_5:WindowContext, _arg_6:Rectangle, _arg_7:IWindow, _arg_8:Function=null, _arg_9:Array=null, _arg_10:Array=null, _arg_11:uint=0)
        {
            super(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5, _arg_6, _arg_7, _arg_8, _arg_9, _arg_10, _arg_11);
            _SafeStr_9419 = false;
        }
        public function get spacing():int
        {
            return (this._spacing);
        }
        public function set spacing(_arg_1:int):void
        {
            this._spacing = _arg_1;
            this.updateSelectableRegion();
        }
        override public function update(_arg_1:WindowController, _arg_2:WindowEvent):Boolean
        {
            if (_arg_2.type == WindowEvent.WE_CHILD_ADDED){
                this.updateSelectableRegion();
            }
            else {
                if (_arg_2.type == WindowEvent.WE_CHILD_RESIZED){
                    this.updateSelectableRegion();
                }
                else {
                    if (_arg_2.type == WindowEvent.WE_CHILD_RELOCATED){
                        this.updateSelectableRegion();
                    };
                };
            };
            return (super.update(_arg_1, _arg_2));
        }
        private function updateSelectableRegion():void
        {
            var _local_2:IWindow;
            var _local_4:uint;
            if (this._SafeStr_9420){
                return;
            };
            this._SafeStr_9420 = true;
            var _local_1:uint = numSelectables;
            var _local_3:int;
            _local_4 = 0;
            while (_local_4 < _local_1) {
                _local_2 = getSelectableAt(_local_4);
                _local_2.x = _local_3;
                _local_3 = (_local_3 + (_local_2.width + this._spacing));
                _local_4++;
            };
            this._SafeStr_9420 = false;
        }
        override public function get properties():Array
        {
            var _local_1:Array = super.properties;
            if (this._spacing != PropertyDefaults._SafeStr_9336){
                _local_1.push(new PropertyStruct(PropertyDefaults._SafeStr_9337, this._spacing, PropertyStruct._SafeStr_8992, true));
            }
            else {
                _local_1.push(PropertyDefaults._SafeStr_9338);
            };
            return (_local_1);
        }
        override public function set properties(_arg_1:Array):void
        {
            var _local_2:PropertyStruct;
            for each (_local_2 in _arg_1) {
                switch (_local_2.key){
                    case PropertyDefaults._SafeStr_9337:
                        if (_local_2.value != this._spacing){
                            this.spacing = (_local_2.value as int);
                        };
                        break;
                };
            };
            super.properties = _arg_1;
        }

    }
}//package com.sulake.core.window.components

// WindowEvent = "_-Jh" (String#2085, DoABC#2)
// WindowContext = "_-2K8" (String#6447, DoABC#2)
// PropertyStruct = "_-t6" (String#24410, DoABC#2)
// PropertyDefaults = "_-3Dd" (String#22019, DoABC#2)
// SelectorController = "_-0GX" (String#3886, DoABC#2)
// TabSelectorController = "_-3K5" (String#7706, DoABC#2)
// _SafeStr_8992 = "_-5d" (String#22447, DoABC#2)
// numSelectables = "_-1pQ" (String#5845, DoABC#2)
// getSelectableAt = "_-2Vc" (String#6675, DoABC#2)
// WE_CHILD_RESIZED = "_-i1" (String#23965, DoABC#2)
// WE_CHILD_RELOCATED = "_-30I" (String#21512, DoABC#2)
// _SafeStr_9336 = "_-1IE" (String#17202, DoABC#2)
// _SafeStr_9337 = "_-2tT" (String#21220, DoABC#2)
// _SafeStr_9338 = "_-9p" (String#22611, DoABC#2)
// _SafeStr_9419 = "_-2b5" (String#20491, DoABC#2)
// _SafeStr_9420 = "_-0V3" (String#4207, DoABC#2)
// updateSelectableRegion = "_-2O5" (String#19968, DoABC#2)
// WE_CHILD_ADDED = "_-32L" (String#21593, DoABC#2)


