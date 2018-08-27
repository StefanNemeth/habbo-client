
package com.sulake.habbo.window
{
    import com.sulake.core.runtime.Component;
    import com.sulake.core.window.ICoreWindowManager;
    import com.sulake.core.window.IWindowFactory;
    import com.sulake.core.runtime.IUpdateReceiver;
    import com.sulake.core.window.IWindowContextStateListener;
    import com.sulake.core.localization.ICoreLocalizationManager;
    import com.sulake.core.window.IWindowContext;
    import com.sulake.core.window.graphics.IWindowRenderer;
    import com.sulake.core.window.graphics.ISkinContainer;
    import flash.events.IEventDispatcher;
    import com.sulake.core.window.tools.ProfilerOutput;
    import com.sulake.core.utils.profiler.ProfilerAgentTask;
    import flash.utils.Dictionary;
    import com.sulake.core.utils.FontEnum;
    import com.sulake.habbo.window.enum.HabboWindowType;
    import com.sulake.core.window.enum.WindowType;
    import com.sulake.core.window.components.HTMLTextController;
    import com.sulake.iid.IIDCoreLocalizationManager;
    import com.sulake.core.runtime.IContext;
    import com.sulake.core.assets.IAssetLibrary;
    import flash.utils.getTimer;
    import com.sulake.core.assets.IAsset;
    import com.sulake.core.window.graphics.SkinContainer;
    import com.sulake.core.window.graphics.WindowRenderer;
    import flash.geom.Rectangle;
    import com.sulake.core.window.WindowContext;
    import com.sulake.core.runtime.IIDProfiler;
    import com.sulake.core.runtime.IID;
    import com.sulake.core.runtime.IUnknown;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.runtime.IProfiler;
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.core.utils.Map;
    import com.sulake.core.window.utils.DefaultAttStruct;
    import com.sulake.core.window.components.IDesktopWindow;
    import com.sulake.habbo.window.utils.AlertDialog;
    import com.sulake.core.window.utils.INotify;
    import com.sulake.habbo.window.utils.IAlertDialog;
    import com.sulake.habbo.window.utils.AlertDialogWithLink;
    import com.sulake.habbo.window.utils.IAlertDialogWithLink;
    import com.sulake.habbo.window.utils.ConfirmDialog;
    import com.sulake.habbo.window.utils.IConfirmDialog;
    import flash.events.Event;
    import com.sulake.habbo.window.enum.HabboWindowTrackingEvent;
    import com.sulake.core.window.utils.MouseCursorControl;
    import flash.events.MouseEvent;
    import com.sulake.core.utils.ErrorReportStorage;
    import com.sulake.habbo.tracking.HabboErrorVariableEnum;
    import com.sulake.core.window.events.*;
    import com.sulake.core.window.enum.*;

    public class HabboWindowManagerComponent extends Component implements IHabboWindowManager, ICoreWindowManager, IWindowFactory, IUpdateReceiver, IWindowContextStateListener 
    {

        private static var _instance:IHabboWindowManager;
        private static const _SafeStr_14373:uint = 3;
        private static const _SafeStr_14374:uint = 1;

        private var _localization:ICoreLocalizationManager;
        private var _windowContextArray:Array;
        private var _SafeStr_9637:IWindowContext;
        private var _SafeStr_9665:IWindowRenderer;
        private var _skinContainer:ISkinContainer;
        private var _SafeStr_14375:Array;
        private var _SafeStr_14376:IEventDispatcher;
        private var _SafeStr_14377:Boolean = false;
        private var _SafeStr_14378:ProfilerOutput;
        private var _SafeStr_14379:ProfilerAgentTask;
        private var _SafeStr_14380:ProfilerAgentTask;

        public function HabboWindowManagerComponent(_arg_1:IContext, _arg_2:uint=0, _arg_3:IAssetLibrary=null)
        {
            var _local_4:Dictionary;
            super(_arg_1, _arg_2, _arg_3);
            lock();
            FontEnum.refresh();
            _instance = this;
            this._SafeStr_14376 = _arg_1.events;
            this._SafeStr_14375 = new Array();
            _local_4 = new Dictionary();
            _local_4[HabboWindowType._SafeStr_3728] = null;
            _local_4[HabboWindowType._SafeStr_7511] = (_arg_3.getAssetByName("habbo_window_layout_frame_xml").content as XML);
            _local_4[HabboWindowType._SafeStr_7514] = (_arg_3.getAssetByName("habbo_window_layout_simple_xml").content as XML);
            _local_4[HabboWindowType.0] = (_arg_3.getAssetByName("habbo_window_layout_frame_xml").content as XML);
            _local_4[HabboWindowType._SafeStr_7540] = (_arg_3.getAssetByName("habbo_window_layout_header_xml").content as XML);
            _local_4[HabboWindowType._SafeStr_7517] = null;
            _local_4[HabboWindowType._SafeStr_7525] = (_arg_3.getAssetByName("habbo_window_layout_scrollbar_horizontal_xml").content as XML);
            _local_4[HabboWindowType._SafeStr_7542] = null;
            _local_4[HabboWindowType._SafeStr_4662] = null;
            _local_4[HabboWindowType._SafeStr_7538] = (_arg_3.getAssetByName("habbo_window_layout_bubble_xml").content as XML);
            _local_4[HabboWindowType.BUTTON] = (_arg_3.getAssetByName("habbo_window_layout_button_xml").content as XML);
            _local_4[HabboWindowType._SafeStr_7536] = (_arg_3.getAssetByName("habbo_window_layout_button_thick_xml").content as XML);
            _local_4[HabboWindowType._SafeStr_7576] = (_arg_3.getAssetByName("habbo_window_layout_button_xml").content as XML);
            _local_4[HabboWindowType._SafeStr_7578] = (_arg_3.getAssetByName("habbo_window_layout_button_xml").content as XML);
            _local_4[HabboWindowType._SafeStr_7580] = (_arg_3.getAssetByName("habbo_window_layout_button_xml").content as XML);
            _local_4[HabboWindowType._SafeStr_7519] = null;
            _local_4[HabboWindowType._SafeStr_7527] = (_arg_3.getAssetByName("habbo_window_layout_scrollbar_vertical_xml").content as XML);
            _local_4[HabboWindowType._SafeStr_7547] = (_arg_3.getAssetByName("habbo_window_layout_dropmenu_xml").content as XML);
            _local_4[HabboWindowType._SafeStr_7549] = (_arg_3.getAssetByName("habbo_window_layout_dropmenu_item_xml").content as XML);
            _local_4[HabboWindowType._SafeStr_7552] = null;
            _local_4[HabboWindowType._SafeStr_6022] = null;
            _local_4[HabboWindowType._SafeStr_7558] = null;
            _local_4[HabboWindowType._SafeStr_7554] = null;
            _local_4[HabboWindowType._SafeStr_7562] = (_arg_3.getAssetByName("habbo_window_layout_tab_button_xml").content as XML);
            _local_4[WindowType._SafeStr_9435] = (_arg_3.getAssetByName("habbo_window_layout_badge_xml").content as XML);
            _local_4[WindowType._SafeStr_7567] = (_arg_3.getAssetByName("habbo_window_layout_tab_context_xml").content as XML);
            _local_4[WindowType._SafeStr_9432] = (_arg_3.getAssetByName("habbo_window_layout_tooltip_xml").content as XML);
            _local_4[WindowType._SafeStr_9468] = (_arg_3.getAssetByName("habbo_window_layout_scaler_xml").content as XML);
            _local_4[WindowType.WINDOW_TYPE_SCROLLABLE_ITEMLIST_VERTICAL] = (_arg_3.getAssetByName("habbo_window_layout_scrollable_itemlist_vertical_xml").content as XML);
            this._SafeStr_14375.push(_local_4);
            _local_4 = new Dictionary();
            _local_4[HabboWindowType.BUTTON] = (_arg_3.getAssetByName("habbo_window_layout_button_black_xml").content as XML);
            _local_4[HabboWindowType._SafeStr_7540] = (_arg_3.getAssetByName("habbo_window_layout_header_black_xml").content as XML);
            _local_4[HabboWindowType._SafeStr_7536] = (_arg_3.getAssetByName("habbo_window_layout_button_thick_black_xml").content as XML);
            _local_4[HabboWindowType._SafeStr_7576] = (_arg_3.getAssetByName("habbo_window_layout_button_black_xml").content as XML);
            _local_4[HabboWindowType._SafeStr_7578] = (_arg_3.getAssetByName("habbo_window_layout_button_black_xml").content as XML);
            _local_4[HabboWindowType._SafeStr_7580] = (_arg_3.getAssetByName("habbo_window_layout_button_black_xml").content as XML);
            _local_4[HabboWindowType._SafeStr_7547] = (_arg_3.getAssetByName("habbo_window_layout_dropmenu_black_xml").content as XML);
            _local_4[HabboWindowType._SafeStr_7549] = (_arg_3.getAssetByName("habbo_window_layout_dropmenu_item_black_xml").content as XML);
            _local_4[HabboWindowType._SafeStr_7562] = (_arg_3.getAssetByName("habbo_window_layout_tab_button_black_xml").content as XML);
            this._SafeStr_14375.push(_local_4);
            _local_4 = new Dictionary();
            _local_4[HabboWindowType.BUTTON] = (_arg_3.getAssetByName("habbo_window_layout_button_xml").content as XML);
            _local_4[HabboWindowType._SafeStr_7536] = (_arg_3.getAssetByName("habbo_window_layout_button_thick_xml").content as XML);
            _local_4[HabboWindowType._SafeStr_7576] = (_arg_3.getAssetByName("habbo_window_layout_button_xml").content as XML);
            _local_4[HabboWindowType._SafeStr_7578] = (_arg_3.getAssetByName("habbo_window_layout_button_xml").content as XML);
            _local_4[HabboWindowType._SafeStr_7580] = (_arg_3.getAssetByName("habbo_window_layout_button_xml").content as XML);
            _local_4[HabboWindowType._SafeStr_7562] = (_arg_3.getAssetByName("habbo_window_layout_tab_button_xml").content as XML);
            this._SafeStr_14375.push(_local_4);
            _local_4 = new Dictionary();
            _local_4[HabboWindowType._SafeStr_7511] = (_arg_3.getAssetByName("habbo_window_layout_frame_3_xml").content as XML);
            _local_4[HabboWindowType._SafeStr_7540] = (_arg_3.getAssetByName("habbo_window_layout_header_3_xml").content as XML);
            _local_4[HabboWindowType.BUTTON] = (_arg_3.getAssetByName("habbo_window_layout_button_shiny_xml").content as XML);
            _local_4[HabboWindowType._SafeStr_7536] = (_arg_3.getAssetByName("habbo_window_layout_button_shiny_thick_xml").content as XML);
            _local_4[WindowType._SafeStr_9468] = (_arg_3.getAssetByName("habbo_window_layout_scaler_3_xml").content as XML);
            _local_4[HabboWindowType._SafeStr_7562] = (_arg_3.getAssetByName("habbo_window_layout_tab_button_3_xml").content as XML);
            _local_4[WindowType._SafeStr_7567] = (_arg_3.getAssetByName("habbo_window_layout_tab_context_3_xml").content as XML);
            this._SafeStr_14375.push(_local_4);
            _local_4 = new Dictionary();
            _local_4[HabboWindowType.BUTTON] = (_arg_3.getAssetByName("habbo_window_layout_button_shiny_black_xml").content as XML);
            _local_4[HabboWindowType._SafeStr_7536] = (_arg_3.getAssetByName("habbo_window_layout_button_shiny_thick_black_xml").content as XML);
            this._SafeStr_14375.push(_local_4);
            _local_4 = new Dictionary();
            _local_4[HabboWindowType.BUTTON] = (_arg_3.getAssetByName("habbo_window_layout_button_shiny_black_xml").content as XML);
            _local_4[HabboWindowType._SafeStr_7536] = (_arg_3.getAssetByName("habbo_window_layout_button_shiny_thick_black_xml").content as XML);
            this._SafeStr_14375.push(_local_4);
            HTMLTextController.defaultLinkTarget = "habboMain";
            queueInterface(new IIDCoreLocalizationManager(), this.initialize);
        }
        public static function getInstance():IHabboWindowManager
        {
            return (_instance);
        }

        private function initialize(_arg_1:IID, _arg_2:IUnknown):void
        {
            var _local_3:int = getTimer();
            this._localization = (_arg_2 as ICoreLocalizationManager);
            var _local_4:IAsset = assets.getAssetByName("habbo_element_description_xml");
            this._skinContainer = new SkinContainer((_local_4.content as XML), assets);
            this._SafeStr_9665 = new WindowRenderer(this._skinContainer);
            this._windowContextArray = new Array(_SafeStr_14373);
            var _local_5:Rectangle = new Rectangle(0, 0, context.displayObjectContainer.stage.stageWidth, context.displayObjectContainer.stage.stageHeight);
            var _local_6:uint;
            while (_local_6 < _SafeStr_14373) {
                this._windowContextArray[_local_6] = new WindowContext(("layer_" + _local_6), this._SafeStr_9665, this, this._localization, context.displayObjectContainer, _local_5);
                _local_6++;
            };
            this._SafeStr_9637 = this._windowContextArray[_SafeStr_14374];
            this.addMouseEventTracker(this);
            unlock();
            registerUpdateReceiver(this, 0);
            queueInterface(new IIDProfiler(), this.receiveProfilerInterface);
            _local_3 = (getTimer() - _local_3);
            Logger.log((("initializing window framework took " + _local_3) + "ms"));
        }
        private function onCrashTest(_arg_1:WindowMouseEvent):void
        {
            var _local_2:IWindow;
            Logger.log("CRASH!");
            _local_2.background = true;
        }
        private function receiveProfilerInterface(_arg_1:IID, _arg_2:IUnknown):void
        {
            var _local_3:IProfiler = (_arg_2 as IProfiler);
            if (_local_3 != null){
                if (!this._SafeStr_14378){
                    this._SafeStr_14378 = new ProfilerOutput(context, this, this._SafeStr_9665);
                };
                this._SafeStr_14378.profiler = _local_3;
                this._SafeStr_14379 = new ProfilerAgentTask("Update", "Event processing");
                _local_3.getProfilerAgentForReceiver(this).addSubTask(this._SafeStr_14379);
                this._SafeStr_14380 = new ProfilerAgentTask("Redraw", "Window rasterizer");
                _local_3.getProfilerAgentForReceiver(this).addSubTask(this._SafeStr_14380);
                this._SafeStr_14377 = true;
            };
        }
        private function receiveLoggerInterface(_arg_1:IID, _arg_2:IUnknown):void
        {
        }
        override public function dispose():void
        {
            if (!disposed){
                removeUpdateReceiver(this);
                if (this._windowContextArray){
                    while (this._windowContextArray.length > 0) {
                        IDisposable(this._windowContextArray.pop()).dispose();
                    };
                };
                this._windowContextArray = null;
                if (this._SafeStr_14375){
                    while (this._SafeStr_14375.length > 0) {
                        this._SafeStr_14375.pop();
                    };
                };
                this._SafeStr_14375 = null;
                if (this._localization){
                    this._localization.release(new IIDCoreLocalizationManager());
                    this._localization = null;
                };
                if (this._SafeStr_9665){
                    this._SafeStr_9665.dispose();
                    this._SafeStr_9665 = null;
                };
                if (this._skinContainer){
                    this._skinContainer.dispose();
                    this._skinContainer = null;
                };
                super.dispose();
            };
        }
        public function create(_arg_1:String, _arg_2:uint, _arg_3:uint, _arg_4:uint, _arg_5:Rectangle, _arg_6:Function=null, _arg_7:String="", _arg_8:uint=0, _arg_9:Array=null, _arg_10:IWindow=null, _arg_11:Array=null):IWindow
        {
            return (this._SafeStr_9637.create(_arg_1, _arg_7, _arg_2, _arg_3, _arg_4, _arg_5, _arg_6, _arg_10, _arg_8, _arg_11, _arg_9));
        }
        public function destroy(_arg_1:IWindow):void
        {
            _arg_1.destroy();
        }
        public function buildFromXML(_arg_1:XML, _arg_2:uint=1, _arg_3:Map=null):IWindow
        {
            return (this.getWindowContext(_arg_2).getWindowParser().parseAndConstruct(_arg_1, null, _arg_3));
        }
        public function windowToXMLString(_arg_1:IWindow):String
        {
            return (this._SafeStr_9637.getWindowParser().windowToXMLString(_arg_1));
        }
        public function getLayoutByTypeAndStyle(_arg_1:uint, _arg_2:uint):XML
        {
            var _local_3:Dictionary = (this._SafeStr_14375[_arg_2] as Dictionary);
            if (_local_3 == null){
                return (null);
            };
            var _local_4:XML = (_local_3[_arg_1] as XML);
            return ((((_local_4 == null)) ? (this._SafeStr_14375[0][_arg_1] as XML) : _local_4));
        }
        public function getDefaultsByTypeAndStyle(_arg_1:uint, _arg_2:uint):DefaultAttStruct
        {
            return (this._skinContainer.getDefaultAttributesByTypeAndStyle(_arg_1, _arg_2));
        }
        public function createWindow(_arg_1:String, _arg_2:String="", _arg_3:uint=0, _arg_4:uint=0, _arg_5:uint=0, _arg_6:Rectangle=null, _arg_7:Function=null, _arg_8:uint=0, _arg_9:uint=1):IWindow
        {
            return (this._windowContextArray[_arg_9].create(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5, _arg_6, _arg_7, null, _arg_8, null, null));
        }
        public function removeWindow(_arg_1:String, _arg_2:uint=1):void
        {
            var _local_3:IDesktopWindow = this._windowContextArray[_arg_2].getDesktopWindow();
            var _local_4:IWindow = _local_3.getChildByName(_arg_1);
            if (_local_4 != null){
                _local_4.destroy();
            };
        }
        public function getWindowByName(_arg_1:String, _arg_2:uint=1):IWindow
        {
            return (this._windowContextArray[_arg_2].getDesktopWindow().getChildByName(_arg_1));
        }
        public function getActiveWindow(_arg_1:uint=1):IWindow
        {
            return (this._windowContextArray[_arg_1].getDesktopWindow().getChildAt((this._SafeStr_9637.getDesktopWindow().numChildren - 1)));
        }
        public function getWindowContext(_arg_1:uint):IWindowContext
        {
            return (this._windowContextArray[_arg_1]);
        }
        public function getDesktop(_arg_1:uint):IDesktopWindow
        {
            var _local_2:IWindowContext = this._windowContextArray[_arg_1];
            return (((_local_2) ? _local_2.getDesktopWindow() : null));
        }
        public function notify(_arg_1:String, _arg_2:String, _arg_3:Function, _arg_4:uint=0):INotify
        {
            var _local_5:IAsset = assets.getAssetByName("habbo_window_alert_xml");
            if (!_local_5){
                throw (new Error("Failed to initialize alert dialog; missing asset!"));
            };
            var _local_6:XML = (_local_5.content as XML);
            return (new AlertDialog(this, _local_6, _arg_1, _arg_2, _arg_4, _arg_3));
        }
        public function alert(_arg_1:String, _arg_2:String, _arg_3:uint, _arg_4:Function):IAlertDialog
        {
            var _local_5:IAsset = assets.getAssetByName("habbo_window_alert_xml");
            if (!_local_5){
                throw (new Error("Failed to initialize alert dialog; missing asset!"));
            };
            var _local_6:XML = (_local_5.content as XML);
            return (new AlertDialog(this, _local_6, _arg_1, _arg_2, _arg_3, _arg_4));
        }
        public function alertWithLink(_arg_1:String, _arg_2:String, _arg_3:String, _arg_4:String, _arg_5:uint, _arg_6:Function):IAlertDialogWithLink
        {
            var _local_7:IAsset = assets.getAssetByName("habbo_window_alert_link_xml");
            if (!_local_7){
                throw (new Error("Failed to initialize alert dialog; missing asset!"));
            };
            var _local_8:XML = (_local_7.content as XML);
            return (new AlertDialogWithLink(this, _local_8, _arg_1, _arg_2, _arg_3, _arg_4, _arg_5, _arg_6));
        }
        public function confirm(_arg_1:String, _arg_2:String, _arg_3:uint, _arg_4:Function):IConfirmDialog
        {
            var _local_5:IAsset = assets.getAssetByName("habbo_window_confirm_xml");
            if (!_local_5){
                throw (new Error("Failed to initialize aleret dialog; missing asset!"));
            };
            var _local_6:XML = (_local_5.content as XML);
            return (new ConfirmDialog(this, _local_6, _arg_1, _arg_2, _arg_3, _arg_4));
        }
        public function registerLocalizationParameter(_arg_1:String, _arg_2:String, _arg_3:String, _arg_4:String="%"):void
        {
            this._localization.registerParameter(_arg_1, _arg_2, _arg_3, _arg_4);
        }
        public function update(_arg_1:uint):void
        {
            var _local_2:int;
            if (this._SafeStr_14377){
                this._SafeStr_14379.start();
            };
            if (WindowContext._SafeStr_9783.length > 0){
                this._SafeStr_14376.dispatchEvent(new Event(HabboWindowTrackingEvent.HABBO_WINDOW_TRACKING_EVENT_INPUT));
                _local_2 = (_SafeStr_14373 - 1);
                while (_local_2 >= 0) {
                    this._windowContextArray[_local_2].update(_arg_1);
                    _local_2--;
                };
            };
            if (this._SafeStr_14377){
                this._SafeStr_14379.stop();
            };
            if (this._SafeStr_14377){
                this._SafeStr_14380.start();
            };
            this._SafeStr_14376.dispatchEvent(new Event(HabboWindowTrackingEvent.HABBO_WINDOW_TRACKING_EVENT_RENDER));
            _local_2 = 0;
            while (_local_2 < _SafeStr_14373) {
                this._windowContextArray[_local_2].render(_arg_1);
                _local_2++;
            };
            if (this._SafeStr_14377){
                this._SafeStr_14380.stop();
            };
            if (WindowContext._SafeStr_9783.length > 0){
                WindowContext._SafeStr_9783.flush();
            };
            MouseCursorControl.change();
            this._SafeStr_14376.dispatchEvent(new Event(HabboWindowTrackingEvent.HABBO_WINDOW_TRACKING_EVENT_SLEEP));
        }
        public function addMouseEventTracker(_arg_1:IWindowContextStateListener):void
        {
            var _local_2:IWindowContext;
            for each (_local_2 in this._windowContextArray) {
                _local_2.addMouseEventTracker(_arg_1);
            };
        }
        public function removeMouseEventTracker(_arg_1:IWindowContextStateListener):void
        {
            var _local_2:IWindowContext;
            for each (_local_2 in this._windowContextArray) {
                _local_2.removeMouseEventTracker(_arg_1);
            };
        }
        public function mouseEventReceived(_arg_1:String, _arg_2:IWindow):void
        {
            if (_arg_2 != null){
                if (_arg_1 == MouseEvent.CLICK){
                    ErrorReportStorage.setParameter(HabboErrorVariableEnum._SafeStr_13800, new Date().getTime().toString());
                    ErrorReportStorage.setParameter(HabboErrorVariableEnum._SafeStr_13801, ((_arg_2.name + ": ") + _arg_2.toString()));
                }
                else {
                    if (_arg_1 == MouseEvent.MOUSE_UP){
                        ErrorReportStorage.setParameter(HabboErrorVariableEnum._SafeStr_13798, new Date().getTime().toString());
                        ErrorReportStorage.setParameter(HabboErrorVariableEnum._SafeStr_13799, ((_arg_2.name + ": ") + _arg_2.toString()));
                    };
                };
            };
        }
        private function performTestCases():void
        {
        }

    }
}//package com.sulake.habbo.window

// IID = "_-3KV" (String#7712, DoABC#2)
// alertWithLink = "_-KV" (String#8092, DoABC#2)
// IAlertDialog = "_-2LY" (String#6472, DoABC#2)
// _SafeStr_13798 = "_-0Xm" (String#15347, DoABC#2)
// _SafeStr_13799 = "_-0Im" (String#14791, DoABC#2)
// _SafeStr_13800 = "_-0Ho" (String#14749, DoABC#2)
// _SafeStr_13801 = "_-2L2" (String#19848, DoABC#2)
// IConfirmDialog = "_-35c" (String#7421, DoABC#2)
// _SafeStr_14373 = "_-3-C" (String#21469, DoABC#2)
// _SafeStr_14374 = "_-34z" (String#21694, DoABC#2)
// _SafeStr_14375 = "_-2Td" (String#20187, DoABC#2)
// _SafeStr_14376 = "_-2rI" (String#21129, DoABC#2)
// _SafeStr_14377 = "_-27N" (String#19307, DoABC#2)
// _SafeStr_14378 = "_-0Ek" (String#14633, DoABC#2)
// _SafeStr_14379 = "_-06T" (String#14304, DoABC#2)
// _SafeStr_14380 = "_-193" (String#16820, DoABC#2)
// receiveProfilerInterface = "_-2D6" (String#19528, DoABC#2)
// onCrashTest = "_-0ac" (String#15459, DoABC#2)
// receiveLoggerInterface = "_-16o" (String#16727, DoABC#2)
// getWindowByName = "_-3LJ" (String#7725, DoABC#2)
// performTestCases = "_-2iZ" (String#20790, DoABC#2)
// HabboWindowType = "_-29U" (String#19384, DoABC#2)
// INotify = "_-3FZ" (String#7620, DoABC#2)
// IWindowContext = "_-8b" (String#2061, DoABC#2)
// IAlertDialogWithLink = "_-0zQ" (String#4836, DoABC#2)
// DefaultAttStruct = "_-2e0" (String#20604, DoABC#2)
// AlertDialog = "_-eF" (String#8488, DoABC#2)
// AlertDialogWithLink = "_-1oC" (String#5823, DoABC#2)
// ProfilerOutput = "_-34L" (String#7396, DoABC#2)
// IIDProfiler = "_-1l" (String#18333, DoABC#2)
// WindowContext = "_-2K8" (String#6447, DoABC#2)
// ProfilerAgentTask = "_-0U3" (String#4185, DoABC#2)
// FontEnum = "_-15T" (String#4985, DoABC#2)
// WindowType = "_-1yl" (String#6008, DoABC#2)
// ConfirmDialog = "_-Nb" (String#8156, DoABC#2)
// IWindowRenderer = "_-2Oq" (String#6539, DoABC#2)
// MouseCursorControl = "_-eM" (String#23816, DoABC#2)
// ISkinContainer = "_-us" (String#8781, DoABC#2)
// SkinContainer = "_-9E" (String#7847, DoABC#2)
// IProfiler = "_-Fo" (String#7989, DoABC#2)
// HTMLTextController = "_-0F9" (String#3855, DoABC#2)
// IDisposable = "_-0dY" (String#4382, DoABC#2)
// _SafeStr_3728 = "_-1IW" (String#5215, DoABC#2)
// getInstance = "_-n5" (String#24157, DoABC#2)
// refresh = "_-s9" (String#189, DoABC#2)
// registerUpdateReceiver = "_-35P" (String#7415, DoABC#2)
// ICoreWindowManager = "_-YU" (String#2128, DoABC#2)
// IWindowFactory = "_-Zd" (String#8408, DoABC#2)
// _SafeStr_4662 = "_-0g1" (String#15673, DoABC#2)
// change = "_-Bl" (String#7908, DoABC#2)
// _SafeStr_6022 = "_-1t4" (String#18679, DoABC#2)
// destroy = "_-25R" (String#615, DoABC#2)
// Component = "_-19A" (String#5060, DoABC#2)
// removeWindow = "_-x0" (String#949, DoABC#2)
// _SafeStr_7511 = "_-1Fr" (String#17109, DoABC#2)
// 0 = "_-2pg" (String#21067, DoABC#2)
// _SafeStr_7514 = "_-2Fh" (String#19630, DoABC#2)
// _SafeStr_7517 = "_-18U" (String#16793, DoABC#2)
// _SafeStr_7519 = "_-07K" (String#14339, DoABC#2)
// _SafeStr_7525 = "_-1Lz" (String#17356, DoABC#2)
// _SafeStr_7527 = "_-3Gx" (String#22160, DoABC#2)
// _SafeStr_7536 = "_-1nn" (String#18451, DoABC#2)
// _SafeStr_7538 = "_-1Ah" (String#1627, DoABC#2)
// _SafeStr_7540 = "_-1l4" (String#444, DoABC#2)
// _SafeStr_7542 = "_-1wo" (String#18836, DoABC#2)
// _SafeStr_7547 = "_-jJ" (String#24011, DoABC#2)
// _SafeStr_7549 = "_-0cm" (String#15545, DoABC#2)
// _SafeStr_7552 = "_-1fx" (String#18137, DoABC#2)
// _SafeStr_7554 = "_-0B4" (String#14491, DoABC#2)
// _SafeStr_7558 = "_-sC" (String#8741, DoABC#2)
// _SafeStr_7562 = "_-1FJ" (String#17086, DoABC#2)
// _SafeStr_7567 = "_-7P" (String#22518, DoABC#2)
// _SafeStr_7576 = "_-0dd" (String#15570, DoABC#2)
// _SafeStr_7578 = "_-2hS" (String#20750, DoABC#2)
// _SafeStr_7580 = "_-YY" (String#23582, DoABC#2)
// IUpdateReceiver = "_-Qe" (String#8218, DoABC#2)
// addSubTask = "_-0mE" (String#15905, DoABC#2)
// HabboErrorVariableEnum = "_-zF" (String#24662, DoABC#2)
// HabboWindowTrackingEvent = "_-1lw" (String#18372, DoABC#2)
// ErrorReportStorage = "_-Yg" (String#8387, DoABC#2)
// setParameter = "_-33Y" (String#21643, DoABC#2)
// getProfilerAgentForReceiver = "_-XH" (String#8354, DoABC#2)
// defaultLinkTarget = "_-354" (String#21699, DoABC#2)
// getActiveWindow = "_-1h8" (String#1744, DoABC#2)
// _SafeStr_9432 = "_-oz" (String#24234, DoABC#2)
// _SafeStr_9435 = "_-2KX" (String#19824, DoABC#2)
// _SafeStr_9468 = "_-0La" (String#14896, DoABC#2)
// getDefaultAttributesByTypeAndStyle = "_-Sn" (String#8262, DoABC#2)
// _SafeStr_9637 = "_-2Xg" (String#1895, DoABC#2)
// _SafeStr_9665 = "_-2sh" (String#7132, DoABC#2)
// windowToXMLString = "_-1D-" (String#841, DoABC#2)
// mouseEventReceived = "_-3K3" (String#7704, DoABC#2)
// addMouseEventTracker = "_-0WZ" (String#1491, DoABC#2)
// removeMouseEventTracker = "_-0Ak" (String#1417, DoABC#2)
// _SafeStr_9783 = "_-1aE" (String#17904, DoABC#2)
// getLayoutByTypeAndStyle = "_-9S" (String#7853, DoABC#2)
// getDefaultsByTypeAndStyle = "_-2ch" (String#6806, DoABC#2)


