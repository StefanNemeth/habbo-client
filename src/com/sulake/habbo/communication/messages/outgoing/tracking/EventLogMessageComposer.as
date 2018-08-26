
package com.sulake.habbo.communication.messages.outgoing.tracking
{
    import com.sulake.core.communication.messages.IMessageComposer;

    public class EventLogMessageComposer implements IMessageComposer 
    {

        private var _category:String;
        private var _type:String;
        private var _action:String;
        private var _extraString:String;
        private var _extraInt:int;

        public function EventLogMessageComposer(_arg_1:String, _arg_2:String, _arg_3:String, _arg_4:String="", _arg_5:int=0)
        {
            if ((((((_arg_1 == null)) || ((_arg_2 == null)))) || ((_arg_3 == null)))){
            };
            this._category = ((_arg_1) ? _arg_1 : "");
            this._type = ((_arg_2) ? _arg_2 : "");
            this._action = ((_arg_3) ? _arg_3 : "");
            this._extraString = ((_arg_4) ? _arg_4 : "");
            this._extraInt = ((_arg_5) ? _arg_5 : 0);
        }
        public function dispose():void
        {
        }
        public function getMessageArray():Array
        {
            return ([this._category, this._type, this._action, this._extraString, this._extraInt]);
        }

    }
}//package com.sulake.habbo.communication.messages.outgoing.tracking

// _extraString = "_-ZJ" (String#8401, DoABC#2)
// _extraInt = "_-0sh" (String#4701, DoABC#2)
// getMessageArray = "_-2vs" (String#7197, DoABC#2)
// EventLogMessageComposer = "_-2lH" (String#6984, DoABC#2)


