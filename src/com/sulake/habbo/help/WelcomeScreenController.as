
package com.sulake.habbo.help
{
    import com.sulake.core.runtime.IUpdateReceiver;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.core.window.IWindowContainer;
    import flash.geom.Point;
    import com.sulake.habbo.toolbar.events.HabboToolbarEvent;
    import com.sulake.core.window.components.ITextWindow;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import com.sulake.core.assets.BitmapDataAsset;
    import flash.display.BitmapData;
    import com.sulake.core.window.components.IFrameWindow;
    import com.sulake.core.window.enum.WindowParam;
    import com.sulake.core.window.events.WindowMouseEvent;

    public class WelcomeScreenController implements IUpdateReceiver 
    {

        private var _SafeStr_11411:HabboHelp;
        private var _windowManager:IHabboWindowManager;
        private var _disposed:Boolean;
        private var _window:IWindowContainer;
        private var _realTargetLoc:Point;
        private var _SafeStr_11485:WelcomeNotification;

        public function WelcomeScreenController(_arg_1:HabboHelp, _arg_2:IHabboWindowManager)
        {
            this._realTargetLoc = new Point(72, 10);
            super();
            this._SafeStr_11411 = _arg_1;
            this._windowManager = _arg_2;
        }
        public function get disposed():Boolean
        {
            return (this._disposed);
        }
        public function dispose():void
        {
            if (this._SafeStr_11411){
                this._SafeStr_11411.removeUpdateReceiver(this);
                this._SafeStr_11411.toolbar.events.removeEventListener(HabboToolbarEvent.HTE_TOOLBAR_CLICK, this.RoomEngine);
                this._SafeStr_11411 = null;
            };
            this._windowManager = null;
            if (this._window){
                this._window.dispose();
                this._window = null;
            };
            this._SafeStr_11485 = null;
            this._disposed = true;
        }
        public function showWelcomeScreen(_arg_1:WelcomeNotification):void
        {
            if (this._disposed){
                return;
            };
            this._SafeStr_11485 = _arg_1;
            this._SafeStr_11411.toolbar.events.addEventListener(HabboToolbarEvent.HTE_TOOLBAR_CLICK, this.RoomEngine);
            if (this._window == null){
                this.WelcomeScreenController();
            };
            var _local_2:ITextWindow = ITextWindow(this._window.findChildByName("text"));
            _local_2.caption = this._SafeStr_11411.localization.getKey(_arg_1.localizationKey);
            _local_2.height = (_local_2.textHeight + 5);
            this._realTargetLoc.y = (this._SafeStr_11411.toolbar.getIconVerticalLocation(_arg_1.targetIconId) - (this._window.height / 2));
            this._window.y = this._realTargetLoc.y;
            var _local_3:IWindow = this._window.findChildByName("arrow");
            _local_3.y = ((this._window.height - _local_3.height) / 2);
            this._window.x = -(this._window.width);
            this.WelcomeScreenController();
            this._window.visible = true;
            this._window.activate();
        }
        private function WelcomeScreenController():void
        {
            var _local_1:XmlAsset = (this._SafeStr_11411.assets.getAssetByName("welcome_screen_xml") as XmlAsset);
            this._window = (this._windowManager.buildFromXML((_local_1.content as XML), 2) as IWindowContainer);
            var _local_2:IBitmapWrapperWindow = (this._window.findChildByName("arrow") as IBitmapWrapperWindow);
            var _local_3:BitmapDataAsset = (this._SafeStr_11411.assets.getAssetByName("welcome_screen_arrow") as BitmapDataAsset);
            _local_2.bitmap = (_local_3.content as BitmapData).clone();
            var _local_4:IFrameWindow = (this._window.findChildByName("frame") as IFrameWindow);
            _local_4.header.visible = false;
            _local_4.content.y = (_local_4.content.y - 20);
            var _local_5:ITextWindow = (this._window.findChildByName("text") as ITextWindow);
            _local_5.height = (_local_5.textHeight + 5);
            _local_4.content.setParamFlag(WindowParam._SafeStr_7460, false);
            _local_4.height = (_local_4.height - 20);
            this._window.findChildByName("close").addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.WelcomeScreenController);
        }
        private function WelcomeScreenController(_arg_1:WindowMouseEvent):void
        {
            this.WelcomeScreenController();
        }
        private function RoomEngine(_arg_1:HabboToolbarEvent):void
        {
            this.WelcomeScreenController();
        }
        private function WelcomeScreenController():void
        {
            if (!this._window){
                return;
            };
            this._window.visible = false;
            this.dispose();
        }
        public function update(_arg_1:uint):void
        {
            var _local_3:Point;
            if (this._window == null){
                this._SafeStr_11411.removeUpdateReceiver(this);
                return;
            };
            var _local_2:Number = Point.distance(this._window.rectangle.topLeft, this._realTargetLoc);
            if (_local_2 > 5){
                _local_3 = Point.interpolate(this._window.rectangle.topLeft, this._realTargetLoc, 0.5);
                this._window.x = _local_3.x;
                this._window.y = _local_3.y;
            }
            else {
                this._window.x = this._realTargetLoc.x;
                this._window.y = this._realTargetLoc.y;
                this._SafeStr_11411.removeUpdateReceiver(this);
            };
        }
        private function WelcomeScreenController():void
        {
            this._SafeStr_11411.removeUpdateReceiver(this);
            this._SafeStr_11411.IContext(this, 10);
        }

    }
}//package com.sulake.habbo.help

// _SafeStr_11411 = "_-0kl" (String#822, DoABC#2)
// targetIconId = "_-1LJ" (String#17325, DoABC#2)
// _SafeStr_11485 = "_-22W" (String#6098, DoABC#2)
// showWelcomeScreen = "_-QV" (String#8213, DoABC#2)
// WelcomeScreenController = "_-0p1" (String#16015, DoABC#2)
// getIconVerticalLocation = "_-1P2" (String#5334, DoABC#2)
// WelcomeScreenController = "_-0HM" (String#14734, DoABC#2)
// WelcomeScreenController = "_-WP" (String#23506, DoABC#2)
// BitmapDataAsset = "_-0PB" (String#4074, DoABC#2)
// WelcomeNotification = "_-ka" (String#8616, DoABC#2)
// WelcomeScreenController = "_-08g" (String#3733, DoABC#2)
// RoomEngine = "_-hN" (String#941, DoABC#2)
// WelcomeScreenController = "_-0Kd" (String#584, DoABC#2)
// IContext = "_-35P" (String#7415, DoABC#2)
// HTE_TOOLBAR_CLICK = "_-22-" (String#19089, DoABC#2)
// _SafeStr_7460 = "_-ZZ" (String#23619, DoABC#2)
// IUpdateReceiver = "_-Qe" (String#8218, DoABC#2)
// _realTargetLoc = "_-0bq" (String#1509, DoABC#2)


