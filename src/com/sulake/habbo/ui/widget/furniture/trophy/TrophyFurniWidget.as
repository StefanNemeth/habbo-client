
package com.sulake.habbo.ui.widget.furniture.trophy
{
    import com.sulake.habbo.ui.widget.RoomWidgetBase;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.ui.IRoomWidgetHandler;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.habbo.ui.widget.events.RoomWidgetTrophyDataUpdateEvent;
    import flash.events.IEventDispatcher;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.components.ITextWindow;
    import com.sulake.core.assets.BitmapDataAsset;
    import flash.display.BitmapData;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import com.sulake.core.assets.IAsset;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.core.window.events.WindowMouseEvent;

    public class TrophyFurniWidget extends RoomWidgetBase 
    {

        private static const _SafeStr_5505:Array = new Array("trophy_bg_gold", "trophy_bg_silver", "trophy_bg_bronze");
        private static const _SafeStr_5506:Array = new Array(4293707079, 4291411404, 4290279476);

        private var _window:IWindowContainer;
        private var _name:String;
        private var _date:String;
        private var _message:String = null;
        private var _color:Number;

        public function TrophyFurniWidget(_arg_1:IRoomWidgetHandler, _arg_2:IHabboWindowManager, _arg_3:IAssetLibrary=null)
        {
            super(_arg_1, _arg_2, _arg_3);
        }
        override public function dispose():void
        {
            this.disposeInterface();
            super.dispose();
        }
        override public function RoomChatWidget(_arg_1:IEventDispatcher):void
        {
            if (_arg_1 == null){
                return;
            };
            _arg_1.addEventListener(RoomWidgetTrophyDataUpdateEvent.RWTDUE_TROPHY_DATA, this.onObjectUpdate);
            super.RoomChatWidget(_arg_1);
        }
        override public function RoomChatWidget(_arg_1:IEventDispatcher):void
        {
            if (_arg_1 == null){
                return;
            };
            _arg_1.removeEventListener(RoomWidgetTrophyDataUpdateEvent.RWTDUE_TROPHY_DATA, this.onObjectUpdate);
        }
        private function onObjectUpdate(_arg_1:RoomWidgetTrophyDataUpdateEvent):void
        {
            this.disposeInterface();
            this._name = _arg_1.name;
            this._date = _arg_1.date;
            this._message = _arg_1.message;
            this._color = (_arg_1.color - 1);
            if ((((this._color > 2)) || ((this._color < 0)))){
                this._color = 0;
            };
            this.showInterface();
        }
        private function showInterface():void
        {
            var _local_3:IWindow;
            var _local_4:IWindowContainer;
            var _local_5:ITextWindow;
            var _local_6:ITextWindow;
            var _local_7:ITextWindow;
            var _local_8:BitmapDataAsset;
            var _local_9:BitmapData;
            var _local_10:IBitmapWrapperWindow;
            var _local_1:IAsset = assets.getAssetByName("trophy");
            var _local_2:XmlAsset = XmlAsset(_local_1);
            if (_local_2 == null){
                return;
            };
            if (this._window != null){
                this._window.dispose();
                this._window = null;
            };
            this._window = (windowManager.buildFromXML((_local_2.content as XML)) as IWindowContainer);
            this._window.center();
            _local_3 = this._window.findChildByName("close");
            if (_local_3 != null){
                _local_3.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onMouseEvent);
            };
            _local_4 = (this._window.findChildByName("title_bg") as IWindowContainer);
            if (_local_4 != null){
                _local_4.color = _SafeStr_5506[this._color];
            };
            _local_5 = (this._window.findChildByName("greeting") as ITextWindow);
            if (_local_5 != null){
                this._message = this._message.replace(/\\r/g, "\n");
                _local_5.text = this._message;
            };
            _local_6 = (this._window.findChildByName("date") as ITextWindow);
            if (_local_6 != null){
                _local_6.text = this._date;
            };
            _local_7 = (this._window.findChildByName("name") as ITextWindow);
            if (_local_7 != null){
                _local_7.text = this._name;
            };
            _local_8 = (assets.getAssetByName(_SafeStr_5505[this._color]) as BitmapDataAsset);
            _local_10 = (this._window.findChildByName("trophy_bg") as IBitmapWrapperWindow);
            if (_local_8 != null){
                _local_9 = (_local_8.content as BitmapData);
                _local_10.bitmap = _local_9.clone();
            };
        }
        private function disposeInterface():void
        {
            if (this._window != null){
                this._window.dispose();
                this._window = null;
            };
        }
        private function onMouseEvent(_arg_1:WindowMouseEvent):void
        {
            var _local_2:IWindow = (_arg_1.target as IWindow);
            var _local_3:String = _local_2.name;
            this.disposeInterface();
        }

    }
}//package com.sulake.habbo.ui.widget.furniture.trophy

// BitmapDataAsset = "_-0PB" (String#4074, DoABC#2)
// RoomWidgetBase = "_-0eQ" (String#4398, DoABC#2)
// TrophyFurniWidget = "_-0HP" (String#3903, DoABC#2)
// RoomWidgetTrophyDataUpdateEvent = "_-3LM" (String#7726, DoABC#2)
// RoomChatWidget = "_-1yD" (String#1787, DoABC#2)
// onObjectUpdate = "_-2l-" (String#248, DoABC#2)
// RoomChatWidget = "_-0-c" (String#3556, DoABC#2)
// showInterface = "_-121" (String#162, DoABC#2)
// onMouseEvent = "_-0ZW" (String#357, DoABC#2)
// _date = "_-1Dw" (String#1636, DoABC#2)
// _SafeStr_5505 = "_-Y7" (String#23567, DoABC#2)
// _SafeStr_5506 = "_-1oD" (String#18468, DoABC#2)
// disposeInterface = "_-0FF" (String#3856, DoABC#2)
// RWTDUE_TROPHY_DATA = "_-0ag" (String#15461, DoABC#2)


