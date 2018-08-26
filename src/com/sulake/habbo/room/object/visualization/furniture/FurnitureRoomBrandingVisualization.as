
package com.sulake.habbo.room.object.visualization.furniture
{
    import com.sulake.room.object.IRoomObject;
    import com.sulake.room.object.IRoomObjectModel;
    import com.sulake.habbo.room.object.RoomObjectVariableEnum;
    import com.sulake.room.object.visualization.utils.IGraphicAsset;
    import flash.display.BitmapData;
    import flash.geom.Matrix;

    public class FurnitureRoomBrandingVisualization extends FurnitureVisualization 
    {

        private static const _SafeStr_12653:String = "branded_image";
        private static const _SafeStr_12654:int = 0;
        private static const _SafeStr_12655:int = 1;
        private static const _SafeStr_12656:int = 2;
        private static const _SafeStr_12657:int = 3;

        protected var _imageUrl:String;
        protected var _SafeStr_12658:Boolean = false;
        protected var _SafeStr_12659:int;
        protected var _SafeStr_12660:int;
        protected var _paramOffsetZ:int;

        override public function dispose():void
        {
            super.dispose();
            this._imageUrl = null;
        }
        override protected function updateObject(_arg_1:Number, _arg_2:Number):Boolean
        {
            if (super.updateObject(_arg_1, _arg_2)){
                if (this._SafeStr_12658){
                    this.checkAndCreateImageForCurrentState(_arg_1);
                };
                return (true);
            };
            return (false);
        }
        override protected function updateModel(_arg_1:Number):Boolean
        {
            var _local_3:IRoomObject;
            var _local_4:IRoomObjectModel;
            var _local_2:Boolean = super.updateModel(_arg_1);
            if (_local_2){
                _local_3 = object;
                if (_local_3 != null){
                    _local_4 = _local_3.getModel();
                    if (_local_4 != null){
                        this._SafeStr_12659 = _local_4.getNumber(RoomObjectVariableEnum._SafeStr_12477);
                        this._SafeStr_12660 = _local_4.getNumber(RoomObjectVariableEnum._SafeStr_12478);
                        this._paramOffsetZ = _local_4.getNumber(RoomObjectVariableEnum._SafeStr_12479);
                    };
                };
            };
            if (!this._SafeStr_12658){
                this._SafeStr_12658 = this.checkIfImageReady();
                if (this._SafeStr_12658){
                    this.checkAndCreateImageForCurrentState(_arg_1);
                    return (true);
                };
            }
            else {
                if (this.checkIfImageChanged()){
                    this._SafeStr_12658 = false;
                    this._imageUrl = null;
                    return (true);
                };
            };
            return (_local_2);
        }
        protected function checkIfImageChanged():Boolean
        {
            var _local_2:IRoomObjectModel;
            var _local_3:String;
            var _local_1:IRoomObject = object;
            if (_local_1 != null){
                _local_2 = _local_1.getModel();
                if (_local_2 != null){
                    _local_3 = _local_2.getString(RoomObjectVariableEnum._SafeStr_12475);
                    if (((!((_local_3 == null))) && (!((_local_3 == this._imageUrl))))){
                        return (true);
                    };
                };
            };
            return (false);
        }
        protected function checkIfImageReady():Boolean
        {
            var _local_2:IRoomObjectModel;
            var _local_3:String;
            var _local_4:Number;
            var _local_5:IGraphicAsset;
            var _local_6:BitmapData;
            var _local_1:IRoomObject = object;
            if (_local_1 != null){
                _local_2 = _local_1.getModel();
                if (_local_2 != null){
                    _local_3 = _local_2.getString(RoomObjectVariableEnum._SafeStr_12475);
                    if (_local_3 != null){
                        if ((((this._imageUrl == null)) || (!((this._imageUrl == _local_3))))){
                            _local_4 = _local_2.getNumber(RoomObjectVariableEnum._SafeStr_12474);
                            if (_local_4 == 1){
                                _local_5 = assetCollection.getAsset(_local_3);
                                if (_local_5 != null){
                                    _local_6 = (_local_5.asset.content as BitmapData);
                                    if (_local_6 != null){
                                        this.imageReady(_local_6, _local_3);
                                        return (true);
                                    };
                                };
                            };
                        };
                    };
                };
            };
            return (false);
        }
        override protected function updateSprites(_arg_1:int, _arg_2:Boolean, _arg_3:int):void
        {
            super.updateSprites(_arg_1, _arg_2, _arg_3);
        }
        protected function imageReady(_arg_1:BitmapData, _arg_2:String):void
        {
            Logger.log(("billboard visualization got image from url = " + _arg_2));
            if (_arg_1 != null){
                this._imageUrl = _arg_2;
            }
            else {
                this._imageUrl = null;
            };
        }
        override protected function getSpriteAssetName(_arg_1:int, _arg_2:int):String
        {
            var _local_7:int;
            var _local_3:int = FurnitureVisualization(_arg_1);
            var _local_4:String = type;
            var _local_5:String = "";
            if (_arg_2 < (spriteCount - 1)){
                _local_5 = String.fromCharCode(("a".charCodeAt() + _arg_2));
            }
            else {
                _local_5 = "sd";
            };
            if (_local_3 == 1){
                _local_4 = (_local_4 + ("_icon_" + _local_5));
            }
            else {
                _local_7 = getFrameNumber(_arg_1, _arg_2);
                _local_4 = (_local_4 + ((((((("_" + _local_3) + "_") + _local_5) + "_") + direction) + "_") + _local_7));
            };
            var _local_6:String = FurnitureVisualization(_arg_1, direction, _arg_2);
            if (((!((this._imageUrl == null))) && ((_local_6 == _SafeStr_12653)))){
                return (((((this._imageUrl + "_") + _local_3) + "_") + object.getState(0)));
            };
            return (_local_4);
        }
        private function checkAndCreateImageForCurrentState(_arg_1:int):void
        {
            var _local_8:BitmapData;
            var _local_14:Matrix;
            if ((((object == null)) || ((this._imageUrl == null)))){
                return;
            };
            var _local_2:IGraphicAsset = assetCollection.getAsset(this._imageUrl);
            if (_local_2 == null){
                return;
            };
            var _local_3:int = object.getState(0);
            var _local_4:int = FurnitureVisualization(_arg_1);
            var _local_5:String = ((((this._imageUrl + "_") + _local_4) + "_") + _local_3);
            var _local_6:IGraphicAsset = assetCollection.getAsset(_local_5);
            if (_local_6 != null){
                return;
            };
            var _local_7:BitmapData = (_local_2.asset.content as BitmapData);
            if (_local_7 == null){
                Logger.log(("could not find bitmap data for image " + _local_5));
                return;
            };
            if (_local_4 == 32){
                _local_14 = new Matrix();
                _local_14.scale(0.5, 0.5);
                _local_8 = new BitmapData((_local_7.width / 2), (_local_7.height / 2), true, 0xFFFFFF);
                _local_8.draw(_local_7, _local_14);
            }
            else {
                _local_8 = _local_7.clone();
            };
            var _local_9:int;
            var _local_10:int;
            var _local_11:Boolean;
            var _local_12:Boolean;
            switch (_local_3){
                case _SafeStr_12654:
                    _local_9 = 0;
                    _local_10 = 0;
                    _local_11 = false;
                    _local_12 = false;
                    break;
                case _SafeStr_12655:
                    _local_9 = -(_local_8.width);
                    _local_10 = 0;
                    _local_11 = true;
                    _local_12 = false;
                    break;
                case _SafeStr_12656:
                    _local_9 = -(_local_8.width);
                    _local_10 = -(_local_8.height);
                    _local_11 = true;
                    _local_12 = true;
                    break;
                case _SafeStr_12657:
                    _local_9 = 0;
                    _local_10 = -(_local_8.height);
                    _local_11 = false;
                    _local_12 = true;
                    break;
                default:
                    Logger.log(("could not handle unknown state " + _local_3));
            };
            var _local_13:Boolean = assetCollection.addAsset(_local_5, _local_8, true, _local_9, _local_10, _local_11, _local_12);
            if (!_local_13){
                Logger.log(("could not add asset for image " + _local_5));
            };
        }

    }
}//package com.sulake.habbo.room.object.visualization.furniture

// _SafeStr_12474 = "_-1cM" (String#17984, DoABC#2)
// _SafeStr_12475 = "_-19Q" (String#16834, DoABC#2)
// _SafeStr_12477 = "_-2MO" (String#19901, DoABC#2)
// _SafeStr_12478 = "_-0cY" (String#15536, DoABC#2)
// _SafeStr_12479 = "_-0Kb" (String#14864, DoABC#2)
// updateSprites = "_-03G" (String#805, DoABC#2)
// FurnitureVisualization = "_-00o" (String#14086, DoABC#2)
// _SafeStr_12653 = "_-1r9" (String#18588, DoABC#2)
// _SafeStr_12654 = "_-4" (String#22377, DoABC#2)
// _SafeStr_12655 = "_-Bi" (String#22678, DoABC#2)
// _SafeStr_12656 = "_-32B" (String#21588, DoABC#2)
// _SafeStr_12657 = "_-0SI" (String#15146, DoABC#2)
// _SafeStr_12658 = "_-1Nc" (String#17422, DoABC#2)
// _SafeStr_12659 = "_-Hj" (String#22921, DoABC#2)
// _SafeStr_12660 = "_-1-i" (String#16455, DoABC#2)
// checkAndCreateImageForCurrentState = "_-1ua" (String#18739, DoABC#2)
// checkIfImageReady = "_-ie" (String#23985, DoABC#2)
// checkIfImageChanged = "_-1k5" (String#18292, DoABC#2)
// RoomObjectVariableEnum = "_-1MH" (String#17370, DoABC#2)
// IRoomObjectModel = "_-253" (String#6141, DoABC#2)
// FurnitureVisualization = "_-1sy" (String#5900, DoABC#2)
// FurnitureRoomBrandingVisualization = "_-1XC" (String#5501, DoABC#2)
// IGraphicAsset = "_-1HF" (String#5195, DoABC#2)
// updateModel = "_-1CW" (String#441, DoABC#2)
// spriteCount = "_-2A7" (String#6252, DoABC#2)
// getFrameNumber = "_-0XM" (String#436, DoABC#2)
// getSpriteAssetName = "_-0c-" (String#590, DoABC#2)
// FurnitureVisualization = "_-1GK" (String#5174, DoABC#2)


