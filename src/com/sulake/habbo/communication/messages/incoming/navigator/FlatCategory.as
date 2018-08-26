
package com.sulake.habbo.communication.messages.incoming.navigator
{
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class FlatCategory 
    {

        private var _nodeId:int;
        private var _nodeName:String;
        private var _visible:Boolean;

        public function FlatCategory(_arg_1:IMessageDataWrapper)
        {
            this._nodeId = _arg_1.readInteger();
            this._nodeName = _arg_1.readString();
            this._visible = _arg_1.readBoolean();
        }
        public function get nodeId():int
        {
            return (this._nodeId);
        }
        public function get nodeName():String
        {
            return (this._nodeName);
        }
        public function get visible():Boolean
        {
            return (this._visible);
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.navigator

// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// FlatCategory = "_-1Lo" (String#5274, DoABC#2)
// readString = "_-2y7" (String#1973, DoABC#2)
// readBoolean = "_-0ZR" (String#1499, DoABC#2)
// nodeId = "_-3K6" (String#22286, DoABC#2)
// _visible = "_-1SE" (String#363, DoABC#2)
// _nodeId = "_-0zZ" (String#830, DoABC#2)
// _nodeName = "_-3DI" (String#22007, DoABC#2)
// nodeName = "_-2F3" (String#19606, DoABC#2)


