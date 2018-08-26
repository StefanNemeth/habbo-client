
package com.sulake.habbo.communication.messages.parser.inventory.achievements
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class AchievementsScoreMessageParser implements IMessageParser 
    {

        private var _score:int;

        public function flush():Boolean
        {
            return (true);
        }
        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            this._score = _arg_1.readInteger();
            return (true);
        }
        public function get score():int
        {
            return (this._score);
        }

    }
}//package com.sulake.habbo.communication.messages.parser.inventory.achievements

// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// AchievementsScoreMessageParser = "_-hH" (String#23941, DoABC#2)
// _score = "_-2ca" (String#1911, DoABC#2)
// IMessageParser = "_-5U" (String#7770, DoABC#2)


