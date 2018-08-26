
package com.sulake.core.window
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.core.runtime.IUpdateReceiver;
    import com.sulake.core.window.utils.IEventQueue;
    import com.sulake.core.window.utils.IEventProcessor;
    import com.sulake.core.window.graphics.IWindowRenderer;
    import flash.display.Stage;
    import com.sulake.core.window.utils.EventProcessorState;
    import __AS3__.vec.Vector;
    import com.sulake.core.localization.ICoreLocalizationManager;
    import flash.display.DisplayObjectContainer;
    import com.sulake.core.window.services.IInternalWindowServices;
    import com.sulake.core.window.utils.IWindowParser;
    import com.sulake.core.window.components.IDesktopWindow;
    import com.sulake.core.window.components.SubstituteParentController;
    import com.sulake.core.window.services.ServiceManager;
    import com.sulake.core.window.utils.WindowParser;
    import flash.geom.Rectangle;
    import com.sulake.core.window.components.DesktopController;
    import flash.events.Event;
    import com.sulake.core.window.utils.MouseEventQueue;
    import com.sulake.core.window.utils.MouseEventProcessor;
    import com.sulake.core.window.utils.tablet.TabletEventQueue;
    import com.sulake.core.window.utils.tablet.TabletEventProcessor;
    import com.sulake.core.window.graphics.IGraphicContextHost;
    import flash.display.DisplayObject;
    import com.sulake.core.localization.ILocalizable;
    import com.sulake.core.window.enum.WindowParam;
    import com.sulake.core.window.enum.WindowState;
    import __AS3__.vec.*;

    public class WindowContext implements IWindowContext, IDisposable, IUpdateReceiver 
    {

        public static const _SafeStr_9776:uint = 0;
        public static const _SafeStr_9777:uint = 1;
        public static const _SafeStr_9778:int = 0;
        public static const _SafeStr_9779:int = 1;
        public static const _SafeStr_9780:int = 2;
        public static const _SafeStr_9781:int = 3;
        public static const _SafeStr_9782:int = 4;
        public static const _SafeStr_9169:int = 5;
        public static var _SafeStr_9783:IEventQueue;
        private static var _SafeStr_9784:IEventProcessor;
        private static var _SafeStr_9785:uint = _SafeStr_9776;//0
        private static var _RoomInstance:IWindowRenderer;
        private static var stage:Stage;

        private var _SafeStr_9786:EventProcessorState;
        private var _SafeStr_9787:Vector.<IWindowContextStateListener>;
        protected var _localization:ICoreLocalizationManager;
        protected var _SafeStr_9788:DisplayObjectContainer;
        protected var _SafeStr_9789:Boolean = true;
        protected var _WindowContext:Error;
        protected var _SafeStr_9790:int = -1;
        protected var _SafeStr_9791:IInternalWindowServices;
        protected var _SafeStr_9792:IWindowParser;
        protected var _SafeStr_9793:IWindowFactory;
        protected var _SafeStr_8617:IDesktopWindow;
        protected var _SafeStr_9794:SubstituteParentController;
        private var _disposed:Boolean = false;
        private var _SafeStr_9299:Boolean = false;
        private var _SafeStr_9795:Boolean = false;
        private var _name:String;

        public function WindowContext(_arg_1:String, _arg_2:IWindowRenderer, _arg_3:IWindowFactory, _arg_4:ICoreLocalizationManager, _arg_5:DisplayObjectContainer, _arg_6:Rectangle)
        {
            this._name = _arg_1;
            _RoomInstance = _arg_2;
            this._localization = _arg_4;
            this._SafeStr_9788 = _arg_5;
            this._SafeStr_9791 = new ServiceManager(this, _arg_5);
            this._SafeStr_9793 = _arg_3;
            this._SafeStr_9792 = new WindowParser(this);
            this._SafeStr_9787 = new Vector.<IWindowContextStateListener>();
            if (!stage){
                if ((this._SafeStr_9788 is Stage)){
                    stage = (this._SafeStr_9788 as Stage);
                }
                else {
                    if (this._SafeStr_9788.stage){
                        stage = this._SafeStr_9788.stage;
                    };
                };
            };
            Classes.init();
            if (_arg_6 == null){
                _arg_6 = new Rectangle(0, 0, 800, 600);
            };
            this._SafeStr_8617 = new DesktopController(("_CONTEXT_DESKTOP_" + this._name), this, _arg_6);
            this._SafeStr_8617.limits.maxWidth = _arg_6.width;
            this._SafeStr_8617.limits.maxHeight = _arg_6.height;
            this._SafeStr_9788.addChild(this._SafeStr_8617.getDisplayObject());
            this._SafeStr_9788.doubleClickEnabled = true;
            this._SafeStr_9788.addEventListener(Event.RESIZE, this.stageResizedHandler);
            this._SafeStr_9786 = new EventProcessorState(_RoomInstance, this._SafeStr_8617, this._SafeStr_8617, null, this._SafeStr_9787);
            inputMode = _SafeStr_9776;
            this._SafeStr_9794 = new SubstituteParentController(this);
        }
        public static function get inputMode():uint
        {
            return (_SafeStr_9785);
        }
        public static function set inputMode(value:uint):void
        {
            if (_SafeStr_9783){
                if ((_SafeStr_9783 is IDisposable)){
                    IDisposable(_SafeStr_9783).dispose();
                };
            };
            if (_SafeStr_9784){
                if ((_SafeStr_9784 is IDisposable)){
                    IDisposable(_SafeStr_9784).dispose();
                };
            };
            switch (value){
                case _SafeStr_9776:
                    _SafeStr_9783 = new MouseEventQueue(stage);
                    _SafeStr_9784 = new MouseEventProcessor();
                    try {
                    }
                    catch(e:Error) {
                    };
                    return;
                case _SafeStr_9777:
                    _SafeStr_9783 = new TabletEventQueue(stage);
                    _SafeStr_9784 = new TabletEventProcessor();
                    try {
                    }
                    catch(e:Error) {
                    };
                    return;
                default:
                    inputMode = _SafeStr_9776;
                    throw (new Error(("Unknown input mode " + value)));
            };
        }

        public function get disposed():Boolean
        {
            return (this._disposed);
        }
        public function dispose():void
        {
            if (!this._disposed){
                this._disposed = true;
                this._SafeStr_9788.removeEventListener(Event.RESIZE, this.stageResizedHandler);
                this._SafeStr_9788.removeChild((IGraphicContextHost(this._SafeStr_8617).getGraphicContext(true) as DisplayObject));
                this._SafeStr_8617.destroy();
                this._SafeStr_8617 = null;
                this._SafeStr_9794.destroy();
                this._SafeStr_9794 = null;
                if ((this._SafeStr_9791 is IDisposable)){
                    IDisposable(this._SafeStr_9791).dispose();
                };
                this._SafeStr_9791 = null;
                this._SafeStr_9792.dispose();
                this._SafeStr_9792 = null;
                _RoomInstance = null;
            };
        }
        public function getLastError():Error
        {
            return (this._WindowContext);
        }
        public function getLastErrorCode():int
        {
            return (this._SafeStr_9790);
        }
        public function handleError(_arg_1:int, _arg_2:Error):void
        {
            this._WindowContext = _arg_2;
            this._SafeStr_9790 = _arg_1;
            if (this._SafeStr_9789){
                throw (_arg_2);
            };
        }
        public function flushError():void
        {
            this._WindowContext = null;
            this._SafeStr_9790 = -1;
        }
        public function getWindowServices():IInternalWindowServices
        {
            return (this._SafeStr_9791);
        }
        public function getWindowParser():IWindowParser
        {
            return (this._SafeStr_9792);
        }
        public function getWindowFactory():IWindowFactory
        {
            return (this._SafeStr_9793);
        }
        public function getDesktopWindow():IDesktopWindow
        {
            return (this._SafeStr_8617);
        }
        public function findWindowByName(_arg_1:String):IWindow
        {
            return (this._SafeStr_8617.findChildByName(_arg_1));
        }
        public function registerLocalizationListener(_arg_1:String, _arg_2:IWindow):void
        {
            this._localization.registerListener(_arg_1, (_arg_2 as ILocalizable));
        }
        public function removeLocalizationListener(_arg_1:String, _arg_2:IWindow):void
        {
            this._localization.PetDataManager(_arg_1, (_arg_2 as ILocalizable));
        }
        public function create(_arg_1:String, _arg_2:String, _arg_3:uint, _arg_4:uint, _arg_5:uint, _arg_6:Rectangle, _arg_7:Function, _arg_8:IWindow, _arg_9:uint, _arg_10:Array=null, _arg_11:Array=null):IWindow
        {
            var _local_12:IWindow;
            var _local_13:Class = Classes.getWindowClassByType(_arg_3);
            if (_local_13 == null){
                this.handleError(WindowContext._SafeStr_9782, new Error((('Failed to solve implementation for window "' + _arg_1) + '"!')));
                return (null);
            };
            if (_arg_8 == null){
                if ((_arg_5 & WindowParam._SafeStr_7443)){
                    _arg_8 = this._SafeStr_9794;
                };
            };
            _local_12 = new (_local_13)(_arg_1, _arg_3, _arg_4, _arg_5, this, _arg_6, (((_arg_8)!=null) ? _arg_8 : this._SafeStr_8617), _arg_7, _arg_10, _arg_11, _arg_9);
            if (((_arg_2) && (_arg_2.length))){
                _local_12.caption = _arg_2;
            };
            return (_local_12);
        }
        public function destroy(_arg_1:IWindow):Boolean
        {
            if (_arg_1 == this._SafeStr_8617){
                this._SafeStr_8617 = null;
            };
            if (_arg_1.state != WindowState._SafeStr_9480){
                _arg_1.destroy();
            };
            return (true);
        }
        public function invalidate(_arg_1:IWindow, _arg_2:Rectangle, _arg_3:uint):void
        {
            if (!this.disposed){
                _RoomInstance.WindowRenderer(WindowController(_arg_1), _arg_2, _arg_3);
            };
        }
        public function update(_arg_1:uint):void
        {
            this._SafeStr_9299 = true;
            if (this._WindowContext){
                throw (this._WindowContext);
            };
            _SafeStr_9784.MouseEventProcessor(this._SafeStr_9786, _SafeStr_9783);
            this._SafeStr_9299 = false;
        }
        public function render(_arg_1:uint):void
        {
            this._SafeStr_9795 = true;
            _RoomInstance.update(_arg_1);
            this._SafeStr_9795 = false;
        }
        private function stageResizedHandler(_arg_1:Event):void
        {
            if (((!((this._SafeStr_8617 == null))) && (!(this._SafeStr_8617.disposed)))){
                if ((this._SafeStr_9788 is Stage)){
                    this._SafeStr_8617.limits.maxWidth = Stage(this._SafeStr_9788).stageWidth;
                    this._SafeStr_8617.limits.maxHeight = Stage(this._SafeStr_9788).stageHeight;
                    this._SafeStr_8617.width = Stage(this._SafeStr_9788).stageWidth;
                    this._SafeStr_8617.height = Stage(this._SafeStr_9788).stageHeight;
                }
                else {
                    this._SafeStr_8617.limits.maxWidth = this._SafeStr_9788.width;
                    this._SafeStr_8617.limits.maxHeight = this._SafeStr_9788.height;
                    this._SafeStr_8617.width = this._SafeStr_9788.width;
                    this._SafeStr_8617.height = this._SafeStr_9788.height;
                };
            };
        }
        public function addMouseEventTracker(_arg_1:IWindowContextStateListener):void
        {
            if (this._SafeStr_9787.indexOf(_arg_1) < 0){
                this._SafeStr_9787.push(_arg_1);
            };
        }
        public function removeMouseEventTracker(_arg_1:IWindowContextStateListener):void
        {
            var _local_2:int = this._SafeStr_9787.indexOf(_arg_1);
            if (_local_2 > -1){
                this._SafeStr_9787.splice(_local_2, 1);
            };
        }

    }
}//package com.sulake.core.window

// ILocalizable = "_-3Dn" (String#2024, DoABC#2)
// IWindowContext = "_-8b" (String#2061, DoABC#2)
// WindowContext = "_-2K8" (String#6447, DoABC#2)
// IWindowRenderer = "_-2Oq" (String#6539, DoABC#2)
// IGraphicContextHost = "_-2on" (String#1945, DoABC#2)
// Classes = "_-0TN" (String#1480, DoABC#2)
// WindowState = "_-1Kt" (String#5262, DoABC#2)
// IInternalWindowServices = "_-2Ry" (String#6605, DoABC#2)
// IWindowParser = "_-14A" (String#4960, DoABC#2)
// SubstituteParentController = "_-0kg" (String#4514, DoABC#2)
// DesktopController = "_-03D" (String#3633, DoABC#2)
// WindowParser = "_-0Rl" (String#4128, DoABC#2)
// EventProcessorState = "_-Ct" (String#7930, DoABC#2)
// IEventQueue = "_-cw" (String#8470, DoABC#2)
// TabletEventQueue = "_-0sJ" (String#16135, DoABC#2)
// MouseEventQueue = "_-3Du" (String#22030, DoABC#2)
// IEventProcessor = "_-1A-" (String#5077, DoABC#2)
// MouseEventProcessor = "_-1zl" (String#6028, DoABC#2)
// TabletEventProcessor = "_-1h0" (String#5685, DoABC#2)
// ServiceManager = "_-21o" (String#6081, DoABC#2)
// IDisposable = "_-0dY" (String#4382, DoABC#2)
// IWindowFactory = "_-Zd" (String#8408, DoABC#2)
// destroy = "_-25R" (String#615, DoABC#2)
// _SafeStr_7443 = "_-0YX" (String#15382, DoABC#2)
// IUpdateReceiver = "_-Qe" (String#8218, DoABC#2)
// MouseEventProcessor = "_-3Fw" (String#2032, DoABC#2)
// _SafeStr_8617 = "_-1WY" (String#5483, DoABC#2)
// _RoomInstance = "_-32W" (String#628, DoABC#2)
// registerListener = "_-6e" (String#7798, DoABC#2)
// PetDataManager = "_-1Hc" (String#1653, DoABC#2)
// _WindowContext = "_-0NR" (String#4029, DoABC#2)
// _SafeStr_9169 = "_-2Nz" (String#19963, DoABC#2)
// _SafeStr_9299 = "_-2FT" (String#6353, DoABC#2)
// limits = "_-2BM" (String#6274, DoABC#2)
// _SafeStr_9480 = "_-2cN" (String#20539, DoABC#2)
// WindowRenderer = "_-1zA" (String#6020, DoABC#2)
// findWindowByName = "_-0I5" (String#3917, DoABC#2)
// getLastError = "_-8" (String#7822, DoABC#2)
// getLastErrorCode = "_-oV" (String#8683, DoABC#2)
// flushError = "_-wd" (String#8816, DoABC#2)
// addMouseEventTracker = "_-0WZ" (String#1491, DoABC#2)
// removeMouseEventTracker = "_-0Ak" (String#1417, DoABC#2)
// _SafeStr_9776 = "_-2lQ" (String#20898, DoABC#2)
// _SafeStr_9777 = "_-2X1" (String#20324, DoABC#2)
// _SafeStr_9778 = "_-Dd" (String#22755, DoABC#2)
// _SafeStr_9779 = "_-8E" (String#22550, DoABC#2)
// _SafeStr_9780 = "_-2nc" (String#20983, DoABC#2)
// _SafeStr_9781 = "_-rb" (String#24343, DoABC#2)
// _SafeStr_9782 = "_-EX" (String#22793, DoABC#2)
// _SafeStr_9783 = "_-1aE" (String#17904, DoABC#2)
// _SafeStr_9784 = "_-1Q0" (String#17510, DoABC#2)
// _SafeStr_9785 = "_-0jR" (String#15806, DoABC#2)
// _SafeStr_9786 = "_-0I4" (String#14761, DoABC#2)
// _SafeStr_9787 = "_-1y" (String#18887, DoABC#2)
// _SafeStr_9788 = "_-2xb" (String#21378, DoABC#2)
// _SafeStr_9789 = "_-0Ra" (String#15123, DoABC#2)
// _SafeStr_9790 = "_-2zJ" (String#21432, DoABC#2)
// _SafeStr_9791 = "_-dP" (String#23777, DoABC#2)
// _SafeStr_9792 = "_-3F6" (String#22082, DoABC#2)
// _SafeStr_9793 = "_-2nm" (String#20990, DoABC#2)
// _SafeStr_9794 = "_-0XZ" (String#15338, DoABC#2)
// _SafeStr_9795 = "_-Wk" (String#23515, DoABC#2)
// stageResizedHandler = "_-2Un" (String#20229, DoABC#2)
// inputMode = "_-0pJ" (String#16027, DoABC#2)
// getWindowFactory = "_-0-h" (String#14041, DoABC#2)
// getWindowClassByType = "_-UC" (String#23415, DoABC#2)


