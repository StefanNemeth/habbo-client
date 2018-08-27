
package com.sulake.room.renderer.cache
{
    import com.sulake.room.utils.Vector3d;
    import com.sulake.room.utils.IVector3d;
    import com.sulake.room.object.IRoomObject;
    import com.sulake.room.utils.IRoomGeometry;

    public class RoomObjectLocationCacheItem 
    {

        private var _roomObjectVariableAccurateZ:String = "";
        private var _geometryUpdateId:int = -1;
        private var _SafeStr_14426:int = -1;
        private var _SafeStr_14427:Vector3d;
        private var _SafeStr_14428:Vector3d = null;
        private var _locationChanged:Boolean = false;

        public function RoomObjectLocationCacheItem(_arg_1:String)
        {
            this._SafeStr_14427 = new Vector3d();
            super();
            this._roomObjectVariableAccurateZ = _arg_1;
            this._SafeStr_14428 = new Vector3d();
        }
        public function get locationChanged():Boolean
        {
            return (this._locationChanged);
        }
        public function dispose():void
        {
            this._SafeStr_14428 = null;
        }
        public function getScreenLocation(_arg_1:IRoomObject, _arg_2:IRoomGeometry):IVector3d
        {
            var _local_5:IVector3d;
            var _local_6:Number;
            var _local_7:Vector3d;
            var _local_8:IVector3d;
            if ((((_arg_1 == null)) || ((_arg_2 == null)))){
                return (null);
            };
            var _local_3:Boolean;
            var _local_4:IVector3d = _arg_1.getLocation();
            if (((!((_arg_2.updateId == this._geometryUpdateId))) || (!((_arg_1.getUpdateID() == this._SafeStr_14426))))){
                this._SafeStr_14426 = _arg_1.getUpdateID();
                if (((((((!((_arg_2.updateId == this._geometryUpdateId))) || (!((_local_4.x == this._SafeStr_14427.x))))) || (!((_local_4.y == this._SafeStr_14427.y))))) || (!((_local_4.z == this._SafeStr_14427.z))))){
                    this._geometryUpdateId = _arg_2.updateId;
                    this._SafeStr_14427.assign(_local_4);
                    _local_3 = true;
                };
            };
            this._locationChanged = _local_3;
            if (_local_3){
                _local_5 = _arg_2.getScreenPosition(_local_4);
                if (_local_5 == null){
                    return (null);
                };
                _local_6 = _arg_1.getModel().getNumber(this._roomObjectVariableAccurateZ);
                if (((isNaN(_local_6)) || ((_local_6 == 0)))){
                    _local_7 = new Vector3d(Math.round(_local_4.x), Math.round(_local_4.y), _local_4.z);
                    if (((!((_local_7.x == _local_4.x))) || (!((_local_7.y == _local_4.y))))){
                        _local_8 = _arg_2.getScreenPosition(_local_7);
                        this._SafeStr_14428.assign(_local_5);
                        if (_local_8 != null){
                            this._SafeStr_14428.z = _local_8.z;
                        };
                    }
                    else {
                        this._SafeStr_14428.assign(_local_5);
                    };
                }
                else {
                    this._SafeStr_14428.assign(_local_5);
                };
                this._SafeStr_14428.x = Math.round(this._SafeStr_14428.x);
                this._SafeStr_14428.y = Math.round(this._SafeStr_14428.y);
            };
            return (this._SafeStr_14428);
        }

    }
}//package com.sulake.room.renderer.cache

// getScreenPosition = "_-1QP" (String#5358, DoABC#2)
// IVector3d = "_-hf" (String#8547, DoABC#2)
// Vector3d = "_-1Rb" (String#17568, DoABC#2)
// _SafeStr_14426 = "_-0BO" (String#14501, DoABC#2)
// _SafeStr_14427 = "_-216" (String#19054, DoABC#2)
// _SafeStr_14428 = "_-2nB" (String#20968, DoABC#2)
// _locationChanged = "_-242" (String#19178, DoABC#2)
// locationChanged = "_-2d5" (String#20566, DoABC#2)
// getScreenLocation = "_-PG" (String#23217, DoABC#2)
// IRoomGeometry = "_-0z9" (String#4829, DoABC#2)
// RoomObjectLocationCacheItem = "_-2gl" (String#6886, DoABC#2)
// getUpdateID = "_-Ga" (String#932, DoABC#2)
// _geometryUpdateId = "_-2yN" (String#370, DoABC#2)
// updateId = "_-0TD" (String#1478, DoABC#2)


