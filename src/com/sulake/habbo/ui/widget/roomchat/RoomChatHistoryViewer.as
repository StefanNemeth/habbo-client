
package com.sulake.habbo.ui.widget.roomchat
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.core.window.components.IScrollbarWindow;
    import com.sulake.core.window.components.IItemListWindow;
    import com.sulake.habbo.window.enum.HabboWindowType;
    import com.sulake.habbo.window.enum.HabboWindowStyle;
    import com.sulake.habbo.window.enum.HabboWindowParam;
    import flash.geom.Rectangle;
    import com.sulake.core.window.components.IScrollableWindow;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.assets.IAssetLibrary;
    import flash.display.DisplayObject;
    import flash.display.Stage;
    import flash.events.MouseEvent;

    public class RoomChatHistoryViewer implements IDisposable 
    {

        private static const _SafeStr_14230:int = 18;
        private static const SCROLLBAR_WIDTH:int = 20;
        public static const _SafeStr_14224:int = 3;

        private var _SafeStr_14231:RoomChatHistoryPulldown;
        private var _active:Boolean = false;
        private var _SafeStr_14233:Number = -1;
        private var _SafeStr_14234:IScrollbarWindow;
        private var _SafeStr_14235:Number = 1;
        private var _disabled:Boolean = false;
        private var _widget:RoomChatWidget;
        private var _disposed:Boolean = false;
        private var _SafeStr_14236:Boolean = false;
        private var _SafeStr_14237:Boolean = false;

        public function RoomChatHistoryViewer(_arg_1:RoomChatWidget, _arg_2:IHabboWindowManager, _arg_3:IWindowContainer, _arg_4:IAssetLibrary)
        {
            this._disposed = false;
            this._widget = _arg_1;
            this._SafeStr_14231 = new RoomChatHistoryPulldown(_arg_1, _arg_2, _arg_3, _arg_4);
            this._SafeStr_14231.state = RoomChatHistoryPulldown._SafeStr_14238;
            var _local_5:IItemListWindow = (_arg_3.getChildByName("chat_contentlist") as IItemListWindow);
            if (_local_5 == null){
                return;
            };
            _arg_3.removeChild(_local_5);
            _arg_3.addChild(_local_5);
            this._SafeStr_14234 = (_arg_2.createWindow("chatscroller", "", HabboWindowType._SafeStr_7527, HabboWindowStyle._SafeStr_4662, (HabboWindowParam._SafeStr_6023 | HabboWindowParam._SafeStr_4662), new Rectangle((_arg_3.rectangle.right - SCROLLBAR_WIDTH), _arg_3.y, SCROLLBAR_WIDTH, (_arg_3.height - RoomChatHistoryPulldown._SafeStr_14178)), null, 0) as IScrollbarWindow);
            _arg_3.addChild(this._SafeStr_14234);
            this._SafeStr_14234.visible = false;
            this._SafeStr_14234.scrollable = (_local_5 as IScrollableWindow);
        }
        public function set disabled(_arg_1:Boolean):void
        {
            this._disabled = _arg_1;
        }
        public function set visible(_arg_1:Boolean):void
        {
            if (this._SafeStr_14231 == null){
                return;
            };
            this._SafeStr_14231.state = (((_arg_1)==true) ? RoomChatHistoryPulldown._SafeStr_14239 : RoomChatHistoryPulldown._SafeStr_14238);
        }
        public function get active():Boolean
        {
            return (this._active);
        }
        public function get scrollbarWidth():Number
        {
            return (((this._active) ? SCROLLBAR_WIDTH : 0));
        }
        public function get pulldownBarHeight():Number
        {
            return (RoomChatHistoryPulldown._SafeStr_14178);
        }
        public function get disposed():Boolean
        {
            return (this._disposed);
        }
        public function get visible():Boolean
        {
            if (this._SafeStr_14231 == null){
                return (false);
            };
            return ((((this._SafeStr_14231.state == RoomChatHistoryPulldown._SafeStr_14239)) || ((this._SafeStr_14231.state == RoomChatHistoryPulldown._SafeStr_12100))));
        }
        public function dispose():void
        {
            this.RoomChatWidget();
            if (this._SafeStr_14234 != null){
                this._SafeStr_14234.dispose();
                this._SafeStr_14234 = null;
            };
            if (this._SafeStr_14231 != null){
                this._SafeStr_14231.dispose();
                this._SafeStr_14231 = null;
            };
            this._disposed = true;
        }
        public function update(_arg_1:uint):void
        {
            if (this._SafeStr_14231 != null){
                this._SafeStr_14231.update(_arg_1);
            };
            this.RoomChatHistoryViewer();
        }
        public function RoomChatHistoryViewer():void
        {
            if (this._active){
                this.RoomChatWidget();
            }
            else {
                this.RoomChatHistoryViewer();
            };
        }
        public function RoomChatWidget():void
        {
            this._SafeStr_14235 = 1;
            this.RoomChatHistoryViewer();
            this._active = false;
            this.RoomChatHistoryViewer(false);
            this._SafeStr_14231.state = RoomChatHistoryPulldown._SafeStr_14238;
            if (this._widget != null){
                this._widget.RoomChatWidget();
                this._widget.RoomChatWidget();
            };
        }
        public function RoomChatHistoryViewer():void
        {
            var _local_1:RoomChatItem;
            var _local_2:int;
            var _local_3:IWindowContainer;
            if (((!(this._active)) && (!(this._disabled)))){
                this._active = true;
                this.RoomChatHistoryViewer(true);
                this._SafeStr_14231.state = RoomChatHistoryPulldown._SafeStr_14239;
                if (this._widget != null){
                    this._widget.RoomChatWidget();
                    this._widget.RoomChatWidget();
                };
            };
        }
        private function RoomChatHistoryViewer(_arg_1:Boolean):void
        {
            if (this._SafeStr_14234 != null){
                this._SafeStr_14234.visible = _arg_1;
                if (_arg_1){
                    this._SafeStr_14234.scrollV = 1;
                    this._SafeStr_14235 = 1;
                }
                else {
                    this._active = false;
                    this._SafeStr_14233 = -1;
                };
            };
        }
        public function RoomChatHistoryViewer(_arg_1:Rectangle, _arg_2:Boolean=false):void
        {
            if (this._SafeStr_14234 != null){
                this._SafeStr_14234.x = ((_arg_1.x + _arg_1.width) - this._SafeStr_14234.width);
                this._SafeStr_14234.y = _arg_1.y;
                this._SafeStr_14234.height = (_arg_1.height - RoomChatHistoryPulldown._SafeStr_14178);
                if (_arg_2){
                    this._SafeStr_14234.scrollV = this._SafeStr_14235;
                };
            };
            if (this._SafeStr_14231 != null){
                this._SafeStr_14231.RoomChatHistoryViewer(_arg_1);
            };
        }
        private function RoomChatHistoryViewer(_arg_1:Number, _arg_2:Boolean=false):void
        {
            var _local_3:Number;
            var _local_4:Number;
            var _local_5:Number;
            var _local_6:int;
            var _local_7:Boolean;
            var _local_8:Boolean;
            if ((((this._SafeStr_14233 > 0)) && (_arg_2))){
                if (this._SafeStr_14237){
                    if (Math.abs((_arg_1 - this._SafeStr_14233)) > _SafeStr_14224){
                        this._SafeStr_14237 = false;
                    }
                    else {
                        return;
                    };
                };
                if (!this._active){
                    this._widget.RoomChatWidget();
                    this.RoomChatHistoryViewer();
                    this.RoomChatHistoryViewer();
                };
                if (this._active){
                    this.RoomChatHistoryViewer();
                    _local_4 = (this._SafeStr_14234.scrollable.scrollableRegion.height / this._SafeStr_14234.scrollable.visibleRegion.height);
                    _local_5 = ((_arg_1 - this._SafeStr_14233) / this._SafeStr_14234.height);
                    _local_3 = (this._SafeStr_14235 - (_local_5 / _local_4));
                    _local_3 = Math.max(0, _local_3);
                    _local_3 = Math.min(1, _local_3);
                    _local_6 = (_arg_1 - this._SafeStr_14233);
                    _local_7 = true;
                    _local_8 = true;
                    if (this._SafeStr_14234.scrollV < (1 - (_SafeStr_14230 / this._SafeStr_14234.scrollable.scrollableRegion.height))){
                        _local_8 = false;
                    };
                    if (((_local_8) || (this._SafeStr_14236))){
                        this._widget.RoomChatWidget(_local_6);
                        _local_7 = false;
                        this._SafeStr_14234.scrollV = 1;
                    };
                    if (_local_7){
                        this._SafeStr_14235 = _local_3;
                    };
                    this._SafeStr_14233 = _arg_1;
                };
            }
            else {
                this._SafeStr_14233 = -1;
            };
        }
        public function RoomChatHistoryViewer(_arg_1:Number, _arg_2:Boolean=false):void
        {
            var _local_3:DisplayObject;
            var _local_4:Stage;
            this._SafeStr_14233 = _arg_1;
            this._SafeStr_14236 = _arg_2;
            this._SafeStr_14237 = true;
            if (this._SafeStr_14234 != null){
                this._SafeStr_14235 = this._SafeStr_14234.scrollV;
            };
            if (this._SafeStr_14234 != null){
                _local_3 = this._SafeStr_14234.context.getDesktopWindow().getDisplayObject();
                if (_local_3 != null){
                    _local_4 = _local_3.stage;
                    if (_local_4 != null){
                        _local_4.addEventListener(MouseEvent.MOUSE_MOVE, this.RoomChatHistoryViewer);
                        _local_4.addEventListener(MouseEvent.MOUSE_UP, this.RoomChatHistoryViewer);
                    };
                };
            };
        }
        public function RoomChatHistoryViewer():void
        {
            var _local_1:DisplayObject;
            var _local_2:Stage;
            this._SafeStr_14233 = -1;
            if (this._SafeStr_14234 != null){
                _local_1 = this._SafeStr_14234.context.getDesktopWindow().getDisplayObject();
                if (_local_1 != null){
                    _local_2 = _local_1.stage;
                    if (_local_2 != null){
                        _local_2.removeEventListener(MouseEvent.MOUSE_MOVE, this.RoomChatHistoryViewer);
                        _local_2.removeEventListener(MouseEvent.MOUSE_UP, this.RoomChatHistoryViewer);
                    };
                };
            };
        }
        private function RoomChatHistoryViewer():void
        {
            if (!this._active){
                return;
            };
            if (this._SafeStr_14233 == -1){
                return;
            };
            if (this._SafeStr_14236){
                return;
            };
            var _local_1:Number = (this._SafeStr_14235 - this._SafeStr_14234.scrollV);
            if (_local_1 == 0){
                return;
            };
            if (Math.abs(_local_1) < 0.01){
                this._SafeStr_14234.scrollV = this._SafeStr_14235;
            }
            else {
                this._SafeStr_14234.scrollV = (this._SafeStr_14234.scrollV + (_local_1 / 2));
            };
        }
        private function RoomChatHistoryViewer(_arg_1:MouseEvent):void
        {
            this.RoomChatHistoryViewer();
            if (this._widget != null){
                this._widget.RoomChatWidget();
            };
        }
        private function RoomChatHistoryViewer(_arg_1:MouseEvent):void
        {
            this.RoomChatHistoryViewer(_arg_1.stageY, _arg_1.buttonDown);
        }

    }
}//package com.sulake.habbo.ui.widget.roomchat

// _SafeStr_12100 = "_-14H" (String#4964, DoABC#2)
// IScrollableWindow = "_-2R2" (String#1880, DoABC#2)
// _SafeStr_14178 = "_-fB" (String#23854, DoABC#2)
// pulldownBarHeight = "_-0S" (String#15135, DoABC#2)
// scrollbarWidth = "_-Pt" (String#23244, DoABC#2)
// RoomChatWidget = "_-0vm" (String#16266, DoABC#2)
// RoomChatHistoryViewer = "_-7s" (String#22537, DoABC#2)
// RoomChatWidget = "_-2XN" (String#20337, DoABC#2)
// RoomChatWidget = "_-ZU" (String#23615, DoABC#2)
// RoomChatHistoryViewer = "_-39s" (String#21880, DoABC#2)
// RoomChatHistoryViewer = "_-1DA" (String#16988, DoABC#2)
// RoomChatHistoryViewer = "_-nM" (String#24165, DoABC#2)
// RoomChatWidget = "_-1Aa" (String#16882, DoABC#2)
// RoomChatWidget = "_-1-c" (String#16451, DoABC#2)
// _SafeStr_14224 = "_-1AK" (String#16874, DoABC#2)
// RoomChatWidget = "_-0IF" (String#14768, DoABC#2)
// RoomChatWidget = "_-2-H" (String#18981, DoABC#2)
// RoomChatWidget = "_-02Z" (String#14145, DoABC#2)
// _SafeStr_14230 = "_-1GZ" (String#17137, DoABC#2)
// _SafeStr_14231 = "_-1Dy" (String#17023, DoABC#2)
// _active = "_-2pp" (String#21075, DoABC#2)
// _SafeStr_14233 = "_-Ee" (String#22800, DoABC#2)
// _SafeStr_14234 = "_-08u" (String#14402, DoABC#2)
// _SafeStr_14235 = "_-1uD" (String#18725, DoABC#2)
// _SafeStr_14236 = "_-2sR" (String#21176, DoABC#2)
// _SafeStr_14237 = "_-0cT" (String#15533, DoABC#2)
// _SafeStr_14238 = "_-1iW" (String#18228, DoABC#2)
// _SafeStr_14239 = "_-bs" (String#23709, DoABC#2)
// RoomChatHistoryViewer = "_-17-" (String#16735, DoABC#2)
// RoomChatHistoryViewer = "_-0td" (String#16186, DoABC#2)
// RoomChatHistoryViewer = "_-1ss" (String#18671, DoABC#2)
// RoomChatHistoryViewer = "_-7r" (String#22536, DoABC#2)
// RoomChatHistoryViewer = "_-2E0" (String#19568, DoABC#2)
// HabboWindowParam = "_-29D" (String#6233, DoABC#2)
// HabboWindowStyle = "_-0E1" (String#14608, DoABC#2)
// HabboWindowType = "_-29U" (String#19384, DoABC#2)
// IScrollbarWindow = "_-2fP" (String#1920, DoABC#2)
// RoomChatWidget = "_-Yb" (String#8385, DoABC#2)
// RoomChatHistoryViewer = "_-0ZO" (String#4288, DoABC#2)
// RoomChatHistoryPulldown = "_-0uL" (String#4732, DoABC#2)
// RoomChatItem = "_-2kD" (String#6959, DoABC#2)
// IDisposable = "_-0dY" (String#4382, DoABC#2)
// scrollableRegion = "_-2ku" (String#6976, DoABC#2)
// _disposed = "_-6m" (String#31, DoABC#2)
// _SafeStr_4662 = "_-0g1" (String#15673, DoABC#2)
// _disabled = "_-2lG" (String#1933, DoABC#2)
// _SafeStr_6023 = "_-Mr" (String#23121, DoABC#2)
// _SafeStr_7527 = "_-3Gx" (String#22160, DoABC#2)
// visibleRegion = "_-MK" (String#8129, DoABC#2)
// RoomChatHistoryViewer = "_-2UW" (String#6655, DoABC#2)


