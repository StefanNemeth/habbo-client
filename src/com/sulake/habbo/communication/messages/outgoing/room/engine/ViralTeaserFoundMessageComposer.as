
package com.sulake.habbo.communication.messages.outgoing.room.engine
{
    import com.sulake.core.communication.messages.IMessageComposer;

    public class ViralTeaserFoundMessageComposer implements IMessageComposer 
    {

        private var _roomId:int;
        private var _roomCategory:int;

        public function ViralTeaserFoundMessageComposer(_arg_1:int=0, _arg_2:int=0)
        {
            this._roomId = _arg_1;
            this._roomCategory = _arg_2;
        }
        public function dispose():void
        {
        }
        public function getMessageArray():Array
        {
            return ([]);
        }

    }
}//package com.sulake.habbo.communication.messages.outgoing.room.engine

// ViralTeaserFoundMessageComposer = "_-05s" (String#14277, DoABC#2)
// getMessageArray = "_-2vs" (String#7197, DoABC#2)


