
package com.sulake.habbo.communication.messages.parser.userdefinedroomevents
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.ConditionDefinition;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class WiredFurniConditionMessageParser implements IMessageParser 
    {

        private var _def:ConditionDefinition;

        public function flush():Boolean
        {
            this._def = null;
            return (true);
        }
        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            this._def = new ConditionDefinition(_arg_1);
            return (true);
        }
        public function get def():ConditionDefinition
        {
            return (this._def);
        }

    }
}//package com.sulake.habbo.communication.messages.parser.userdefinedroomevents

// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// WiredFurniConditionMessageParser = "_-2a5" (String#6761, DoABC#2)
// ConditionDefinition = "_-Lz" (String#8123, DoABC#2)
// _def = "_-2dQ" (String#1915, DoABC#2)
// def = "_-15K" (String#16666, DoABC#2)
// IMessageParser = "_-5U" (String#7770, DoABC#2)


