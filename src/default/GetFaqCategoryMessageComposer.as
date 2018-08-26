
package default
{
    import com.sulake.core.communication.messages.IMessageComposer;

    public class GetFaqCategoryMessageComposer implements IMessageComposer 
    {

        private var _categoryId:int;

        public function GetFaqCategoryMessageComposer(_arg_1:int)
        {
            this._categoryId = _arg_1;
        }
        public function getMessageArray():Array
        {
            return ([this._categoryId]);
        }
        public function dispose():void
        {
        }

    }
}//package default

// GetFaqCategoryMessageComposer = "_-Zf" (String#23622, DoABC#2)
// getMessageArray = "_-2vs" (String#7197, DoABC#2)
// _categoryId = "_-1If" (String#186, DoABC#2)


