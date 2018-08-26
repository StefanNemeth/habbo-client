
package com.sulake.habbo.communication.messages.incoming.navigator
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class PublicRoomData implements IDisposable 
    {

        private var _unitPropertySet:String;
        private var _unitPort:int;
        private var _worldId:int;
        private var _castLibs:String;
        private var _maxUsers:int;
        private var _nodeId:int;
        private var _disposed:Boolean;

        public function PublicRoomData(_arg_1:IMessageDataWrapper)
        {
            this._unitPropertySet = _arg_1.readString();
            this._unitPort = _arg_1.readInteger();
            this._worldId = _arg_1.readInteger();
            this._castLibs = _arg_1.readString();
            this._maxUsers = _arg_1.readInteger();
            this._nodeId = _arg_1.readInteger();
        }
        public function dispose():void
        {
            if (this._disposed){
                return;
            };
            this._disposed = true;
        }
        public function get disposed():Boolean
        {
            return (this._disposed);
        }
        public function get unitPropertySet():String
        {
            return (this._unitPropertySet);
        }
        public function get unitPort():int
        {
            return (this._unitPort);
        }
        public function get worldId():int
        {
            return (this._worldId);
        }
        public function get castLibs():String
        {
            return (this._castLibs);
        }
        public function get maxUsers():int
        {
            return (this._maxUsers);
        }
        public function get nodeId():int
        {
            return (this._nodeId);
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.navigator

// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// IDisposable = "_-0dY" (String#4382, DoABC#2)
// PublicRoomData = "_-3Dv" (String#920, DoABC#2)
// readString = "_-2y7" (String#1973, DoABC#2)
// maxUsers = "_-Rs" (String#23320, DoABC#2)
// castLibs = "_-0m9" (String#15901, DoABC#2)
// nodeId = "_-3K6" (String#22286, DoABC#2)
// unitPropertySet = "_-ix" (String#23996, DoABC#2)
// worldId = "_-2Ip" (String#19760, DoABC#2)
// _unitPropertySet = "_-2ju" (String#6953, DoABC#2)
// _worldId = "_-pp" (String#944, DoABC#2)
// _nodeId = "_-0zZ" (String#830, DoABC#2)
// _unitPort = "_-0vq" (String#1579, DoABC#2)
// _castLibs = "_-29c" (String#6242, DoABC#2)
// _maxUsers = "_-fm" (String#23879, DoABC#2)
// unitPort = "_-2js" (String#20840, DoABC#2)


