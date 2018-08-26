
package com.sulake.habbo.room.utils
{
    import com.sulake.habbo.room.ISelectedRoomObjectData;
    import com.sulake.room.utils.Vector3d;
    import com.sulake.room.utils.IVector3d;

    public class SelectedRoomObjectData implements ISelectedRoomObjectData 
    {

        private var _id:int = 0;
        private var _category:int = 0;
        private var _operation:String = "";
        private var _loc:Vector3d = null;
        private var _dir:Vector3d = null;
        private var _typeId:int = 0;
        private var _instanceData:String = null;

        public function SelectedRoomObjectData(_arg_1:int, _arg_2:int, _arg_3:String, _arg_4:IVector3d, _arg_5:IVector3d, _arg_6:int=0, _arg_7:String=null)
        {
            this._id = _arg_1;
            this._category = _arg_2;
            this._operation = _arg_3;
            this._loc = new Vector3d();
            this._loc.assign(_arg_4);
            this._dir = new Vector3d();
            this._dir.assign(_arg_5);
            this._typeId = _arg_6;
            this._instanceData = _arg_7;
        }
        public function get id():int
        {
            return (this._id);
        }
        public function get category():int
        {
            return (this._category);
        }
        public function get operation():String
        {
            return (this._operation);
        }
        public function get loc():Vector3d
        {
            return (this._loc);
        }
        public function get dir():Vector3d
        {
            return (this._dir);
        }
        public function get typeId():int
        {
            return (this._typeId);
        }
        public function get instanceData():String
        {
            return (this._instanceData);
        }
        public function dispose():void
        {
            this._loc = null;
            this._dir = null;
        }

    }
}//package com.sulake.habbo.room.utils

// _typeId = "_-3LT" (String#2045, DoABC#2)
// IVector3d = "_-hf" (String#8547, DoABC#2)
// Vector3d = "_-1Rb" (String#17568, DoABC#2)
// _operation = "_-2iy" (String#20804, DoABC#2)
// ISelectedRoomObjectData = "_-J6" (String#8063, DoABC#2)
// SelectedRoomObjectData = "_-0MS" (String#4010, DoABC#2)
// _dir = "_-1kY" (String#187, DoABC#2)
// operation = "_-0Ag" (String#3770, DoABC#2)
// _loc = "_-0OE" (String#185, DoABC#2)
// loc = "_-0fh" (String#15660, DoABC#2)
// _instanceData = "_-0ui" (String#4738, DoABC#2)


