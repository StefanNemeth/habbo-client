
package com.sulake.habbo.communication.messages.outgoing.quest
{
    import com.sulake.core.communication.messages.IMessageComposer;

    public class StartCampaignMessageComposer implements IMessageComposer 
    {

        private var _data:Array;

        public function StartCampaignMessageComposer(_arg_1:String, _arg_2:Boolean)
        {
            this._data = [];
            super();
            this._data.push(_arg_1, _arg_2);
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
}//package com.sulake.habbo.communication.messages.outgoing.quest

// StartCampaignMessageComposer = "_-2Vv" (String#20278, DoABC#2)
// getMessageArray = "_-2vs" (String#7197, DoABC#2)


