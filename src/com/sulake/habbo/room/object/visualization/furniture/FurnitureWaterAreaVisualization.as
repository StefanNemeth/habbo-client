
package com.sulake.habbo.room.object.visualization.furniture
{
    import flash.display.BitmapData;
    import com.sulake.room.object.visualization.utils.IGraphicAsset;
    import com.sulake.room.object.IRoomObjectModel;
    import com.sulake.habbo.room.object.RoomObjectVariableEnum;
    import flash.geom.Point;

    public class FurnitureWaterAreaVisualization extends AnimatedFurnitureVisualization 
    {

        private static const _SafeStr_12699:String = "shore";

        private var _SafeStr_12700:Boolean = true;
        private var _SafeStr_12701:Array;
        private var _SafeStr_12702:Array;
        private var _SafeStr_12703:Array;
        private var _needsShoreUpdate:Boolean = false;
        private var _sizeX:int = 0;
        private var _sizeY:int = 0;
        private var _shoreSpriteIndex:int = 0;
        private var _SafeStr_12705:int = -1;
        private var _SafeStr_12706:int = -1;
        private var _SafeStr_12707:BitmapData = null;

        public function FurnitureWaterAreaVisualization()
        {
            this._SafeStr_12701 = [];
            this._SafeStr_12702 = [];
            this._SafeStr_12703 = [];
            super();
        }
        override public function dispose():void
        {
            var _local_1:int;
            if (assetCollection != null){
                for each (_local_1 in this._SafeStr_12703) {
                    ShoreMaskCreatorUtility.disposeInstanceMask(object.getInstanceId(), _local_1, assetCollection);
                };
                this._SafeStr_12703 = [];
            };
            if (this._SafeStr_12707 != null){
                this._SafeStr_12707.dispose();
                this._SafeStr_12707 = null;
            };
            super.dispose();
        }
        override protected function updateObject(_arg_1:Number, _arg_2:Number):Boolean
        {
            if (super.updateObject(_arg_1, _arg_2)){
                this._needsShoreUpdate = true;
                this.updateBorderData();
                return (true);
            };
            return (false);
        }
        override protected function updateAnimation(_arg_1:Number):int
        {
            var _local_3:int;
            var _local_2:int = super.updateAnimation(_arg_1);
            if (this.updateInstanceShoreMask(_arg_1)){
                _local_3 = this.getShoreSpriteIndex(_arg_1);
                _local_2 = (_local_2 | (1 << _local_3));
            };
            return (_local_2);
        }
        override protected function getSpriteAssetName(_arg_1:int, _arg_2:int):String
        {
            if ((((_arg_1 == 1)) || (!((_arg_2 == this.getShoreSpriteIndex(_arg_1)))))){
                return (super.getSpriteAssetName(_arg_1, _arg_2));
            };
            if (this._SafeStr_12700){
                return (ShoreMaskCreatorUtility.getInstanceMaskName(object.getInstanceId(), getSize(_arg_1)));
            };
            return (null);
        }
        private function getShoreSpriteIndex(_arg_1:int):int
        {
            if ((((this._SafeStr_12705 == _arg_1)) && ((this._SafeStr_12706 == direction)))){
                return (this._shoreSpriteIndex);
            };
            var _local_2:int = (spriteCount - 1);
            while (_local_2 >= 0) {
                if (getSpriteTag(_arg_1, direction, _local_2) == _SafeStr_12699){
                    this._shoreSpriteIndex = _local_2;
                    this._SafeStr_12705 = _arg_1;
                    this._SafeStr_12706 = direction;
                    return (this._shoreSpriteIndex);
                };
                _local_2--;
            };
            return (-1);
        }
        private function getShoreAsset(_arg_1:int):IGraphicAsset
        {
            var _local_2:String = super.getSpriteAssetName(_arg_1, this.getShoreSpriteIndex(_arg_1));
            return (assetCollection.getAsset(_local_2));
        }
        private function getInstanceMask(_arg_1:int):IGraphicAsset
        {
            var _local_2:int = getSize(_arg_1);
            var _local_3:IGraphicAsset = ShoreMaskCreatorUtility.getInstanceMask(object.getInstanceId(), _local_2, assetCollection, this.getShoreAsset(_arg_1));
            if (_local_3 != null){
                if (this._SafeStr_12703.indexOf(_local_2) < 0){
                    this._SafeStr_12703.push(_local_2);
                };
            };
            return (_local_3);
        }
        private function updateBorderData():void
        {
            this.resetBorders();
            var _local_1:int = object.getState(0);
            var _local_2:Array = this.getAreaData();
            var _local_3:int = (this._sizeX + 2);
            var _local_4:int = (this._sizeY + 2);
            var _local_5:int;
            var _local_6:Array = _local_2[(_local_4 - 1)];
            _local_5 = (_local_3 - 1);
            while (_local_5 >= 0) {
                if ((_local_1 & 1)){
                    _local_6[_local_5] = true;
                };
                _local_1 = (_local_1 >> 1);
                _local_5--;
            };
            _local_5 = (_local_4 - 2);
            while (_local_5 >= 1) {
                _local_6 = _local_2[_local_5];
                if ((_local_1 & 1)){
                    _local_6[(_local_3 - 1)] = true;
                };
                _local_1 = (_local_1 >> 1);
                if ((_local_1 & 1)){
                    _local_6[0] = true;
                };
                _local_1 = (_local_1 >> 1);
                _local_5--;
            };
            _local_6 = _local_2[0];
            _local_5 = (_local_3 - 1);
            while (_local_5 >= 0) {
                if ((_local_1 & 1)){
                    _local_6[_local_5] = true;
                };
                _local_1 = (_local_1 >> 1);
                _local_5--;
            };
            var _local_7:int;
            _local_7 = this.updateTopBorder(_local_2, _local_7);
            _local_7 = this.updateRightBorder(_local_2, _local_7);
            _local_7 = this.updateBottomBorder(_local_2, _local_7);
            _local_7 = this.updateLeftBorder(_local_2, _local_7);
            this._SafeStr_12700 = false;
            _local_5 = 0;
            while (_local_5 < this._SafeStr_12701.length) {
                if (this._SafeStr_12701[_local_5] == true){
                    this._SafeStr_12700 = true;
                };
                _local_5++;
            };
        }
        private function updateTopBorder(_arg_1:Array, _arg_2:int):int
        {
            var _local_3:int = (this._sizeX + 2);
            var _local_4:Array = _arg_1[0];
            var _local_5:Array = _arg_1[1];
            var _local_6:int;
            var _local_7:int;
            var _local_8:int = 1;
            while (_local_8 < (_local_3 - 1)) {
                if (_local_4[_local_8] == false){
                    this._SafeStr_12701[_arg_2] = true;
                    if ((((_local_5[(_local_8 - 1)] == false)) && ((_local_4[(_local_8 - 1)] == false)))){
                        _local_6 = ShoreMaskCreatorUtility._SafeStr_12721;
                    }
                    else {
                        if (_local_4[(_local_8 - 1)] == true){
                            _local_6 = ShoreMaskCreatorUtility._SafeStr_12722;
                        }
                        else {
                            _local_6 = ShoreMaskCreatorUtility._SafeStr_12723;
                        };
                    };
                    if ((((_local_5[(_local_8 + 1)] == false)) && ((_local_4[(_local_8 + 1)] == false)))){
                        _local_7 = ShoreMaskCreatorUtility._SafeStr_12721;
                    }
                    else {
                        if (_local_4[(_local_8 + 1)] == true){
                            _local_7 = ShoreMaskCreatorUtility._SafeStr_12722;
                        }
                        else {
                            _local_7 = ShoreMaskCreatorUtility._SafeStr_12723;
                        };
                    };
                    this._SafeStr_12702[_arg_2] = ShoreMaskCreatorUtility.getBorderType(_local_6, _local_7);
                };
                _arg_2++;
                _local_8++;
            };
            return (_arg_2);
        }
        private function updateRightBorder(_arg_1:Array, _arg_2:int):int
        {
            var _local_3:int = (this._sizeX + 2);
            var _local_4:int = (this._sizeY + 2);
            var _local_5:int;
            var _local_6:int;
            var _local_7:Array;
            var _local_8:Array;
            var _local_9:Array;
            var _local_10:int = 1;
            while (_local_10 < (_local_4 - 1)) {
                _local_7 = _arg_1[_local_10];
                _local_8 = _arg_1[(_local_10 - 1)];
                _local_9 = _arg_1[(_local_10 + 1)];
                if (_local_7[(_local_3 - 1)] == false){
                    this._SafeStr_12701[_arg_2] = true;
                    if ((((_local_8[(_local_3 - 2)] == false)) && ((_local_8[(_local_3 - 1)] == false)))){
                        _local_5 = ShoreMaskCreatorUtility._SafeStr_12721;
                    }
                    else {
                        if (_local_8[(_local_3 - 1)] == true){
                            _local_5 = ShoreMaskCreatorUtility._SafeStr_12722;
                        }
                        else {
                            _local_5 = ShoreMaskCreatorUtility._SafeStr_12723;
                        };
                    };
                    if ((((_local_9[(_local_3 - 2)] == false)) && ((_local_9[(_local_3 - 1)] == false)))){
                        _local_6 = ShoreMaskCreatorUtility._SafeStr_12721;
                    }
                    else {
                        if (_local_9[(_local_3 - 1)] == true){
                            _local_6 = ShoreMaskCreatorUtility._SafeStr_12722;
                        }
                        else {
                            _local_6 = ShoreMaskCreatorUtility._SafeStr_12723;
                        };
                    };
                    this._SafeStr_12702[_arg_2] = ShoreMaskCreatorUtility.getBorderType(_local_5, _local_6);
                };
                _arg_2++;
                _local_10++;
            };
            return (_arg_2);
        }
        private function updateBottomBorder(_arg_1:Array, _arg_2:int):int
        {
            var _local_3:int = (this._sizeX + 2);
            var _local_4:int = (this._sizeY + 2);
            var _local_5:int;
            var _local_6:int;
            var _local_7:Array = _arg_1[(_local_4 - 1)];
            var _local_8:Array = _arg_1[(_local_4 - 2)];
            var _local_9:int = (_local_3 - 2);
            while (_local_9 >= 1) {
                if (_local_7[_local_9] == false){
                    this._SafeStr_12701[_arg_2] = true;
                    if ((((_local_8[(_local_9 + 1)] == false)) && ((_local_7[(_local_9 + 1)] == false)))){
                        _local_5 = ShoreMaskCreatorUtility._SafeStr_12721;
                    }
                    else {
                        if (_local_7[(_local_9 + 1)] == true){
                            _local_5 = ShoreMaskCreatorUtility._SafeStr_12722;
                        }
                        else {
                            _local_5 = ShoreMaskCreatorUtility._SafeStr_12723;
                        };
                    };
                    if ((((_local_8[(_local_9 - 1)] == false)) && ((_local_7[(_local_9 - 1)] == false)))){
                        _local_6 = ShoreMaskCreatorUtility._SafeStr_12721;
                    }
                    else {
                        if (_local_7[(_local_9 - 1)] == true){
                            _local_6 = ShoreMaskCreatorUtility._SafeStr_12722;
                        }
                        else {
                            _local_6 = ShoreMaskCreatorUtility._SafeStr_12723;
                        };
                    };
                    this._SafeStr_12702[_arg_2] = ShoreMaskCreatorUtility.getBorderType(_local_5, _local_6);
                };
                _arg_2++;
                _local_9--;
            };
            return (_arg_2);
        }
        private function updateLeftBorder(_arg_1:Array, _arg_2:int):int
        {
            var _local_3:int = (this._sizeX + 2);
            var _local_4:int = (this._sizeY + 2);
            var _local_5:int;
            var _local_6:int;
            var _local_7:Array;
            var _local_8:Array;
            var _local_9:Array;
            var _local_10:int = (_local_4 - 2);
            while (_local_10 >= 1) {
                _local_7 = _arg_1[_local_10];
                _local_8 = _arg_1[(_local_10 + 1)];
                _local_9 = _arg_1[(_local_10 - 1)];
                if (_local_7[0] == false){
                    this._SafeStr_12701[_arg_2] = true;
                    if ((((_local_8[1] == false)) && ((_local_8[0] == false)))){
                        _local_5 = ShoreMaskCreatorUtility._SafeStr_12721;
                    }
                    else {
                        if (_local_8[0] == true){
                            _local_5 = ShoreMaskCreatorUtility._SafeStr_12722;
                        }
                        else {
                            _local_5 = ShoreMaskCreatorUtility._SafeStr_12723;
                        };
                    };
                    if ((((_local_9[1] == false)) && ((_local_9[0] == false)))){
                        _local_6 = ShoreMaskCreatorUtility._SafeStr_12721;
                    }
                    else {
                        if (_local_9[0] == true){
                            _local_6 = ShoreMaskCreatorUtility._SafeStr_12722;
                        }
                        else {
                            _local_6 = ShoreMaskCreatorUtility._SafeStr_12723;
                        };
                    };
                    this._SafeStr_12702[_arg_2] = ShoreMaskCreatorUtility.getBorderType(_local_5, _local_6);
                };
                _arg_2++;
                _local_10--;
            };
            return (_arg_2);
        }
        private function resetBorders():void
        {
            var _local_2:IRoomObjectModel;
            if ((((this._sizeX == 0)) || ((this._sizeY == 0)))){
                if ((((object == null)) || ((object.getModel() == null)))){
                    return;
                };
                _local_2 = object.getModel();
                this._sizeX = _local_2.getNumber(RoomObjectVariableEnum._SafeStr_12442);
                this._sizeY = _local_2.getNumber(RoomObjectVariableEnum._SafeStr_12443);
            };
            this._SafeStr_12701 = [];
            this._SafeStr_12702 = [];
            var _local_1:int;
            while (_local_1 < ((this._sizeX * 2) + (this._sizeY * 2))) {
                this._SafeStr_12701.push(false);
                this._SafeStr_12702.push(ShoreMaskCreatorUtility._SafeStr_12723);
                _local_1++;
            };
        }
        private function getAreaData():Array
        {
            var _local_1:int = (this._sizeX + 2);
            var _local_2:int = (this._sizeY + 2);
            var _local_3:Array = [];
            var _local_4:Array;
            var _local_5:int;
            var _local_6:int;
            _local_6 = 0;
            while (_local_6 < _local_2) {
                _local_4 = [];
                _local_5 = (_local_1 - 1);
                while (_local_5 >= 0) {
                    _local_4.push(false);
                    _local_5--;
                };
                _local_3.push(_local_4);
                _local_6++;
            };
            _local_6 = 1;
            while (_local_6 < (_local_2 - 1)) {
                _local_4 = _local_3[_local_6];
                _local_5 = 1;
                while (_local_5 < (_local_1 - 1)) {
                    _local_4[_local_5] = true;
                    _local_5++;
                };
                _local_6++;
            };
            return (_local_3);
        }
        private function initializeShoreMasks(_arg_1:Number):Boolean
        {
            return (ShoreMaskCreatorUtility.initializeShoreMasks(getSize(_arg_1), assetCollection, this.getShoreAsset(_arg_1)));
        }
        private function createShoreMask(_arg_1:int, _arg_2:int, _arg_3:Number):BitmapData
        {
            if ((((((this._SafeStr_12707 == null)) || ((this._SafeStr_12707.width < _arg_1)))) || ((this._SafeStr_12707.height < _arg_2)))){
                if (this._SafeStr_12707 != null){
                    this._SafeStr_12707.dispose();
                };
                this._SafeStr_12707 = ShoreMaskCreatorUtility.createEmptyMask(_arg_1, _arg_2);
            };
            return (ShoreMaskCreatorUtility.createShoreMask2x2(this._SafeStr_12707, getSize(_arg_3), this._SafeStr_12701, this._SafeStr_12702, assetCollection));
        }
        private function updateInstanceShoreMask(_arg_1:Number):Boolean
        {
            var _local_3:BitmapData;
            var _local_4:BitmapData;
            var _local_5:IGraphicAsset;
            var _local_6:BitmapData;
            if (!this._needsShoreUpdate){
                return (false);
            };
            var _local_2:IGraphicAsset = this.getInstanceMask(_arg_1);
            if (((((!((_local_2 == null))) && (!((_local_2.asset == null))))) && (this.initializeShoreMasks(_arg_1)))){
                _local_3 = (_local_2.asset.content as BitmapData);
                if (_local_3 != null){
                    _local_4 = this.createShoreMask(_local_3.width, _local_3.height, _arg_1);
                    _local_5 = this.getShoreAsset(_arg_1);
                    if (((!((_local_5 == null))) && (!((_local_5.asset == null))))){
                        _local_6 = (_local_5.asset.content as BitmapData);
                        if (_local_6 != null){
                            _local_3.fillRect(_local_3.rect, 0);
                            _local_3.copyPixels(_local_6, _local_6.rect, new Point(0, 0), _local_4, new Point(0, 0), true);
                        };
                        this._needsShoreUpdate = false;
                    };
                };
                return (true);
            };
            return (false);
        }
        override protected function setAnimation(_arg_1:int):void
        {
            super.setAnimation(0);
        }

    }
}//package com.sulake.habbo.room.object.visualization.furniture

// _SafeStr_12442 = "_-0vN" (String#16252, DoABC#2)
// _SafeStr_12443 = "_-7h" (String#22530, DoABC#2)
// getSpriteTag = "_-00o" (String#14086, DoABC#2)
// _SafeStr_12699 = "_-ZR" (String#23612, DoABC#2)
// _SafeStr_12700 = "_-0mN" (String#15911, DoABC#2)
// _SafeStr_12701 = "_-0fI" (String#15642, DoABC#2)
// _SafeStr_12702 = "_-xI" (String#24580, DoABC#2)
// _SafeStr_12703 = "_-2su" (String#21194, DoABC#2)
// _shoreSpriteIndex = "_-2zG" (String#21431, DoABC#2)
// _SafeStr_12705 = "_-0We" (String#15302, DoABC#2)
// _SafeStr_12706 = "_-2HC" (String#19693, DoABC#2)
// _SafeStr_12707 = "_-15f" (String#4989, DoABC#2)
// disposeInstanceMask = "_-3Cx" (String#21994, DoABC#2)
// updateBorderData = "_-Lx" (String#23080, DoABC#2)
// updateInstanceShoreMask = "_-0Yk" (String#15389, DoABC#2)
// getShoreSpriteIndex = "_-XN" (String#23538, DoABC#2)
// getInstanceMaskName = "_-t9" (String#24412, DoABC#2)
// getShoreAsset = "_-1Pg" (String#17495, DoABC#2)
// getInstanceMask = "_-1YO" (String#5528, DoABC#2)
// resetBorders = "_-0ll" (String#15889, DoABC#2)
// getAreaData = "_-31G" (String#21549, DoABC#2)
// updateTopBorder = "_-0de" (String#15571, DoABC#2)
// updateRightBorder = "_-0Sx" (String#15167, DoABC#2)
// updateBottomBorder = "_-1BN" (String#16912, DoABC#2)
// updateLeftBorder = "_-2u5" (String#21243, DoABC#2)
// _SafeStr_12721 = "_-2ip" (String#20799, DoABC#2)
// _SafeStr_12722 = "_-v2" (String#24493, DoABC#2)
// _SafeStr_12723 = "_-352" (String#21697, DoABC#2)
// getBorderType = "_-1jN" (String#18260, DoABC#2)
// initializeShoreMasks = "_-2Ll" (String#6478, DoABC#2)
// createShoreMask = "_-0UK" (String#15217, DoABC#2)
// createEmptyMask = "_-0D8" (String#14573, DoABC#2)
// createShoreMask2x2 = "_-3FY" (String#22100, DoABC#2)
// RoomObjectVariableEnum = "_-1MH" (String#17370, DoABC#2)
// IRoomObjectModel = "_-253" (String#6141, DoABC#2)
// AnimatedFurnitureVisualization = "_-0y2" (String#4811, DoABC#2)
// FurnitureWaterAreaVisualization = "_-3U" (String#7735, DoABC#2)
// IGraphicAsset = "_-1HF" (String#5195, DoABC#2)
// updateAnimation = "_-XZ" (String#166, DoABC#2)
// spriteCount = "_-2A7" (String#6252, DoABC#2)
// setAnimation = "_-ON" (String#252, DoABC#2)
// getSpriteAssetName = "_-0c-" (String#590, DoABC#2)
// getSize = "_-1GK" (String#5174, DoABC#2)
// _sizeX = "_-sQ" (String#946, DoABC#2)
// _sizeY = "_-36G" (String#912, DoABC#2)


