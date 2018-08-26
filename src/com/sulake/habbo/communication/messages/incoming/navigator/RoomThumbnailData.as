
package com.sulake.habbo.communication.messages.incoming.navigator
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class RoomThumbnailData implements IDisposable 
    {

        private var _bgImgId:int;
        private var _frontImgId:int;
        private var _objects:Array;
        private var _disposed:Boolean;

        public function RoomThumbnailData(_arg_1:IMessageDataWrapper)
        {
            var _local_4:RoomThumbnailObjectData;
            this._objects = new Array();
            super();
            if (_arg_1 == null){
                return;
            };
            this._bgImgId = _arg_1.readInteger();
            this._frontImgId = _arg_1.readInteger();
            var _local_2:int = _arg_1.readInteger();
            var _local_3:int;
            while (_local_3 < _local_2) {
                _local_4 = new RoomThumbnailObjectData();
                _local_4.pos = _arg_1.readInteger();
                _local_4.imgId = _arg_1.readInteger();
                this._objects.push(_local_4);
                _local_3++;
            };
            if (this._bgImgId == 0){
                this.setDefaults();
            };
        }
        private function setDefaults():void
        {
            this._bgImgId = 1;
            this._frontImgId = 0;
            var _local_1:RoomThumbnailObjectData = new RoomThumbnailObjectData();
            _local_1.pos = 4;
            _local_1.imgId = 1;
            this._objects.push(_local_1);
        }
        public function getCopy():RoomThumbnailData
        {
            var _local_2:RoomThumbnailObjectData;
            var _local_1:RoomThumbnailData = new RoomThumbnailData(null);
            _local_1._bgImgId = this._bgImgId;
            _local_1._frontImgId = this._frontImgId;
            for each (_local_2 in this._objects) {
                _local_1._objects.push(_local_2.getCopy());
            };
            return (_local_1);
        }
        public function dispose():void
        {
            if (this._disposed){
                return;
            };
            this._disposed = true;
            this._objects = null;
        }
        public function getAsString():String
        {
            var _local_2:RoomThumbnailObjectData;
            var _local_1 = (this._frontImgId + ";");
            _local_1 = (_local_1 + (this._bgImgId + ";"));
            for each (_local_2 in this._objects) {
                _local_1 = (_local_1 + (((_local_2.imgId + ",") + _local_2.pos) + ";"));
            };
            return (_local_1);
        }
        public function get disposed():Boolean
        {
            return (this._disposed);
        }
        public function get bgImgId():int
        {
            return (this._bgImgId);
        }
        public function get frontImgId():int
        {
            return (this._frontImgId);
        }
        public function get objects():Array
        {
            return (this._objects);
        }
        public function set bgImgId(_arg_1:int):void
        {
            this._bgImgId = _arg_1;
        }
        public function set frontImgId(_arg_1:int):void
        {
            this._frontImgId = _arg_1;
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.navigator

// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// RoomThumbnailData = "_-2bQ" (String#6781, DoABC#2)
// RoomThumbnailObjectData = "_-bW" (String#8446, DoABC#2)
// IDisposable = "_-0dY" (String#4382, DoABC#2)
// getAsString = "_-3JH" (String#22254, DoABC#2)
// objects = "_-8h" (String#22568, DoABC#2)
// frontImgId = "_-2Ep" (String#19597, DoABC#2)
// pos = "_-g8" (String#23898, DoABC#2)
// imgId = "_-wA" (String#24536, DoABC#2)
// getCopy = "_-119" (String#16504, DoABC#2)
// _bgImgId = "_-1Fn" (String#17107, DoABC#2)
// _frontImgId = "_-2M7" (String#19889, DoABC#2)
// setDefaults = "_-1MT" (String#17377, DoABC#2)


