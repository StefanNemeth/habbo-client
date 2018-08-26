
package com.sulake.habbo.notifications
{
    import com.sulake.core.runtime.IUpdateReceiver;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.utils.Map;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.components.ITextWindow;
    import com.sulake.core.assets.IAsset;
    import com.sulake.habbo.window.IHabboWindowManager;
    import flash.display.BitmapData;
    import com.sulake.habbo.session.events.BadgeImageReadyEvent;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import flash.geom.Point;
    import com.sulake.core.window.components.IDesktopWindow;
    import com.sulake.core.window.events.WindowMouseEvent;

    public class HabboNotificationItemView implements IUpdateReceiver 
    {

        public static const _SafeStr_12075:int = 70;
        public static const _SafeStr_12099:int = 5;
        private static const _SafeStr_10168:int = 0;
        private static const _SafeStr_12100:int = 1;
        private static const _SafeStr_12101:int = 2;
        private static const _SafeStr_12102:int = 3;

        private var _window:IWindow;
        private var _SafeStr_3764:HabboNotificationItem;
        private var _SafeStr_12103:Boolean = false;
        private var _SafeStr_12066:Map;
        private var _SafeStr_12067:Map;
        private var _SafeStr_12104:uint;
        private var _SafeStr_12105:uint;
        private var _SafeStr_12106:uint;
        private var _verticalPosition:int;
        private var _blend:Number;
        private var _SafeStr_12108:int;
        private var _SafeStr_12109:int;
        private var _state:int;

        public function HabboNotificationItemView(_arg_1:IAsset, _arg_2:IHabboWindowManager, _arg_3:Map, _arg_4:Map, _arg_5:HabboNotificationItem)
        {
            this._SafeStr_12066 = _arg_3;
            this._SafeStr_12067 = _arg_4;
            var _local_6:XmlAsset = (_arg_1 as XmlAsset);
            if (_local_6 == null){
                return;
            };
            this._window = _arg_2.buildFromXML((_local_6.content as XML), 1);
            this._window.tags.push("notificationview");
            this._window.context.getDesktopWindow().addEventListener(WindowEvent.WE_RESIZED, this.onRoomViewResized);
            this._window.procedure = this.onWindowEvent;
            this._window.blend = 0;
            this._window.visible = false;
            var _local_7:ITextWindow = (IWindowContainer(this._window).findChildByTag("notification_text") as ITextWindow);
            if (_local_7 != null){
                this._SafeStr_12108 = (this._window.height - _local_7.rectangle.bottom);
            }
            else {
                this._SafeStr_12108 = 15;
            };
            this._SafeStr_12109 = this._window.height;
            this._verticalPosition = 4;
            this._blend = 0;
            this._state = _SafeStr_10168;
            this.showItem(_arg_5);
        }
        public function get disposed():Boolean
        {
            return ((this._window == null));
        }
        public function get ready():Boolean
        {
            return ((this._state == _SafeStr_10168));
        }
        public function get verticalPosition():int
        {
            return (this._verticalPosition);
        }
        private function showItem(_arg_1:HabboNotificationItem):void
        {
            if (_arg_1 == null){
                return;
            };
            var _local_2:String = _arg_1.content;
            this.setNotificationText(_local_2);
            var _local_3:BitmapData = _arg_1.style.icon;
            this.setNotificationIcon(_local_3);
            this._SafeStr_3764 = _arg_1;
            this.reposition();
            this.startFadeIn();
        }
        public function replaceIcon(_arg_1:BadgeImageReadyEvent):void
        {
            if (_arg_1.badgeId != this._SafeStr_3764.style.iconSrc){
                return;
            };
            if (_arg_1.badgeImage != null){
                this.setNotificationIcon(_arg_1.badgeImage);
            };
        }
        public function update(_arg_1:uint):void
        {
            var _local_2:Number;
            var _local_3:Number;
            switch (this._state){
                case _SafeStr_10168:
                    return;
                case _SafeStr_12100:
                    this._SafeStr_12104 = (this._SafeStr_12104 + _arg_1);
                    _local_2 = (Number(this._SafeStr_12104) / Number(this._SafeStr_12067["time_fade_in"]));
                    if (this._SafeStr_12104 > int(this._SafeStr_12067["time_fade_in"])){
                        this.startDisplay();
                    };
                    this.adjustBlend(_local_2);
                    return;
                case _SafeStr_12101:
                    this._SafeStr_12106 = (this._SafeStr_12106 + _arg_1);
                    if ((((this._SafeStr_12106 > int(this._SafeStr_12067["time_display"]))) && (!(this._SafeStr_12103)))){
                        this.startFadeOut();
                    };
                    return;
                case _SafeStr_12102:
                    this._SafeStr_12105 = (this._SafeStr_12105 + _arg_1);
                    _local_3 = (1 - (Number(this._SafeStr_12105) / Number(this._SafeStr_12067["time_fade_out"])));
                    this.adjustBlend(_local_3);
                    if (this._SafeStr_12105 > int(this._SafeStr_12067["time_fade_in"])){
                        this.startIdling();
                    };
                    return;
            };
        }
        public function dispose():void
        {
            if (this._window != null){
                this._window.dispose();
                this._window = null;
            };
            if (this._SafeStr_3764 != null){
                this._SafeStr_3764.dispose();
                this._SafeStr_3764 = null;
            };
        }
        private function setNotificationText(_arg_1:String):void
        {
            var _local_2:ITextWindow = (IWindowContainer(this._window).findChildByTag("notification_text") as ITextWindow);
            if ((((_local_2 == null)) || ((_arg_1 == null)))){
                return;
            };
            this._window.height = 0;
            _local_2.text = _arg_1;
            _local_2.height = (_local_2.textHeight + this._SafeStr_12108);
            if (this._window.height < this._SafeStr_12109){
                this._window.height = this._SafeStr_12109;
            };
        }
        private function setNotificationIcon(_arg_1:BitmapData):void
        {
            var _local_3:BitmapData;
            var _local_4:int;
            var _local_5:int;
            var _local_6:int;
            var _local_2:IBitmapWrapperWindow = (IWindowContainer(this._window).findChildByTag("notification_icon") as IBitmapWrapperWindow);
            if (_local_2 == null){
                return;
            };
            if (_arg_1 == null){
                _local_2.bitmap = null;
                return;
            };
            if ((((_arg_1.width < _local_2.width)) && ((_arg_1.height < _local_2.height)))){
                _local_3 = new BitmapData(_local_2.width, _local_2.height, true, 0);
                _local_5 = ((_local_2.width - _arg_1.width) / 2);
                _local_6 = ((_local_2.height - _arg_1.height) / 2);
                _local_3.copyPixels(_arg_1, _arg_1.rect, new Point(_local_5, _local_6));
            }
            else {
                if (_arg_1.width < _arg_1.height){
                    _local_3 = new BitmapData(_arg_1.height, _arg_1.height, true, 0);
                    _local_4 = ((_arg_1.height - _arg_1.width) / 2);
                    _local_3.copyPixels(_arg_1, _arg_1.rect, new Point(_local_4, 0));
                }
                else {
                    if (_arg_1.width > _arg_1.height){
                        _local_3 = new BitmapData(_arg_1.width, _arg_1.width, true, 0);
                        _local_4 = ((_arg_1.width - _arg_1.height) / 2);
                        _local_3.copyPixels(_arg_1, _arg_1.rect, new Point(0, _local_4));
                    }
                    else {
                        _local_3 = new BitmapData(_arg_1.width, _arg_1.height);
                        _local_3.copyPixels(_arg_1, _arg_1.rect, new Point(0, 0));
                    };
                };
            };
            _local_2.bitmap = _local_3;
        }
        private function startFadeIn():void
        {
            this._SafeStr_12104 = 0;
            this._state = _SafeStr_12100;
            this._window.visible = true;
        }
        private function startFadeOut():void
        {
            this._SafeStr_12105 = 0;
            this._state = _SafeStr_12102;
        }
        private function startDisplay():void
        {
            this._SafeStr_12106 = 0;
            this._state = _SafeStr_12101;
        }
        private function startIdling():void
        {
            this._state = _SafeStr_10168;
            this._window.visible = false;
        }
        public function reposition(_arg_1:int=-1):void
        {
            if (this._window == null){
                return;
            };
            var _local_2:IDesktopWindow = this._window.context.getDesktopWindow();
            if (_local_2 == null){
                return;
            };
            if (_arg_1 != -1){
                this._verticalPosition = _arg_1;
            };
            this._window.x = ((_local_2.width - this._window.width) - _SafeStr_12099);
            this._window.y = this._verticalPosition;
        }
        public function onWindowEvent(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1 == null){
                return;
            };
            if (_arg_1.type == WindowMouseEvent.WINDOW_EVENT_MOUSE_OVER){
                this._SafeStr_12103 = true;
                Logger.log("notifications - hover on");
            }
            else {
                if (_arg_1.type == WindowMouseEvent.WME_OUT){
                    this._SafeStr_12103 = false;
                    Logger.log("notifications - hover off");
                }
                else {
                    if (_arg_1.type == WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK){
                        if (this._SafeStr_3764 != null){
                            this._SafeStr_3764.ExecuteUiLinks();
                        };
                    };
                };
            };
        }
        private function onRoomViewResized(_arg_1:WindowEvent):void
        {
            this.reposition();
        }
        private function adjustBlend(_arg_1:Number):void
        {
            this._blend = _arg_1;
            if (this._blend > 1){
                this._blend = 1;
            };
            if (this._blend < 0){
                this._blend = 0;
            };
            this._window.blend = this._blend;
        }

    }
}//package com.sulake.habbo.notifications

// _SafeStr_10168 = "_-32Y" (String#7359, DoABC#2)
// _SafeStr_12066 = "_-0JJ" (String#3939, DoABC#2)
// _SafeStr_12067 = "_-1F6" (String#5160, DoABC#2)
// replaceIcon = "_-1sg" (String#18663, DoABC#2)
// showItem = "_-1J5" (String#5224, DoABC#2)
// reposition = "_-2Nm" (String#19956, DoABC#2)
// _SafeStr_12075 = "_-2sv" (String#21195, DoABC#2)
// ExecuteUiLinks = "_-21S" (String#19071, DoABC#2)
// iconSrc = "_-2xt" (String#21388, DoABC#2)
// _SafeStr_12099 = "_-Jd" (String#22990, DoABC#2)
// _SafeStr_12100 = "_-14H" (String#4964, DoABC#2)
// _SafeStr_12101 = "_-8U" (String#22560, DoABC#2)
// _SafeStr_12102 = "_-00H" (String#3568, DoABC#2)
// _SafeStr_12103 = "_-2q9" (String#21087, DoABC#2)
// _SafeStr_12104 = "_-2f-" (String#20645, DoABC#2)
// _SafeStr_12105 = "_-1ne" (String#18447, DoABC#2)
// _SafeStr_12106 = "_-LF" (String#23056, DoABC#2)
// _verticalPosition = "_-2zQ" (String#21437, DoABC#2)
// _SafeStr_12108 = "_-3Le" (String#22351, DoABC#2)
// _SafeStr_12109 = "_-09i" (String#14435, DoABC#2)
// onRoomViewResized = "_-109" (String#4872, DoABC#2)
// onWindowEvent = "_-0zm" (String#4843, DoABC#2)
// setNotificationText = "_-RC" (String#23291, DoABC#2)
// setNotificationIcon = "_-1n2" (String#18424, DoABC#2)
// startFadeIn = "_-04I" (String#14214, DoABC#2)
// startDisplay = "_-1qY" (String#18565, DoABC#2)
// adjustBlend = "_-02s" (String#14154, DoABC#2)
// startFadeOut = "_-0wd" (String#16296, DoABC#2)
// startIdling = "_-2OJ" (String#19979, DoABC#2)
// WindowEvent = "_-Jh" (String#2085, DoABC#2)
// BadgeImageReadyEvent = "_-03M" (String#14177, DoABC#2)
// HabboNotificationItem = "_-0sR" (String#4694, DoABC#2)
// HabboNotificationItemView = "_-0Sb" (String#4151, DoABC#2)
// badgeId = "_-g6" (String#23896, DoABC#2)
// _SafeStr_3764 = "_-1eS" (String#609, DoABC#2)
// WME_OUT = "_-0h2" (String#15712, DoABC#2)
// WE_RESIZED = "_-76" (String#22505, DoABC#2)
// badgeImage = "_-250" (String#19222, DoABC#2)
// _blend = "_-2A2" (String#616, DoABC#2)
// IUpdateReceiver = "_-Qe" (String#8218, DoABC#2)


