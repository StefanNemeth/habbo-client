
package com.sulake.core.window.components
{
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.WindowContext;
    import flash.geom.Rectangle;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.WindowController;

    public class ActivatorController extends ContainerController 
    {

        protected var _activeChild:IWindow;

        public function ActivatorController(_arg_1:String, _arg_2:uint, _arg_3:uint, _arg_4:uint, _arg_5:WindowContext, _arg_6:Rectangle, _arg_7:IWindow, _arg_8:Function=null, _arg_9:Array=null, _arg_10:Array=null, _arg_11:uint=0)
        {
            super(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5, _arg_6, _arg_7, _arg_8, _arg_9, _arg_10, _arg_11);
        }
        override public function update(_arg_1:WindowController, _arg_2:WindowEvent):Boolean
        {
            if (_arg_2.type == WindowEvent.WE_CHILD_ACTIVATED){
                this.setActiveChild((_arg_1 as IWindow));
            }
            else {
                if (_arg_2.type == WindowEvent.WE_PARENT_ACTIVATED){
                    return (true);
                };
            };
            return (super.update(_arg_1, _arg_2));
        }
        public function getActiveChild():IWindow
        {
            return (this._activeChild);
        }
        public function setActiveChild(_arg_1:IWindow):IWindow
        {
            if (_arg_1.parent != this){
                while (true) {
                    _arg_1 = _arg_1.parent;
                    if (_arg_1 == null){
                        throw (new Error("Window passed to activator is not a child!"));
                    };
                    if (_arg_1.parent == this) break;
                };
            };
            var _local_2:IWindow = this._activeChild;
            if (this._activeChild != _arg_1){
                if (this._activeChild != null){
                    if (!this._activeChild.disposed){
                        this._activeChild.deactivate();
                    };
                };
                this._activeChild = _arg_1;
                if (getChildIndex(_arg_1) != (numChildren - 1)){
                    setChildIndex(_arg_1, (numChildren - 1));
                };
            };
            return (_local_2);
        }

    }
}//package com.sulake.core.window.components

// WindowEvent = "_-Jh" (String#2085, DoABC#2)
// WindowContext = "_-2K8" (String#6447, DoABC#2)
// ContainerController = "_-1v4" (String#5943, DoABC#2)
// ActivatorController = "_-Wd" (String#8339, DoABC#2)
// _activeChild = "_-0x2" (String#16314, DoABC#2)
// WE_CHILD_ACTIVATED = "_-f-" (String#23845, DoABC#2)
// setActiveChild = "_-lC" (String#24077, DoABC#2)
// WE_PARENT_ACTIVATED = "_-1o3" (String#18465, DoABC#2)
// getActiveChild = "_-1cK" (String#17983, DoABC#2)


