
package com.sulake.habbo.ui.widget.events
{
    import flash.display.BitmapData;

    public class RoomWidgetEcotronBoxDataUpdateEvent extends RoomWidgetUpdateEvent 
    {

        public static const RWEBDUE_PACKAGEINFO:String = "RWEBDUE_PACKAGEINFO";
        public static const RWEBDUE_CONTENTS:String = "RWEBDUE_CONTENTS";

        private var _objectId:int = -1;
        private var _text:String;
        private var _controller:Boolean;
        private var _iconBitmapData:BitmapData;

        public function RoomWidgetEcotronBoxDataUpdateEvent(_arg_1:String, _arg_2:int, _arg_3:String, _arg_4:Boolean=false, _arg_5:BitmapData=null, _arg_6:Boolean=false, _arg_7:Boolean=false)
        {
            super(_arg_1, _arg_6, _arg_7);
            this._objectId = _arg_2;
            this._text = _arg_3;
            this._controller = _arg_4;
            this._iconBitmapData = _arg_5;
        }
        public function get objectId():int
        {
            return (this._objectId);
        }
        public function get text():String
        {
            return (this._text);
        }
        public function get controller():Boolean
        {
            return (this._controller);
        }
        public function get iconBitmapData():BitmapData
        {
            return (this._iconBitmapData);
        }

    }
}//package com.sulake.habbo.ui.widget.events

// _iconBitmapData = "_-2WE" (String#6688, DoABC#2)
// RoomWidgetUpdateEvent = "_-0ZP" (String#4289, DoABC#2)
// RoomWidgetEcotronBoxDataUpdateEvent = "_-18a" (String#16797, DoABC#2)
// _objectId = "_-1YP" (String#18, DoABC#2)
// _controller = "_-18D" (String#59, DoABC#2)
// RWEBDUE_PACKAGEINFO = "_-1FM" (String#17088, DoABC#2)
// RWEBDUE_CONTENTS = "_-k8" (String#24041, DoABC#2)
// iconBitmapData = "_-1Ok" (String#17458, DoABC#2)


