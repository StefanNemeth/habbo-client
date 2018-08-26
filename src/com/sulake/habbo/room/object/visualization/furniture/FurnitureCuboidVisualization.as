
package com.sulake.habbo.room.object.visualization.furniture
{
    import com.sulake.room.object.visualization.RoomObjectSpriteVisualization;
    import com.sulake.core.assets.AssetLibrary;
    import com.sulake.room.object.visualization.IRoomObjectVisualizationData;
    import com.sulake.room.utils.IVector3d;
    import com.sulake.room.object.IRoomObject;
    import com.sulake.habbo.room.object.RoomObjectVariableEnum;
    import com.sulake.room.utils.Vector3d;
    import com.sulake.room.utils.IRoomGeometry;
    import com.sulake.core.assets.BitmapDataAsset;
    import com.sulake.room.object.visualization.IRoomObjectSprite;
    import flash.display.BitmapData;
    import flash.geom.Point;

    public class FurnitureCuboidVisualization extends RoomObjectSpriteVisualization 
    {

        private var _assetLibrary:AssetLibrary = null;
        private var _SafeStr_12729:Array;
        private var _planesInitialized:Boolean = false;
        private var _SafeStr_12730:int = 0;

        public function FurnitureCuboidVisualization()
        {
            this._SafeStr_12729 = [];
            super();
        }
        override public function dispose():void
        {
            var _local_1:int;
            var _local_2:FurniturePlane;
            super.dispose();
            if (this._assetLibrary != null){
                this._assetLibrary.dispose();
                this._assetLibrary = null;
            };
            if (this._SafeStr_12729 != null){
                _local_1 = 0;
                while (_local_1 < this._SafeStr_12729.length) {
                    _local_2 = (this._SafeStr_12729[_local_1] as FurniturePlane);
                    if (_local_2 != null){
                        _local_2.dispose();
                    };
                    _local_1++;
                };
                this._SafeStr_12729 = null;
            };
        }
        override public function initialize(_arg_1:IRoomObjectVisualizationData):Boolean
        {
            reset();
            return (true);
        }
        protected function RoomVisualization():void
        {
            var _local_1:int = 1;
            createSprites(_local_1);
        }
        protected function initializePlanes():void
        {
            var _local_9:IVector3d;
            var _local_10:FurniturePlane;
            if (this._planesInitialized){
                return;
            };
            var _local_1:IRoomObject = object;
            if (_local_1 == null){
                return;
            };
            var _local_2:int = 1;
            var _local_3:Number = _local_1.getModel().getNumber(RoomObjectVariableEnum._SafeStr_12442);
            var _local_4:Number = _local_1.getModel().getNumber(RoomObjectVariableEnum._SafeStr_12443);
            var _local_5:Number = _local_1.getModel().getNumber(RoomObjectVariableEnum._SafeStr_4992);
            if (((((isNaN(_local_3)) || (isNaN(_local_4)))) || (isNaN(_local_5)))){
                return;
            };
            var _local_6:Vector3d = new Vector3d(_local_3, 0, 0);
            var _local_7:Vector3d = new Vector3d(0, _local_4, 0);
            var _local_8:Vector3d = new Vector3d(-0.5, -0.5, 0);
            if (((((!((_local_8 == null))) && (!((_local_6 == null))))) && (!((_local_7 == null))))){
                _local_9 = Vector3d.crossProduct(_local_6, _local_7);
                _local_10 = new FurniturePlane(_local_8, _local_6, _local_7);
                _local_10.color = 0xFFFF00;
                this._SafeStr_12729.push(_local_10);
            }
            else {
                return;
            };
            this._planesInitialized = true;
            this.RoomVisualization();
        }
        override public function update(_arg_1:IRoomGeometry, _arg_2:int, _arg_3:Boolean, _arg_4:Boolean):void
        {
            var _local_5:IRoomObject = object;
            if (_local_5 == null){
                return;
            };
            if (this._assetLibrary == null){
                this._assetLibrary = new AssetLibrary(("furniture cuboid visualization - " + _local_5.getInstanceId()));
            };
            if (_arg_1 == null){
                return;
            };
            this.initializePlanes();
            this.RoomVisualization(_arg_1, _arg_2);
        }
        protected function RoomVisualization(_arg_1:IRoomGeometry, _arg_2:int):void
        {
            var _local_6:Boolean;
            var _local_7:String;
            var _local_8:BitmapDataAsset;
            var _local_9:FurniturePlane;
            var _local_10:IRoomObjectSprite;
            var _local_11:int;
            var _local_12:BitmapData;
            var _local_13:BitmapData;
            var _local_14:Point;
            var _local_3:IRoomObject = object;
            if (_local_3 == null){
                return;
            };
            if ((((_arg_1 == null)) || ((this._assetLibrary == null)))){
                return;
            };
            this._SafeStr_12730++;
            var _local_4:int = _arg_2;
            var _local_5:int;
            while (_local_5 < this._SafeStr_12729.length) {
                _local_6 = false;
                _local_7 = ((("plane " + _local_5) + " ") + _arg_1.scale);
                _local_8 = (this._assetLibrary.getAssetByName(_local_7) as BitmapDataAsset);
                if (_local_8 == null){
                    _local_8 = new BitmapDataAsset(this._assetLibrary.IAssetLibrary(BitmapDataAsset));
                    this._assetLibrary.IAssetLibrary(_local_7, _local_8);
                };
                _local_9 = (this._SafeStr_12729[_local_5] as FurniturePlane);
                if (_local_9 != null){
                    _local_11 = _local_3.getDirection().x;
                    if (((((_local_11 / 45) == 2)) || (((_local_11 / 45) == 6)))){
                        _local_9.FurniturePlane(true);
                    }
                    else {
                        _local_9.FurniturePlane(false);
                    };
                    if (_local_9.update(_arg_1, _local_4)){
                        _local_12 = _local_9.bitmapData;
                        _local_13 = (_local_8.content as BitmapData);
                        if (_local_12 == null){
                            _local_8 = null;
                        }
                        else {
                            if (_local_13 != _local_12){
                                if (_local_13 != null){
                                    _local_13.dispose();
                                };
                                _local_8.setUnknownContent(_local_12);
                            };
                        };
                        _local_6 = true;
                    };
                }
                else {
                    _local_8 = null;
                };
                _local_10 = getSprite(_local_5);
                if (_local_10 != null){
                    if (_local_9 != null){
                        _local_14 = _local_9.offset;
                        _local_10.offsetX = -(_local_14.x);
                        _local_10.offsetY = -(_local_14.y);
                        _local_10.color = _local_9.color;
                        _local_10.visible = _local_9.visible;
                    }
                    else {
                        _local_10.visible = false;
                    };
                    if (_local_8 != null){
                        _local_10.asset = (_local_8.content as BitmapData);
                    }
                    else {
                        _local_10.asset = null;
                    };
                    if (_local_6){
                        _local_10.assetName = ((((_local_7 + "_") + _local_3.getInstanceId()) + "_") + this._SafeStr_12730);
                    };
                    _local_10.relativeDepth = _local_9.relativeDepth;
                };
                _local_5++;
            };
        }

    }
}//package com.sulake.habbo.room.object.visualization.furniture

// _SafeStr_12442 = "_-0vN" (String#16252, DoABC#2)
// _SafeStr_12443 = "_-7h" (String#22530, DoABC#2)
// _SafeStr_12729 = "_-29o" (String#879, DoABC#2)
// _SafeStr_12730 = "_-2md" (String#7014, DoABC#2)
// RoomVisualization = "_-10j" (String#4890, DoABC#2)
// crossProduct = "_-0hD" (String#15719, DoABC#2)
// RoomVisualization = "_-22x" (String#6103, DoABC#2)
// FurniturePlane = "_-0yz" (String#16391, DoABC#2)
// BitmapDataAsset = "_-0PB" (String#4074, DoABC#2)
// IVector3d = "_-hf" (String#8547, DoABC#2)
// Vector3d = "_-1Rb" (String#17568, DoABC#2)
// RoomObjectVariableEnum = "_-1MH" (String#17370, DoABC#2)
// IRoomObjectVisualizationData = "_-26A" (String#6167, DoABC#2)
// RoomObjectSpriteVisualization = "_-01y" (String#3602, DoABC#2)
// FurnitureCuboidVisualization = "_-1uL" (String#18731, DoABC#2)
// IRoomGeometry = "_-0z9" (String#4829, DoABC#2)
// IRoomObjectSprite = "_-0di" (String#4386, DoABC#2)
// getSprite = "_-sN" (String#2210, DoABC#2)
// createSprites = "_-1Im" (String#17226, DoABC#2)
// initializePlanes = "_-CW" (String#459, DoABC#2)
// _SafeStr_4992 = "_-0BD" (String#14494, DoABC#2)
// setUnknownContent = "_-2zE" (String#7271, DoABC#2)
// IAssetLibrary = "_-08Y" (String#3730, DoABC#2)
// IAssetLibrary = "_-5x" (String#7779, DoABC#2)


