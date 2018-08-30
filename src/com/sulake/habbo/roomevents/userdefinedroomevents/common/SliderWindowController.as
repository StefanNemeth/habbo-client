
package com.sulake.habbo.roomevents.userdefinedroomevents.common
{
    import com.sulake.core.runtime.events.EventDispatcher;
    import com.sulake.core.window.IWindowContainer;
    import flash.display.BitmapData;
    import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
    import com.sulake.core.assets.IAssetLibrary;
    import flash.events.Event;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import com.sulake.core.window.components.IContainerButtonWindow;
    import flash.geom.Point;
    import com.sulake.core.assets.BitmapDataAsset;

    public class SliderWindowController extends EventDispatcher 
    {

        private var _value:Number = 0;
        private var _sliderContainer:IWindowContainer;
        private var _SafeStr_4313:Boolean = false;
        private var _SafeStr_3956:BitmapData;
        private var _SafeStr_3957:BitmapData;
        private var _SafeStr_3958:int;
        private var _minValue:Number = 0;
        private var _max:Number = 1;
        private var _SafeStr_4314:Number = 0;

        public function SliderWindowController(_arg_1:HabboUserDefinedRoomEvents, _arg_2:IWindowContainer, _arg_3:IAssetLibrary, _arg_4:Number=0, _arg_5:Number=1, _arg_6:Number=0)
        {
            this._sliderContainer = IWindowContainer(_arg_1.getXmlWindow("ude_slider"));
            _arg_2.addChild(this._sliderContainer);
            this._minValue = _arg_4;
            this._max = _arg_5;
            this._SafeStr_4314 = _arg_6;
            this._value = 0;
            this.storeAssets(_arg_3);
            this.displaySlider();
        }
        override public function dispose():void
        {
            super.dispose();
            this._sliderContainer = null;
            this._SafeStr_3956 = null;
            this._SafeStr_3957 = null;
        }
        public function setValue(_arg_1:Number, _arg_2:Boolean=true):void
        {
            _arg_1 = Math.max(this._minValue, _arg_1);
            _arg_1 = Math.min(this._max, _arg_1);
            this._value = _arg_1;
            if (_arg_2){
                this.updateSliderPosition();
            };
            dispatchEvent(new Event(Event.CHANGE));
        }
        public function getValue():Number
        {
            return (this._value);
        }
        public function set min(_arg_1:Number):void
        {
            this._minValue = _arg_1;
        }
        public function set max(_arg_1:Number):void
        {
            this._max = _arg_1;
        }
        private function updateSliderPosition():void
        {
            if (this._sliderContainer == null){
                return;
            };
            var _local_1:IWindow = this._sliderContainer.findChildByName("slider_button");
            if (_local_1 != null){
                _local_1.x = this.getSliderPosition(this._value);
            };
            _local_1.parent.invalidate();
        }
        private function getSliderPosition(_arg_1:Number):int
        {
            return (int((this._SafeStr_3958 * (Number((_arg_1 - this._minValue)) / (this._max - this._minValue)))));
        }
        private function getValueAtPosition(_arg_1:Number):Number
        {
            return ((((_arg_1 / this._SafeStr_3958) * (this._max - this._minValue)) + this._minValue));
        }
        private function sliderProcedure(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            var _local_3:Number;
            var _local_4:Number;
            if (_arg_1.type == WindowMouseEvent.WME_DOWN){
                this._SafeStr_4313 = true;
            };
            if (this._SafeStr_4313){
                if ((((_arg_1.type == WindowMouseEvent.WME_UP)) || ((_arg_1.type == WindowMouseEvent.WME_UP_OUTSIDE)))){
                    this._SafeStr_4313 = false;
                };
            };
            if (((!(this._SafeStr_4313)) || (!((_arg_1.type == WindowEvent.WE_RELOCATED))))){
                return;
            };
            if (this._SafeStr_4314 != 0){
                _local_3 = this.getValueAtPosition(_arg_2.x);
                _local_4 = (Math.round((_local_3 / this._SafeStr_4314)) * this._SafeStr_4314);
                this.setValue(_local_4, false);
            };
        }
        private function sliderButtonRightProcedure(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            var _local_3:Number;
            if (_arg_1.type == WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK){
                this._SafeStr_4313 = false;
                if (this._SafeStr_4314 != 0){
                    _local_3 = (this._value + this._SafeStr_4314);
                    this.setValue(_local_3);
                };
            };
        }
        private function sliderButtonLeftProcedure(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            var _local_3:Number;
            if (_arg_1.type == WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK){
                this._SafeStr_4313 = false;
                if (this._SafeStr_4314 != 0){
                    _local_3 = (this._value - this._SafeStr_4314);
                    this.setValue(_local_3);
                };
            };
        }
        private function displaySlider():void
        {
            var _local_1:IWindowContainer;
            var _local_2:IBitmapWrapperWindow;
            var _local_3:IContainerButtonWindow;
            var _local_4:IContainerButtonWindow;
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
                    _local_2.procedure = this.sliderProcedure;
                    this._SafeStr_3958 = (_local_1.width - _local_2.width);
                };
            };
            _local_4 = (this._sliderContainer.findChildByName("slider_button_left") as IContainerButtonWindow);
            if (_local_4){
                _local_4.procedure = this.sliderButtonLeftProcedure;
            };
            _local_3 = (this._sliderContainer.findChildByName("slider_button_right") as IContainerButtonWindow);
            if (_local_3){
                _local_3.procedure = this.sliderButtonRightProcedure;
            };
        }
        private function storeAssets(_arg_1:IAssetLibrary):void
        {
            var _local_2:BitmapDataAsset;
            if (_arg_1 == null){
                return;
            };
            _local_2 = BitmapDataAsset(_arg_1.getAssetByName("slider_bg_png"));
            this._SafeStr_3956 = BitmapData(_local_2.content);
            _local_2 = BitmapDataAsset(_arg_1.getAssetByName("slider_obj_png"));
            this._SafeStr_3957 = BitmapData(_local_2.content);
        }

    }
}//package com.sulake.habbo.roomevents.userdefinedroomevents.common

// WindowEvent = "_-Jh" (String#2085, DoABC#2)
// BitmapDataAsset = "_-0PB" (String#4074, DoABC#2)
// IContainerButtonWindow = "_-0UF" (String#1484, DoABC#2)
// SliderWindowController = "_-GO" (String#8002, DoABC#2)
// _SafeStr_3956 = "_-1ds" (String#1728, DoABC#2)
// _SafeStr_3957 = "_-pS" (String#2201, DoABC#2)
// _SafeStr_3958 = "_-0zE" (String#1593, DoABC#2)
// _max = "_-0Os" (String#1462, DoABC#2)
// displaySlider = "_-2mk" (String#1938, DoABC#2)
// getSliderPosition = "_-0BT" (String#1421, DoABC#2)
// WE_RELOCATED = "_-13s" (String#16612, DoABC#2)
// _value = "_-Mi" (String#23114, DoABC#2)
// _SafeStr_4313 = "_-1uK" (String#18730, DoABC#2)
// _SafeStr_4314 = "_-1l6" (String#18335, DoABC#2)
// updateSliderPosition = "_-0So" (String#15161, DoABC#2)
// getValueAtPosition = "_-0b3" (String#15477, DoABC#2)
// sliderProcedure = "_-24e" (String#19208, DoABC#2)
// WME_DOWN = "_-hL" (String#23944, DoABC#2)
// WME_UP_OUTSIDE = "_-2qi" (String#21110, DoABC#2)
// WME_UP = "_-0Cs" (String#14566, DoABC#2)
// sliderButtonRightProcedure = "_-E-" (String#22770, DoABC#2)
// sliderButtonLeftProcedure = "_-0-K" (String#14025, DoABC#2)


