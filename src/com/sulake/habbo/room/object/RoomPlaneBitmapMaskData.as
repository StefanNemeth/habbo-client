
package com.sulake.habbo.room.object
{
    import com.sulake.room.utils.Vector3d;
    import com.sulake.room.utils.IVector3d;

    public class RoomPlaneBitmapMaskData 
    {

        public static const _SafeStr_5791:String = "window";
        public static const _SafeStr_5793:String = "hole";

        private var _loc:Vector3d = null;
        private var _type:String = null;
        private var _category:String = null;

        public function RoomPlaneBitmapMaskData(_arg_1:String, _arg_2:IVector3d, _arg_3:String)
        {
            this.type = _arg_1;
            this.loc = _arg_2;
            this.category = _arg_3;
        }
        public function get loc():IVector3d
        {
            return (this._loc);
        }
        public function set loc(_arg_1:IVector3d):void
        {
            if (this._loc == null){
                this._loc = new Vector3d();
            };
            this._loc.assign(_arg_1);
        }
        public function get type():String
        {
            return (this._type);
        }
        public function set type(_arg_1:String):void
        {
            this._type = _arg_1;
        }
        public function get category():String
        {
            return (this._category);
        }
        public function set category(_arg_1:String):void
        {
            this._category = _arg_1;
        }
        public function dispose():void
        {
            this._loc = null;
        }

    }
}//package com.sulake.habbo.room.object

// IVector3d = "_-hf" (String#8547, DoABC#2)
// Vector3d = "_-1Rb" (String#17568, DoABC#2)
// RoomPlaneBitmapMaskData = "_-2dh" (String#6826, DoABC#2)
// _loc = "_-0OE" (String#185, DoABC#2)
// loc = "_-0fh" (String#15660, DoABC#2)
// _SafeStr_5791 = "_-2fX" (String#20670, DoABC#2)
// _SafeStr_5793 = "_-3En" (String#22068, DoABC#2)


