
package com.sulake.core.communication.messages
{
    import flash.utils.Dictionary;
    import flash.utils.describeType;
    import flash.utils.getQualifiedClassName;
    import flash.events.*;
    import flash.xml.*;

    public class MessageClassManager implements IMessageClassManager 
    {

        private var _SafeStr_8847:Dictionary;
        private var _SafeStr_8848:Dictionary;

        public function MessageClassManager()
        {
            this._SafeStr_8847 = new Dictionary();
            this._SafeStr_8848 = new Dictionary();
        }
        public function registerMessages(_arg_1:IMessageConfiguration):Boolean
        {
            var _local_2:String;
            for (_local_2 in _arg_1.events) {
                this.registerMessageEvent(parseInt(_local_2), _arg_1.events[_local_2]);
            };
            for (_local_2 in _arg_1.composers) {
                this.registerMessageComposer(parseInt(_local_2), _arg_1.composers[_local_2]);
            };
            return (true);
        }
        private function registerMessageComposer(_arg_1:int, _arg_2:Class):Boolean
        {
            var _local_6:XML;
            var _local_3:XML = describeType(_arg_2);
            var _local_4:Boolean;
            var _local_5:String = getQualifiedClassName(IMessageComposer);
            for each (_local_6 in _local_3..implementsInterface) {
                if (_local_6.@type == _local_5){
                    _local_4 = true;
                    break;
                };
            };
            if (_local_4){
                this._SafeStr_8847[_arg_1] = _arg_2;
                return (true);
            };
            throw (new Error((("Invalid Message Composer class defined for message id: " + _arg_1) + "!")));
        }
        private function registerMessageEvent(_arg_1:int, _arg_2:Class):Boolean
        {
            var _local_5:Array;
            var _local_3:XML = describeType(_arg_2);
            var _local_4:String = getQualifiedClassName(IMessageEvent);
            if (_local_3..implementsInterface.@type == _local_4){
                Logger.log((("Message Event ID: " + _arg_1) + " implements IMessageEvent"));
                if (this._SafeStr_8848[_arg_1] == null){
                    this._SafeStr_8848[_arg_1] = [_arg_2];
                }
                else {
                    _local_5 = this._SafeStr_8848[_arg_1];
                    _local_5.push(_arg_2);
                };
                return (true);
            };
            throw (new Error((("Invalid Message Event class defined for message id: " + _arg_1) + " does not implement IMessageEvent")));
        }
        public function getMessageComposerID(_arg_1:IMessageComposer):int
        {
            var _local_3:String;
            var _local_4:Class;
            var _local_2:int = -1;
            for (_local_3 in this._SafeStr_8847) {
                _local_4 = (this._SafeStr_8847[_local_3] as Class);
                if ((_arg_1 is _local_4)){
                    _local_2 = parseInt(_local_3);
                    break;
                };
            };
            return (_local_2);
        }
        public function getMessageEventClasses(_arg_1:int):Array
        {
            var _local_2:Array = this._SafeStr_8848[_arg_1];
            if (_local_2 != null){
                return (_local_2);
            };
            return ([]);
        }
        public function toString():String
        {
            var _local_1:String = "";
            var _local_2:String = "";
            _local_1 = (_local_1 + "Registered Message Composer Classes: \n");
            for (_local_2 in this._SafeStr_8847) {
                _local_1 = (_local_1 + (((_local_2 + " -> ") + this._SafeStr_8847[_local_2]) + "\n"));
            };
            _local_1 = (_local_1 + "Registered Message Event Classes: \n");
            for (_local_2 in this._SafeStr_8848) {
                _local_1 = (_local_1 + (((_local_2 + " -> ") + this._SafeStr_8848[_local_2]) + "\n"));
            };
            return (_local_1);
        }

    }
}//package com.sulake.core.communication.messages

// IMessageConfiguration = "_-EK" (String#7959, DoABC#2)
// IMessageClassManager = "_-2if" (String#6924, DoABC#2)
// getMessageComposerID = "_-2Ur" (String#6664, DoABC#2)
// registerMessages = "_-2Qq" (String#6573, DoABC#2)
// getMessageEventClasses = "_-1Uo" (String#5450, DoABC#2)
// _SafeStr_8847 = "_-16E" (String#16706, DoABC#2)
// _SafeStr_8848 = "_-ND" (String#23133, DoABC#2)
// registerMessageEvent = "_-2JF" (String#19778, DoABC#2)
// registerMessageComposer = "_-16p" (String#16728, DoABC#2)


