
package com.sulake.habbo.communication.messages.parser.room.engine
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.habbo.communication.messages.incoming.room.engine.SlideObjectMessageData;
    import com.sulake.room.utils.Vector3d;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class SlideObjectBundleMessageParser implements IMessageParser 
    {

        private var _roomId:int = 0;
        private var _roomCategory:int = 0;
        private var _id:int;
        private var _SafeStr_3795:Number;
        private var _SafeStr_3796:String;
        private var _objectList:Array;
        private var _avatar:SlideObjectMessageData = null;

        public function get roomId():int
        {
            return (this._roomId);
        }
        public function get roomCategory():int
        {
            return (this._roomCategory);
        }
        public function get id():int
        {
            return (this._id);
        }
        public function get avatar():SlideObjectMessageData
        {
            return (this._avatar);
        }
        public function get objectList():Array
        {
            return (this._objectList);
        }
        public function flush():Boolean
        {
            this._roomId = 0;
            this._roomCategory = 0;
            this._id = -1;
            this._avatar = null;
            this._objectList = new Array();
            return (true);
        }
        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            var _local_7:int;
            var _local_8:SlideObjectMessageData;
            var _local_9:Vector3d;
            var _local_10:Vector3d;
            var _local_11:Number;
            var _local_12:Number;
            if (_arg_1 == null){
                return (false);
            };
            var _local_2:Number = _arg_1.readInteger();
            var _local_3:Number = _arg_1.readInteger();
            var _local_4:Number = _arg_1.readInteger();
            var _local_5:Number = _arg_1.readInteger();
            var _local_6:int = _arg_1.readInteger();
            this._objectList = new Array();
            var _local_13:int;
            while (_local_13 < _local_6) {
                _local_7 = _arg_1.readInteger();
                _local_11 = Number(_arg_1.readString());
                _local_12 = Number(_arg_1.readString());
                _local_9 = new Vector3d(_local_2, _local_3, _local_11);
                _local_10 = new Vector3d(_local_4, _local_5, _local_12);
                _local_8 = new SlideObjectMessageData(_local_7, _local_9, _local_10);
                this._objectList.push(_local_8);
                _local_13++;
            };
            this._id = _arg_1.readInteger();
            var _local_14:int = _arg_1.readInteger();
            switch (_local_14){
                case 0:
                    break;
                case 1:
                    _local_7 = _arg_1.readInteger();
                    _local_11 = Number(_arg_1.readString());
                    _local_12 = Number(_arg_1.readString());
                    _local_9 = new Vector3d(_local_2, _local_3, _local_11);
                    _local_10 = new Vector3d(_local_4, _local_5, _local_12);
                    this._avatar = new SlideObjectMessageData(_local_7, _local_9, _local_10, SlideObjectMessageData._SafeStr_3800);
                    break;
                case 2:
                    _local_7 = _arg_1.readInteger();
                    _local_11 = Number(_arg_1.readString());
                    _local_12 = Number(_arg_1.readString());
                    _local_9 = new Vector3d(_local_2, _local_3, _local_11);
                    _local_10 = new Vector3d(_local_4, _local_5, _local_12);
                    this._avatar = new SlideObjectMessageData(_local_7, _local_9, _local_10, SlideObjectMessageData._moveType);
                    break;
                default:
                    Logger.log("** Incompatible character movetype!");
            };
            return (true);
        }

    }
}//package com.sulake.habbo.communication.messages.parser.room.engine

// Vector3d = "_-1Rb" (String#17568, DoABC#2)
// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// SlideObjectMessageData = "_-Q2" (String#8200, DoABC#2)
// SlideObjectBundleMessageParser = "_-255" (String#6143, DoABC#2)
// readString = "_-2y7" (String#1973, DoABC#2)
// _SafeStr_3795 = "_-S" (String#23325, DoABC#2)
// _SafeStr_3796 = "_-2IB" (String#19734, DoABC#2)
// _objectList = "_-2I" (String#19728, DoABC#2)
// _avatar = "_-0GT" (String#3883, DoABC#2)
// objectList = "_-1qv" (String#18577, DoABC#2)
// _SafeStr_3800 = "_-0hj" (String#15737, DoABC#2)
// _moveType = "_-0q-" (String#16051, DoABC#2)
// IMessageParser = "_-5U" (String#7770, DoABC#2)


