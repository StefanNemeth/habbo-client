
package 
{
    import mx.core.SimpleApplication;
    import com.sulake.bootstrap.AdManager;
    import com.sulake.iid.IIDHabboAdManager;
    import flash.utils.ByteArray;
    import flash.display.BitmapData;

    public class HabboAdManagerCom extends SimpleApplication 
    {

        public static var manifest:Class = HabboAdManagerCom_manifest;
        public static var requiredClasses:Array = new Array(AdManager, IIDHabboAdManager);
        private static var crcTable:Array;
        private static var crcTableComputed:Boolean = false;

        public static function encode(img:BitmapData):ByteArray
        {
            var i:int;
            var p:uint = null;
            var j:int;
            var png:ByteArray = new ByteArray();
            png.writeUnsignedInt(-1991225785);
            png.writeUnsignedInt(218765834);
            var IHDR:ByteArray = new ByteArray();
            IHDR.writeInt(img.width);
            IHDR.writeInt(img.height);
            IHDR.writeUnsignedInt(134610944);
            IHDR.writeByte(0);
            writeChunk(png, 1229472850, IHDR);
            var IDAT:ByteArray = new ByteArray();
            i = 0;
            while (i < img.height) {
                IDAT.writeByte(0);
                if (!(img.transparent)){
                    j = 0;
                    while (j < img.width) {
                        p = img.getPixel(j, i);
                        IDAT.writeUnsignedInt(uint((((p & 0xFFFFFF) << 8) | 0xFF)));
                        j++;
                    };
                }
                else {
                    j = 0;
                    while (j < img.width) {
                        p = img.getPixel32(j, i);
                        IDAT.writeUnsignedInt(uint((((p & 0xFFFFFF) << 8) | (p >>> 24))));
                        j++;
                    };
                };
                i++;
            };
            IDAT.compress();
            writeChunk(png, 1229209940, IDAT);
            writeChunk(png, 1229278788, null);
            return (png);
        }
        private static function writeChunk(png:ByteArray, _arg_2:uint, data:ByteArray):void
        {
            var c:uint = null;
            var n:uint = null;
            var k:uint = null;
            var i:int;
            if (!(crcTableComputed)){
                crcTableComputed = true;
                crcTable = [];
                n = 0;
                while (n < 0x0100) {
                    c = n;
                    k = 0;
                    while (k < 8) {
                        if ((c & 1)){
                            c = uint((uint(-306674912) ^ uint((c >>> 1))));
                        }
                        else {
                            c = uint((c >>> 1));
                        };
                        k++;
                    };
                    crcTable[n] = c;
                    n++;
                };
            };
            var len:uint;
            if (data != null){
                len = data.length;
            };
            png.writeUnsignedInt(len);
            var p:uint = png.position;
            png.writeUnsignedInt(_arg_2);
            if (data != null){
                png.writeBytes(data);
            };
            var e:uint = png.position;
            png.position = p;
            c = -1;
            i = 0;
            while (i < (e - p)) {
                c = uint((crcTable[((c ^ png.readUnsignedByte()) & uint(0xFF))] ^ uint((c >>> 8))));
                i++;
            };
            c = uint((c ^ uint(-1)));
            png.position = e;
            png.writeUnsignedInt(c);
        }

    }
}//package 

// HabboAdManagerCom_manifest = "_-2uf" (String#7172, DoABC#2)


