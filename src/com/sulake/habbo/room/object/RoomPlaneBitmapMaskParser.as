
package com.sulake.habbo.room.object
{
    import com.sulake.core.utils.Map;
    import com.sulake.room.utils.Vector3d;
    import com.sulake.room.utils.XMLValidator;
    import com.sulake.room.utils.IVector3d;

    public class RoomPlaneBitmapMaskParser 
    {

        private var _SafeStr_12837:Map = null;

        public function RoomPlaneBitmapMaskParser()
        {
            this._SafeStr_12837 = new Map();
        }
        public function get maskCount():int
        {
            return (this._SafeStr_12837.length);
        }
        public function dispose():void
        {
            if (this._SafeStr_12837 != null){
                this.reset();
                this._SafeStr_12837.dispose();
                this._SafeStr_12837 = null;
            };
        }
        public function initialize(_arg_1:XML):Boolean
        {
            var _local_7:XML;
            var _local_8:String;
            var _local_9:String;
            var _local_10:Vector3d;
            var _local_11:String;
            var _local_12:XMLList;
            var _local_13:XML;
            var _local_14:RoomPlaneBitmapMaskData;
            if (_arg_1 == null){
                return (false);
            };
            this._SafeStr_12837.reset();
            var _local_2:Array = ["id", "type", "category"];
            var _local_3:Array = ["x", "y", "z"];
            var _local_4:XMLList;
            var _local_5:XMLList = _arg_1.planeMask;
            var _local_6:int;
            while (_local_6 < _local_5.length()) {
                _local_7 = _local_5[_local_6];
                if (!XMLValidator.checkRequiredAttributes(_local_7, _local_2)){
                    return (false);
                };
                _local_8 = _local_7.@id;
                _local_9 = _local_7.@type;
                _local_10 = null;
                _local_11 = _local_7.@category;
                _local_12 = _local_7.location;
                if (_local_12.length() != 1){
                    return (false);
                };
                _local_13 = _local_12[0];
                if (!XMLValidator.checkRequiredAttributes(_local_13, _local_3)){
                    return (false);
                };
                _local_10 = new Vector3d(Number(_local_13.@x), Number(_local_13.@y), Number(_local_13.@z));
                _local_14 = new RoomPlaneBitmapMaskData(_local_9, _local_10, _local_11);
                this._SafeStr_12837.add(_local_8, _local_14);
                _local_6++;
            };
            return (true);
        }
        public function reset():void
        {
            var _local_2:RoomPlaneBitmapMaskData;
            var _local_1:int;
            while (_local_1 < this._SafeStr_12837.length) {
                _local_2 = (this._SafeStr_12837.getWithIndex(_local_1) as RoomPlaneBitmapMaskData);
                if (_local_2 != null){
                    _local_2.dispose();
                };
                _local_1++;
            };
            this._SafeStr_12837.reset();
        }
        public function addMask(_arg_1:String, _arg_2:String, _arg_3:IVector3d, _arg_4:String):void
        {
            var _local_5:RoomPlaneBitmapMaskData = new RoomPlaneBitmapMaskData(_arg_2, _arg_3, _arg_4);
            this._SafeStr_12837.remove(_arg_1);
            this._SafeStr_12837.add(_arg_1, _local_5);
        }
        public function removeMask(_arg_1:String):Boolean
        {
            var _local_2:RoomPlaneBitmapMaskData = (this._SafeStr_12837.remove(_arg_1) as RoomPlaneBitmapMaskData);
            if (_local_2 != null){
                _local_2.dispose();
                return (true);
            };
            return (false);
        }
        public function getXML():XML
        {
            var _local_3:String;
            var _local_4:String;
            var _local_5:XML;
            var _local_6:IVector3d;
            var _local_1:XML = <planeMasks/>
            ;
            var _local_2:int;
            while (_local_2 < this.maskCount) {
                _local_3 = this.getMaskType(_local_2);
                _local_4 = this.getMaskCategory(_local_2);
                _local_5 = new (XML)((((((('<planeMask id="' + _local_2) + '" type="') + _local_3) + '" category="') + _local_4) + '"/>'));
                _local_6 = this.getMaskLocation(_local_2);
                if (_local_6 != null){
                    _local_5.appendChild(new (XML)((((((('<location x="' + _local_6.x) + '" y="') + _local_6.y) + '" z="') + _local_6.z) + '"/>')));
                    _local_1.appendChild(_local_5);
                };
                _local_2++;
            };
            return (_local_1);
        }
        public function getMaskLocation(_arg_1:int):IVector3d
        {
            if ((((_arg_1 < 0)) || ((_arg_1 >= this.maskCount)))){
                return (null);
            };
            var _local_2:RoomPlaneBitmapMaskData = (this._SafeStr_12837.getWithIndex(_arg_1) as RoomPlaneBitmapMaskData);
            if (_local_2 != null){
                return (_local_2.loc);
            };
            return (null);
        }
        public function getMaskType(_arg_1:int):String
        {
            if ((((_arg_1 < 0)) || ((_arg_1 >= this.maskCount)))){
                return (null);
            };
            var _local_2:RoomPlaneBitmapMaskData = (this._SafeStr_12837.getWithIndex(_arg_1) as RoomPlaneBitmapMaskData);
            if (_local_2 != null){
                return (_local_2.type);
            };
            return (null);
        }
        public function getMaskCategory(_arg_1:int):String
        {
            if ((((_arg_1 < 0)) || ((_arg_1 >= this.maskCount)))){
                return (null);
            };
            var _local_2:RoomPlaneBitmapMaskData = (this._SafeStr_12837.getWithIndex(_arg_1) as RoomPlaneBitmapMaskData);
            if (_local_2 != null){
                return (_local_2.category);
            };
            return (null);
        }

    }
}//package com.sulake.habbo.room.object

// _SafeStr_12837 = "_-014" (String#1385, DoABC#2)
// IVector3d = "_-hf" (String#8547, DoABC#2)
// Vector3d = "_-1Rb" (String#17568, DoABC#2)
// maskCount = "_-3BF" (String#21934, DoABC#2)
// getMaskType = "_-rP" (String#24334, DoABC#2)
// getMaskLocation = "_-3Di" (String#22023, DoABC#2)
// getMaskCategory = "_-1wz" (String#18845, DoABC#2)
// RoomPlaneBitmapMaskParser = "_-27E" (String#6188, DoABC#2)
// RoomPlaneBitmapMaskData = "_-2dh" (String#6826, DoABC#2)
// getXML = "_-2Oe" (String#6532, DoABC#2)
// loc = "_-0fh" (String#15660, DoABC#2)
// addMask = "_-0SM" (String#15149, DoABC#2)
// removeMask = "_-07G" (String#14336, DoABC#2)


