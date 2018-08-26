
package com.sulake.habbo.avatar.palette
{
    import flash.utils.ByteArray;
    import flash.geom.Point;
    import flash.display.BitmapData;

    public class PaletteMap 
    {

        private var _SafeStr_6868:Array;
        private var _blank:Array;

        public function PaletteMap(_arg_1:ByteArray)
        {
            var _local_2:uint;
            var _local_3:uint;
            var _local_4:uint;
            var _local_5:uint;
            super();
            this._SafeStr_6868 = new Array();
            _arg_1.position = 0;
            while (_arg_1.bytesAvailable >= 3) {
                _local_2 = _arg_1.readUnsignedByte();
                _local_3 = _arg_1.readUnsignedByte();
                _local_4 = _arg_1.readUnsignedByte();
                _local_5 = (((_local_2 << 16) | (_local_3 << 8)) | _local_4);
                this._SafeStr_6868.push(_local_5);
            };
            this._blank = new Array();
            while (this._blank.length < 0x0100) {
                this._blank.push(0);
            };
        }
        public function getIndex(_arg_1:uint):int
        {
            var _local_2:int = this._SafeStr_6868.indexOf(_arg_1);
            return ((((_local_2)<0) ? 0 : _local_2));
        }
        public function colorizeBitmap(_arg_1:BitmapData):void
        {
            _arg_1.paletteMap(_arg_1, _arg_1.rect, new Point(0, 0), this._blank, this._SafeStr_6868, this._blank, this._blank);
        }
        public function colorize(_arg_1:ByteArray):ByteArray
        {
            var _local_3:uint;
            var _local_4:uint;
            var _local_5:uint;
            var _local_6:uint;
            var _local_7:uint;
            var _local_2:ByteArray = new ByteArray();
            _arg_1.position = 0;
            while (_arg_1.bytesAvailable >= 4) {
                _local_3 = _arg_1.readUnsignedByte();
                _local_4 = _arg_1.readUnsignedByte();
                _local_5 = _arg_1.readUnsignedByte();
                _local_6 = _arg_1.readUnsignedByte();
                _local_7 = (this._SafeStr_6868[_local_5] as uint);
                _local_2.writeUnsignedInt(((_local_3 << 24) | _local_7));
            };
            _local_2.position = 0;
            return (_local_2);
        }
        public function invert():void
        {
            var _local_1:Array = new Array();
            while (this._SafeStr_6868.length > 0) {
                _local_1.push(this._SafeStr_6868.pop());
            };
            this._SafeStr_6868 = _local_1;
        }

    }
}//package com.sulake.habbo.avatar.palette

// PaletteMap = "_-2DD" (String#6308, DoABC#2)
// _SafeStr_6868 = "_-1wu" (String#18842, DoABC#2)
// getIndex = "_-0ZZ" (String#15426, DoABC#2)
// colorizeBitmap = "_-1Af" (String#16887, DoABC#2)


