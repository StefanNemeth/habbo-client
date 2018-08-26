
package com.sulake.core.window.graphics.renderer
{
    import flash.geom.ColorTransform;
    import flash.geom.Rectangle;
    import flash.geom.Point;
    import flash.utils.Dictionary;
    import flash.geom.Matrix;
    import com.sulake.core.window.graphics.BitmapSkinParser;
    import com.sulake.core.assets.IAsset;
    import com.sulake.core.assets.IAssetLibrary;
    import flash.display.BitmapData;
    import com.sulake.core.window.enum.WindowState;
    import com.sulake.core.window.IWindow;
    import flash.display.IBitmapDrawable;
    import com.sulake.core.assets.BitmapDataAsset;
    import com.sulake.core.utils.profiler.tracking.TrackedBitmapData;
    import flash.display.BitmapDataChannel;

    public class BitmapSkinRenderer extends SkinRenderer implements ISkinRenderer 
    {

        private static var ALPHA:ColorTransform = new ColorTransform(1, 1, 1, 1);
        private static var REGION:Rectangle = new Rectangle();
        private static const TOP_LEFT:Point = new Point();

        protected var _SafeStr_4070:Dictionary;
        protected var _SafeStr_4071:Dictionary;
        private var _SafeStr_4072:Matrix;
        private var _colorTransform:ColorTransform;

        public function BitmapSkinRenderer(_arg_1:String)
        {
            super(_arg_1);
            this._SafeStr_4070 = new Dictionary(false);
            this._SafeStr_4071 = new Dictionary(false);
            this._SafeStr_4072 = new Matrix();
            this._colorTransform = new ColorTransform();
        }
        override public function parse(_arg_1:IAsset, _arg_2:XMLList, _arg_3:IAssetLibrary):void
        {
            BitmapSkinParser.parseSkinDescription((_arg_1.content as XML), _arg_2, this, name, _arg_3);
        }
        override public function dispose():void
        {
            var _local_1:String;
            var _local_2:BitmapData;
            if (!disposed){
                super.dispose();
                this._SafeStr_4072 = null;
                this._colorTransform = null;
                for (_local_1 in this._SafeStr_4070) {
                    _local_2 = (this._SafeStr_4070[_local_1] as BitmapData);
                    _local_2.dispose();
                    delete this._SafeStr_4070[_local_1];
                };
                this._SafeStr_4070 = null;
                for (_local_1 in this._SafeStr_4071) {
                    _local_2 = (this._SafeStr_4071[_local_1] as BitmapData);
                    _local_2.dispose();
                    delete this._SafeStr_4071[_local_1];
                };
                this._SafeStr_4071 = null;
            };
        }
        override public function isStateDrawable(_arg_1:uint):Boolean
        {
            return (!((_templatesByState[_arg_1] == null)));
        }
        override public function draw(_arg_1:IWindow, _arg_2:IBitmapDrawable, _arg_3:Rectangle, _arg_4:uint, _arg_5:Boolean):void
        {
            var _local_9:uint;
            var _local_10:SkinLayoutEntity;
            var _local_11:ISkinTemplateEntity;
            var _local_12:Boolean;
            var _local_13:Boolean;
            var _local_14:int;
            var _local_15:int;
            var _local_16:Boolean;
            var _local_17:uint;
            var _local_18:BitmapData;
            var _local_19:BitmapData;
            var _local_20:int;
            var _local_21:int;
            var _local_22:int;
            var _local_23:int;
            var _local_24:int;
            var _local_25:int;
            var _local_26:Point;
            var _local_27:Rectangle;
            var _local_28:Rectangle;
            var _local_29:uint;
            var _local_30:int;
            var _local_31:BitmapData;
            var _local_32:BitmapData;
            var _local_6:BitmapData = (_arg_2 as BitmapData);
            var _local_7:ISkinLayout = _SafeStr_4062[_arg_4];
            var _local_8:ISkinTemplate = _templatesByState[_arg_4];
            if (_local_7 == null){
                Logger.log(("LAYOUT NULL " + _arg_4));
                _local_7 = _SafeStr_4062[WindowState._SafeStr_4075];
                _local_8 = _templatesByState[WindowState._SafeStr_4075];
            };
            _local_9 = _local_7.numChildren;
            if (((!((_local_7 == null))) && ((_local_9 > 0)))){
                _local_14 = (_arg_3.width - _local_7.width);
                _local_15 = (_arg_3.height - _local_7.height);
                _local_16 = ((!(_arg_1.background)) && (((_arg_1.color & 0xFFFFFF) < 0xFFFFFF)));
                if (_local_16){
                    this._colorTransform.redMultiplier = (((_arg_1.color & 0xFF0000) >> 16) / 0xFF);
                    this._colorTransform.greenMultiplier = (((_arg_1.color & 0xFF00) >> 8) / 0xFF);
                    this._colorTransform.blueMultiplier = ((_arg_1.color & 0xFF) / 0xFF);
                    this._colorTransform.alphaMultiplier = 1;
                };
                _local_17 = 0;
                while (_local_17 < _local_9) {
                    _local_10 = (_local_7.getChildAt(_local_17) as SkinLayoutEntity);
                    _local_11 = (_local_8.getChildByName(_local_10.name) as ISkinTemplateEntity);
                    if (_local_11 != null){
                        _local_18 = this.getBitmapFromCache(_local_8, _local_10.name);
                        _local_19 = this.getAlphaFromCache(_local_8, _local_10.name);
                        if (((_local_16) && (_local_10.colorize))){
                            _local_18 = _local_18.clone();
                            _local_18.colorTransform(_local_18.rect, this._colorTransform);
                        };
                        _local_12 = false;
                        _local_13 = false;
                        REGION.x = (_local_10.region.x + _arg_3.x);
                        REGION.y = (_local_10.region.y + _arg_3.y);
                        REGION.width = _local_10.region.width;
                        REGION.height = _local_10.region.height;
                        if (_local_10._SafeStr_4078 == SkinLayoutEntity._SafeStr_4079){
                            REGION.x = (REGION.x + _local_14);
                        }
                        else {
                            if (_local_10._SafeStr_4078 == SkinLayoutEntity._SafeStr_4080){
                                _local_12 = true;
                                REGION.right = (REGION.right + _local_14);
                                if (REGION.width < 1) break;
                            }
                            else {
                                if (_local_10._SafeStr_4078 == SkinLayoutEntity._SafeStr_4081){
                                    _local_12 = true;
                                    REGION.right = (REGION.right + _local_14);
                                    if (REGION.width < 1) break;
                                }
                                else {
                                    if (_local_10._SafeStr_4078 == SkinLayoutEntity._SafeStr_4082){
                                        REGION.x = ((_arg_3.width / 2) - (REGION.width / 2));
                                    };
                                };
                            };
                        };
                        if (_local_10._SafeStr_4083 == SkinLayoutEntity._SafeStr_4079){
                            REGION.y = (REGION.y + _local_15);
                        }
                        else {
                            if (_local_10._SafeStr_4083 == SkinLayoutEntity._SafeStr_4080){
                                _local_13 = true;
                                REGION.bottom = (REGION.bottom + _local_15);
                                if (REGION.height < 1) break;
                            }
                            else {
                                if (_local_10._SafeStr_4083 == SkinLayoutEntity._SafeStr_4081){
                                    _local_13 = true;
                                    REGION.bottom = (REGION.bottom + _local_15);
                                    if (REGION.height < 1) break;
                                }
                                else {
                                    if (_local_10._SafeStr_4083 == SkinLayoutEntity._SafeStr_4082){
                                        REGION.y = ((_arg_3.height / 2) - (REGION.height / 2));
                                    };
                                };
                            };
                        };
                        if (((!(_local_12)) && (!(_local_13)))){
                            _local_6.copyPixels(_local_18, _local_18.rect, REGION.topLeft, _local_19, TOP_LEFT, true);
                        }
                        else {
                            if ((((_local_10._SafeStr_4083 == SkinLayoutEntity._SafeStr_4081)) || ((_local_10._SafeStr_4078 == SkinLayoutEntity._SafeStr_4081)))){
                                _local_20 = _local_18.width;
                                _local_21 = _local_18.height;
                                _local_22 = (REGION.width / _local_20);
                                _local_23 = (REGION.height / _local_21);
                                _local_24 = (REGION.width % _local_20);
                                _local_25 = (REGION.height % _local_21);
                                _local_26 = new Point(REGION.x, REGION.y);
                                _local_27 = new Rectangle(0, 0, _local_24, _local_18.height);
                                _local_28 = new Rectangle(0, 0, _local_18.width, _local_25);
                                _local_29 = 0;
                                while (_local_29 < _local_23) {
                                    _local_26.x = REGION.x;
                                    _local_30 = 0;
                                    while (_local_30 < _local_22) {
                                        _local_6.copyPixels(_local_18, _local_18.rect, _local_26, _local_19, TOP_LEFT, true);
                                        _local_26.x = (_local_26.x + _local_20);
                                        _local_30++;
                                    };
                                    if (_local_24 > 0){
                                        _local_6.copyPixels(_local_18, _local_27, _local_26, _local_19, TOP_LEFT, true);
                                    };
                                    _local_26.y = (_local_26.y + _local_21);
                                    _local_29++;
                                };
                                if (_local_25 > 0){
                                    _local_26.x = REGION.x;
                                    _local_29 = 0;
                                    while (_local_29 < _local_22) {
                                        _local_6.copyPixels(_local_18, _local_28, _local_26, _local_19, TOP_LEFT, true);
                                        _local_26.x = (_local_26.x + _local_20);
                                        _local_29++;
                                    };
                                };
                            }
                            else {
                                if ((((_local_18.width == 1)) && ((_local_18.height == 1)))){
                                    this._SafeStr_4072.a = REGION.width;
                                    this._SafeStr_4072.d = REGION.height;
                                    this._SafeStr_4072.tx = REGION.x;
                                    this._SafeStr_4072.ty = REGION.y;
                                    ALPHA.alphaMultiplier = ((_local_19.getPixel32(0, 0) >>> 24) / 0xFF);
                                    _local_6.draw(_local_18, this._SafeStr_4072, ALPHA);
                                }
                                else {
                                    this._SafeStr_4072.a = (REGION.width / _local_18.width);
                                    this._SafeStr_4072.d = (REGION.height / _local_18.height);
                                    this._SafeStr_4072.tx = 0;
                                    this._SafeStr_4072.ty = 0;
                                    _local_31 = new BitmapData(REGION.width, REGION.height, _local_18.transparent);
                                    _local_31.draw(_local_18, this._SafeStr_4072);
                                    _local_32 = new BitmapData(REGION.width, REGION.height, true, 0);
                                    _local_32.draw(_local_19, this._SafeStr_4072, null);
                                    _local_6.copyPixels(_local_31, _local_31.rect, REGION.topLeft, _local_32, TOP_LEFT, true);
                                    _local_32.dispose();
                                    _local_31.dispose();
                                };
                            };
                        };
                        if (((_local_16) && (_local_10.colorize))){
                            _local_18.dispose();
                        };
                    };
                    _local_17++;
                };
            };
        }
        protected function drawStaticLayoutEntity(_arg_1:BitmapData, _arg_2:Rectangle, _arg_3:ISkinLayout, _arg_4:SkinLayoutEntity, _arg_5:ISkinTemplate, _arg_6:ISkinTemplateEntity):void
        {
            var _local_8:BitmapData;
            var _local_9:BitmapData;
            var _local_7:Rectangle = _arg_4.region.clone();
            _local_7.x = (_local_7.x + _arg_2.x);
            _local_7.y = (_local_7.y + _arg_2.y);
            switch (_arg_6.type){
                case "bitmap":
                    _local_8 = this.getBitmapFromCache(_arg_5, _arg_4.name);
                    _local_9 = this.getAlphaFromCache(_arg_5, _arg_4.name);
                    if (_arg_4._SafeStr_4078 == SkinLayoutEntity._SafeStr_4079){
                        _local_7.x = (_local_7.x + (_arg_2.width - _arg_3.width));
                    };
                    if (_arg_4._SafeStr_4083 == SkinLayoutEntity._SafeStr_4079){
                        _local_7.y = (_local_7.y + (_arg_2.height - _arg_3.height));
                    };
                    _arg_1.copyPixels(_local_8, _local_8.rect, _local_7.topLeft, _local_9, null, true);
                    return;
                case "fill":
                    _arg_1.fillRect(_local_7, _arg_4.color);
                    return;
            };
        }
        private function getBitmapFromCache(_arg_1:ISkinTemplate, _arg_2:String):BitmapData
        {
            var _local_5:ISkinTemplateEntity;
            var _local_6:BitmapData;
            var _local_3:String = ((_arg_2 + "@") + _arg_1.name);
            var _local_4:BitmapData = this._SafeStr_4070[_local_3];
            if (_local_4 == null){
                _local_5 = (_arg_1.getChildByName(_arg_2) as ISkinTemplateEntity);
                if (_local_5 == null){
                    throw (new Error((("Template entity" + _arg_2) + "not found!")));
                };
                _local_6 = (BitmapDataAsset(_arg_1.asset).content as BitmapData);
                if (_local_6 == null){
                    throw (new Error((("Asset " + _arg_1.asset) + " not found!")));
                };
                _local_4 = new TrackedBitmapData(this, _local_5.region.width, _local_5.region.height, false);
                _local_4.copyPixels(_local_6, _local_5.region, _local_4.rect.topLeft);
                this._SafeStr_4070[_local_3] = _local_4;
            };
            return (_local_4);
        }
        private function getAlphaFromCache(_arg_1:ISkinTemplate, _arg_2:String):BitmapData
        {
            var _local_5:ISkinTemplateEntity;
            var _local_6:BitmapData;
            var _local_3:String = ((_arg_2 + "@") + _arg_1.name);
            var _local_4:BitmapData = this._SafeStr_4071[_local_3];
            if (_local_4 == null){
                _local_5 = (_arg_1.getChildByName(_arg_2) as ISkinTemplateEntity);
                if (_local_5 == null){
                    throw (new Error((("Template entity" + _arg_2) + "not found!")));
                };
                _local_6 = (BitmapDataAsset(_arg_1.asset).content as BitmapData);
                if (_local_6 == null){
                    throw (new Error((("Asset " + _arg_1.asset) + " not found!")));
                };
                _local_4 = new TrackedBitmapData(this, _local_5.region.width, _local_5.region.height, true);
                _local_4.copyChannel(_local_6, _local_5.region, _local_4.rect.topLeft, BitmapDataChannel.ALPHA, BitmapDataChannel.ALPHA);
                this._SafeStr_4071[_local_3] = _local_4;
            };
            return (_local_4);
        }
        private function drawBorders(_arg_1:BitmapData, _arg_2:Rectangle, _arg_3:uint):void
        {
            var _local_4:int;
            var _local_5:int = (_arg_2.bottom - 1);
            _local_4 = _arg_2.left;
            while (_local_4 < (_arg_2.right - 1)) {
                _arg_1.setPixel32(_local_4, 0, _arg_3);
                _arg_1.setPixel32(_local_4, _local_5, _arg_3);
                _local_4++;
            };
            _local_5 = _arg_2.top;
            while (_local_5 < (_arg_2.bottom - 1)) {
                _arg_1.setPixel32(0, _local_5, _arg_3);
                _arg_1.setPixel32(_local_4, _local_5, _arg_3);
                _local_5++;
            };
        }

    }
}//package com.sulake.core.window.graphics.renderer

// BitmapDataAsset = "_-0PB" (String#4074, DoABC#2)
// ISkinLayout = "_-m8" (String#2182, DoABC#2)
// ISkinRenderer = "_-1uJ" (String#1780, DoABC#2)
// ISkinTemplateEntity = "_-27h" (String#1819, DoABC#2)
// ISkinTemplate = "_-31I" (String#1988, DoABC#2)
// WindowState = "_-1Kt" (String#5262, DoABC#2)
// SkinRenderer = "_-bE" (String#8445, DoABC#2)
// BitmapSkinRenderer = "_-CQ" (String#7925, DoABC#2)
// TrackedBitmapData = "_-1gF" (String#5666, DoABC#2)
// BitmapSkinParser = "_-0dO" (String#4378, DoABC#2)
// SkinLayoutEntity = "_-27j" (String#6196, DoABC#2)
// isStateDrawable = "_-0hI" (String#4452, DoABC#2)
// _SafeStr_4062 = "_-IB" (String#22936, DoABC#2)
// _SafeStr_4070 = "_-2Z8" (String#20404, DoABC#2)
// _SafeStr_4071 = "_-0ma" (String#15920, DoABC#2)
// _SafeStr_4072 = "_-0fD" (String#15638, DoABC#2)
// _colorTransform = "_-0yf" (String#300, DoABC#2)
// parseSkinDescription = "_-tq" (String#24441, DoABC#2)
// _SafeStr_4075 = "_-0DX" (String#14589, DoABC#2)
// getBitmapFromCache = "_-01Q" (String#14107, DoABC#2)
// getAlphaFromCache = "_-2vN" (String#21292, DoABC#2)
// _SafeStr_4078 = "_-30D" (String#21509, DoABC#2)
// _SafeStr_4079 = "_-0Lq" (String#14907, DoABC#2)
// _SafeStr_4080 = "_-2Gj" (String#19670, DoABC#2)
// _SafeStr_4081 = "_-0AU" (String#14466, DoABC#2)
// _SafeStr_4082 = "_-0dp" (String#15577, DoABC#2)
// _SafeStr_4083 = "_-2vf" (String#21301, DoABC#2)
// drawStaticLayoutEntity = "_-2zk" (String#21449, DoABC#2)
// drawBorders = "_-24-" (String#19176, DoABC#2)


