
package com.sulake.habbo.advertisement
{
    public class AdImageRequest 
    {

        private var _roomId:int;
        private var _roomCategory:int;
        private var _objectId:int;
        private var _objectCategory:int;
        private var _imageURL:String;
        private var _clickURL:String;

        public function AdImageRequest(_arg_1:int, _arg_2:int, _arg_3:String=null, _arg_4:String=null, _arg_5:int=-1, _arg_6:int=-1)
        {
            this._roomId = _arg_1;
            this._roomCategory = _arg_2;
            this._objectId = _arg_5;
            this._objectCategory = _arg_6;
            this._imageURL = _arg_3;
            this._clickURL = _arg_4;
        }
        public function get roomId():int
        {
            return (this._roomId);
        }
        public function get roomCategory():int
        {
            return (this._roomCategory);
        }
        public function get objectId():int
        {
            return (this._objectId);
        }
        public function get objectCategory():int
        {
            return (this._objectCategory);
        }
        public function get imageURL():String
        {
            return (this._imageURL);
        }
        public function get clickURL():String
        {
            return (this._clickURL);
        }

    }
}//package com.sulake.habbo.advertisement

// AdImageRequest = "_-2tt" (String#7157, DoABC#2)
// _objectId = "_-1YP" (String#18, DoABC#2)
// _objectCategory = "_-2Bf" (String#367, DoABC#2)
// _clickURL = "_-00g" (String#3575, DoABC#2)
// clickURL = "_-0-5" (String#14015, DoABC#2)
// _imageURL = "_-1lT" (String#18351, DoABC#2)
// imageURL = "_-1v5" (String#18759, DoABC#2)


