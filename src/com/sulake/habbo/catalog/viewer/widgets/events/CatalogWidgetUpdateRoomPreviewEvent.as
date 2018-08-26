
package com.sulake.habbo.catalog.viewer.widgets.events
{
    import flash.events.Event;

    public class CatalogWidgetUpdateRoomPreviewEvent extends Event 
    {

        private var _wallType:String = "default";
        private var _floorType:String = "default";
        private var _landscapeType:String = "1.1";
        private var _tileSize:int = 64;

        public function CatalogWidgetUpdateRoomPreviewEvent(_arg_1:String, _arg_2:String, _arg_3:String, _arg_4:int, _arg_5:Boolean=false, _arg_6:Boolean=false)
        {
            super(WidgetEvent.CWE_UPDATE_ROOM_PREVIEW, _arg_5, _arg_6);
            this._floorType = _arg_1;
            this._wallType = _arg_2;
            this._landscapeType = _arg_3;
            this._tileSize = _arg_4;
        }
        public function get wallType():String
        {
            return (this._wallType);
        }
        public function get floorType():String
        {
            return (this._floorType);
        }
        public function get landscapeType():String
        {
            return (this._landscapeType);
        }
        public function get tileSize():int
        {
            return (this._tileSize);
        }

    }
}//package com.sulake.habbo.catalog.viewer.widgets.events

// CatalogWidgetUpdateRoomPreviewEvent = "_-1w1" (String#5958, DoABC#2)
// _wallType = "_-04G" (String#578, DoABC#2)
// _landscapeType = "_-2Wo" (String#621, DoABC#2)
// floorType = "_-1D4" (String#16985, DoABC#2)
// wallType = "_-0n5" (String#15942, DoABC#2)
// landscapeType = "_-29h" (String#19391, DoABC#2)
// tileSize = "_-2va" (String#21298, DoABC#2)


