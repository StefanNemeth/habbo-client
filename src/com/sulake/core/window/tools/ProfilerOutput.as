
package com.sulake.core.window.tools
{
    import com.sulake.core.runtime.IProfiler;
    import com.sulake.core.runtime.ICore;
    import com.sulake.core.window.components.IFrameWindow;
    import com.sulake.core.window.ICoreWindowManager;
    import com.sulake.core.window.graphics.IWindowRenderer;
    import flash.utils.ByteArray;
    import com.sulake.core.window.components.ILabelWindow;
    import com.sulake.core.runtime.IContext;
    import com.sulake.core.runtime.IIDProfiler;
    import com.sulake.core.runtime.IID;
    import com.sulake.core.runtime.IUnknown;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.components.IItemListWindow;
    import com.sulake.core.window.graphics.GraphicContext;
    import flash.events.Event;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import com.sulake.core.utils.profiler.ProfilerAgentTask;
    import flash.display.BitmapData;
    import flash.geom.Rectangle;
    import flash.geom.Point;
    import com.sulake.core.window.components.ICanvasWindow;

    public class ProfilerOutput implements IDevTool 
    {

        private static var _SafeStr_9660:Class = ProfilerOutput_profiler_dialog_xml;
        private static var _SafeStr_9661:Class = ProfilerOutput_profiler_task_xml;

        private var _disposed:Boolean = false;
        private var _profiler:IProfiler;
        private var _SafeStr_9663:ICore;
        private var _window:IFrameWindow;
        private var _SafeStr_9664:Array;
        private var _windowManager:ICoreWindowManager;
        private var _SafeStr_9665:IWindowRenderer;
        private var _SafeStr_9666:Boolean = false;

        public function ProfilerOutput(_arg_1:IContext, _arg_2:ICoreWindowManager, _arg_3:IWindowRenderer)
        {
            this._SafeStr_9663 = (_arg_1 as ICore);
            this._SafeStr_9664 = new Array();
            this._profiler = this.profiler;
            this._windowManager = _arg_2;
            this._SafeStr_9665 = _arg_3;
            var _local_4:ByteArray = (new _SafeStr_9660() as ByteArray);
            var _local_5:XML = new XML(_local_4.readUTFBytes(_local_4.length));
            this._window = (this._windowManager.buildFromXML(_local_5, 2) as IFrameWindow);
            this._window.visible = false;
            this._window.procedure = this.profilerWindowEventProc;
            this._window.findChildByName("header").caption = (((((((padAlign("task", 28) + "|") + padAlign("#rounds", 8)) + "|") + padAlign("latest ms", 8)) + "|") + padAlign("total ms", 8)) + "|");
            this._window.findChildByName("footer").caption = "<- Click to enable bitmap memory tracking";
            ILabelWindow(this._window.findChildByName("footer")).textColor = 4284900966;
        }
        private static function padAlign(_arg_1:String, _arg_2:int, _arg_3:String=" ", _arg_4:Boolean=false):String
        {
            var _local_5:int = (_arg_2 - _arg_1.length);
            if (_local_5 <= 0){
                return (_arg_1.substring(0, _arg_2));
            };
            var _local_6:String = "";
            var _local_7:int;
            while (_local_7 < _local_5) {
                _local_6 = (_local_6 + _arg_3);
                _local_7++;
            };
            return (((_arg_4) ? (_local_6 + _arg_1) : (_arg_1 + _local_6)));
        }

        public function get caption():String
        {
            return ("Component Profiler");
        }
        public function get disposed():Boolean
        {
            return (this._disposed);
        }
        public function get visible():Boolean
        {
            return (((this._window) && (this._window.visible)));
        }
        public function set visible(value:Boolean):void
        {
            if (value != this.visible){
                this._window.visible = value;
                if (value){
                    this._window.activate();
                    this._SafeStr_9663.setProfilerMode(true);
                    this._SafeStr_9663.queueInterface(new IIDProfiler(), function (_arg_1:IID, _arg_2:IUnknown):void
                    {
                        profiler = (_arg_2 as IProfiler);
                    });
                }
                else {
                    this._SafeStr_9663.setProfilerMode(false);
                };
            };
        }
        public function set profiler(_arg_1:IProfiler):void
        {
            if (this._profiler){
                this._profiler.removeStopEventListener(this.refresh);
                this._profiler = null;
            };
            if (((!(this._profiler)) && (_arg_1))){
                this._profiler = _arg_1;
                this._profiler.addStopEventListener(this.refresh);
            };
        }
        public function get profiler():IProfiler
        {
            return (this._profiler);
        }
        public function dispose():void
        {
            if (!this._disposed){
                this._window.dispose();
                this._window = null;
                this._profiler.removeStopEventListener(this.refresh);
                this._profiler = null;
                this._windowManager = null;
                this._SafeStr_9665 = null;
                this._disposed = true;
            };
        }
        private function profilerWindowEventProc(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type == WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK){
                if (_arg_2.tags.indexOf("close") > -1){
                    this._window.visible = false;
                }
                else {
                    if (_arg_2.name == "button_gc"){
                        this._profiler.gc();
                    };
                };
            };
            if (_arg_2.name == "footer_enable_toggle"){
                if (_arg_1.type == WindowEvent.WE_SELECTED){
                    this._SafeStr_9666 = true;
                    ILabelWindow(this._window.findChildByName("footer")).textColor = 0xFF000000;
                }
                else {
                    if (_arg_1.type == WindowEvent.WE_UNSELECTED){
                        this._SafeStr_9666 = false;
                        ILabelWindow(this._window.findChildByName("footer")).textColor = 4284900966;
                    };
                };
            };
        }
        public function refresh(_arg_1:Event):void
        {
            var _local_2:Array = this._profiler.getProfilerAgentsInArray();
            var _local_3:IItemListWindow = (this._window.findChildByName("list") as IItemListWindow);
            var _local_4:uint;
            while (_local_2.length > 0) {
                _local_4 = this.recursiveRedraw(_local_2.pop(), _local_3, _local_4, 0);
            };
            if (this._SafeStr_9666){
                this._window.findChildByName("footer").caption = ((((((((((((((("Assets - Libraries: " + this._profiler.numAssetLibraryInstances) + " ") + "Bitmaps: ") + this._profiler.numBitmapAssetInstances) + " / ") + this._profiler.numAllocatedBitmapDataBytes) + " bytes \n") + "Windows - Allocated bitmap data: ") + (this._SafeStr_9665.allocatedByteCount + GraphicContext.allocatedByteCount)) + " bytes \n") + "Tracked bitmap data: ") + this._profiler.numTrackedBitmapDataInstances) + " / ") + this._profiler.numTrackedBitmapDataBytes) + " bytes");
            };
        }
        private function recursiveRedraw(_arg_1:ProfilerAgentTask, _arg_2:IItemListWindow, _arg_3:uint, _arg_4:uint):uint
        {
            var _local_5:IWindowContainer;
            if (_arg_3 >= _arg_2.numListItems){
                _local_5 = this.createListItem(_arg_2);
            }
            else {
                _local_5 = (_arg_2.getListItemAt(_arg_3) as IWindowContainer);
            };
            var _local_6:String = _arg_1.name;
            if (_arg_4 > 0){
                _local_6 = padAlign(_local_6, (_arg_4 + _local_6.length), "-", true);
            };
            var _local_7:IWindow = (_local_5.findChildByName("text") as IWindow);
            _local_7.caption = (((((((padAlign(_local_6, 28, " ", false) + "|") + padAlign(String(_arg_1.rounds), 8, " ", true)) + "|") + padAlign(String(_arg_1.latest), 8, " ", true)) + "|") + padAlign(String(_arg_1.total), 8, " ", true)) + "|\r");
            _local_5.findChildByName("caption").caption = _arg_1.caption;
            var _local_8:IBitmapWrapperWindow = (_local_5.findChildByName("canvas") as IBitmapWrapperWindow);
            this.refreshBitmapImage(_local_8, _arg_1);
            _arg_3++;
            var _local_9:uint;
            while (_local_9 < _arg_1.numSubTasks) {
                _arg_3 = this.recursiveRedraw(_arg_1.ProfilerAgentTask(_local_9), _arg_2, _arg_3, (_arg_4 + 1));
                _local_9++;
            };
            return (_arg_3);
        }
        private function refreshBitmapImage(_arg_1:IBitmapWrapperWindow, _arg_2:ProfilerAgentTask):void
        {
            var _local_3:BitmapData = _arg_1.bitmap;
            if (_local_3 == null){
                _local_3 = new BitmapData(_arg_1.width, _arg_1.height, false, 0xFFFFFFFF);
                _arg_1.bitmap = _local_3;
            };
            var _local_4:Rectangle = _local_3.rect;
            var _local_5:int = _arg_2.latest;
            var _local_6:int = (((_local_5 > _local_3.height)) ? _local_3.height : _local_5);
            _local_4.x = (_local_4.x + 1);
            _local_4.width--;
            _local_3.copyPixels(_local_3, _local_4, new Point());
            _local_4.x = (_local_4.x + (_local_4.width - 2));
            _local_4.y = (_local_4.y + (_local_4.height - _local_6));
            _local_4.width = 1;
            _local_4.height = _local_6;
            _local_3.fillRect(_local_4, (((_local_5 > _local_3.height)) ? 0xFFFF0000 : 0xFF0000FF));
            _arg_1.invalidate();
        }
        private function refreshCanvasImage(_arg_1:ICanvasWindow, _arg_2:ProfilerAgentTask):void
        {
            var _local_3:Rectangle = new Rectangle();
            var _local_4:BitmapData = _arg_1.retrieveDrawBuffer(null, _local_3);
            var _local_5:int = _arg_2.latest;
            var _local_6:int = (((_local_5 > _local_4.height)) ? _local_4.height : _local_5);
            _local_3.x = (_local_3.x + 1);
            _local_3.width--;
            _local_4.copyPixels(_local_4, _local_3, new Point());
            _local_3.x = (_local_3.x + (_local_3.width - 2));
            _local_3.y = (_local_3.y + (_local_3.height - _local_6));
            _local_3.width = 1;
            _local_3.height = _local_6;
            _local_4.fillRect(_local_3, (((_local_5 > _local_4.height)) ? 0xFFFF0000 : 0xFF0000FF));
            _arg_1.invalidate();
        }
        private function createListItem(_arg_1:IItemListWindow):IWindowContainer
        {
            var _local_2:ByteArray = (new _SafeStr_9661() as ByteArray);
            var _local_3:XML = new XML(_local_2.readUTFBytes(_local_2.length));
            var _local_4:IWindowContainer = (this._windowManager.buildFromXML(_local_3, 2) as IWindowContainer);
            _arg_1.addListItem(_local_4);
            return (_local_4);
        }

    }
}//package com.sulake.core.window.tools

// IID = "_-3KV" (String#7712, DoABC#2)
// WindowEvent = "_-Jh" (String#2085, DoABC#2)
// IDevTool = "_-3Jf" (String#7697, DoABC#2)
// ProfilerOutput = "_-34L" (String#7396, DoABC#2)
// IIDProfiler = "_-1l" (String#18333, DoABC#2)
// ProfilerAgentTask = "_-0U3" (String#4185, DoABC#2)
// IWindowRenderer = "_-2Oq" (String#6539, DoABC#2)
// IProfiler = "_-Fo" (String#7989, DoABC#2)
// ICanvasWindow = "_-1Ij" (String#1656, DoABC#2)
// ProfilerOutput_profiler_dialog_xml = "_-1ZM" (String#5551, DoABC#2)
// GraphicContext = "_-03R" (String#14179, DoABC#2)
// ProfilerOutput_profiler_task_xml = "_-1AV" (String#5084, DoABC#2)
// ICore = "_-2kX" (String#6966, DoABC#2)
// gc = "_-1mw" (String#5797, DoABC#2)
// refresh = "_-s9" (String#189, DoABC#2)
// WE_SELECTED = "_-17F" (String#16745, DoABC#2)
// ICoreWindowManager = "_-YU" (String#2128, DoABC#2)
// createListItem = "_-mV" (String#2185, DoABC#2)
// WE_UNSELECTED = "_-1D" (String#16982, DoABC#2)
// allocatedByteCount = "_-2p5" (String#7060, DoABC#2)
// rounds = "_-1pu" (String#18538, DoABC#2)
// total = "_-2Ok" (String#19993, DoABC#2)
// latest = "_-0Hv" (String#14754, DoABC#2)
// numSubTasks = "_-25m" (String#19249, DoABC#2)
// ProfilerAgentTask = "_-2T5" (String#20167, DoABC#2)
// addStopEventListener = "_-3A-" (String#7511, DoABC#2)
// padAlign = "_-0pr" (String#4630, DoABC#2)
// removeStopEventListener = "_-1u8" (String#5924, DoABC#2)
// getProfilerAgentsInArray = "_-OW" (String#8173, DoABC#2)
// numAssetLibraryInstances = "_-2Aj" (String#6261, DoABC#2)
// setProfilerMode = "_-hp" (String#8551, DoABC#2)
// numBitmapAssetInstances = "_-lG" (String#8631, DoABC#2)
// numAllocatedBitmapDataBytes = "_-24G" (String#6127, DoABC#2)
// numTrackedBitmapDataInstances = "_-1YE" (String#5524, DoABC#2)
// numTrackedBitmapDataBytes = "_-Lb" (String#8116, DoABC#2)
// retrieveDrawBuffer = "_-ak" (String#8433, DoABC#2)
// _SafeStr_9660 = "_-1rV" (String#18607, DoABC#2)
// _SafeStr_9661 = "_-6y" (String#22498, DoABC#2)
// _profiler = "_-RV" (String#23305, DoABC#2)
// _SafeStr_9663 = "_-2Gg" (String#6381, DoABC#2)
// _SafeStr_9664 = "_-3I8" (String#22207, DoABC#2)
// _SafeStr_9665 = "_-2sh" (String#7132, DoABC#2)
// _SafeStr_9666 = "_-Yz" (String#23599, DoABC#2)
// profilerWindowEventProc = "_-0gR" (String#15690, DoABC#2)
// recursiveRedraw = "_-2KI" (String#19815, DoABC#2)
// refreshBitmapImage = "_-kY" (String#24052, DoABC#2)
// refreshCanvasImage = "_-Vq" (String#23486, DoABC#2)


