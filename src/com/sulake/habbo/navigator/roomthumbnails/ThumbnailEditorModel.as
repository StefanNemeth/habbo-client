
package com.sulake.habbo.navigator.roomthumbnails
{
    import com.sulake.habbo.communication.messages.incoming.navigator.RoomThumbnailObjectData;
    import com.sulake.habbo.communication.messages.incoming.navigator.RoomThumbnailData;
    import com.sulake.habbo.navigator.Util;
    import flash.utils.Dictionary;

    public class ThumbnailEditorModel 
    {

        public static const _SafeStr_6034:int = 1;
        public static const _SafeStr_6036:int = 2;
        public static const _SafeStr_6037:int = 3;

        private var _mode:int = 1;
        private var _selected:RoomThumbnailObjectData;
        private var _data:RoomThumbnailData;

        private function removeSelected():void
        {
            var _local_1:Array = this._data.objects;
            if (this._selected == null){
                return;
            };
            var _local_2:int = Util.remove(_local_1, this._selected);
            this._selected = null;
            if (_local_1.length > 0){
                this._selected = _local_1[Math.min(_local_2, (_local_1.length - 1))];
            };
        }
        private function addObject(_arg_1:int):void
        {
            Logger.log(("New object pos: " + _arg_1));
            var _local_2:RoomThumbnailObjectData = new RoomThumbnailObjectData();
            _local_2.pos = _arg_1;
            _local_2.imgId = 0;
            this._data.objects.push(_local_2);
            this._selected = _local_2;
            Logger.log(("Object count after insert: " + this._data.objects.length));
        }
        public function setPos(_arg_1:int):void
        {
            this._selected = this.findByPos(_arg_1);
            if (this._selected == null){
                this.addObject(_arg_1);
            };
        }
        public function setImg(_arg_1:int):void
        {
            if (this._mode == _SafeStr_6034){
                this._data.bgImgId = _arg_1;
            }
            else {
                if (this._mode == _SafeStr_6036){
                    this._data.frontImgId = _arg_1;
                };
            };
            if (this._mode == _SafeStr_6037){
                if (this._selected == null){
                    return;
                };
                this._selected.imgId = _arg_1;
            };
        }
        public function getImgId():int
        {
            if (this._mode == _SafeStr_6034){
                return (this._data.bgImgId);
            };
            if (this._mode == _SafeStr_6036){
                return (this._data.frontImgId);
            };
            return ((((this._selected == null)) ? -1 : this._selected.imgId));
        }
        public function findByPos(_arg_1:int):RoomThumbnailObjectData
        {
            var _local_2:RoomThumbnailObjectData;
            for each (_local_2 in this._data.objects) {
                if (_local_2.pos == _arg_1){
                    return (_local_2);
                };
            };
            return (null);
        }
        public function getBlockedPositions():Dictionary
        {
            var _local_2:RoomThumbnailObjectData;
            var _local_1:Dictionary = new Dictionary();
            for each (_local_2 in this._data.objects) {
                if (_local_2.imgId > 0){
                    _local_1[_local_2.pos] = "taken";
                };
            };
            return (_local_1);
        }
        public function set data(_arg_1:RoomThumbnailData):void
        {
            this._data = _arg_1;
            this._mode = _SafeStr_6034;
            if (this._data.objects.length > 0){
                this._selected = this._data.objects[0];
            }
            else {
                this._selected = null;
            };
        }
        public function set mode(_arg_1:int):void
        {
            this._mode = _arg_1;
        }
        public function set selected(_arg_1:RoomThumbnailObjectData):void
        {
            this._selected = _arg_1;
        }
        public function get mode():int
        {
            return (this._mode);
        }
        public function get selected():RoomThumbnailObjectData
        {
            return (this._selected);
        }
        public function get data():RoomThumbnailData
        {
            return (this._data);
        }

    }
}//package com.sulake.habbo.navigator.roomthumbnails

// Util = "_-1ve" (String#445, DoABC#2)
// RoomThumbnailData = "_-2bQ" (String#6781, DoABC#2)
// RoomThumbnailObjectData = "_-bW" (String#8446, DoABC#2)
// objects = "_-8h" (String#22568, DoABC#2)
// frontImgId = "_-2Ep" (String#19597, DoABC#2)
// pos = "_-g8" (String#23898, DoABC#2)
// _SafeStr_6034 = "_-gy" (String#23927, DoABC#2)
// _SafeStr_6036 = "_-0-d" (String#14037, DoABC#2)
// _SafeStr_6037 = "_-3FA" (String#22084, DoABC#2)
// imgId = "_-wA" (String#24536, DoABC#2)
// mode = "_-3Cz" (String#2023, DoABC#2)
// setPos = "_-05A" (String#14250, DoABC#2)
// setImg = "_-wg" (String#24557, DoABC#2)
// getBlockedPositions = "_-yo" (String#24643, DoABC#2)
// getImgId = "_-0gW" (String#15694, DoABC#2)
// _mode = "_-1kk" (String#611, DoABC#2)
// removeSelected = "_-1at" (String#17929, DoABC#2)
// addObject = "_-0EW" (String#1435, DoABC#2)
// findByPos = "_-5a" (String#22445, DoABC#2)


