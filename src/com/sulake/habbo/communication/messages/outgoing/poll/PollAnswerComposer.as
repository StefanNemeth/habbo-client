
package com.sulake.habbo.communication.messages.outgoing.poll
{
    import com.sulake.core.communication.messages.IMessageComposer;

    public class PollAnswerComposer implements IMessageComposer 
    {

        private var _data:Array;

        public function PollAnswerComposer(_arg_1:int, _arg_2:int, _arg_3:Array)
        {
            var _local_4:int;
            super();
            this._data = [_arg_1, _arg_2];
            if ((_arg_3[0] is String)){
                this._data.push(1);
                this._data.push(_arg_3[0]);
            }
            else {
                this._data.push(_arg_3.length);
                _local_4 = 0;
                while (_local_4 < _arg_3.length) {
                    this._data.push(String(_arg_3[_local_4]));
                    _local_4++;
                };
            };
        }
        public function getMessageArray():Array
        {
            return (this._data);
        }
        public function dispose():void
        {
            this._data = null;
        }

    }
}//package com.sulake.habbo.communication.messages.outgoing.poll

// PollAnswerComposer = "_-0P6" (String#15030, DoABC#2)
// getMessageArray = "_-2vs" (String#7197, DoABC#2)


