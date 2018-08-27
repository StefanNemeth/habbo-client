
package com.sulake.habbo.inventory
{
    import flash.utils.Timer;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.core.window.IWindowContainer;
    import flash.display.BitmapData;
    import flash.events.TimerEvent;
    import com.sulake.core.assets.BitmapDataAsset;
    import com.sulake.core.window.components.ITextWindow;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import flash.geom.Rectangle;
    import flash.geom.Point;

    public class ItemPopupCtrl 
    {

        public static const _SafeStr_11664:int = 1;
        public static const _SafeStr_11602:int = 2;
        private static const _SafeStr_11665:int = 5;
        private static const _SafeStr_11666:int = 250;
        private static const _SafeStr_11667:int = 100;
        private static const _SafeStr_11668:int = 180;
        private static const _SafeStr_11669:int = 200;

        private var _SafeStr_11670:Timer;
        private var _SafeStr_11671:Timer;
        private var _assets:IAssetLibrary;
        private var _SafeStr_11672:IWindowContainer;
        private var _parent:IWindowContainer;
        private var _SafeStr_11673:int = 2;
        private var _SafeStr_11674:BitmapData;
        private var _SafeStr_11675:BitmapData;

        public function ItemPopupCtrl(_arg_1:IWindowContainer, _arg_2:IAssetLibrary)
        {
            this._SafeStr_11670 = new Timer(_SafeStr_11666, 1);
            this._SafeStr_11671 = new Timer(_SafeStr_11667, 1);
            super();
            if (_arg_1 == null){
                return;
            };
            if (_arg_2 == null){
                return;
            };
            this._SafeStr_11672 = _arg_1;
            this._SafeStr_11672.visible = false;
            this._assets = _arg_2;
            this._SafeStr_11670.addEventListener(TimerEvent.TIMER, this.onDisplayTimer);
            this._SafeStr_11671.addEventListener(TimerEvent.TIMER, this.onHideTimer);
            var _local_3:BitmapDataAsset = (this._assets.getAssetByName("popup_arrow_right_png") as BitmapDataAsset);
            if (((!((_local_3 == null))) && (!((_local_3.content == null))))){
                this._SafeStr_11675 = (_local_3.content as BitmapData);
            };
            _local_3 = (this._assets.getAssetByName("popup_arrow_left_png") as BitmapDataAsset);
            if (((!((_local_3 == null))) && (!((_local_3.content == null))))){
                this._SafeStr_11674 = (_local_3.content as BitmapData);
            };
        }
        public function dispose():void
        {
            if (this._SafeStr_11670 != null){
                this._SafeStr_11670.removeEventListener(TimerEvent.TIMER, this.onDisplayTimer);
                this._SafeStr_11670.stop();
                this._SafeStr_11670 = null;
            };
            if (this._SafeStr_11671 != null){
                this._SafeStr_11671.removeEventListener(TimerEvent.TIMER, this.onHideTimer);
                this._SafeStr_11671.stop();
                this._SafeStr_11671 = null;
            };
            this._assets = null;
            this._SafeStr_11672 = null;
            this._parent = null;
            this._SafeStr_11674 = null;
            this._SafeStr_11675 = null;
        }
        public function updateContent(_arg_1:IWindowContainer, _arg_2:String, _arg_3:BitmapData, _arg_4:int=2):void
        {
            var _local_7:BitmapData;
            if (this._SafeStr_11672 == null){
                return;
            };
            if (_arg_1 == null){
                return;
            };
            if (_arg_3 == null){
                _arg_3 = new BitmapData(1, 1, true, 0xFFFFFF);
            };
            if (this._parent != null){
                this._parent.removeChild(this._SafeStr_11672);
            };
            this._parent = _arg_1;
            this._SafeStr_11673 = _arg_4;
            var _local_5:ITextWindow = ITextWindow(this._SafeStr_11672.findChildByName("item_name_text"));
            if (_local_5){
                _local_5.text = _arg_2;
            };
            var _local_6:IBitmapWrapperWindow = (this._SafeStr_11672.findChildByName("item_image") as IBitmapWrapperWindow);
            if (_local_6){
                _local_7 = new BitmapData(Math.min(_SafeStr_11668, _arg_3.width), Math.min(_SafeStr_11669, _arg_3.height), true, 0xFFFFFF);
                _local_7.copyPixels(_arg_3, new Rectangle(0, 0, _local_7.width, _local_7.height), new Point(0, 0), null, null, true);
                _local_6.bitmap = _local_7;
                _local_6.width = _local_6.bitmap.width;
                _local_6.height = _local_6.bitmap.height;
                _local_6.x = ((this._SafeStr_11672.width - _local_6.width) / 2);
                this._SafeStr_11672.height = (_local_6.rectangle.bottom + 10);
            };
        }
        public function show():void
        {
            this._SafeStr_11671.reset();
            this._SafeStr_11670.reset();
            if (this._parent == null){
                return;
            };
            this._SafeStr_11672.visible = true;
            this._parent.addChild(this._SafeStr_11672);
            this.refreshArrow(this._SafeStr_11673);
            switch (this._SafeStr_11673){
                case _SafeStr_11664:
                    this._SafeStr_11672.x = ((-1 * this._SafeStr_11672.width) - _SafeStr_11665);
                    break;
                case _SafeStr_11602:
                    this._SafeStr_11672.x = (this._parent.width + _SafeStr_11665);
                    break;
            };
            this._SafeStr_11672.y = ((this._parent.height - this._SafeStr_11672.height) / 2);
        }
        public function hide():void
        {
            this._SafeStr_11672.visible = false;
            this._SafeStr_11671.reset();
            this._SafeStr_11670.reset();
            if (this._parent != null){
                this._parent.removeChild(this._SafeStr_11672);
            };
        }
        public function showDelayed():void
        {
            this._SafeStr_11671.reset();
            this._SafeStr_11670.reset();
            this._SafeStr_11670.start();
        }
        public function hideDelayed():void
        {
            this._SafeStr_11671.reset();
            this._SafeStr_11670.reset();
            this._SafeStr_11671.start();
        }
        private function refreshArrow(_arg_1:int=2):void
        {
            if ((((this._SafeStr_11672 == null)) || (this._SafeStr_11672.disposed))){
                return;
            };
            var _local_2:IBitmapWrapperWindow = IBitmapWrapperWindow(this._SafeStr_11672.findChildByName("arrow_pointer"));
            if (!_local_2){
                return;
            };
            switch (_arg_1){
                case _SafeStr_11664:
                    _local_2.bitmap = this._SafeStr_11675.clone();
                    _local_2.width = this._SafeStr_11675.width;
                    _local_2.height = this._SafeStr_11675.height;
                    _local_2.y = ((this._SafeStr_11672.height - this._SafeStr_11675.height) / 2);
                    _local_2.x = (this._SafeStr_11672.width - 1);
                    break;
                case _SafeStr_11602:
                    _local_2.bitmap = this._SafeStr_11674.clone();
                    _local_2.width = this._SafeStr_11674.width;
                    _local_2.height = this._SafeStr_11674.height;
                    _local_2.y = ((this._SafeStr_11672.height - this._SafeStr_11674.height) / 2);
                    _local_2.x = ((-1 * this._SafeStr_11674.width) + 1);
                    break;
            };
            _local_2.invalidate();
        }
        private function onDisplayTimer(_arg_1:TimerEvent):void
        {
            this.show();
        }
        private function onHideTimer(_arg_1:TimerEvent):void
        {
            this.hide();
        }

    }
}//package com.sulake.habbo.inventory

// onDisplayTimer = "_-0bX" (String#1508, DoABC#2)
// onHideTimer = "_-lJ" (String#2176, DoABC#2)
// updateContent = "_-N5" (String#23127, DoABC#2)
// _SafeStr_11602 = "_-14h" (String#16641, DoABC#2)
// hideDelayed = "_-2Ey" (String#19602, DoABC#2)
// _SafeStr_11664 = "_-1KK" (String#17287, DoABC#2)
// _SafeStr_11665 = "_-0WI" (String#15291, DoABC#2)
// _SafeStr_11666 = "_-1My" (String#17398, DoABC#2)
// _SafeStr_11667 = "_-0yD" (String#16361, DoABC#2)
// _SafeStr_11668 = "_-0s" (String#16121, DoABC#2)
// _SafeStr_11669 = "_-1C-" (String#16942, DoABC#2)
// _SafeStr_11670 = "_-1wj" (String#18832, DoABC#2)
// _SafeStr_11671 = "_-d9" (String#23765, DoABC#2)
// _SafeStr_11672 = "_-3q" (String#22369, DoABC#2)
// _SafeStr_11673 = "_-9J" (String#22591, DoABC#2)
// _SafeStr_11674 = "_-2c5" (String#20526, DoABC#2)
// _SafeStr_11675 = "_-0X9" (String#15320, DoABC#2)
// refreshArrow = "_-2Jt" (String#6436, DoABC#2)
// showDelayed = "_-DK" (String#22743, DoABC#2)
// BitmapDataAsset = "_-0PB" (String#4074, DoABC#2)
// ItemPopupCtrl = "_-0QF" (String#15073, DoABC#2)


