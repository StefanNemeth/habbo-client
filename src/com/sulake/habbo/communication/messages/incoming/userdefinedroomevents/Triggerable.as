
package com.sulake.habbo.communication.messages.incoming.userdefinedroomevents
{
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class Triggerable 
    {

        private var _stuffTypeSelectionEnabled:Boolean;
        private var _furniLimit:int;
        private var _stuffIds:Array;
        private var _id:int;
        private var _stringParam:String;
        private var _intParams:Array;
        private var _stuffTypeId:int;
        private var _stuffTypeSelectionCode:int;

        public function Triggerable(_arg_1:IMessageDataWrapper)
        {
            var _local_5:int;
            this._stuffIds = new Array();
            this._intParams = new Array();
            super();
            this._stuffTypeSelectionEnabled = _arg_1.readBoolean();
            this._furniLimit = _arg_1.readInteger();
            var _local_2:int = _arg_1.readInteger();
            var _local_3:int;
            while (_local_3 < _local_2) {
                _local_5 = _arg_1.readInteger();
                this._stuffIds.push(_local_5);
                _local_3++;
            };
            this._stuffTypeId = _arg_1.readInteger();
            this._id = _arg_1.readInteger();
            this._stringParam = _arg_1.readString();
            var _local_4:int = _arg_1.readInteger();
            _local_3 = 0;
            while (_local_3 < _local_4) {
                this._intParams.push(_arg_1.readInteger());
                _local_3++;
            };
            this._stuffTypeSelectionCode = _arg_1.readInteger();
        }
        public function get stuffTypeSelectionEnabled():Boolean
        {
            return (this._stuffTypeSelectionEnabled);
        }
        public function get stuffTypeSelectionCode():int
        {
            return (this._stuffTypeSelectionCode);
        }
        public function set stuffTypeSelectionCode(_arg_1:int):void
        {
            this._stuffTypeSelectionCode = _arg_1;
        }
        public function get furniLimit():int
        {
            return (this._furniLimit);
        }
        public function get stuffIds():Array
        {
            return (this._stuffIds);
        }
        public function get id():int
        {
            return (this._id);
        }
        public function get stringParam():String
        {
            return (this._stringParam);
        }
        public function get intParams():Array
        {
            return (this._intParams);
        }
        public function get code():int
        {
            return (0);
        }
        public function get stuffTypeId():int
        {
            return (this._stuffTypeId);
        }
        public function getBoolean(_arg_1:int):Boolean
        {
            return ((this._intParams[_arg_1] == 1));
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.userdefinedroomevents

// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// Triggerable = "_-2oD" (String#7043, DoABC#2)
// readString = "_-2y7" (String#1973, DoABC#2)
// readBoolean = "_-0ZR" (String#1499, DoABC#2)
// code = "_-12Y" (String#4926, DoABC#2)
// intParams = "_-kt" (String#24066, DoABC#2)
// stringParam = "_-WR" (String#23508, DoABC#2)
// _stuffTypeSelectionEnabled = "_-0rr" (String#16116, DoABC#2)
// _stuffIds = "_-2E3" (String#19571, DoABC#2)
// _stringParam = "_-Mz" (String#23124, DoABC#2)
// _intParams = "_-12I" (String#16549, DoABC#2)
// _stuffTypeId = "_-0Q5" (String#15064, DoABC#2)
// _stuffTypeSelectionCode = "_-NN" (String#23139, DoABC#2)
// stuffTypeSelectionEnabled = "_-0rL" (String#16098, DoABC#2)
// stuffTypeSelectionCode = "_-1BV" (String#16918, DoABC#2)
// furniLimit = "_-22s" (String#19128, DoABC#2)
// stuffIds = "_-0b1" (String#15475, DoABC#2)
// stuffTypeId = "_-0zV" (String#16407, DoABC#2)


