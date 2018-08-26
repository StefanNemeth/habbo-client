
package com.sulake.habbo.ui.handler
{
    import com.sulake.habbo.ui.IRoomWidgetHandler;
    import com.sulake.habbo.ui.IRoomWidgetHandlerContainer;
    import com.sulake.habbo.ui.widget.effects.EffectsWidget;
    import com.sulake.habbo.ui.widget.enums.RoomWidgetEnum;
    import com.sulake.habbo.inventory.events.HabboInventoryEffectsEvent;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetRequestWidgetMessage;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetMessage;
    import com.sulake.habbo.ui.widget.events.RoomWidgetUpdateEvent;
    import flash.events.Event;

    public class EffectsWidgetHandler implements IRoomWidgetHandler 
    {

        private var _disposed:Boolean = false;
        private var _container:IRoomWidgetHandlerContainer = null;
        private var _widget:EffectsWidget;

        public function get disposed():Boolean
        {
            return (this._disposed);
        }
        public function dispose():void
        {
            if (!this._disposed){
                this.container = null;
                this._widget = null;
                this._disposed = true;
            };
        }
        public function get type():String
        {
            return (RoomWidgetEnum.RWE_EFFECTS);
        }
        public function set widget(_arg_1:EffectsWidget):void
        {
            this._widget = _arg_1;
        }
        public function set container(_arg_1:IRoomWidgetHandlerContainer):void
        {
            if (this._container != null){
                this._container.inventory.events.removeEventListener(HabboInventoryEffectsEvent.HIEE_EFFECTS_CHANGED, this.EffectsWidgetHandler);
            };
            this._container = _arg_1;
            if (this._container != null){
                this._container.inventory.events.addEventListener(HabboInventoryEffectsEvent.HIEE_EFFECTS_CHANGED, this.EffectsWidgetHandler);
            };
        }
        public function get container():IRoomWidgetHandlerContainer
        {
            return (this._container);
        }
        private function EffectsWidgetHandler(_arg_1:HabboInventoryEffectsEvent):void
        {
            if (this._widget){
                this._widget.open();
            };
        }
        public function IRoomWidgetHandler():Array
        {
            return ([RoomWidgetRequestWidgetMessage.RWRWM_EFFECTS]);
        }
        public function IRoomWidgetHandler():Array
        {
            return ([]);
        }
        public function processWidgetMessage(_arg_1:RoomWidgetMessage):RoomWidgetUpdateEvent
        {
            if (!_arg_1){
                return (null);
            };
            switch (_arg_1.type){
                case RoomWidgetRequestWidgetMessage.RWRWM_EFFECTS:
                    this._widget.open();
                    break;
            };
            return (null);
        }
        public function IRoomWidgetHandler(_arg_1:Event):void
        {
        }
        public function update():void
        {
        }

    }
}//package com.sulake.habbo.ui.handler

// HabboInventoryEffectsEvent = "_-0Us" (String#15238, DoABC#2)
// RoomWidgetMessage = "_-04U" (String#3654, DoABC#2)
// EffectsWidget = "_-ds" (String#8482, DoABC#2)
// RoomWidgetUpdateEvent = "_-0ZP" (String#4289, DoABC#2)
// EffectsWidgetHandler = "_-0V2" (String#4206, DoABC#2)
// RoomWidgetRequestWidgetMessage = "_-XQ" (String#8356, DoABC#2)
// RWRWM_EFFECTS = "_-9y" (String#22615, DoABC#2)
// widget = "_-1yo" (String#18920, DoABC#2)
// RWE_EFFECTS = "_-mU" (String#24127, DoABC#2)
// HIEE_EFFECTS_CHANGED = "_-9W" (String#22600, DoABC#2)
// EffectsWidgetHandler = "_-1tP" (String#5909, DoABC#2)
// IRoomWidgetHandler = "_-1dr" (String#5626, DoABC#2)
// IRoomWidgetHandler = "_-0gb" (String#4436, DoABC#2)
// IRoomWidgetHandler = "_-xT" (String#2223, DoABC#2)


