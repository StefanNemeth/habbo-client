
package com.sulake.habbo.room.object.visualization.furniture
{
    import flash.display.BitmapData;
    import com.sulake.core.assets.BitmapDataAsset;
    import com.sulake.room.object.visualization.utils.IGraphicAsset;
    import com.sulake.room.object.visualization.utils.IGraphicAssetCollection;
    import flash.geom.Point;
    import flash.geom.Rectangle;
    import com.sulake.room.utils.Rasterizer;

    public class ShoreMaskCreatorUtility 
    {

        public static const _SafeStr_12721:int = 0;
        public static const _SafeStr_12723:int = 1;
        public static const _SafeStr_12722:int = 2;
        private static const _SafeStr_12820:int = 3;
        private static const MASK_COLOR_TRANSPARENT:uint = 0;
        private static const MASK_COLOR_SOLID:uint = 0xFFFFFFFF;

        public static function createEmptyMask(_arg_1:int, _arg_2:int):BitmapData
        {
            return (new BitmapData(_arg_1, _arg_2, true, MASK_COLOR_TRANSPARENT));
        }
        public static function getInstanceMaskName(_arg_1:int, _arg_2:int):String
        {
            return (((("instance_mask_" + _arg_1) + "_") + _arg_2));
        }
        public static function getBorderType(_arg_1:int, _arg_2:int):int
        {
            return ((_arg_1 + (_arg_2 * _SafeStr_12820)));
        }
        public static function getInstanceMask(_arg_1:int, _arg_2:int, _arg_3:IGraphicAssetCollection, _arg_4:IGraphicAsset):IGraphicAsset
        {
            var _local_7:BitmapDataAsset;
            var _local_8:BitmapData;
            var _local_5:String = getInstanceMaskName(_arg_1, _arg_2);
            var _local_6:IGraphicAsset = _arg_3.getAsset(_local_5);
            if (_local_6 == null){
                if (_arg_4 != null){
                    _local_7 = (_arg_4.asset as BitmapDataAsset);
                    if (_local_7 != null){
                        _local_8 = (_local_7.content as BitmapData);
                        if (_local_8 != null){
                            _arg_3.addAsset(_local_5, new BitmapData(_local_8.width, _local_8.height, true, MASK_COLOR_TRANSPARENT), false, _arg_4.offsetX, _arg_4.offsetY);
                            _local_6 = _arg_3.getAsset(_local_5);
                        };
                    };
                };
            };
            return (_local_6);
        }
        public static function disposeInstanceMask(_arg_1:int, _arg_2:int, _arg_3:IGraphicAssetCollection):void
        {
            var _local_4:String = getInstanceMaskName(_arg_1, _arg_2);
            _arg_3.disposeAsset(_local_4);
        }
        public static function createShoreMask2x2(_arg_1:BitmapData, _arg_2:int, _arg_3:Array, _arg_4:Array, _arg_5:IGraphicAssetCollection):BitmapData
        {
            var _local_7:String;
            var _local_8:IGraphicAsset;
            var _local_9:BitmapData;
            _arg_1.fillRect(_arg_1.rect, MASK_COLOR_TRANSPARENT);
            var _local_6:int;
            while (_local_6 < _arg_3.length) {
                if (_arg_3[_local_6] == true){
                    _local_7 = ((((("mask_" + _arg_2) + "_") + _local_6) + "_") + _arg_4[_local_6]);
                    _local_8 = _arg_5.getAsset(_local_7);
                    if (((!((_local_8 == null))) && (!((_local_8.asset == null))))){
                        _local_9 = (_local_8.asset.content as BitmapData);
                        if (_local_9 != null){
                            _arg_1.copyPixels(_local_9, _local_9.rect, new Point(0, 0), _local_9, new Point(0, 0), true);
                        };
                    };
                };
                _local_6++;
            };
            return (_arg_1);
        }
        public static function initializeShoreMasks(_arg_1:int, _arg_2:IGraphicAssetCollection, _arg_3:IGraphicAsset):Boolean
        {
            var _local_4:String;
            var _local_5:BitmapDataAsset;
            var _local_6:BitmapData;
            var _local_7:Array;
            var _local_8:Array;
            var _local_9:BitmapData;
            var _local_10:int;
            if (_arg_2 != null){
                _local_4 = ("masks_done_" + _arg_1);
                if (_arg_2.getAsset(_local_4) == null){
                    if (_arg_3 != null){
                        _local_5 = (_arg_3.asset as BitmapDataAsset);
                        if (_local_5 != null){
                            _local_6 = (_local_5.content as BitmapData);
                            _local_7 = [_SafeStr_12721, _SafeStr_12723, _SafeStr_12722, _SafeStr_12721, _SafeStr_12723, _SafeStr_12722];
                            _local_8 = [_SafeStr_12723, _SafeStr_12723, _SafeStr_12723, _SafeStr_12722, _SafeStr_12722, _SafeStr_12722];
                            _local_9 = null;
                            _local_10 = 0;
                            if (_local_6 != null){
                                _local_10 = 0;
                                while ((((_local_10 < _local_7.length)) && ((_local_10 < _local_8.length)))) {
                                    _local_9 = createMaskLeft(_local_6.width, _local_6.height);
                                    cutLeftMask(_local_9, _arg_1, _local_7[_local_10], _local_8[_local_10]);
                                    storeLeftMask(_arg_2, _local_9, _arg_1, _local_7[_local_10], _local_8[_local_10]);
                                    _local_9 = createMaskRight(_local_6.width, _local_6.height);
                                    cutRightMask(_local_9, _arg_1, _local_8[_local_10], _local_7[_local_10]);
                                    storeRightMask(_arg_2, _local_9, _arg_1, _local_8[_local_10], _local_7[_local_10]);
                                    _local_10++;
                                };
                            };
                        };
                        _arg_2.addAsset(_local_4, new BitmapData(1, 1), false);
                        return (true);
                    };
                    return (false);
                };
                return (true);
            };
            return (false);
        }
        private static function createMaskLeft(_arg_1:int, _arg_2:int):BitmapData
        {
            var _local_3:BitmapData = new BitmapData(_arg_1, _arg_2, true, MASK_COLOR_TRANSPARENT);
            fillTopLeftCorner(_local_3, (_local_3.width / 2), ((_local_3.height / 2) - 1), 1, MASK_COLOR_SOLID);
            return (_local_3);
        }
        private static function cutLeftMask(_arg_1:BitmapData, _arg_2:int, _arg_3:int, _arg_4:int):void
        {
            if (_arg_3 == _SafeStr_12723){
                cutLeftMaskOuterCorner(_arg_1, _arg_2, false);
            }
            else {
                if (_arg_3 == _SafeStr_12722){
                    cutLeftMaskOuterCorner(_arg_1, _arg_2, true);
                };
            };
            if (_arg_4 == _SafeStr_12722){
                cutLeftMaskInnerCorner(_arg_1, _arg_2);
            };
        }
        private static function cutLeftMaskOuterCorner(_arg_1:BitmapData, _arg_2:int, _arg_3:Boolean):void
        {
            var _local_4:int = ((_arg_1.height / 2) - (_arg_2 / 2));
            var _local_5:int = (_arg_1.width / 2);
            if (_arg_3){
                _arg_1.fillRect(new Rectangle(_local_5, 0, _arg_1.width, _local_4), MASK_COLOR_TRANSPARENT);
            }
            else {
                fillTopLeftCorner(_arg_1, _local_5, (_local_4 - 1), 1, MASK_COLOR_TRANSPARENT);
            };
        }
        private static function cutLeftMaskInnerCorner(_arg_1:BitmapData, _arg_2:int):void
        {
            var _local_3:int = ((_arg_1.width / 2) + (_arg_2 / 2));
            _arg_1.fillRect(new Rectangle(_local_3, 0, _arg_1.width, (_arg_1.height / 2)), MASK_COLOR_TRANSPARENT);
        }
        private static function createMaskRight(_arg_1:int, _arg_2:int):BitmapData
        {
            var _local_3:BitmapData = new BitmapData(_arg_1, _arg_2, true, MASK_COLOR_TRANSPARENT);
            fillBottomRightCorner(_local_3, ((_local_3.width / 2) + 1), ((_local_3.height / 2) - 1), MASK_COLOR_SOLID);
            return (_local_3);
        }
        private static function cutRightMask(_arg_1:BitmapData, _arg_2:int, _arg_3:int, _arg_4:int):void
        {
            if (_arg_4 == _SafeStr_12723){
                cutRightMaskOuterCorner(_arg_1, _arg_2, false);
            }
            else {
                if (_arg_4 == _SafeStr_12722){
                    cutRightMaskOuterCorner(_arg_1, _arg_2, true);
                };
            };
            if (_arg_3 == _SafeStr_12722){
                cutRightMaskInnerCorner(_arg_1, _arg_2);
            };
        }
        private static function cutRightMaskInnerCorner(_arg_1:BitmapData, _arg_2:int):void
        {
            var _local_3:int = ((_arg_1.width / 2) + (_arg_2 / 2));
            _arg_1.fillRect(new Rectangle(_local_3, 0, _arg_1.width, ((_arg_1.height / 2) - (_arg_2 / 4))), MASK_COLOR_TRANSPARENT);
        }
        private static function cutRightMaskOuterCorner(_arg_1:BitmapData, _arg_2:int, _arg_3:Boolean):void
        {
            var _local_4:int = (_arg_1.height / 2);
            var _local_5:int = ((_arg_1.width / 2) + _arg_2);
            if (_arg_3){
                _arg_1.fillRect(new Rectangle(_local_5, 0, _arg_1.width, _local_4), MASK_COLOR_TRANSPARENT);
            }
            else {
                fillBottomRightCorner(_arg_1, (_local_5 + 1), (_local_4 - 1), MASK_COLOR_TRANSPARENT);
            };
        }
        private static function storeLeftMask(_arg_1:IGraphicAssetCollection, _arg_2:BitmapData, _arg_3:int, _arg_4:int, _arg_5:int):void
        {
            var _local_6:String;
            if (_arg_1 != null){
                _local_6 = "";
                _local_6 = ((("mask_" + _arg_3) + "_0_") + getBorderType(_arg_4, _arg_5));
                _arg_1.addAsset(_local_6, _arg_2, false);
                _local_6 = ((("mask_" + _arg_3) + "_3_") + getBorderType(_arg_5, _arg_4));
                _arg_1.addAsset(_local_6, Rasterizer.getFlipVBitmapData(_arg_2), false);
                _local_6 = ((("mask_" + _arg_3) + "_4_") + getBorderType(_arg_4, _arg_5));
                _arg_1.addAsset(_local_6, Rasterizer.getFlipHVBitmapData(_arg_2), false);
                _local_6 = ((("mask_" + _arg_3) + "_7_") + getBorderType(_arg_5, _arg_4));
                _arg_1.addAsset(_local_6, Rasterizer.getFlipHBitmapData(_arg_2), false);
            };
        }
        private static function storeRightMask(_arg_1:IGraphicAssetCollection, _arg_2:BitmapData, _arg_3:int, _arg_4:int, _arg_5:int):void
        {
            var _local_6:String;
            if (_arg_1 != null){
                _local_6 = "";
                _local_6 = ((("mask_" + _arg_3) + "_1_") + getBorderType(_arg_4, _arg_5));
                _arg_1.addAsset(_local_6, _arg_2, false);
                _local_6 = ((("mask_" + _arg_3) + "_2_") + getBorderType(_arg_5, _arg_4));
                _arg_1.addAsset(_local_6, Rasterizer.getFlipVBitmapData(_arg_2), false);
                _local_6 = ((("mask_" + _arg_3) + "_5_") + getBorderType(_arg_4, _arg_5));
                _arg_1.addAsset(_local_6, Rasterizer.getFlipHVBitmapData(_arg_2), false);
                _local_6 = ((("mask_" + _arg_3) + "_6_") + getBorderType(_arg_5, _arg_4));
                _arg_1.addAsset(_local_6, Rasterizer.getFlipHBitmapData(_arg_2), false);
            };
        }
        private static function fillTopLeftCorner(_arg_1:BitmapData, _arg_2:int, _arg_3:int, _arg_4:int, _arg_5:uint):void
        {
            var _local_9:int;
            var _local_6:int = _arg_2;
            var _local_7:int = _arg_3;
            var _local_8:int = _arg_4;
            while (_local_7 >= 0) {
                _local_9 = _local_7;
                while (_local_9 >= 0) {
                    _arg_1.setPixel32(_local_6, _local_9, _arg_5);
                    _local_9--;
                };
                if (++_local_8 >= 2){
                    _local_7--;
                    _local_8 = 0;
                };
                _local_6++;
            };
        }
        private static function fillBottomRightCorner(_arg_1:BitmapData, _arg_2:int, _arg_3:int, _arg_4:uint):void
        {
            var _local_7:int;
            var _local_5:int = _arg_2;
            var _local_6:int = _arg_3;
            while (_local_5 < _arg_1.width) {
                _local_7 = _local_5;
                while (_local_7 < _arg_1.width) {
                    _arg_1.setPixel32(_local_7, _local_6, _arg_4);
                    _local_7++;
                };
                _local_6--;
                _local_5 = (_local_5 + 2);
            };
        }

    }
}//package com.sulake.habbo.room.object.visualization.furniture

// disposeInstanceMask = "_-3Cx" (String#21994, DoABC#2)
// getInstanceMaskName = "_-t9" (String#24412, DoABC#2)
// getInstanceMask = "_-1YO" (String#5528, DoABC#2)
// _SafeStr_12721 = "_-2ip" (String#20799, DoABC#2)
// _SafeStr_12722 = "_-v2" (String#24493, DoABC#2)
// _SafeStr_12723 = "_-352" (String#21697, DoABC#2)
// getBorderType = "_-1jN" (String#18260, DoABC#2)
// initializeShoreMasks = "_-2Ll" (String#6478, DoABC#2)
// createEmptyMask = "_-0D8" (String#14573, DoABC#2)
// createShoreMask2x2 = "_-3FY" (String#22100, DoABC#2)
// _SafeStr_12820 = "_-3K0" (String#22284, DoABC#2)
// disposeAsset = "_-2uj" (String#7174, DoABC#2)
// createMaskLeft = "_-1O4" (String#17437, DoABC#2)
// cutLeftMask = "_-2Js" (String#19804, DoABC#2)
// storeLeftMask = "_-0wY" (String#16292, DoABC#2)
// createMaskRight = "_-2J-" (String#19765, DoABC#2)
// cutRightMask = "_-2TY" (String#20183, DoABC#2)
// storeRightMask = "_-ZA" (String#23606, DoABC#2)
// fillTopLeftCorner = "_-Yt" (String#23595, DoABC#2)
// cutLeftMaskOuterCorner = "_-2VN" (String#20256, DoABC#2)
// cutLeftMaskInnerCorner = "_-7p" (String#22535, DoABC#2)
// fillBottomRightCorner = "_-2Q1" (String#20043, DoABC#2)
// cutRightMaskOuterCorner = "_-0u7" (String#16208, DoABC#2)
// cutRightMaskInnerCorner = "_-1lN" (String#18347, DoABC#2)
// getFlipVBitmapData = "_-vn" (String#24520, DoABC#2)
// getFlipHVBitmapData = "_-2RA" (String#20090, DoABC#2)
// getFlipHBitmapData = "_-Gl" (String#22880, DoABC#2)
// BitmapDataAsset = "_-0PB" (String#4074, DoABC#2)
// IGraphicAssetCollection = "_-24o" (String#6134, DoABC#2)
// IGraphicAsset = "_-1HF" (String#5195, DoABC#2)
// Rasterizer = "_-jl" (String#8595, DoABC#2)


