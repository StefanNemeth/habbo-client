
package com.sulake.habbo.toolbar.extensions.purse
{
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import __AS3__.vec.Vector;
    import flash.display.BitmapData;
    import flash.utils.Timer;
    import flash.events.IEventDispatcher;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.assets.XmlAsset;
    import flash.events.TimerEvent;
    import com.sulake.core.window.components.ITextWindow;
    import com.sulake.core.assets.IAsset;
    import __AS3__.vec.*;

    public class CurrencyIndicatorBase implements ICurrencyIndicator 
    {

        protected static const ANIM_DIRECTION_FORWARD:int = 0;
        protected static const ANIM_DIRECTION_BACKWARD:int = 1;

        private var _view:IWindowContainer;
        private var _windowManager:IHabboWindowManager;
        private var _assets:IAssetLibrary;
        private var _disposed:Boolean = false;
        private var _SafeStr_13731:IBitmapWrapperWindow;
        private var _bgColorLight:uint;
        private var _bgColorDark:uint;
        private var _textElementName:String;
        private var _textElementShadowName:String;
        private var _SafeStr_13736:Vector.<BitmapData>;
        private var _iconAnimationDelay:uint;
        private var _amountZeroText:String = null;
        private var _SafeStr_13739:uint = 0;
        private var _SafeStr_13740:int;
        private var _SafeStr_6266:Timer;

        public function CurrencyIndicatorBase(_arg_1:IHabboWindowManager, _arg_2:IAssetLibrary)
        {
            this._SafeStr_13736 = new Vector.<BitmapData>();
            super();
            this._view = null;
            this._windowManager = _arg_1;
            this._assets = _arg_2;
            this._SafeStr_6266 = null;
        }
        protected function set bgColorLight(_arg_1:uint):void
        {
            this._bgColorLight = _arg_1;
        }
        protected function set bgColorDark(_arg_1:uint):void
        {
            this._bgColorDark = _arg_1;
        }
        protected function set textElementName(_arg_1:String):void
        {
            this._textElementName = _arg_1;
        }
        protected function set textElementShadowName(_arg_1:String):void
        {
            this._textElementShadowName = _arg_1;
        }
        protected function set iconAnimationDelay(_arg_1:uint):void
        {
            this._iconAnimationDelay = _arg_1;
        }
        protected function set amountZeroText(_arg_1:String):void
        {
            this._amountZeroText = _arg_1;
        }
        protected function get amountZeroText():String
        {
            return (this._amountZeroText);
        }
        public function get view():IWindowContainer
        {
            return (this._view);
        }
        public function dispose():void
        {
            if (this._disposed){
                return;
            };
            if (this._SafeStr_6266){
                this._SafeStr_6266.stop();
                this._SafeStr_6266 = null;
            };
            if (this._SafeStr_13736){
                this._SafeStr_13736 = null;
            };
            if (this._view){
                this._view.dispose();
                this._view = null;
            };
            this._disposed = true;
        }
        public function RoomChatWidget(_arg_1:IEventDispatcher):void
        {
        }
        public function RoomChatWidget(_arg_1:IEventDispatcher):void
        {
        }
        protected function CurrencyIndicatorBase(_arg_1:WindowMouseEvent):void
        {
        }
        protected function createWindow(_arg_1:String, _arg_2:String):void
        {
            var _local_4:Array;
            var _local_5:BitmapData;
            var _local_3:XmlAsset = (this._assets.getAssetByName(_arg_1) as XmlAsset);
            if (_local_3){
                this._view = (this._windowManager.buildFromXML((_local_3.content as XML), 1) as IWindowContainer);
                if (this._view){
                    this._view.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.CurrencyIndicatorBase);
                    this._view.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_OVER, this.CurrencyIndicatorBase);
                    this._view.addEventListener(WindowMouseEvent.WME_OUT, this.CurrencyIndicatorBase);
                    _local_4 = [];
                    if (this._view.WindowController("ICON", _local_4, true) == 1){
                        this._SafeStr_13731 = (_local_4[0] as IBitmapWrapperWindow);
                        _local_5 = (this._assets.getAssetByName(_arg_2).content as BitmapData);
                        if (_local_5){
                            this.setIconBitmap(_local_5);
                        };
                    };
                };
            };
        }
        protected function CurrencyIndicatorBase(_arg_1:int):void
        {
            this._SafeStr_13739 = _arg_1;
            if (((this._SafeStr_13731) && ((this._SafeStr_13736.length > 0)))){
                if (this._SafeStr_13739 == ANIM_DIRECTION_FORWARD){
                    this._SafeStr_13740 = 0;
                }
                else {
                    this._SafeStr_13740 = (this._SafeStr_13736.length - 1);
                };
                this._SafeStr_6266 = new Timer(this._iconAnimationDelay, this._SafeStr_13736.length);
                this._SafeStr_6266.addEventListener(TimerEvent.TIMER, this.CurrencyIndicatorBase);
                this._SafeStr_6266.addEventListener(TimerEvent.TIMER_COMPLETE, this.CurrencyIndicatorBase);
                this._SafeStr_6266.start();
                this.CurrencyIndicatorBase(null);
            };
        }
        protected function CurrencyIndicatorBase(_arg_1:String):void
        {
            if (this._view){
                this._view.findChildByName(this._textElementName).caption = _arg_1;
                this._view.findChildByName(this._textElementShadowName).caption = _arg_1;
            };
        }
        protected function CurrencyIndicatorBase(_arg_1:Boolean):void
        {
            var _local_2:ITextWindow;
            var _local_3:ITextWindow;
            if (this._view){
                _local_2 = (this._view.findChildByName(this._textElementName) as ITextWindow);
                _local_3 = (this._view.findChildByName(this._textElementShadowName) as ITextWindow);
                _local_2.underline = _arg_1;
                _local_3.underline = _arg_1;
            };
        }
        protected function set iconAnimationSequence(_arg_1:Array):void
        {
            var _local_2:String;
            var _local_3:IAsset;
            var _local_4:BitmapData;
            for each (_local_2 in _arg_1) {
                _local_3 = this._assets.getAssetByName(_local_2);
                if (_local_3){
                    _local_4 = (_local_3.content as BitmapData);
                    if (_local_4){
                        this._SafeStr_13736.push(_local_4.clone());
                    };
                };
            };
        }
        private function CurrencyIndicatorBase(_arg_1:TimerEvent):void
        {
            if (((this._SafeStr_13731) && ((this._SafeStr_13736.length > 0)))){
                this.setIconBitmap(this._SafeStr_13736[this._SafeStr_13740]);
                if (this._SafeStr_13739 == ANIM_DIRECTION_FORWARD){
                    this._SafeStr_13740++;
                    this._SafeStr_13740 = (((this._SafeStr_13740)<this._SafeStr_13736.length) ? this._SafeStr_13740 : (this._SafeStr_13736.length - 1));
                }
                else {
                    this._SafeStr_13740--;
                    this._SafeStr_13740 = (((this._SafeStr_13740)>=0) ? this._SafeStr_13740 : 0);
                };
            };
        }
        private function CurrencyIndicatorBase(_arg_1:TimerEvent):void
        {
            if (this._SafeStr_13736.length > 0){
                this.setIconBitmap(this._SafeStr_13736[0]);
            };
        }
        private function setIconBitmap(_arg_1:BitmapData):void
        {
            if (this._SafeStr_13731){
                this._SafeStr_13731.bitmap = _arg_1.clone();
                this._SafeStr_13731.width = _arg_1.width;
                this._SafeStr_13731.height = _arg_1.height;
                this._SafeStr_13731.invalidate();
            };
        }
        private function CurrencyIndicatorBase(_arg_1:WindowMouseEvent):void
        {
            this._view.color = this._bgColorDark;
        }
        private function CurrencyIndicatorBase(_arg_1:WindowMouseEvent):void
        {
            this._view.color = this._bgColorLight;
        }

    }
}//package com.sulake.habbo.toolbar.extensions.purse

// _SafeStr_13731 = "_-HD" (String#22899, DoABC#2)
// _bgColorLight = "_-0hV" (String#15727, DoABC#2)
// _bgColorDark = "_-Cj" (String#22714, DoABC#2)
// _textElementName = "_-1wK" (String#18813, DoABC#2)
// _textElementShadowName = "_-1DG" (String#16994, DoABC#2)
// _SafeStr_13736 = "_-1A5" (String#16860, DoABC#2)
// _iconAnimationDelay = "_-Kw" (String#23041, DoABC#2)
// _amountZeroText = "_-1U9" (String#17673, DoABC#2)
// _SafeStr_13739 = "_-0pN" (String#16029, DoABC#2)
// _SafeStr_13740 = "_-AO" (String#22632, DoABC#2)
// CurrencyIndicatorBase = "_-2Nb" (String#19948, DoABC#2)
// CurrencyIndicatorBase = "_-o5" (String#24192, DoABC#2)
// CurrencyIndicatorBase = "_-0Dt" (String#3824, DoABC#2)
// RoomChatWidget = "_-1yD" (String#1787, DoABC#2)
// RoomChatWidget = "_-0-c" (String#3556, DoABC#2)
// WME_OUT = "_-0h2" (String#15712, DoABC#2)
// bgColorLight = "_-OA" (String#23175, DoABC#2)
// bgColorDark = "_-ic" (String#23983, DoABC#2)
// textElementShadowName = "_-1dv" (String#18053, DoABC#2)
// iconAnimationDelay = "_-1Yv" (String#17847, DoABC#2)
// amountZeroText = "_-Md" (String#23110, DoABC#2)
// CurrencyIndicatorBase = "_-1M3" (String#602, DoABC#2)
// CurrencyIndicatorBase = "_-L5" (String#23050, DoABC#2)
// CurrencyIndicatorBase = "_-uZ" (String#24474, DoABC#2)
// CurrencyIndicatorBase = "_-1vu" (String#243, DoABC#2)
// _SafeStr_6266 = "_-0bu" (String#4344, DoABC#2)
// CurrencyIndicatorBase = "_-1j1" (String#5735, DoABC#2)
// CurrencyIndicatorBase = "_-2Lp" (String#6480, DoABC#2)
// setIconBitmap = "_-27Q" (String#1818, DoABC#2)
// WindowController = "_-cU" (String#2141, DoABC#2)


