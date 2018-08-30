
package com.sulake.habbo.ui.widget.avatarinfo
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.utils.FixedSizeStack;
    import flash.utils.Timer;
    import flash.events.TimerEvent;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.window.IWindow;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetUserActionMessage;
    import com.sulake.core.assets.BitmapDataAsset;
    import flash.display.BitmapData;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import com.sulake.habbo.room.object.RoomObjectTypeEnum;
    import flash.geom.Rectangle;
    import flash.geom.Point;
    import com.sulake.core.assets.XmlAsset;

    public class AvatarInfoView implements IDisposable 
    {

        protected static const _SafeStr_6816:uint = 4281149991;
        protected static const _SafeStr_6817:uint = 4282950861;
        protected static const _SafeStr_6818:uint = 0xFF993300;
        protected static const _SafeStr_6819:uint = 0xFFFFFF;
        protected static const _SafeStr_6820:uint = 9552639;
        protected static const _SafeStr_6821:uint = 0xFFFFFF;
        protected static const _SafeStr_6822:uint = 5789011;
        protected static const _SafeStr_6823:uint = 13947341;
        protected static const _SafeStr_6824:uint = 5789011;
        private static const _SafeStr_6825:int = 25;
        private static const _SafeStr_6826:int = 3;
        protected static var _SafeStr_6827:Boolean = false;

        protected var _window:IWindowContainer;
        protected var _minimizedView:IWindowContainer;
        protected var _activeView:IWindowContainer;
        private var _SafeStr_6830:Boolean;
        protected var _widget:AvatarInfoWidget;
        protected var _userId:int;
        protected var _userName:String;
        protected var _userType:int;
        protected var _allowNameChange:Boolean;
        protected var _roomIndex:int;
        protected var _SafeStr_5951:Boolean;
        protected var _SafeStr_6832:FixedSizeStack;
        protected var _SafeStr_6833:int = -1000000;
        protected var _disposed:Boolean;
        protected var _SafeStr_6834:Timer;
        protected var _SafeStr_6835:int = 3000;
        protected var _SafeStr_6836:Boolean;
        protected var _SafeStr_6837:Boolean;
        protected var _blend:Number;
        protected var _SafeStr_6839:int;
        protected var _SafeStr_6840:int = 500;
        protected var _SafeStr_6841:Boolean;

        public function AvatarInfoView(_arg_1:AvatarInfoWidget)
        {
            this._SafeStr_6832 = new FixedSizeStack(_SafeStr_6825);
            super();
            this._widget = _arg_1;
            this._SafeStr_6841 = true;
            this._SafeStr_6836 = false;
            this._SafeStr_6837 = false;
        }
        public static function setup(_arg_1:AvatarInfoView, _arg_2:int, _arg_3:String, _arg_4:int, _arg_5:int, _arg_6:Boolean=false):void
        {
            _arg_1._userId = _arg_2;
            _arg_1._userName = _arg_3;
            _arg_1._userType = _arg_5;
            _arg_1._roomIndex = _arg_4;
            _arg_1._allowNameChange = _arg_6;
            _arg_1._SafeStr_6836 = false;
            _arg_1._SafeStr_6840 = 500;
            _arg_1._SafeStr_6837 = false;
            _arg_1._blend = 1;
            if (_arg_1._SafeStr_6841){
                if (!_arg_1._SafeStr_6834){
                    _arg_1._SafeStr_6834 = new Timer(_arg_1._SafeStr_6835, 1);
                    _arg_1._SafeStr_6834.addEventListener(TimerEvent.TIMER_COMPLETE, _arg_1.onTimerComplete);
                };
                _arg_1._SafeStr_6834.reset();
                _arg_1._SafeStr_6834.start();
            };
            _arg_1.updateWindow();
        }

        public function get userId():int
        {
            return (this._userId);
        }
        public function get userType():int
        {
            return (this._userType);
        }
        public function get roomIndex():int
        {
            return (this._roomIndex);
        }
        public function get userName():String
        {
            return (this._userName);
        }
        public function get allowNameChange():Boolean
        {
            return (this._allowNameChange);
        }
        public function get disposed():Boolean
        {
            return (this._disposed);
        }
        public function dispose():void
        {
            this._widget = null;
            this._activeView = null;
            if (this._window){
                this._window.dispose();
                this._window = null;
            };
            if (this._minimizedView){
                this._minimizedView.dispose();
                this._minimizedView = null;
            };
            if (this._SafeStr_6834){
                this._SafeStr_6834.removeEventListener(TimerEvent.TIMER_COMPLETE, this.onTimerComplete);
                this._SafeStr_6834.reset();
                this._SafeStr_6834 = null;
            };
            this._disposed = true;
        }
        private function onTimerComplete(_arg_1:TimerEvent):void
        {
            this._SafeStr_6837 = true;
            this._SafeStr_6839 = 0;
            this.hide(true);
        }
        protected function addMouseClickListener(_arg_1:IWindow, _arg_2:Function):void
        {
            if (_arg_1 != null){
                _arg_1.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, _arg_2);
            };
        }
        protected function updateWindow():void
        {
            var _local_2:XML;
            var _local_3:IWindow;
            if (((((!(this._widget)) || (!(this._widget.assets)))) || (!(this._widget.windowManager)))){
                return;
            };
            if (!this._window){
                _local_2 = (this._widget.assets.getAssetByName("avatar_info_widget").content as XML);
                this._window = (this._widget.windowManager.buildFromXML(_local_2, 0) as IWindowContainer);
                if (!this._window){
                    return;
                };
            };
            var _local_1:IWindow = this._window.findChildByName("name");
            _local_1.caption = this._userName;
            if (!this._allowNameChange){
                this._window.findChildByName("change_name_container").visible = false;
                this._window.height = 39;
                this._window.width = (32 + _local_1.width);
            }
            else {
                _local_3 = this._window.findChildByName("change_name_container");
                _local_3.visible = true;
                this._window.height = (39 + _local_3.height);
                this.addMouseClickListener(this._window.findChildByName("change_name_container"), this.clickHandler);
            };
            this.activeView = this._window;
        }
        protected function clickHandler(_arg_1:WindowMouseEvent):void
        {
            this._widget.messageListener.processWidgetMessage(new RoomWidgetUserActionMessage(RoomWidgetUserActionMessage.RWUAM_START_NAME_CHANGE));
            this._widget.removeView(this, false);
        }
        public function setImageAsset(_arg_1:IBitmapWrapperWindow, _arg_2:String):void
        {
            if (((((!(_arg_1)) || (!(this._widget)))) || (!(this._widget.assets)))){
                return;
            };
            var _local_3:BitmapDataAsset = (this._widget.assets.getAssetByName(_arg_2) as BitmapDataAsset);
            if (!_local_3){
                return;
            };
            var _local_4:BitmapData = (_local_3.content as BitmapData);
            if (!_local_4){
                return;
            };
            if (_arg_1.bitmap){
                _arg_1.bitmap.fillRect(_arg_1.bitmap.rect, 0);
            }
            else {
                _arg_1.bitmap = new BitmapData(_arg_1.width, _arg_1.height, true, 0);
            };
            _arg_1.bitmap.draw(_local_4);
        }
        public function show():void
        {
            if (this._activeView != null){
                this._widget.windowManager.getDesktop(0).addChild(this._activeView);
                this._activeView.visible = true;
                this._activeView.activate();
            };
        }
        public function hide(_arg_1:Boolean):void
        {
            if (this._activeView != null){
                if (((!(this._SafeStr_6836)) && (_arg_1))){
                    this._SafeStr_6836 = true;
                    this._SafeStr_6834.start();
                }
                else {
                    this._activeView.visible = false;
                    this._activeView.parent = null;
                };
            };
        }
        public function update(_arg_1:Rectangle, _arg_2:Point, _arg_3:uint):void
        {
            var _local_4:int;
            var _local_5:int;
            var _local_6:int;
            var _local_7:int;
            if (!_arg_1){
                return;
            };
            if (!this._activeView){
                this.updateWindow();
            };
            if (this._SafeStr_6837){
                this._SafeStr_6839 = (this._SafeStr_6839 + _arg_3);
                this._blend = (1 - (this._SafeStr_6839 / Number(this._SafeStr_6840)));
            }
            else {
                this._blend = 1;
            };
            if (this._blend <= 0){
                this._widget.removeView(this, false);
                return;
            };
            if (((!(this._SafeStr_5951)) || (this._SafeStr_6830))){
                _local_4 = -(this._activeView.height);
                if ((((this._userType == RoomObjectTypeEnum._SafeStr_3740)) || ((this._userType == RoomObjectTypeEnum._SafeStr_3749)))){
                    _local_4 = (_local_4 + (((_arg_1.height > 50)) ? 25 : 0));
                }
                else {
                    _local_4 = (_local_4 - 4);
                };
                _local_5 = (_arg_2.y - _arg_1.top);
                this._SafeStr_6832.addValue(_local_5);
                _local_6 = this._SafeStr_6832.getMax();
                if (_local_6 < (this._SafeStr_6833 - _SafeStr_6826)){
                    _local_6 = (this._SafeStr_6833 - _SafeStr_6826);
                };
                _local_7 = (_arg_2.y - _local_6);
                this._SafeStr_6833 = _local_6;
                this._activeView.x = (_arg_2.x - (this._activeView.width / 2));
                this._activeView.y = (_local_7 + _local_4);
                this._SafeStr_6830 = false;
            };
            this._activeView.blend = this._blend;
            this.show();
        }
        protected function onMouseHoverEvent(_arg_1:WindowMouseEvent):void
        {
            if (_arg_1.type == WindowMouseEvent.WINDOW_EVENT_MOUSE_OVER){
                this._SafeStr_5951 = true;
            }
            else {
                if (_arg_1.type == WindowMouseEvent.WME_OUT){
                    if (!_arg_1.window.hitTestGlobalPoint(new Point(_arg_1.stageX, _arg_1.stageY))){
                        this._SafeStr_5951 = false;
                    };
                };
            };
        }
        protected function setMinimized(_arg_1:Boolean):void
        {
            _SafeStr_6827 = _arg_1;
            this._SafeStr_6830 = true;
            this.updateWindow();
        }
        protected function getMinimizedView():IWindowContainer
        {
            var _local_1:XML;
            if (!this._minimizedView){
                _local_1 = (XmlAsset(this._widget.assets.getAssetByName("minimized_menu")).content as XML);
                this._minimizedView = (this._widget.windowManager.buildFromXML(_local_1, 0) as IWindowContainer);
                this._minimizedView.findChildByName("minimize").addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onMaximize);
                this._minimizedView.findChildByName("minimize").addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_OVER, this.onMinimizeHover);
                this._minimizedView.findChildByName("minimize").addEventListener(WindowMouseEvent.WME_OUT, this.onMinimizeHover);
                this._minimizedView.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_OVER, this.onMouseHoverEvent);
                this._minimizedView.addEventListener(WindowMouseEvent.WME_OUT, this.onMouseHoverEvent);
            };
            return (this._minimizedView);
        }
        private function onMaximize(_arg_1:WindowMouseEvent):void
        {
            this.setMinimized(false);
        }
        protected function set activeView(_arg_1:IWindowContainer):void
        {
            if (!_arg_1){
                return;
            };
            if (this._activeView){
                this._activeView.parent = null;
            };
            this._activeView = _arg_1;
        }
        protected function onMinimize(_arg_1:WindowMouseEvent):void
        {
            this.setMinimized(true);
        }
        protected function onMinimizeHover(_arg_1:WindowMouseEvent):void
        {
            var _local_3:IWindow;
            var _local_2:IWindowContainer = (_arg_1.window as IWindowContainer);
            if (_local_2){
                _local_3 = _local_2.findChildByName("icon");
                if (_local_3){
                    if (_arg_1.type == WindowMouseEvent.WINDOW_EVENT_MOUSE_OVER){
                        _local_3.color = _SafeStr_6817;
                    }
                    else {
                        _local_3.color = 0xFFFFFF;
                    };
                };
            };
        }

    }
}//package com.sulake.habbo.ui.widget.avatarinfo

// BitmapDataAsset = "_-0PB" (String#4074, DoABC#2)
// AvatarInfoWidget = "_-3Bt" (String#7549, DoABC#2)
// RoomObjectTypeEnum = "_-2hK" (String#20744, DoABC#2)
// RoomWidgetUserActionMessage = "_-22U" (String#19109, DoABC#2)
// AvatarInfoView = "_-1fg" (String#5659, DoABC#2)
// IDisposable = "_-0dY" (String#4382, DoABC#2)
// FixedSizeStack = "_-0Ks" (String#3972, DoABC#2)
// _userType = "_-1N3" (String#1672, DoABC#2)
// userType = "_-0Dh" (String#14596, DoABC#2)
// RWUAM_START_NAME_CHANGE = "_-21I" (String#19065, DoABC#2)
// _SafeStr_3740 = "_-39-" (String#21844, DoABC#2)
// _SafeStr_3749 = "_-1aR" (String#17911, DoABC#2)
// _roomIndex = "_-1S2" (String#362, DoABC#2)
// WME_OUT = "_-0h2" (String#15712, DoABC#2)
// clickHandler = "_-34y" (String#630, DoABC#2)
// addValue = "_-0YF" (String#15367, DoABC#2)
// getMax = "_-pu" (String#24268, DoABC#2)
// _SafeStr_5951 = "_-1Ge" (String#5180, DoABC#2)
// addMouseClickListener = "_-10B" (String#595, DoABC#2)
// setImageAsset = "_-3-s" (String#21496, DoABC#2)
// allowNameChange = "_-KQ" (String#23022, DoABC#2)
// _SafeStr_6816 = "_-9d" (String#22605, DoABC#2)
// _SafeStr_6817 = "_-31y" (String#21577, DoABC#2)
// _SafeStr_6818 = "_-0YQ" (String#15376, DoABC#2)
// _SafeStr_6819 = "_-05y" (String#14281, DoABC#2)
// _SafeStr_6820 = "_-gZ" (String#23915, DoABC#2)
// _SafeStr_6821 = "_-00J" (String#14067, DoABC#2)
// _SafeStr_6822 = "_-RS" (String#23302, DoABC#2)
// _SafeStr_6823 = "_-3Ac" (String#21905, DoABC#2)
// _SafeStr_6824 = "_-3Hu" (String#22198, DoABC#2)
// _SafeStr_6825 = "_-0FW" (String#14666, DoABC#2)
// _SafeStr_6826 = "_-2If" (String#19754, DoABC#2)
// _SafeStr_6827 = "_-0Pc" (String#4085, DoABC#2)
// _minimizedView = "_-3Gz" (String#22162, DoABC#2)
// _activeView = "_-0q0" (String#16052, DoABC#2)
// _SafeStr_6830 = "_-0fx" (String#15668, DoABC#2)
// _allowNameChange = "_-21h" (String#1802, DoABC#2)
// _SafeStr_6832 = "_-08V" (String#14386, DoABC#2)
// _SafeStr_6833 = "_-z0" (String#24650, DoABC#2)
// _SafeStr_6834 = "_-2nP" (String#20974, DoABC#2)
// _SafeStr_6835 = "_-20o" (String#19044, DoABC#2)
// _SafeStr_6836 = "_-0zv" (String#16423, DoABC#2)
// _SafeStr_6837 = "_-096" (String#14413, DoABC#2)
// _blend = "_-2A2" (String#616, DoABC#2)
// _SafeStr_6839 = "_-2dx" (String#6832, DoABC#2)
// _SafeStr_6840 = "_-1QZ" (String#17535, DoABC#2)
// _SafeStr_6841 = "_-Jp" (String#22999, DoABC#2)
// onTimerComplete = "_-085" (String#14369, DoABC#2)
// updateWindow = "_-2s1" (String#451, DoABC#2)
// activeView = "_-2aO" (String#20459, DoABC#2)
// onMouseHoverEvent = "_-k9" (String#24042, DoABC#2)
// setMinimized = "_-2Cz" (String#6306, DoABC#2)
// getMinimizedView = "_-03T" (String#14180, DoABC#2)
// onMaximize = "_-0aM" (String#15452, DoABC#2)
// onMinimizeHover = "_-DL" (String#22744, DoABC#2)
// onMinimize = "_-1Gr" (String#17145, DoABC#2)


