
package com.sulake.habbo.communication.messages.parser.room.furniture
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class ViralFurniStatusMessageParser implements IMessageParser 
    {

        private var _campaignID:String;
        private var _objectId:int;
        private var _roomId:int = 0;
        private var _roomCategory:int = 0;
        private var _itemCategory:int = 0;
        private var _status:int;
        private var _shareId:String;
        private var _firstClickUserName:String;

        public function get campaignID():String
        {
            return (this._campaignID);
        }
        public function get objectId():int
        {
            return (this._objectId);
        }
        public function get roomId():int
        {
            return (this._roomId);
        }
        public function get roomCategory():int
        {
            return (this._roomCategory);
        }
        public function get itemCategory():int
        {
            return (this._itemCategory);
        }
        public function get shareId():String
        {
            return (this._shareId);
        }
        public function get status():int
        {
            return (this._status);
        }
        public function get firstClickUserName():String
        {
            return (this._firstClickUserName);
        }
        public function flush():Boolean
        {
            this._roomId = 0;
            this._roomCategory = 0;
            return (true);
        }
        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            this._campaignID = _arg_1.readString();
            this._objectId = _arg_1.readInteger();
            this._status = _arg_1.readInteger();
            this._shareId = _arg_1.readString();
            this._firstClickUserName = _arg_1.readString();
            this._itemCategory = _arg_1.readInteger();
            return (true);
        }

    }
}//package com.sulake.habbo.communication.messages.parser.room.furniture

// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// _objectId = "_-1YP" (String#18, DoABC#2)
// readString = "_-2y7" (String#1973, DoABC#2)
// _status = "_-0kS" (String#126, DoABC#2)
// _campaignID = "_-eQ" (String#639, DoABC#2)
// _firstClickUserName = "_-1Cl" (String#838, DoABC#2)
// _itemCategory = "_-0MW" (String#814, DoABC#2)
// shareId = "_-0L" (String#14876, DoABC#2)
// firstClickUserName = "_-0jN" (String#15804, DoABC#2)
// itemCategory = "_-3Bq" (String#21955, DoABC#2)
// campaignID = "_-09Z" (String#14429, DoABC#2)
// IMessageParser = "_-5U" (String#7770, DoABC#2)


