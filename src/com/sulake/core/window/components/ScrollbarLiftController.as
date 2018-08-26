
package com.sulake.core.window.components
{
    import com.sulake.core.window.enum.WindowParam;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.WindowContext;
    import flash.geom.Rectangle;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.WindowController;

    public class ScrollbarLiftController extends InteractiveController implements IDragBarWindow 
    {

        protected var _offsetX:Number;
        protected var _originalOffsetY:Number;
        protected var _scrollBar:ScrollbarController;

        public function ScrollbarLiftController(_arg_1:String, _arg_2:uint, _arg_3:uint, _arg_4:uint, _arg_5:WindowContext, _arg_6:Rectangle, _arg_7:IWindow, _arg_8:Function, _arg_9:Array=null, _arg_10:Array=null, _arg_11:uint=0)
        {
            this._offsetX = 0;
            this._originalOffsetY = 0;
            _arg_4 = (_arg_4 | WindowParam._SafeStr_7445);
            _arg_4 = (_arg_4 | WindowParam._SafeStr_7486);
            _arg_4 = (_arg_4 | WindowParam._SafeStr_7488);
            super(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5, _arg_6, _arg_7, _arg_8, _arg_9, _arg_10, _arg_11);
            var _local_12:IWindow = _arg_7;
            while (_local_12 != null) {
                if ((_local_12 is IScrollbarWindow)){
                    this._scrollBar = ScrollbarController(_local_12);
                    _local_12 = null;
                }
                else {
                    _local_12 = _local_12.parent;
                };
            };
            if (this._scrollBar.horizontal){
                limits.minWidth = width;
            }
            else {
                limits.minHeight = height;
            };
        }
        public function get offsetX():Number
        {
            return (this._offsetX);
        }
        public function get offsetY():Number
        {
            return (this._originalOffsetY);
        }
        public function set offsetX(_arg_1:Number):void
        {
        }
        public function set offsetY(_arg_1:Number):void
        {
        }
        override public function update(_arg_1:WindowController, _arg_2:WindowEvent):Boolean
        {
            var _local_3:WindowEvent;
            if (_arg_2.type == WindowEvent.WE_RELOCATED){
                this._offsetX = (((x)!=0) ? (x / Number((_parent.width - width))) : 0);
                this._originalOffsetY = (((y)!=0) ? (y / Number((_parent.height - height))) : 0);
                if (_parent != this._scrollBar){
                    _local_3 = WindowEvent.allocate(WindowEvent.WE_CHILD_RELOCATED, this, null);
                    this._scrollBar.update(this, _local_3);
                    _local_3.recycle();
                };
            };
            return (super.update(_arg_1, _arg_2));
        }

    }
}//package com.sulake.core.window.components

// WindowEvent = "_-Jh" (String#2085, DoABC#2)
// WindowContext = "_-2K8" (String#6447, DoABC#2)
// IScrollbarWindow = "_-2fP" (String#1920, DoABC#2)
// IDragBarWindow = "_-BG" (String#2070, DoABC#2)
// InteractiveController = "_-25D" (String#6146, DoABC#2)
// ScrollbarController = "_-1Mk" (String#5287, DoABC#2)
// ScrollbarLiftController = "_-1WE" (String#5477, DoABC#2)
// WE_RELOCATED = "_-13s" (String#16612, DoABC#2)
// _originalOffsetY = "_-hb" (String#375, DoABC#2)
// _SafeStr_7445 = "_-3Kg" (String#22311, DoABC#2)
// _SafeStr_7486 = "_-2NN" (String#19938, DoABC#2)
// _SafeStr_7488 = "_-1ib" (String#18232, DoABC#2)
// allocate = "_-08G" (String#14374, DoABC#2)
// WE_CHILD_RELOCATED = "_-30I" (String#21512, DoABC#2)
// _scrollBar = "_-2z7" (String#906, DoABC#2)
// limits = "_-2BM" (String#6274, DoABC#2)


