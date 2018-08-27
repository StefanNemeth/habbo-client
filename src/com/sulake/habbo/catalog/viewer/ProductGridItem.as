
package com.sulake.habbo.catalog.viewer
{
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import com.sulake.habbo.window.enum.HabboWindowStyle;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.components.IInteractiveWindow;
    import com.sulake.core.window.enum.WindowState;
    import com.sulake.core.window.enum.MouseCursorType;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.window.events.WindowEvent;
    import flash.display.BitmapData;
    import flash.geom.Point;

    public class ProductGridItem implements IGridItem 
    {

        private static const _SafeStr_4999:String = "bg";

        protected var _view:IWindowContainer;
        private var _grid:IItemGrid;
        protected var _icon:IBitmapWrapperWindow;
        private var _disposed:Boolean = false;
        private var _SafeStr_5001:Object;

        public function get view():IWindowContainer
        {
            return (this._view);
        }
        public function set grid(_arg_1:IItemGrid):void
        {
            this._grid = _arg_1;
        }
        public function dispose():void
        {
            if (this._disposed){
                return;
            };
            this._disposed = true;
            this._grid = null;
            this._icon = null;
            if (this._view != null){
                this._view.dispose();
                this._view = null;
            };
        }
        public function get disposed():Boolean
        {
            return (this._disposed);
        }
        public function activate():void
        {
            this._view.getChildByName(_SafeStr_4999).style = HabboWindowStyle._SafeStr_3729;
        }
        public function deActivate():void
        {
            this._view.getChildByName(_SafeStr_4999).style = 3;
        }
        public function set view(_arg_1:IWindowContainer):void
        {
            if (!_arg_1){
                return;
            };
            this._view = _arg_1;
            this._view.procedure = this.eventProc;
            this._icon = (this._view.findChildByName("image") as IBitmapWrapperWindow);
            var _local_2:IWindow = this._view.findChildByName("multiContainer");
            if (_local_2){
                _local_2.visible = false;
            };
        }
        public function setDraggable(_arg_1:Boolean):void
        {
            if (((this._view) && (_arg_1))){
                (this._view as IInteractiveWindow).setMouseCursorForState(WindowState._SafeStr_5004, MouseCursorType._SafeStr_5005);
                (this._view as IInteractiveWindow).setMouseCursorForState((WindowState._SafeStr_5004 | WindowState._SafeStr_4586), MouseCursorType._SafeStr_5005);
            };
        }
        private function eventProc(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            var _local_3:Boolean;
            if (_arg_1.type == WindowMouseEvent.WME_UP){
                this._SafeStr_5001 = null;
            }
            else {
                if (_arg_1.type == WindowMouseEvent.WME_DOWN){
                    Logger.log(this._view.state);
                    if (_arg_2 == null){
                        return;
                    };
                    this._grid.select(this);
                    this._SafeStr_5001 = _arg_2;
                }
                else {
                    if ((((((_arg_1.type == WindowMouseEvent.WME_OUT)) && (!((this._SafeStr_5001 == null))))) && ((this._SafeStr_5001 == _arg_2)))){
                        _local_3 = this._grid.startDragAndDrop(this);
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
                                    this._SafeStr_5001 = null;
                                };
                            };
                        };
                    };
                };
            };
        }
        protected function setIconImage(_arg_1:BitmapData, _arg_2:Boolean):void
        {
            var _local_3:int;
            var _local_4:int;
            if (_arg_1 == null){
                return;
            };
            if (((!((this._icon == null))) && (!(this._icon.disposed)))){
                _local_3 = ((this._icon.width - _arg_1.width) / 2);
                _local_4 = ((this._icon.height - _arg_1.height) / 2);
                if (this._icon.bitmap == null){
                    this._icon.bitmap = new BitmapData(this._icon.width, this._icon.height, true, 0xFFFFFF);
                };
                this._icon.bitmap.fillRect(this._icon.bitmap.rect, 0xFFFFFF);
                this._icon.bitmap.copyPixels(_arg_1, _arg_1.rect, new Point(_local_3, _local_4), null, null, false);
                this._icon.invalidate();
            };
            if (_arg_2){
                _arg_1.dispose();
            };
        }

    }
}//package com.sulake.habbo.catalog.viewer

// WindowEvent = "_-Jh" (String#2085, DoABC#2)
// HabboWindowStyle = "_-0E1" (String#14608, DoABC#2)
// IInteractiveWindow = "_-0KX" (String#1454, DoABC#2)
// WindowState = "_-1Kt" (String#5262, DoABC#2)
// IGridItem = "_-1oJ" (String#5825, DoABC#2)
// ProductGridItem = "_-24U" (String#6129, DoABC#2)
// IItemGrid = "_-0i3" (String#4468, DoABC#2)
// MouseCursorType = "_-031" (String#14164, DoABC#2)
// _SafeStr_3729 = "_-06z" (String#14322, DoABC#2)
// WME_OUT = "_-0h2" (String#15712, DoABC#2)
// WME_DOWN = "_-hL" (String#23944, DoABC#2)
// WME_UP = "_-0Cs" (String#14566, DoABC#2)
// _SafeStr_4586 = "_-22X" (String#19111, DoABC#2)
// setDraggable = "_-2tF" (String#7142, DoABC#2)
// _SafeStr_4999 = "_-Gm" (String#22881, DoABC#2)
// _grid = "_-CU" (String#2073, DoABC#2)
// _SafeStr_5001 = "_-1CR" (String#1632, DoABC#2)
// eventProc = "_-0xb" (String#1584, DoABC#2)
// setMouseCursorForState = "_-1lf" (String#5777, DoABC#2)
// _SafeStr_5004 = "_-0Yv" (String#15399, DoABC#2)
// _SafeStr_5005 = "_-0xz" (String#16354, DoABC#2)
// startDragAndDrop = "_-Di" (String#7945, DoABC#2)
// WME_DOUBLE_CLICK = "_-Y3" (String#23564, DoABC#2)
// setIconImage = "_-0p8" (String#16022, DoABC#2)


