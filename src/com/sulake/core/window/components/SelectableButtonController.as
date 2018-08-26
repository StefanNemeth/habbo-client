
package com.sulake.core.window.components
{
    import com.sulake.core.window.WindowContext;
    import flash.geom.Rectangle;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.WindowController;
    import com.sulake.core.window.enum.WindowState;
    import com.sulake.core.window.events.WindowEvent;

    public class SelectableButtonController extends ButtonController implements ISelectableWindow 
    {

        public function SelectableButtonController(_arg_1:String, _arg_2:uint, _arg_3:uint, _arg_4:uint, _arg_5:WindowContext, _arg_6:Rectangle, _arg_7:IWindow, _arg_8:Function, _arg_9:Array=null, _arg_10:Array=null, _arg_11:uint=0)
        {
            super(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5, _arg_6, _arg_7, _arg_8, _arg_9, _arg_10, _arg_11);
        }
        public function get selector():ISelectorWindow
        {
            var _local_1:IWindow;
            if (_parent){
                _local_1 = (_parent as WindowController);
                while (_local_1) {
                    if ((_local_1 is ISelectorWindow)){
                        return ((_local_1 as ISelectorWindow));
                    };
                    _local_1 = _local_1.parent;
                };
            };
            return (null);
        }
        public function get isSelected():Boolean
        {
            return (IWindow(WindowState._SafeStr_9258));
        }
        public function set isSelected(_arg_1:Boolean):void
        {
            WindowController(WindowState._SafeStr_9258, _arg_1);
        }
        override public function update(_arg_1:WindowController, _arg_2:WindowEvent):Boolean
        {
            var _local_3:WindowController;
            var _local_4:WindowEvent;
            if (_arg_2.type == WindowEvent.WE_ACTIVATED){
                if (_parent){
                    if (!(_parent is ISelectorWindow)){
                        _local_3 = (_parent.parent as WindowController);
                        while (_local_3) {
                            if ((_local_3 is ISelectorWindow)){
                                _local_4 = WindowEvent.allocate(WindowEvent.WE_CHILD_ACTIVATED, this, null);
                                _local_3.update(this, _local_4);
                                _local_4.recycle();
                                break;
                            };
                            _local_3 = (_local_3.parent as WindowController);
                        };
                    };
                };
            };
            return (super.update(_arg_1, _arg_2));
        }
        public function select():Boolean
        {
            if (WindowController(WindowState._SafeStr_9258)){
                return (true);
            };
            var _local_1:WindowEvent = WindowEvent.allocate(WindowEvent.WE_SELECT, this, null);
            this.update(this, _local_1);
            if (_local_1.isDefaultPrevented()){
                _local_1.recycle();
                return (false);
            };
            _local_1.recycle();
            WindowController(WindowState._SafeStr_9258, true);
            _local_1 = WindowEvent.allocate(WindowEvent.WE_SELECTED, this, null);
            this.update(this, _local_1);
            _local_1.recycle();
            return (true);
        }
        public function ISelectableWindow():Boolean
        {
            if (!WindowController(WindowState._SafeStr_9258)){
                return (true);
            };
            var _local_1:WindowEvent = WindowEvent.allocate(WindowEvent.WE_UNSELECT, this, null);
            this.update(this, _local_1);
            if (_local_1.isDefaultPrevented()){
                _local_1.recycle();
                return (false);
            };
            _local_1.recycle();
            WindowController(WindowState._SafeStr_9258, false);
            _local_1 = WindowEvent.allocate(WindowEvent.WE_UNSELECTED, this, null);
            this.update(this, _local_1);
            _local_1.recycle();
            return (true);
        }

    }
}//package com.sulake.core.window.components

// WindowEvent = "_-Jh" (String#2085, DoABC#2)
// WindowContext = "_-2K8" (String#6447, DoABC#2)
// ISelectableWindow = "_-nA" (String#2188, DoABC#2)
// WindowState = "_-1Kt" (String#5262, DoABC#2)
// ISelectorWindow = "_-1aY" (String#1714, DoABC#2)
// ButtonController = "_-Mw" (String#8140, DoABC#2)
// SelectableButtonController = "_-240" (String#6123, DoABC#2)
// WE_SELECTED = "_-17F" (String#16745, DoABC#2)
// WindowController = "_-1nM" (String#5804, DoABC#2)
// ISelectableWindow = "_-2aK" (String#6764, DoABC#2)
// WE_SELECT = "_-335" (String#21624, DoABC#2)
// WE_UNSELECTED = "_-1D" (String#16982, DoABC#2)
// WindowController = "_-1jq" (String#5750, DoABC#2)
// WE_UNSELECT = "_-sx" (String#24402, DoABC#2)
// allocate = "_-08G" (String#14374, DoABC#2)
// WE_CHILD_ACTIVATED = "_-f-" (String#23845, DoABC#2)
// IWindow = "_-35A" (String#7410, DoABC#2)
// _SafeStr_9258 = "const" (String#44694, DoABC#2)
// WE_ACTIVATED = "_-0ud" (String#16226, DoABC#2)


