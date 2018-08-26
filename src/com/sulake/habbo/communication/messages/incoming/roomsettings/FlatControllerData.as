
package com.sulake.habbo.communication.messages.incoming.roomsettings
{
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class FlatControllerData 
    {

        private var _userId:int;
        private var _userName:String;
        private var _selected:Boolean;

        public function FlatControllerData(_arg_1:IMessageDataWrapper)
        {
            this._userId = _arg_1.readInteger();
            this._userName = _arg_1.readString();
        }
        public function get userId():int
        {
            return (this._userId);
        }
        public function get userName():String
        {
            return (this._userName);
        }
        public function get selected():Boolean
        {
            return (this._selected);
        }
        public function set selected(_arg_1:Boolean):void
        {
            this._selected = _arg_1;
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.roomsettings

// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// FlatControllerData = "_-0aS" (String#4311, DoABC#2)
// readString = "_-2y7" (String#1973, DoABC#2)


