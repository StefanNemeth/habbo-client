
package com.sulake.core.window.components
{
    import com.sulake.core.window.utils.tablet.ITouchAwareWindow;
    import com.sulake.core.window.enum.WindowParam;
    import com.sulake.core.window.WindowContext;
    import flash.geom.Rectangle;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.enum.WindowType;
    import com.sulake.core.window.WindowController;
    import com.sulake.core.window.enum.WindowState;
    import com.sulake.core.window.events.WindowTouchEvent;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.window.utils.PropertyStruct;
    import com.sulake.core.window.utils.PropertyDefaults;

    public class DropMenuController extends InteractiveController implements IDropMenuWindow, ITouchAwareWindow 
    {

        protected static const _BTN_TEXT:String = "_DROPMENU_TITLETEXT";
        protected static const ITEMLIST_NAME:String = "_DROPMENU_ITEMLIST";

        private var _SafeStr_9260:Array;
        private var _selection:int = -1;
        private var _SafeStr_9262:Boolean = false;
        private var _SafeStr_9263:DropMenuController;

        public function DropMenuController(_arg_1:String, _arg_2:uint, _arg_3:uint, _arg_4:uint, _arg_5:WindowContext, _arg_6:Rectangle, _arg_7:IWindow, _arg_8:Function, _arg_9:Array=null, _arg_10:Array=null, _arg_11:uint=0)
        {
            this._SafeStr_9260 = new Array();
            _arg_4 = (_arg_4 | WindowParam._SafeStr_7434);
            super(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5, _arg_6, _arg_7, _arg_8, _arg_9, _arg_10, _arg_11);
        }
        public function get selection():int
        {
            return (this._selection);
        }
        public function set selection(_arg_1:int):void
        {
            if (_arg_1 > (this._SafeStr_9260.lenght - 1)){
                throw (new Error("Menu selection index out of range!"));
            };
            var _local_2:WindowEvent = WindowEvent.allocate(WindowEvent.WE_SELECT, this, null, true);
            this.update(this, _local_2);
            if (!_local_2.isWindowOperationPrevented()){
                _local_2.recycle();
                this._selection = _arg_1;
                this.closeMenuView();
                _local_2 = WindowEvent.allocate(WindowEvent.WE_SELECTED, this, null);
                this.update(this, _local_2);
            };
            _local_2.recycle();
        }
        override public function set caption(_arg_1:String):void
        {
            super.caption = _arg_1;
            this.getTitleLabel().text = _arg_1;
        }
        override public function dispose():void
        {
            if (((!((this._SafeStr_9263 == null))) && (!(this._SafeStr_9263.disposed)))){
                this._SafeStr_9263.destroy();
                this._SafeStr_9263 = null;
            };
            super.dispose();
        }
        override public function activate():Boolean
        {
            if (this._SafeStr_9262){
                return (true);
            };
            return (super.activate());
        }
        private function getTitleLabel():ILabelWindow
        {
            return ((getChildByName(DropMenuController._BTN_TEXT) as ILabelWindow));
        }
        private function getSubMenu():DropMenuController
        {
            var _local_1:Rectangle = new Rectangle();
            getGlobalRectangle(_local_1);
            if ((((this._SafeStr_9263 == null)) || (this._SafeStr_9263.disposed))){
                this._SafeStr_9263 = (context.create((name + "::submenu"), "", WindowType._SafeStr_7548, _style, (WindowParam.WINDOW_PARAM_EXPAND_TO_ACCOMMODATE_CHILDREN | WindowParam._SafeStr_7433), _local_1, this.subMenuEventProc, null, 0, null, [WindowController.TAG_EXCLUDE]) as DropMenuController);
            }
            else {
                this._SafeStr_9263.setGlobalRectangle(_local_1);
            };
            this._SafeStr_9263.activate();
            return (this._SafeStr_9263);
        }
        override public function populate(_arg_1:Array):void
        {
            this._selection = -1;
            while (this._SafeStr_9260.length > 0) {
                this._SafeStr_9260.pop();
            };
            var _local_2:uint;
            while (_local_2 < _arg_1.length) {
                this._SafeStr_9260.push(_arg_1[_local_2]);
                _local_2++;
            };
            this._SafeStr_9262 = true;
            this.closeMenuView();
        }
        public function getMenuItemIndex(_arg_1:IDropMenuItemWindow):int
        {
            var _local_2:int = -1;
            var _local_3:IItemListWindow = (getChildByName(DropMenuController.ITEMLIST_NAME) as IItemListWindow);
            if (_local_3 != null){
                _local_2 = _local_3.getListItemIndex(_arg_1);
            };
            if (_local_2 == -1){
                if (this._SafeStr_9263 != null){
                    _local_2 = this._SafeStr_9263.getMenuItemIndex(_arg_1);
                };
            };
            return (_local_2);
        }
        protected function openMenuView():void
        {
            if (!this._SafeStr_9262){
                if (this.open()){
                    if (this._SafeStr_9260.length){
                        this.populateMenuItemContainer(this._SafeStr_9260, this.getSubMenu(), this.subMenuEventProc);
                        this._SafeStr_9262 = true;
                    };
                };
            };
        }
        protected function closeMenuView():void
        {
            if (this.close()){
                if (this._SafeStr_9263 != null){
                    this._SafeStr_9263.destroy();
                    this._SafeStr_9263 = null;
                };
                this._SafeStr_9262 = false;
                this.getTitleLabel().text = (((((this._selection < this._SafeStr_9260.length)) && ((this._selection > -1)))) ? this._SafeStr_9260[this._selection] : caption);
            };
        }
        protected function populateMenuItemContainer(_arg_1:Array, _arg_2:DropMenuController, _arg_3:Function):void
        {
            var _local_6:IDropMenuItemWindow;
            var _local_4:IItemListWindow = (_arg_2.getChildByName(DropMenuController.ITEMLIST_NAME) as IItemListWindow);
            _local_4.autoArrangeItems = false;
            var _local_5:uint = _arg_1.length;
            var _local_7:int = _local_4.width;
            var _local_8:int = _local_7;
            var _local_9:uint;
            while (_local_9 < _local_5) {
                _local_6 = (context.create(((name + "::menu_item_") + _local_9), _arg_1[_local_9], WindowType._SafeStr_7550, _style, ((((WindowParam._SafeStr_7447 | WindowParam._SafeStr_7456) | WindowParam._SafeStr_7443) | WindowParam._SafeStr_7434) | WindowParam._SafeStr_7433), null, _arg_3, null, _local_9, null, ["_EXCLUDE"]) as DropMenuItemController);
                _local_8 = Math.max(_local_8, _local_6.width);
                _local_6.width = _local_7;
                _local_4.addListItem(_local_6);
                _local_9++;
            };
            if (_local_8 > _local_7){
                _arg_2.width = (_arg_2.width + (_local_8 - _local_4.width));
                _local_9 = 0;
                while (_local_9 < _local_5) {
                    _local_4.getListItemAt(_local_9).width = _local_8;
                    _local_9++;
                };
            };
            var _local_10:IWindow = context.create((name + "::padding"), "", WindowType._SafeStr_7544, _style, (((WindowParam._SafeStr_7447 | WindowParam._SafeStr_7456) | WindowParam._SafeStr_7443) | WindowParam._SafeStr_7433), new Rectangle(0, 0, 1, 2), null, null, 0, null, ["_EXCLUDE"]);
            _local_4.addListItem(_local_10);
            _local_4.autoArrangeItems = true;
            this.fitToDesktop(_arg_2);
            _arg_2.activate();
            if ((((this._selection > -1)) && (_local_5))){
                _local_4.getListItemAt(this._selection).setStateFlag(WindowState._SafeStr_9258, true);
            };
        }
        private function fitToDesktop(_arg_1:IWindow):void
        {
            var _local_2:Rectangle = new Rectangle();
            _arg_1.getGlobalRectangle(_local_2);
            if (_local_2.bottom > desktop.rectangle.bottom){
                _arg_1.offset(0, (desktop.rectangle.bottom - _local_2.bottom));
            }
            else {
                if (_local_2.top < desktop.rectangle.top){
                    _arg_1.offset(0, (_local_2.top - desktop.rectangle.top));
                };
            };
            if (_local_2.left < desktop.rectangle.left){
                _arg_1.offset((_local_2.left - desktop.rectangle.left), 0);
            }
            else {
                if (_local_2.right > desktop.rectangle.right){
                    _arg_1.offset((desktop.rectangle.right - _local_2.right), 0);
                };
            };
        }
        private function menuItemEventProc(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            var _local_3:uint;
            if ((((_arg_1.type == WindowMouseEvent.WME_DOWN)) || ((_arg_1.type == WindowTouchEvent.WTE_TAP)))){
                if ((_arg_2 is IDropMenuItemWindow)){
                    _local_3 = this.getMenuItemIndex((_arg_2 as IDropMenuItemWindow));
                    this.selection = _local_3;
                };
            };
        }
        private function subMenuEventProc(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            switch (_arg_1.type){
                case WindowTouchEvent.WTE_END:
                case WindowMouseEvent.WME_UP:
                    if ((_arg_2 is IDropMenuItemWindow)){
                        if (_arg_2.testStateFlag(WindowState._SafeStr_5004)){
                            this.selection = this.getMenuItemIndex((_arg_2 as IDropMenuItemWindow));
                        };
                    };
                    return;
                case WindowTouchEvent.WTE_BEGIN:
                case WindowMouseEvent.WME_DOWN:
                    if ((_arg_2 is IDropMenuItemWindow)){
                        this.selection = this.getMenuItemIndex((_arg_2 as IDropMenuItemWindow));
                    };
                    return;
                case WindowEvent.WE_DEACTIVATED:
                    if (_arg_2 == this._SafeStr_9263){
                        this.closeMenuView();
                    };
                    return;
            };
        }
        override public function update(_arg_1:WindowController, _arg_2:WindowEvent):Boolean
        {
            switch (_arg_2.type){
                case WindowTouchEvent.WTE_BEGIN:
                case WindowMouseEvent.WME_DOWN:
                    if (!this._SafeStr_9262){
                        this.openMenuView();
                    };
                    break;
            };
            return (super.update(_arg_1, _arg_2));
        }
        public function open():Boolean
        {
            if (getStateFlag(WindowState._SafeStr_4075)){
                return (true);
            };
            var _local_1:WindowEvent = WindowEvent.allocate(WindowEvent.WE_OPEN, this, null);
            this.update(this, _local_1);
            if (_local_1.isDefaultPrevented()){
                _local_1.recycle();
                return (false);
            };
            _local_1.recycle();
            visible = true;
            _local_1 = WindowEvent.allocate(WindowEvent.WE_OPENED, this, null);
            this.update(this, _local_1);
            _local_1.recycle();
            return (true);
        }
        public function close():Boolean
        {
            if (!getStateFlag(WindowState._SafeStr_4075)){
                return (true);
            };
            var _local_1:WindowEvent = WindowEvent.allocate(WindowEvent.WE_CLOSE, this, null);
            this.update(this, _local_1);
            if (_local_1.isDefaultPrevented()){
                _local_1.recycle();
                return (false);
            };
            _local_1.recycle();
            visible = false;
            _local_1 = WindowEvent.allocate(WindowEvent.WE_CLOSED, this, null);
            this.update(this, _local_1);
            _local_1.recycle();
            return (true);
        }
        public function enumerateSelection():Array
        {
            var _local_2:int;
            var _local_1:Array = new Array();
            if (!_disposed){
                _local_2 = 0;
                while (_local_2 < this._SafeStr_9260.length) {
                    _local_1.push(this._SafeStr_9260[_local_2]);
                    _local_2++;
                };
            };
            return (_local_1);
        }
        override public function get properties():Array
        {
            var _local_1:Array = super.properties;
            if (this._SafeStr_9260.length){
                _local_1.push(new PropertyStruct(PropertyDefaults._SafeStr_9278, this._SafeStr_9260, PropertyStruct._SafeStr_9001, true));
            }
            else {
                _local_1.push(PropertyDefaults._SafeStr_9279);
            };
            return (_local_1);
        }
        override public function set properties(_arg_1:Array):void
        {
            var _local_2:PropertyStruct;
            InteractiveController.readInteractiveWindowProperties(this, _arg_1);
            for each (_local_2 in _arg_1) {
                if (_local_2.key == PropertyDefaults._SafeStr_9278){
                    this.populate((_local_2.value as Array));
                    break;
                };
            };
            super.properties = _arg_1;
        }

    }
}//package com.sulake.core.window.components

// WindowEvent = "_-Jh" (String#2085, DoABC#2)
// WindowContext = "_-2K8" (String#6447, DoABC#2)
// WindowType = "_-1yl" (String#6008, DoABC#2)
// WindowState = "_-1Kt" (String#5262, DoABC#2)
// IDropMenuWindow = "_-4Z" (String#2049, DoABC#2)
// IDropMenuItemWindow = "_-11J" (String#1605, DoABC#2)
// PropertyStruct = "_-t6" (String#24410, DoABC#2)
// PropertyDefaults = "_-3Dd" (String#22019, DoABC#2)
// InteractiveController = "_-25D" (String#6146, DoABC#2)
// ITouchAwareWindow = "_-QS" (String#8212, DoABC#2)
// DropMenuController = "_-1-O" (String#4855, DoABC#2)
// DropMenuItemController = "_-A5" (String#7867, DoABC#2)
// WindowTouchEvent = "_-0lW" (String#4536, DoABC#2)
// _style = "_-1AT" (String#599, DoABC#2)
// _SafeStr_4075 = "_-0DX" (String#14589, DoABC#2)
// WE_SELECTED = "_-17F" (String#16745, DoABC#2)
// WME_DOWN = "_-hL" (String#23944, DoABC#2)
// WME_UP = "_-0Cs" (String#14566, DoABC#2)
// getGlobalRectangle = "_-05T" (String#3675, DoABC#2)
// getStateFlag = "_-1nM" (String#5804, DoABC#2)
// _SafeStr_5004 = "_-0Yv" (String#15399, DoABC#2)
// WE_SELECT = "_-335" (String#21624, DoABC#2)
// getListItemIndex = "_-6Q" (String#7792, DoABC#2)
// WE_DEACTIVATED = "_-1oi" (String#18485, DoABC#2)
// setStateFlag = "_-1jq" (String#5750, DoABC#2)
// enumerateSelection = "_-2oo" (String#7052, DoABC#2)
// destroy = "_-25R" (String#615, DoABC#2)
// _SafeStr_7433 = "_-222" (String#19092, DoABC#2)
// _SafeStr_7434 = "_-2xA" (String#21356, DoABC#2)
// _SafeStr_7443 = "_-0YX" (String#15382, DoABC#2)
// _SafeStr_7447 = "_-2dV" (String#20584, DoABC#2)
// _SafeStr_7456 = "_-2vm" (String#21305, DoABC#2)
// _SafeStr_7544 = "_-0c" (String#15512, DoABC#2)
// _SafeStr_7548 = "_-5u" (String#22460, DoABC#2)
// _SafeStr_7550 = "_-2tU" (String#21221, DoABC#2)
// _SafeStr_9001 = "_-2Pe" (String#20029, DoABC#2)
// allocate = "_-08G" (String#14374, DoABC#2)
// isWindowOperationPrevented = "_-27I" (String#19304, DoABC#2)
// _BTN_TEXT = "_-7L" (String#2054, DoABC#2)
// WTE_BEGIN = "_-17q" (String#16767, DoABC#2)
// WTE_END = "_-0i9" (String#15755, DoABC#2)
// WTE_TAP = "_-2Ox" (String#19999, DoABC#2)
// testStateFlag = "_-35A" (String#7410, DoABC#2)
// _SafeStr_9258 = "const" (String#44694, DoABC#2)
// _SafeStr_9260 = "_-20c" (String#19035, DoABC#2)
// _selection = "_-rB" (String#24323, DoABC#2)
// _SafeStr_9262 = "_-oT" (String#24212, DoABC#2)
// _SafeStr_9263 = "_-25Q" (String#19236, DoABC#2)
// closeMenuView = "_-2NK" (String#19936, DoABC#2)
// getTitleLabel = "_-2K5" (String#19810, DoABC#2)
// getSubMenu = "_-22A" (String#19098, DoABC#2)
// subMenuEventProc = "_-1jz" (String#18285, DoABC#2)
// setGlobalRectangle = "_-1XU" (String#5508, DoABC#2)
// getMenuItemIndex = "_-7n" (String#22534, DoABC#2)
// openMenuView = "_-2jU" (String#20825, DoABC#2)
// populateMenuItemContainer = "_-10z" (String#16498, DoABC#2)
// fitToDesktop = "_-1R8" (String#17551, DoABC#2)
// menuItemEventProc = "_-2zn" (String#21452, DoABC#2)
// WE_OPEN = "_-0hq" (String#15741, DoABC#2)
// WE_OPENED = "_-2AP" (String#19423, DoABC#2)
// WE_CLOSE = "_-1dD" (String#18023, DoABC#2)
// WE_CLOSED = "_-1da" (String#18038, DoABC#2)
// _SafeStr_9278 = "_-0Gv" (String#14716, DoABC#2)
// _SafeStr_9279 = "_-mR" (String#24125, DoABC#2)


