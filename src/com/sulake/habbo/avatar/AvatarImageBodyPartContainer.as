
package com.sulake.habbo.avatar
{
    import flash.display.BitmapData;
    import flash.geom.Point;

    public class AvatarImageBodyPartContainer 
    {

        private var _image:BitmapData;
        private var _regpoint:Point;
        private var _offset:Point;

        public function AvatarImageBodyPartContainer(_arg_1:BitmapData, _arg_2:Point)
        {
            this._offset = new Point(0, 0);
            super();
            this._image = _arg_1;
            this._regpoint = _arg_2;
            this.AvatarImageBodyPartContainer();
        }
        public function dispose():void
        {
            if (this._image){
                this._image.dispose();
            };
            this._image = null;
            this._regpoint = null;
            this._offset = null;
        }
        public function set image(_arg_1:BitmapData):void
        {
            this._image = _arg_1;
        }
        public function get image():BitmapData
        {
            return (this._image);
        }
        public function setRegPoint(_arg_1:Point):void
        {
            this._regpoint = _arg_1;
            this.AvatarImageBodyPartContainer();
        }
        public function get regPoint():Point
        {
            return (this._regpoint.add(this._offset));
        }
        public function set offset(_arg_1:Point):void
        {
            this._offset = _arg_1;
            this.AvatarImageBodyPartContainer();
        }
        private function AvatarImageBodyPartContainer():void
        {
            this._regpoint.x = int(this._regpoint.x);
            this._regpoint.y = int(this._regpoint.y);
            this._offset.x = int(this._offset.x);
            this._offset.y = int(this._offset.y);
        }

    }
}//package com.sulake.habbo.avatar

// regPoint = "_-UQ" (String#23428, DoABC#2)
// AvatarImageBodyPartContainer = "_-PD" (String#23216, DoABC#2)
// setRegPoint = "_-0is" (String#15785, DoABC#2)
// AvatarImageBodyPartContainer = "_-Mm" (String#8137, DoABC#2)
// _image = "_-35u" (String#78, DoABC#2)
// _regpoint = "_-2Cn" (String#6299, DoABC#2)


