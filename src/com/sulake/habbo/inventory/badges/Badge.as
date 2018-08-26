
package com.sulake.habbo.inventory.badges
{
    import com.sulake.habbo.inventory.common.IThumbListDrawableItem;
    import flash.display.BitmapData;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import flash.geom.Point;

    public class Badge implements IThumbListDrawableItem 
    {

        private static const _SafeStr_8489:int = 0xCCCCCC;
        private static const _hasUnseenItems:int = 10275685;

        private var _type:String;
        private var _isInUse:Boolean;
        private var _isSelected:Boolean;
        private var _image:BitmapData;
        private var _window:IWindowContainer;
        private var _SafeStr_8491:IWindow;
        private var _SafeStr_8492:IWindow;
        private var _SafeStr_8495:Boolean;

        public function Badge(_arg_1:String, _arg_2:IWindowContainer, _arg_3:Boolean)
        {
            this._image = new BitmapData(1, 1, false, 0xFF00FF00);
            super();
            this._type = _arg_1;
            this._window = _arg_2;
            this._SafeStr_8491 = this._window.findChildByTag("BG_COLOR");
            this._SafeStr_8492 = this._window.findChildByName("outline");
            this._SafeStr_8495 = _arg_3;
            this.isSelected = false;
        }
        public function get type():String
        {
            return (this._type);
        }
        public function get isInUse():Boolean
        {
            return (this._isInUse);
        }
        public function get isSelected():Boolean
        {
            return (this._isSelected);
        }
        public function get iconImage():BitmapData
        {
            return (this._image);
        }
        public function get window():IWindowContainer
        {
            return (this._window);
        }
        public function set isInUse(_arg_1:Boolean):void
        {
            this._isInUse = _arg_1;
        }
        public function set isSelected(_arg_1:Boolean):void
        {
            this._isSelected = _arg_1;
            if (this._SafeStr_8491 == null){
                return;
            };
            this._SafeStr_8491.color = ((this._SafeStr_8495) ? _hasUnseenItems : _SafeStr_8489);
            this._SafeStr_8492.visible = _arg_1;
        }
        public function set iconImage(_arg_1:BitmapData):void
        {
            this._image = _arg_1;
            if (this._image == null){
                return;
            };
            if (this._window == null){
                return;
            };
            var _local_2:IBitmapWrapperWindow = (this._window.findChildByName("bitmap") as IBitmapWrapperWindow);
            if (_local_2 == null){
                return;
            };
            var _local_3:BitmapData = ((_local_2.bitmap) ? _local_2.bitmap : new BitmapData(_local_2.width, _local_2.height));
            _local_3.fillRect(_local_3.rect, 0);
            _local_3.copyPixels(_arg_1, _arg_1.rect, new Point(((_local_3.width / 2) - (_arg_1.width / 2)), ((_local_3.height / 2) - (_arg_1.height / 2))));
            _local_2.bitmap = _local_3;
        }
        public function set isUnseen(_arg_1:Boolean):void
        {
            if (this._SafeStr_8495 != _arg_1){
                this._SafeStr_8495 = _arg_1;
                this.isSelected = this._isSelected;
            };
        }

    }
}//package com.sulake.habbo.inventory.badges

// IThumbListDrawableItem = "_-Sg" (String#8260, DoABC#2)
// Badge = "_-244" (String#19179, DoABC#2)
// isInUse = "_-2LN" (String#6469, DoABC#2)
// _image = "_-35u" (String#78, DoABC#2)
// iconImage = "_-0Pn" (String#4088, DoABC#2)
// _isInUse = "_-Zn" (String#8413, DoABC#2)
// isUnseen = "_-FH" (String#22825, DoABC#2)
// _SafeStr_8489 = "_-1YT" (String#1708, DoABC#2)
// _hasUnseenItems = "_-ZF" (String#2132, DoABC#2)
// _SafeStr_8491 = "_-2y0" (String#903, DoABC#2)
// _SafeStr_8492 = "_-zz" (String#2236, DoABC#2)
// _SafeStr_8495 = "_-2vp" (String#7196, DoABC#2)


