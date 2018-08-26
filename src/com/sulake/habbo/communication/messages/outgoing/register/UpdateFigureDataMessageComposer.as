
package com.sulake.habbo.communication.messages.outgoing.register
{
    import com.sulake.core.communication.messages.IMessageComposer;

    public class UpdateFigureDataMessageComposer implements IMessageComposer 
    {

        private var _data:Array;

        public function UpdateFigureDataMessageComposer(_arg_1:String, _arg_2:String)
        {
            this._data = [];
            super();
            this._data.push(_arg_2);
            this._data.push(_arg_1);
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
}//package com.sulake.habbo.communication.messages.outgoing.register

// UpdateFigureDataMessageComposer = "_-0Qz" (String#15101, DoABC#2)
// getMessageArray = "_-2vs" (String#7197, DoABC#2)


