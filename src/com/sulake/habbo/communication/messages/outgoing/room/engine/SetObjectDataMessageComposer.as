
package com.sulake.habbo.communication.messages.outgoing.room.engine
{
    import com.sulake.core.communication.messages.IMessageComposer;
    import com.sulake.core.utils.Map;

    public class SetObjectDataMessageComposer implements IMessageComposer 
    {

        private var _data:Array;

        public function SetObjectDataMessageComposer(_arg_1:int, _arg_2:Map, _arg_3:int=0, _arg_4:int=0)
        {
            var _local_5:String;
            this._data = [];
            super();
            this._data.push(_arg_1);
            this._data.push((_arg_2.length * 2));
            for each (_local_5 in _arg_2.getKeys()) {
                this._data.push(_local_5);
                this._data.push(_arg_2.getValue(_local_5));
            };
        }
        public function dispose():void
        {
            this._data = null;
        }
        public function getMessageArray():Array
        {
            return (this._data);
        }

    }
}//package com.sulake.habbo.communication.messages.outgoing.room.engine

// SetObjectDataMessageComposer = "_-Go" (String#22882, DoABC#2)
// getMessageArray = "_-2vs" (String#7197, DoABC#2)


