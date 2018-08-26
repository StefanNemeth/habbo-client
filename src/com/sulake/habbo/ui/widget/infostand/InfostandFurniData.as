
package com.sulake.habbo.ui.widget.infostand
{
    import flash.display.BitmapData;
    import com.sulake.habbo.ui.widget.events.RoomWidgetFurniInfoUpdateEvent;

    public class InfostandFurniData 
    {

        private var _id:int = 0;
        private var _category:int = 0;
        private var _name:String = "";
        private var _description:String = "";
        private var _image:BitmapData;
        private var _catalogPageId:int = -1;
        private var _offerId:int = -1;
        private var _extraParam:String = "";

        public function set id(_arg_1:int):void
        {
            this._id = _arg_1;
        }
        public function set category(_arg_1:int):void
        {
            this._category = _arg_1;
        }
        public function set name(_arg_1:String):void
        {
            this._name = _arg_1;
        }
        public function set description(_arg_1:String):void
        {
            this._description = _arg_1;
        }
        public function set image(_arg_1:BitmapData):void
        {
            this._image = _arg_1;
        }
        public function set catalogPageId(_arg_1:int):void
        {
            this._catalogPageId = _arg_1;
        }
        public function set offerId(_arg_1:int):void
        {
            this._offerId = _arg_1;
        }
        public function set extraParam(_arg_1:String):void
        {
            this._extraParam = _arg_1;
        }
        public function get id():int
        {
            return (this._id);
        }
        public function get category():int
        {
            return (this._category);
        }
        public function get name():String
        {
            return (this._name);
        }
        public function get description():String
        {
            return (this._description);
        }
        public function get image():BitmapData
        {
            return (this._image);
        }
        public function get catalogPageId():int
        {
            return (this._catalogPageId);
        }
        public function get offerId():int
        {
            return (this._offerId);
        }
        public function get extraParam():String
        {
            return (this._extraParam);
        }
        public function setData(_arg_1:RoomWidgetFurniInfoUpdateEvent):void
        {
            this.id = _arg_1.id;
            this.category = _arg_1.category;
            this.name = _arg_1.name;
            this.description = _arg_1.description;
            this.image = _arg_1.image;
            this.catalogPageId = _arg_1.catalogPageId;
            this.offerId = _arg_1.offerId;
            this.extraParam = _arg_1.extraParam;
        }

    }
}//package com.sulake.habbo.ui.widget.infostand

// setData = "_-1x" (String#18846, DoABC#2)
// InfostandFurniData = "_-2iT" (String#20787, DoABC#2)
// RoomWidgetFurniInfoUpdateEvent = "_-1V1" (String#5455, DoABC#2)
// _image = "_-35u" (String#78, DoABC#2)
// _offerId = "_-0i7" (String#125, DoABC#2)
// offerId = "_-9g" (String#928, DoABC#2)
// extraParam = "_-AM" (String#7874, DoABC#2)
// _extraParam = "_-2Ad" (String#880, DoABC#2)
// _description = "_-1a7" (String#164, DoABC#2)
// catalogPageId = "_-2oc" (String#7050, DoABC#2)
// _catalogPageId = "_-35n" (String#1999, DoABC#2)


