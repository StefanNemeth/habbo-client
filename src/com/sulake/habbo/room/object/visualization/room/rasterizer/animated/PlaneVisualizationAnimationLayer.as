
package com.sulake.habbo.room.object.visualization.room.rasterizer.animated
{
    import com.sulake.core.runtime.IDisposable;
    import flash.display.BitmapData;
    import com.sulake.room.object.visualization.utils.IGraphicAsset;
    import com.sulake.core.assets.BitmapDataAsset;
    import com.sulake.room.object.visualization.utils.IGraphicAssetCollection;
    import flash.geom.Point;
    import com.sulake.room.utils.IVector3d;

    public class PlaneVisualizationAnimationLayer implements IDisposable 
    {

        private var _color:uint = 0;
        private var _bitmapData:BitmapData = null;
        private var _disposed:Boolean = false;
        private var _items:Array;

        public function PlaneVisualizationAnimationLayer(_arg_1:XML, _arg_2:IGraphicAssetCollection)
        {
            var _local_3:XMLList;
            var _local_4:int;
            var _local_5:XML;
            var _local_6:String;
            var _local_7:IGraphicAsset;
            var _local_8:BitmapDataAsset;
            var _local_9:BitmapData;
            var _local_10:AnimationItem;
            this._items = [];
            super();
            if (((!((_arg_1 == null))) && (!((_arg_2 == null))))){
                _local_3 = _arg_1.item;
                _local_4 = 0;
                while (_local_4 < _local_3.length()) {
                    _local_5 = (_local_3[_local_4] as XML);
                    if (_local_5 != null){
                        _local_6 = _local_5.@asset;
                        _local_7 = _arg_2.getAsset(_local_6);
                        if (_local_7 != null){
                            _local_8 = (_local_7.asset as BitmapDataAsset);
                            if (_local_8 != null){
                                _local_9 = (_local_8.content as BitmapData);
                                if (_local_9 != null){
                                    _local_10 = new AnimationItem(parseFloat(_local_5.@x), parseFloat(_local_5.@y), parseFloat(_local_5.@speedX), parseFloat(_local_5.@speedY), _local_9);
                                    this._items.push(_local_10);
                                };
                            };
                        };
                    };
                    _local_4++;
                };
            };
        }
        public function get disposed():Boolean
        {
            return (this._disposed);
        }
        public function dispose():void
        {
            var _local_1:int;
            var _local_2:AnimationItem;
            this._disposed = true;
            if (this._bitmapData != null){
                this._bitmapData.dispose();
                this._bitmapData = null;
            };
            if (this._items != null){
                _local_1 = 0;
                while (_local_1 < this._items.length) {
                    _local_2 = (this._items[_local_1] as AnimationItem);
                    if (_local_2 != null){
                        _local_2.dispose();
                    };
                    _local_1++;
                };
                this._items = [];
            };
        }
        public function clearCache():void
        {
            if (this._bitmapData != null){
                this._bitmapData.dispose();
                this._bitmapData = null;
            };
        }
        public function render(_arg_1:BitmapData, _arg_2:int, _arg_3:int, _arg_4:IVector3d, _arg_5:int, _arg_6:int, _arg_7:int, _arg_8:int, _arg_9:Number, _arg_10:Number, _arg_11:int):BitmapData
        {
            var _local_12:int;
            var _local_13:AnimationItem;
            var _local_14:Point;
            if ((((((_arg_1 == null)) || (!((_arg_1.width == _arg_2))))) || (!((_arg_1.height == _arg_3))))){
                if ((((((this._bitmapData == null)) || (!((this._bitmapData.width == _arg_2))))) || (!((this._bitmapData.height == _arg_3))))){
                    if (this._bitmapData != null){
                        this._bitmapData.dispose();
                    };
                    this._bitmapData = new BitmapData(_arg_2, _arg_3, true, 0xFFFFFF);
                }
                else {
                    this._bitmapData.fillRect(this._bitmapData.rect, 0xFFFFFF);
                };
                _arg_1 = this._bitmapData;
            };
            if ((((_arg_7 > 0)) && ((_arg_8 > 0)))){
                _local_12 = 0;
                while (_local_12 < this._items.length) {
                    _local_13 = (this._items[_local_12] as AnimationItem);
                    if (_local_13 != null){
                        _local_14 = _local_13.getPosition(_arg_7, _arg_8, _arg_9, _arg_10, _arg_11);
                        _local_14.x = (_local_14.x - _arg_5);
                        _local_14.y = (_local_14.y - _arg_6);
                        if (_local_13.bitmapData != null){
                            if ((((((((_local_14.x > -(_local_13.bitmapData.width))) && ((_local_14.x < _arg_1.width)))) && ((_local_14.y > -(_local_13.bitmapData.height))))) && ((_local_14.y < _arg_1.height)))){
                                _arg_1.copyPixels(_local_13.bitmapData, _local_13.bitmapData.rect, _local_14, null, null, true);
                            };
                            if (((((((((_local_14.x - _arg_7) > -(_local_13.bitmapData.width))) && (((_local_14.x - _arg_7) < _arg_1.width)))) && ((_local_14.y > -(_local_13.bitmapData.height))))) && ((_local_14.y < _arg_1.height)))){
                                _arg_1.copyPixels(_local_13.bitmapData, _local_13.bitmapData.rect, new Point((_local_14.x - _arg_7), _local_14.y), null, null, true);
                            };
                            if ((((((((_local_14.x > -(_local_13.bitmapData.width))) && ((_local_14.x < _arg_1.width)))) && (((_local_14.y - _arg_8) > -(_local_13.bitmapData.height))))) && (((_local_14.y - _arg_8) < _arg_1.height)))){
                                _arg_1.copyPixels(_local_13.bitmapData, _local_13.bitmapData.rect, new Point(_local_14.x, (_local_14.y - _arg_8)), null, null, true);
                            };
                            if (((((((((_local_14.x - _arg_7) > -(_local_13.bitmapData.width))) && (((_local_14.x - _arg_7) < _arg_1.width)))) && (((_local_14.y - _arg_8) > -(_local_13.bitmapData.height))))) && (((_local_14.y - _arg_8) < _arg_1.height)))){
                                _arg_1.copyPixels(_local_13.bitmapData, _local_13.bitmapData.rect, new Point((_local_14.x - _arg_7), (_local_14.y - _arg_8)), null, null, true);
                            };
                        };
                    };
                    _local_12++;
                };
            };
            return (_arg_1);
        }

    }
}//package com.sulake.habbo.room.object.visualization.room.rasterizer.animated

// BitmapDataAsset = "_-0PB" (String#4074, DoABC#2)
// IVector3d = "_-hf" (String#8547, DoABC#2)
// IGraphicAssetCollection = "_-24o" (String#6134, DoABC#2)
// IGraphicAsset = "_-1HF" (String#5195, DoABC#2)
// IDisposable = "_-0dY" (String#4382, DoABC#2)
// PlaneVisualizationAnimationLayer = "_-1Wv" (String#5492, DoABC#2)
// AnimationItem = "_-zq" (String#8879, DoABC#2)
// _disposed = "_-6m" (String#31, DoABC#2)
// getPosition = "_-GB" (String#7997, DoABC#2)


