
package com.sulake.core.window.graphics
{
    import com.sulake.core.runtime.IDisposable;
    import flash.display.BitmapData;
    import com.sulake.core.utils.profiler.tracking.TrackedBitmapData;

    public class DrawBufferAllocator implements IDisposable 
    {

        private var _disposed:Boolean;
        private var _SafeStr_9602:Array;

        public function DrawBufferAllocator()
        {
            this._disposed = false;
            this._SafeStr_9602 = new Array();
        }
        public function get disposed():Boolean
        {
            return (this._disposed);
        }
        public function get allocatedByteCount():uint
        {
            var bitmap:BitmapData;
            var bytes:uint;
            var index:uint = this._SafeStr_9602.length;
            try {
                while (index > 0) {
                    index--;
                    bitmap = BitmapData(this._SafeStr_9602[index]);
                    bytes = (bytes + ((bitmap.width * bitmap.height) * 4));
                };
            }
            catch(e:Error) {
                Logger.log("Disposed bitmap in DrawBufferAllocator!");
            };
            return (bytes);
        }
        public function dispose():void
        {
            var _local_1:uint;
            if (!this._disposed){
                this._disposed = true;
                _local_1 = this._SafeStr_9602.length;
                while (_local_1 > 0) {
                    BitmapData(this._SafeStr_9602.pop()).dispose();
                    _local_1--;
                };
            };
        }
        public function allocate(width:int, height:int, transparent:Boolean=true, fillColor:uint=0xFFFFFFFF):BitmapData
        {
            var bitmap:BitmapData;
            try {
                bitmap = new TrackedBitmapData(this, width, height, transparent, fillColor);
            }
            catch(error:ArgumentError) {
                Logger.log((((("Failed to allocate draw buffer of size " + width) + "x") + height) + "!"));
                bitmap = new TrackedBitmapData(this, 1, 1, transparent, fillColor);
            };
            this._SafeStr_9602.push(bitmap);
            return (bitmap);
        }
        public function free(_arg_1:BitmapData):void
        {
            var _local_2:uint = this._SafeStr_9602.indexOf(_arg_1);
            if (_local_2 < 0){
                throw (new ArgumentError("Provided bitmap data is not managed by this instance!"));
            };
            this._SafeStr_9602.splice(_local_2, 1);
            _arg_1.dispose();
        }

    }
}//package com.sulake.core.window.graphics

// DrawBufferAllocator = "_-2jz" (String#6955, DoABC#2)
// TrackedBitmapData = "_-1gF" (String#5666, DoABC#2)
// IDisposable = "_-0dY" (String#4382, DoABC#2)
// allocatedByteCount = "_-2p5" (String#7060, DoABC#2)
// allocate = "_-08G" (String#14374, DoABC#2)
// _SafeStr_9602 = "_-23R" (String#19151, DoABC#2)


