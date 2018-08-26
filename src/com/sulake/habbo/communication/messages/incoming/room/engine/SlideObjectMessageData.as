
package com.sulake.habbo.communication.messages.incoming.room.engine
{
    import com.sulake.room.utils.Vector3d;

    public class SlideObjectMessageData 
    {

        public static const _SafeStr_3800:String = "mv";
        public static const _moveType:String = "sld";

        private var _id:int = 0;
        private var _loc:Vector3d;
        private var _target:Vector3d;
        private var _moveType:String;
        private var _SafeStr_4520:Boolean = false;

        public function SlideObjectMessageData(_arg_1:int, _arg_2:Vector3d, _arg_3:Vector3d, _arg_4:String=null)
        {
            this._id = _arg_1;
            this._loc = _arg_2;
            this._target = _arg_3;
            this._moveType = _arg_4;
        }
        public function setReadOnly():void
        {
            this._SafeStr_4520 = true;
        }
        public function get id():int
        {
            return (this._id);
        }
        public function get loc():Vector3d
        {
            return (this._loc);
        }
        public function set loc(_arg_1:Vector3d):void
        {
            if (!this._SafeStr_4520){
                this._loc = _arg_1;
            };
        }
        public function get target():Vector3d
        {
            return (this._target);
        }
        public function set target(_arg_1:Vector3d):void
        {
            if (!this._SafeStr_4520){
                this._target = _arg_1;
            };
        }
        public function get moveType():String
        {
            return (this._moveType);
        }
        public function set moveType(_arg_1:String):void
        {
            if (!this._SafeStr_4520){
                this._moveType = _arg_1;
            };
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.room.engine

// Vector3d = "_-1Rb" (String#17568, DoABC#2)
// SlideObjectMessageData = "_-Q2" (String#8200, DoABC#2)
// setReadOnly = "_-5p" (String#22456, DoABC#2)
// _SafeStr_3800 = "_-0hj" (String#15737, DoABC#2)
// _moveType = "_-0q-" (String#16051, DoABC#2)
// _SafeStr_4520 = "_-18k" (String#440, DoABC#2)
// _loc = "_-0OE" (String#185, DoABC#2)
// _moveType = "_-E7" (String#22777, DoABC#2)
// loc = "_-0fh" (String#15660, DoABC#2)


