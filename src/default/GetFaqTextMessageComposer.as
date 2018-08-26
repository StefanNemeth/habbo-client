
package default
{
    import com.sulake.core.communication.messages.IMessageComposer;

    public class GetFaqTextMessageComposer implements IMessageComposer 
    {

        private var _questionId:int;

        public function GetFaqTextMessageComposer(_arg_1:int)
        {
            this._questionId = _arg_1;
        }
        public function getMessageArray():Array
        {
            return ([this._questionId]);
        }
        public function dispose():void
        {
        }

    }
}//package default

// GetFaqTextMessageComposer = "_-nR" (String#24169, DoABC#2)
// _questionId = "_-1oG" (String#865, DoABC#2)
// getMessageArray = "_-2vs" (String#7197, DoABC#2)


