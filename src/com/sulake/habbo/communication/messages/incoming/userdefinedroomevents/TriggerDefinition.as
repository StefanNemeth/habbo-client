
package com.sulake.habbo.communication.messages.incoming.userdefinedroomevents
{
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class TriggerDefinition extends Triggerable 
    {

        private var _code:int;
        private var _conflictingActions:Array;

        public function TriggerDefinition(_arg_1:IMessageDataWrapper)
        {
            this._conflictingActions = new Array();
            super(_arg_1);
            this._code = _arg_1.readInteger();
            var _local_2:int = _arg_1.readInteger();
            var _local_3:int;
            while (_local_3 < _local_2) {
                this._conflictingActions.push(_arg_1.readInteger());
                _local_3++;
            };
        }
        public function get triggerConf():int
        {
            return (this._code);
        }
        override public function get code():int
        {
            return (this._code);
        }
        public function get conflictingActions():Array
        {
            return (this._conflictingActions);
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.userdefinedroomevents

// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// Triggerable = "_-2oD" (String#7043, DoABC#2)
// TriggerDefinition = "_-2ov" (String#7057, DoABC#2)
// code = "_-12Y" (String#4926, DoABC#2)
// _code = "_-0As" (String#14483, DoABC#2)
// _conflictingActions = "_-1Uf" (String#17691, DoABC#2)
// triggerConf = "_-1VR" (String#17717, DoABC#2)
// conflictingActions = "_-0T5" (String#15174, DoABC#2)


