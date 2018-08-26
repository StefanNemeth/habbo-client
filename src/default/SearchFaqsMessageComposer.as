
package default
{
    import com.sulake.core.communication.messages.IMessageComposer;

    public class SearchFaqsMessageComposer implements IMessageComposer 
    {

        private var _SafeStr_10264:String;

        public function SearchFaqsMessageComposer(_arg_1:String)
        {
            this._SafeStr_10264 = _arg_1;
        }
        public function getMessageArray():Array
        {
            return ([this._SafeStr_10264]);
        }
        public function dispose():void
        {
        }

    }
}//package default

// _SafeStr_10264 = "_-1NM" (String#5300, DoABC#2)
// SearchFaqsMessageComposer = "_-1ud" (String#18742, DoABC#2)
// getMessageArray = "_-2vs" (String#7197, DoABC#2)


