
package com.sulake.habbo.session
{
    import flash.display.BitmapData;

    public class BadgeInfo 
    {

        private var _image:BitmapData;
        private var _placeHolder:Boolean;

        public function BadgeInfo(_arg_1:BitmapData, _arg_2:Boolean)
        {
            this._image = _arg_1;
            this._placeHolder = _arg_2;
        }
        public function get image():BitmapData
        {
            return (this._image);
        }
        public function get placeHolder():Boolean
        {
            return (this._placeHolder);
        }

    }
}//package com.sulake.habbo.session

// _placeHolder = "_-1t6" (String#18681, DoABC#2)
// BadgeInfo = "_-3V" (String#7736, DoABC#2)
// _image = "_-35u" (String#78, DoABC#2)


