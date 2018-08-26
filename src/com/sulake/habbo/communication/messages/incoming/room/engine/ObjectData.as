
package com.sulake.habbo.communication.messages.incoming.room.engine
{
    public class ObjectData 
    {

        private var _id:int = 0;
        private var _state:int = 0;
        private var _data:String = "";

        public function ObjectData(_arg_1:int, _arg_2:int, _arg_3:String)
        {
            this._id = _arg_1;
            this._state = _arg_2;
            this._data = _arg_3;
        }
        public function get id():int
        {
            return (this._id);
        }
        public function get state():int
        {
            return (this._state);
        }
        public function get data():String
        {
            return (this._data);
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.room.engine

// ObjectData = "_-D" (String#7932, DoABC#2)


