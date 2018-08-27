
package com.sulake.habbo.ui.widget.furniture.dimmer
{
    import com.sulake.core.window.IWindowContainer;
    import flash.display.BitmapData;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import flash.geom.Point;
    import com.sulake.core.assets.BitmapDataAsset;

    public class DimmerViewAlphaSlider 
    {

        private var _view:DimmerView;
        private var _sliderContainer:IWindowContainer;
        private var _SafeStr_3956:BitmapData;
        private var _SafeStr_3957:BitmapData;
        private var _SafeStr_3958:int;
        private var _SafeStr_13962:int;
        private var _minValue:int = 0;
        private var _max:int = 0xFF;

        public function DimmerViewAlphaSlider(_arg_1:DimmerView, _arg_2:IWindowContainer, _arg_3:IAssetLibrary, _arg_4:int=0, _arg_5:int=0xFF)
        {
            this._view = _arg_1;
            this._sliderContainer = _arg_2;
            this._minValue = _arg_4;
            this._max = _arg_5;
            this.storeAssets(_arg_3);
            this.displaySlider();
        }
        public function dispose():void
        {
            this._view = null;
            this._sliderContainer = null;
            this._SafeStr_3956 = null;
            this._SafeStr_3957 = null;
        }
        public function setValue(_arg_1:int):void
        {
            if (this._sliderContainer == null){
                return;
            };
            var _local_2:IWindow = this._sliderContainer.findChildByName("slider_button");
            if (_local_2 != null){
                _local_2.x = this.getSliderPosition(_arg_1);
            };
        }
        public function set min(_arg_1:Number):void
        {
            this._minValue = _arg_1;
            this.setValue(this._view.selectedBrightness);
        }
        public function set max(_arg_1:Number):void
        {
            this._max = _arg_1;
            this.setValue(this._view.selectedBrightness);
        }
        private function getSliderPosition(_arg_1:int):int
        {
            return (int((this._SafeStr_3958 * (Number((_arg_1 - this._minValue)) / (this._max - this._minValue)))));
        }
        private function getValue(_arg_1:Number):int
        {
            return ((int(((_arg_1 / this._SafeStr_3958) * (this._max - this._minValue))) + this._minValue));
        }
        private function buttonProcedure(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (((!((_arg_1.type == WindowMouseEvent.WME_UP))) && (!((_arg_1.type == WindowMouseEvent.WME_UP_OUTSIDE))))){
                return;
            };
            this._view.selectedBrightness = this.getValue(_arg_2.x);
        }
        private function displaySlider():void
        {
            var _local_1:IWindowContainer;
            var _local_2:IBitmapWrapperWindow;
            if (this._sliderContainer == null){
                return;
            };
            _local_2 = (this._sliderContainer.findChildByName("slider_base") as IBitmapWrapperWindow);
            if (((!((_local_2 == null))) && (!((this._SafeStr_3956 == null))))){
                _local_2.bitmap = new BitmapData(this._SafeStr_3956.width, this._SafeStr_3956.height, true, 0xFFFFFF);
                _local_2.bitmap.copyPixels(this._SafeStr_3956, this._SafeStr_3956.rect, new Point(0, 0), null, null, true);
            };
            _local_1 = (this._sliderContainer.findChildByName("slider_movement_area") as IWindowContainer);
            if (_local_1 != null){
                _local_2 = (_local_1.findChildByName("slider_button") as IBitmapWrapperWindow);
                if (((!((_local_2 == null))) && (!((this._SafeStr_3957 == null))))){
                    _local_2.bitmap = new BitmapData(this._SafeStr_3957.width, this._SafeStr_3957.height, true, 0xFFFFFF);
                    _local_2.bitmap.copyPixels(this._SafeStr_3957, this._SafeStr_3957.rect, new Point(0, 0), null, null, true);
                    _local_2.procedure = this.buttonProcedure;
                    this._SafeStr_3958 = (_local_1.width - _local_2.width);
                };
            };
        }
        private function storeAssets(_arg_1:IAssetLibrary):void
        {
            var _local_2:BitmapDataAsset;
            if (_arg_1 == null){
                return;
            };
            _local_2 = BitmapDataAsset(_arg_1.getAssetByName("dimmer_slider_base"));
            this._SafeStr_3956 = BitmapData(_local_2.content);
            _local_2 = BitmapDataAsset(_arg_1.getAssetByName("dimmer_slider_button"));
            this._SafeStr_3957 = BitmapData(_local_2.content);
        }

    }
}//package com.sulake.habbo.ui.widget.furniture.dimmer

// WindowEvent = "_-Jh" (String#2085, DoABC#2)
// BitmapDataAsset = "_-0PB" (String#4074, DoABC#2)
// selectedBrightness = "_-02h" (String#14148, DoABC#2)
// _SafeStr_13962 = "_-3D9" (String#22001, DoABC#2)
// DimmerView = "_-1QW" (String#5361, DoABC#2)
// DimmerViewAlphaSlider = "_-1Oj" (String#5328, DoABC#2)
// _SafeStr_3956 = "_-1ds" (String#1728, DoABC#2)
// _SafeStr_3957 = "_-pS" (String#2201, DoABC#2)
// _SafeStr_3958 = "_-0zE" (String#1593, DoABC#2)
// _max = "_-0Os" (String#1462, DoABC#2)
// displaySlider = "_-2mk" (String#1938, DoABC#2)
// getSliderPosition = "_-0BT" (String#1421, DoABC#2)
// buttonProcedure = "_-1aH" (String#5565, DoABC#2)
// WME_UP_OUTSIDE = "_-2qi" (String#21110, DoABC#2)
// WME_UP = "_-0Cs" (String#14566, DoABC#2)


