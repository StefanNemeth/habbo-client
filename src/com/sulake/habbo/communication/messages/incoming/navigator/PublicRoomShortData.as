
package com.sulake.habbo.communication.messages.incoming.navigator
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class PublicRoomShortData implements IDisposable 
    {

        private var _unitPropertySet:String;
        private var _worldId:int;
        private var _disposed:Boolean;

        public function PublicRoomShortData(_arg_1:IMessageDataWrapper)
        {
            this._unitPropertySet = _arg_1.readString();
            this._worldId = _arg_1.readInteger();
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
        public function get worldId():int
        {
            return (this._worldId);
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.navigator

// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// PublicRoomShortData = "_-0ae" (String#4315, DoABC#2)
// IDisposable = "_-0dY" (String#4382, DoABC#2)
// readString = "_-2y7" (String#1973, DoABC#2)
// unitPropertySet = "_-ix" (String#23996, DoABC#2)
// worldId = "_-2Ip" (String#19760, DoABC#2)
// _unitPropertySet = "_-2ju" (String#6953, DoABC#2)
// _worldId = "_-pp" (String#944, DoABC#2)


