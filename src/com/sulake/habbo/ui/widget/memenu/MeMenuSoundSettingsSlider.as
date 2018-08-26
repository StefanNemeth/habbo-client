
package com.sulake.habbo.ui.widget.memenu
{
    import com.sulake.core.window.IWindowContainer;
    import flash.display.BitmapData;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import flash.geom.Point;
    import com.sulake.core.assets.BitmapDataAsset;

    public class MeMenuSoundSettingsSlider 
    {

        private var _SafeStr_3955:MeMenuSoundSettingsView;
        private var _sliderContainer:IWindowContainer;
        private var _SafeStr_3956:BitmapData;
        private var _DimmerViewAlphaSlider:BitmapData;
        private var _SafeStr_3958:int;
        private var _minValue:Number = 0;
        private var _max:Number = 1;

        public function MeMenuSoundSettingsSlider(_arg_1:MeMenuSoundSettingsView, _arg_2:IWindowContainer, _arg_3:IAssetLibrary, _arg_4:Number=0, _arg_5:Number=1)
        {
            this._SafeStr_3955 = _arg_1;
            this._sliderContainer = _arg_2;
            this._minValue = _arg_4;
            this._max = _arg_5;
            this.storeAssets(_arg_3);
            this.DimmerViewAlphaSlider();
        }
        public function dispose():void
        {
            this._SafeStr_3955 = null;
            this._sliderContainer = null;
            this._SafeStr_3956 = null;
            this._DimmerViewAlphaSlider = null;
        }
        public function setValue(_arg_1:Number):void
        {
            if (this._sliderContainer == null){
                return;
            };
            var _local_2:IWindow = this._sliderContainer.findChildByName("slider_button");
            if (_local_2 != null){
                _local_2.x = this.DimmerViewAlphaSlider(_arg_1);
            };
        }
        private function DimmerViewAlphaSlider(_arg_1:Number):int
        {
            return (int((this._SafeStr_3958 * (Number((_arg_1 - this._minValue)) / (this._max - this._minValue)))));
        }
        private function getValue(_arg_1:Number):Number
        {
            return ((((_arg_1 / this._SafeStr_3958) * (this._max - this._minValue)) + this._minValue));
        }
        private function DimmerViewAlphaSlider(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type != WindowEvent.WE_RELOCATED){
                return;
            };
            this._SafeStr_3955.MeMenuSoundSettingsView(this.getValue(_arg_2.x), false);
        }
        private function DimmerViewAlphaSlider():void
        {
            var _local_1:IWindowContainer;
            var _local_2:IWindowContainer;
            var _local_3:IBitmapWrapperWindow;
            if (this._sliderContainer == null){
                return;
            };
            _local_3 = (this._sliderContainer.findChildByName("slider_base") as IBitmapWrapperWindow);
            if (((!((_local_3 == null))) && (!((this._SafeStr_3956 == null))))){
                _local_3.bitmap = new BitmapData(this._SafeStr_3956.width, this._SafeStr_3956.height, true, 0xFFFFFF);
                _local_3.bitmap.copyPixels(this._SafeStr_3956, this._SafeStr_3956.rect, new Point(0, 0), null, null, true);
            };
            _local_1 = (this._sliderContainer.findChildByName("slider_movement_area") as IWindowContainer);
            if (_local_1 != null){
                _local_2 = (_local_1.findChildByName("slider_button") as IWindowContainer);
                if (_local_2 != null){
                    _local_3 = (_local_2.findChildByName("slider_bitmap") as IBitmapWrapperWindow);
                    if (((!((_local_3 == null))) && (!((this._DimmerViewAlphaSlider == null))))){
                        _local_3.bitmap = new BitmapData(this._DimmerViewAlphaSlider.width, this._DimmerViewAlphaSlider.height, true, 0xFFFFFF);
                        _local_3.bitmap.copyPixels(this._DimmerViewAlphaSlider, this._DimmerViewAlphaSlider.rect, new Point(0, 0), null, null, true);
                        _local_2.procedure = this.DimmerViewAlphaSlider;
                        this._SafeStr_3958 = (_local_1.width - _local_3.width);
                    };
                };
            };
        }
        private function storeAssets(_arg_1:IAssetLibrary):void
        {
            var _local_2:BitmapDataAsset;
            if (_arg_1 == null){
                return;
            };
            _local_2 = BitmapDataAsset(_arg_1.getAssetByName("memenu_settings_slider_base"));
            this._SafeStr_3956 = BitmapData(_local_2.content);
            _local_2 = BitmapDataAsset(_arg_1.getAssetByName("memenu_settings_slider_button"));
            this._DimmerViewAlphaSlider = BitmapData(_local_2.content);
        }

    }
}//package com.sulake.habbo.ui.widget.memenu

// WindowEvent = "_-Jh" (String#2085, DoABC#2)
// BitmapDataAsset = "_-0PB" (String#4074, DoABC#2)
// MeMenuSoundSettingsView = "_-2Vd" (String#6676, DoABC#2)
// MeMenuSoundSettingsSlider = "_-4n" (String#7761, DoABC#2)
// MeMenuSoundSettingsView = "_-1-3" (String#16432, DoABC#2)
// _SafeStr_3955 = "_-i6" (String#23969, DoABC#2)
// _SafeStr_3956 = "_-1ds" (String#1728, DoABC#2)
// _DimmerViewAlphaSlider = "_-pS" (String#2201, DoABC#2)
// _SafeStr_3958 = "_-0zE" (String#1593, DoABC#2)
// _max = "_-0Os" (String#1462, DoABC#2)
// DimmerViewAlphaSlider = "_-2mk" (String#1938, DoABC#2)
// DimmerViewAlphaSlider = "_-0BT" (String#1421, DoABC#2)
// DimmerViewAlphaSlider = "_-1aH" (String#5565, DoABC#2)
// WE_RELOCATED = "_-13s" (String#16612, DoABC#2)


