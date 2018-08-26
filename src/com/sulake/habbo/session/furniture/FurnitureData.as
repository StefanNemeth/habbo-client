
package com.sulake.habbo.session.furniture
{
    public class FurnitureData implements IFurnitureData 
    {

        public static const _SafeStr_8141:String = "i";
        public static const _SafeStr_8142:String = "s";
        public static const _SafeStr_8143:String = "e";

        private var _type:String;
        private var _id:int;
        private var _name:String;
        private var _colourIndex:int;
        private var _revision:int;
        private var _tileSizeX:int;
        private var _tileSizeY:int;
        private var _tileSizeZ:int;
        private var _colours:Array;
        private var _title:String;
        private var _description:String;
        private var _adUrl:String;
        private var _catalogPageId:int;
        private var _offerId:int;

        public function FurnitureData(_arg_1:String, _arg_2:int, _arg_3:String, _arg_4:int, _arg_5:int, _arg_6:int, _arg_7:int, _arg_8:int, _arg_9:Array, _arg_10:String, _arg_11:String, _arg_12:String, _arg_13:int, _arg_14:int)
        {
            this._type = _arg_1;
            this._id = _arg_2;
            this._name = _arg_3;
            this._colourIndex = _arg_4;
            this._revision = _arg_5;
            this._tileSizeX = _arg_6;
            this._tileSizeY = _arg_7;
            this._tileSizeZ = _arg_8;
            this._colours = _arg_9;
            this._title = _arg_10;
            this._description = _arg_11;
            this._adUrl = _arg_12;
            this._catalogPageId = _arg_13;
            this._offerId = _arg_14;
        }
        public function get type():String
        {
            return (this._type);
        }
        public function get id():int
        {
            return (this._id);
        }
        public function get name():String
        {
            return (this._name);
        }
        public function get colourIndex():int
        {
            return (this._colourIndex);
        }
        public function get revision():int
        {
            return (this._revision);
        }
        public function get tileSizeX():int
        {
            return (this._tileSizeX);
        }
        public function get tileSizeY():int
        {
            return (this._tileSizeY);
        }
        public function get tileSizeZ():int
        {
            return (this._tileSizeZ);
        }
        public function get colours():Array
        {
            return (this._colours);
        }
        public function get title():String
        {
            return (this._title);
        }
        public function get description():String
        {
            return (this._description);
        }
        public function get adUrl():String
        {
            return (this._adUrl);
        }
        public function get catalogPageId():int
        {
            return (this._catalogPageId);
        }
        public function get offerId():int
        {
            return (this._offerId);
        }

    }
}//package com.sulake.habbo.session.furniture

// IFurnitureData = "_-pe" (String#8701, DoABC#2)
// FurnitureData = "_-sW" (String#2211, DoABC#2)
// _offerId = "_-0i7" (String#125, DoABC#2)
// offerId = "_-9g" (String#928, DoABC#2)
// _description = "_-1a7" (String#164, DoABC#2)
// colours = "_-2hm" (String#6902, DoABC#2)
// catalogPageId = "_-2oc" (String#7050, DoABC#2)
// colourIndex = "_-1Ye" (String#5534, DoABC#2)
// tileSizeX = "_-0ot" (String#4612, DoABC#2)
// tileSizeY = "_-02i" (String#3623, DoABC#2)
// tileSizeZ = "_-3Y" (String#7738, DoABC#2)
// adUrl = "_-0pg" (String#4626, DoABC#2)
// _SafeStr_8141 = "_-1u9" (String#18722, DoABC#2)
// _SafeStr_8142 = "_-2jm" (String#20837, DoABC#2)
// _SafeStr_8143 = "_-1s1" (String#18633, DoABC#2)
// _colourIndex = "_-0Xb" (String#15340, DoABC#2)
// _tileSizeX = "_-2-2" (String#18972, DoABC#2)
// _tileSizeY = "_-238" (String#19140, DoABC#2)
// _tileSizeZ = "_-2B5" (String#19448, DoABC#2)
// _colours = "_-2V3" (String#891, DoABC#2)
// _adUrl = "_-2po" (String#21074, DoABC#2)
// _catalogPageId = "_-35n" (String#1999, DoABC#2)


