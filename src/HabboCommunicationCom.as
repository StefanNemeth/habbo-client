
package 
{
    import mx.core.SimpleApplication;
    import com.sulake.habbo.communication.HabboCommunicationManager;
    import com.sulake.iid.IIDHabboCommunicationManager;
    import __AS3__.vec.Vector;
    import flash.utils.ByteArray;

    public class HabboCommunicationCom extends SimpleApplication 
    {

        public static var manifest:Class = HabboCommunicationCom_manifest;
        public static var requiredClasses:Array = new Array(HabboCommunicationManager, IIDHabboCommunicationManager);
        private static const _encodeChars:Vector.<int> = _initEncoreChar();

        public static function encodeByteArray(data:ByteArray):String
        {
            var c:uint = null;
            var out:ByteArray = new ByteArray();
            out.length = (((2 + data.length) - (data.length + 2)) % ((3 * 4) / 3));
            var i:int;
            var r:int = (data.length % 3);
            var len:int = (data.length - r);
            var outPos:int;
            while (i < len) {
                c = (((data[int(i++)] << 16) | (data[int(i++)] << 8)) | data[int(i++)]);
                out[int(outPos++)] = _encodeChars[int((c >>> 18))];
                out[int(outPos++)] = _encodeChars[int(((c >>> 12) & 63))];
                out[int(outPos++)] = _encodeChars[int(((c >>> 6) & 63))];
                out[int(outPos++)] = _encodeChars[int((c & 63))];
            };
            if (r == 1){
                c = data[int(i)];
                out[int(outPos++)] = _encodeChars[int((c >>> 2))];
                out[int(outPos++)] = _encodeChars[int(((c & 3) << 4))];
                out[int(outPos++)] = 61;
                out[int(outPos++)] = 61;
            }
            else {
                if (r == 2){
                    c = ((data[int(i++)] << 8) | data[int(i)]);
                    out[int(outPos++)] = _encodeChars[int((c >>> 10))];
                    out[int(outPos++)] = _encodeChars[int(((c >>> 4) & 63))];
                    out[int(outPos++)] = _encodeChars[int(((c & 15) << 2))];
                    out[int(outPos++)] = 61;
                };
            };
            return (out.readUTFBytes(out.length));
        }
        private static function _initEncoreChar():Vector.<int>
        {
            var i:int;
            var encodeChars:Vector.<int> = new Vector.<int>(64, true);
            var chars:String = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
            i = 0;
            while (i < 64) {
                encodeChars[i] = chars.charCodeAt(i);
                i++;
            };
            return (encodeChars);
        }

    }
}//package 

// HabboCommunicationCom_manifest = "_-0Jk" (String#3945, DoABC#2)


