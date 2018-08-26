
package com.sulake.core.assets
{
    import flash.display.BitmapData;
    import flash.geom.Point;
    import flash.display.Bitmap;

    public class BitmapDataAsset implements ILazyAsset 
    {

        protected static var _SafeStr_8744:uint = 0;
        protected static var _SafeStr_7201:uint = 0;

        private var _disposed:Boolean = false;
        private var _unknown:Object;
        private var _bitmap:BitmapData;
        private var _offset:Point;
        private var _flipH:Boolean = false;
        private var _flipV:Boolean = false;
        private var _declaration:AssetTypeDeclaration;
        private var _url:String;

        public function BitmapDataAsset(_arg_1:AssetTypeDeclaration, _arg_2:String=null)
        {
            this._offset = new Point(0, 0);
            super();
            this._declaration = _arg_1;
            this._url = _arg_2;
            _SafeStr_8744++;
        }
        public static function get instances():uint
        {
            return (_SafeStr_8744);
        }
        public static function get allocatedByteCount():uint
        {
            return (_SafeStr_7201);
        }

        public function get url():String
        {
            return (this._url);
        }
        public function get flipH():Boolean
        {
            return (this._flipH);
        }
        public function get flipV():Boolean
        {
            return (this._flipV);
        }
        public function get offset():Point
        {
            return (this._offset);
        }
        public function get content():Object
        {
            if (!this._bitmap){
                this.prepareLazyContent();
            };
            return (this._bitmap);
        }
        public function get disposed():Boolean
        {
            return (this._disposed);
        }
        public function get declaration():AssetTypeDeclaration
        {
            return (this._declaration);
        }
        public function dispose():void
        {
            if (!this._disposed){
                _SafeStr_8744--;
                if (this._bitmap){
                    try {
                        _SafeStr_7201 = (_SafeStr_7201 - ((this._bitmap.width * this._bitmap.height) * 4));
                        this._bitmap.dispose();
                    }
                    catch(e:Error) {
                    };
                };
                this._unknown = null;
                this._bitmap = null;
                this._offset = null;
                this._declaration = null;
                this._url = null;
                this._disposed = true;
            };
        }
        public function setUnknownContent(_arg_1:Object):void
        {
            this._unknown = _arg_1;
            this._bitmap = null;
        }
        public function prepareLazyContent():void
        {
            var _local_1:Bitmap;
            if (this._unknown == null){
                return;
            };
            if ((this._unknown is Class)){
                _local_1 = (new this._unknown() as Bitmap);
                if (_local_1 != null){
                    this._bitmap = _local_1.bitmapData.clone();
                    _local_1.bitmapData.dispose();
                    if (this._bitmap != null){
                        _SafeStr_7201 = (_SafeStr_7201 + ((this._bitmap.width * this._bitmap.height) * 4));
                        this._unknown = null;
                        return;
                    };
                    throw (new Error("Failed to convert Bitmap Class to BitmapDataAsset!"));
                };
                this._bitmap = (new this._unknown() as BitmapData);
                if (this._bitmap != null){
                    this._unknown = null;
                    return;
                };
                throw (new Error("Failed to convert BitmapData Class to BitmapDataAsset!"));
            };
            if ((this._unknown is Bitmap)){
                this._bitmap = Bitmap(this._unknown).bitmapData;
                if (this._bitmap != null){
                    this._unknown = null;
                }
                else {
                    throw (new Error("Failed to convert Bitmap to BitmapDataAsset!"));
                };
            };
            if ((this._unknown is BitmapData)){
                this._bitmap = (this._unknown as BitmapData);
                if (this._bitmap != null){
                    this._unknown = null;
                    return;
                };
                throw (new Error("Failed to convert BitmapData to BitmapDataAsset!"));
            };
            if ((this._unknown is BitmapDataAsset)){
                this._bitmap = BitmapDataAsset(this._unknown)._bitmap;
                this._offset = BitmapDataAsset(this._unknown)._offset;
                this._flipH = BitmapDataAsset(this._unknown)._flipH;
                this._flipV = BitmapDataAsset(this._unknown)._flipV;
                if (this._bitmap != null){
                    this._unknown = null;
                    return;
                };
                throw (new Error("Failed to read content from BitmaDataAsset!"));
            };
        }
        public function setFromOtherAsset(_arg_1:IAsset):void
        {
            if ((_arg_1 is BitmapDataAsset)){
                this._bitmap = BitmapDataAsset(_arg_1)._bitmap;
                this._offset = BitmapDataAsset(_arg_1)._offset;
            }
            else {
                throw (new Error("Provided asset should be of type BitmapDataAsset!"));
            };
        }
        public function setParamsDesc(_arg_1:XMLList):void
        {
            var _local_3:String;
            var _local_4:String;
            var _local_5:Array;
            var _local_2:uint;
            while (_local_2 < _arg_1.length()) {
                _local_3 = _arg_1[_local_2].attribute("key");
                _local_4 = _arg_1[_local_2].attribute("value");
                switch (_local_3){
                    case "offset":
                        _local_5 = _local_4.split(",");
                        this._offset.x = parseInt(_local_5[0]);
                        this._offset.y = parseInt(_local_5[1]);
                        break;
                    case "flipH":
                        this._flipH = (((_local_4 == "1")) || ((_local_4 == "true")));
                        break;
                    case "flipV":
                        this._flipV = (((_local_4 == "1")) || ((_local_4 == "true")));
                        break;
                };
                _local_2++;
            };
        }

    }
}//package com.sulake.core.assets

// ILazyAsset = "_-0Yb" (String#4275, DoABC#2)
// BitmapDataAsset = "_-0PB" (String#4074, DoABC#2)
// _url = "_-3Jl" (String#151, DoABC#2)
// _flipH = "_-1nk" (String#863, DoABC#2)
// _flipV = "_-1eo" (String#858, DoABC#2)
// _SafeStr_7201 = "_-1uO" (String#5927, DoABC#2)
// allocatedByteCount = "_-2p5" (String#7060, DoABC#2)
// AssetTypeDeclaration = "_-1fO" (String#5653, DoABC#2)
// prepareLazyContent = "_-2p2" (String#7059, DoABC#2)
// _SafeStr_8744 = "_-19N" (String#16831, DoABC#2)
// _unknown = "_-14" (String#4956, DoABC#2)
// _declaration = "_-23H" (String#447, DoABC#2)
// instances = "_-1Ai" (String#16889, DoABC#2)
// declaration = "_-0yc" (String#4820, DoABC#2)
// setUnknownContent = "_-2zE" (String#7271, DoABC#2)
// setFromOtherAsset = "_-0f6" (String#4409, DoABC#2)
// setParamsDesc = "_-0ro" (String#4682, DoABC#2)


