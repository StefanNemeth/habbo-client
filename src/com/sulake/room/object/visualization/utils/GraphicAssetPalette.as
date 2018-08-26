
package com.sulake.room.object.visualization.utils
{
    import flash.utils.ByteArray;
    import flash.display.BitmapData;
    import flash.geom.Point;
    import flash.display.BitmapDataChannel;

    public class GraphicAssetPalette 
    {

        private static var _SafeStr_9496:Array = [];

        private var _SafeStr_7934:Array;
        private var _primaryColor:int = 0;
        private var _secondaryColor:int = 0;

        public function GraphicAssetPalette(_arg_1:ByteArray, _arg_2:int, _arg_3:int)
        {
            var _local_4:uint;
            var _local_5:uint;
            var _local_6:uint;
            var _local_7:uint;
            this._SafeStr_7934 = [];
            super();
            _arg_1.position = 0;
            while (_arg_1.bytesAvailable >= 3) {
                _local_4 = _arg_1.readUnsignedByte();
                _local_5 = _arg_1.readUnsignedByte();
                _local_6 = _arg_1.readUnsignedByte();
                _local_7 = ((((0xFF << 24) | (_local_4 << 16)) | (_local_5 << 8)) | _local_6);
                this._SafeStr_7934.push(_local_7);
            };
            while (this._SafeStr_7934.length < 0x0100) {
                this._SafeStr_7934.push(0);
            };
            while (_SafeStr_9496.length < 0x0100) {
                _SafeStr_9496.push(0);
            };
            this._primaryColor = _arg_2;
            this._secondaryColor = _arg_3;
        }
        public function get primaryColor():int
        {
            return (this._primaryColor);
        }
        public function get secondaryColor():int
        {
            return (this._secondaryColor);
        }
        public function dispose():void
        {
            this._SafeStr_7934 = [];
        }
        public function colorizeBitmap(_arg_1:BitmapData):void
        {
            var _local_2:BitmapData = _arg_1.clone();
            _arg_1.paletteMap(_arg_1, _arg_1.rect, new Point(0, 0), _SafeStr_9496, this._SafeStr_7934, _SafeStr_9496, _SafeStr_9496);
            _arg_1.copyChannel(_local_2, _arg_1.rect, new Point(0, 0), BitmapDataChannel.ALPHA, BitmapDataChannel.ALPHA);
            _local_2.dispose();
        }

    }
}//package com.sulake.room.object.visualization.utils

// primaryColor = "_-jL" (String#24012, DoABC#2)
// _primaryColor = "_-0Wz" (String#4248, DoABC#2)
// _secondaryColor = "_-ub" (String#8775, DoABC#2)
// GraphicAssetPalette = "_-1-H" (String#4852, DoABC#2)
// colorizeBitmap = "_-1Af" (String#16887, DoABC#2)
// _SafeStr_7934 = "_-0Q3" (String#4095, DoABC#2)
// _SafeStr_9496 = "_-2vV" (String#7187, DoABC#2)


