
package com.sulake.habbo.room.object.visualization.room.rasterizer.basic
{
    import com.sulake.room.utils.IRoomGeometry;
    import flash.display.BitmapData;
    import com.sulake.room.utils.Vector3d;
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.habbo.room.object.visualization.room.rasterizer.animated.PlaneVisualizationAnimationLayer;
    import com.sulake.room.object.visualization.utils.IGraphicAssetCollection;
    import flash.geom.Point;
    import com.sulake.room.utils.IVector3d;

    public class PlaneVisualization 
    {

        private var _SafeStr_12502:Array;
        private var _geometry:IRoomGeometry = null;
        private var _PlaneMaterialCell:BitmapData;
        private var _cachedBitmapNormal:Vector3d = null;
        private var _SafeStr_12886:Boolean = false;
        private var _hasAnimationLayers:Boolean = false;

        public function PlaneVisualization(_arg_1:Number, _arg_2:int, _arg_3:IRoomGeometry)
        {
            this._SafeStr_12502 = [];
            super();
            if (_arg_2 < 0){
                _arg_2 = 0;
            };
            var _local_4:int;
            while (_local_4 < _arg_2) {
                this._SafeStr_12502.push(null);
                _local_4++;
            };
            this._geometry = _arg_3;
            this._cachedBitmapNormal = new Vector3d();
        }
        public function get geometry():IRoomGeometry
        {
            return (this._geometry);
        }
        public function get hasAnimationLayers():Boolean
        {
            return (this._hasAnimationLayers);
        }
        public function dispose():void
        {
            var _local_1:int;
            var _local_2:IDisposable;
            if (this._SafeStr_12502 != null){
                _local_1 = 0;
                while (_local_1 < this._SafeStr_12502.length) {
                    _local_2 = (this._SafeStr_12502[_local_1] as IDisposable);
                    if (_local_2 != null){
                        _local_2.dispose();
                    };
                    _local_1++;
                };
                this._SafeStr_12502 = null;
            };
            this._geometry = null;
            if (this._PlaneMaterialCell != null){
                this._PlaneMaterialCell.dispose();
            };
            if (this._cachedBitmapNormal != null){
                this._cachedBitmapNormal = null;
            };
        }
        public function clearCache():void
        {
            var _local_1:int;
            var _local_2:PlaneVisualizationLayer;
            var _local_3:PlaneVisualizationAnimationLayer;
            if (!this._SafeStr_12886){
                return;
            };
            if (this._PlaneMaterialCell != null){
                this._PlaneMaterialCell.dispose();
                this._PlaneMaterialCell = null;
            };
            if (this._cachedBitmapNormal != null){
                this._cachedBitmapNormal.assign(new Vector3d());
            };
            if (this._SafeStr_12502 != null){
                _local_1 = 0;
                while (_local_1 < this._SafeStr_12502.length) {
                    _local_2 = (this._SafeStr_12502[_local_1] as PlaneVisualizationLayer);
                    _local_3 = (this._SafeStr_12502[_local_1] as PlaneVisualizationAnimationLayer);
                    if (_local_2 != null){
                        _local_2.clearCache();
                    }
                    else {
                        if (_local_3 != null){
                            _local_3.clearCache();
                        };
                    };
                    _local_1++;
                };
            };
            this._SafeStr_12886 = false;
        }
        public function _SafeStr_4864(_arg_1:int, _arg_2:PlaneMaterial, _arg_3:uint, _arg_4:int, _arg_5:int=0):Boolean
        {
            if ((((_arg_1 < 0)) || ((_arg_1 > this._SafeStr_12502.length)))){
                return (false);
            };
            var _local_6:IDisposable = (this._SafeStr_12502[_arg_1] as IDisposable);
            if (_local_6 != null){
                _local_6.dispose();
                _local_6 = null;
            };
            _local_6 = new PlaneVisualizationLayer(_arg_2, _arg_3, _arg_4, _arg_5);
            this._SafeStr_12502[_arg_1] = _local_6;
            return (true);
        }
        public function setAnimationLayer(_arg_1:int, _arg_2:XML, _arg_3:IGraphicAssetCollection):Boolean
        {
            if ((((_arg_1 < 0)) || ((_arg_1 > this._SafeStr_12502.length)))){
                return (false);
            };
            var _local_4:IDisposable = (this._SafeStr_12502[_arg_1] as IDisposable);
            if (_local_4 != null){
                _local_4.dispose();
                _local_4 = null;
            };
            _local_4 = new PlaneVisualizationAnimationLayer(_arg_2, _arg_3);
            this._SafeStr_12502[_arg_1] = _local_4;
            this._hasAnimationLayers = true;
            return (true);
        }
        public function render(_arg_1:BitmapData, _arg_2:int, _arg_3:int, _arg_4:IVector3d, _arg_5:Boolean, _arg_6:int=0, _arg_7:int=0, _arg_8:int=0, _arg_9:int=0, _arg_10:Number=0, _arg_11:Number=0, _arg_12:int=0):BitmapData
        {
            var _local_14:PlaneVisualizationLayer;
            var _local_15:PlaneVisualizationAnimationLayer;
            if (_arg_2 < 1){
                _arg_2 = 1;
            };
            if (_arg_3 < 1){
                _arg_3 = 1;
            };
            if ((((((_arg_1 == null)) || (!((_arg_1.width == _arg_2))))) || (!((_arg_1.height == _arg_3))))){
                _arg_1 = null;
            };
            if (this._PlaneMaterialCell != null){
                if ((((((this._PlaneMaterialCell.width == _arg_2)) && ((this._PlaneMaterialCell.height == _arg_3)))) && (Vector3d.isEqual(this._cachedBitmapNormal, _arg_4)))){
                    if (!this.hasAnimationLayers){
                        if (_arg_1 != null){
                            _arg_1.copyPixels(this._PlaneMaterialCell, this._PlaneMaterialCell.rect, new Point(0, 0), null, null, false);
                            return (_arg_1);
                        };
                        return (this._PlaneMaterialCell);
                    };
                }
                else {
                    this._PlaneMaterialCell.dispose();
                    this._PlaneMaterialCell = null;
                };
            };
            this._SafeStr_12886 = true;
            if (this._PlaneMaterialCell == null){
                this._PlaneMaterialCell = new BitmapData(_arg_2, _arg_3, true, 0xFFFFFF);
            }
            else {
                this._PlaneMaterialCell.fillRect(this._PlaneMaterialCell.rect, 0xFFFFFF);
            };
            if (_arg_1 == null){
                _arg_1 = this._PlaneMaterialCell;
            };
            this._cachedBitmapNormal.assign(_arg_4);
            var _local_13:int;
            while (_local_13 < this._SafeStr_12502.length) {
                _local_14 = (this._SafeStr_12502[_local_13] as PlaneVisualizationLayer);
                _local_15 = (this._SafeStr_12502[_local_13] as PlaneVisualizationAnimationLayer);
                if (_local_14 != null){
                    _local_14.render(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5);
                }
                else {
                    if (_local_15 != null){
                        _local_15.render(_arg_1, _arg_2, _arg_3, _arg_4, _arg_6, _arg_7, _arg_8, _arg_9, _arg_10, _arg_11, _arg_12);
                    };
                };
                _local_13++;
            };
            if (((!((_arg_1 == null))) && (!((_arg_1 == this._PlaneMaterialCell))))){
                this._PlaneMaterialCell.copyPixels(_arg_1, _arg_1.rect, new Point(0, 0), null, null, false);
                return (_arg_1);
            };
            return (this._PlaneMaterialCell);
        }

    }
}//package com.sulake.habbo.room.object.visualization.room.rasterizer.basic

// _SafeStr_12502 = "_-20V" (String#1798, DoABC#2)
// _PlaneMaterialCell = "_-3BZ" (String#917, DoABC#2)
// _SafeStr_12886 = "_-1qn" (String#868, DoABC#2)
// isEqual = "_-2hG" (String#20740, DoABC#2)
// _hasAnimationLayers = "_-0VN" (String#15257, DoABC#2)
// IVector3d = "_-hf" (String#8547, DoABC#2)
// Vector3d = "_-1Rb" (String#17568, DoABC#2)
// IGraphicAssetCollection = "_-24o" (String#6134, DoABC#2)
// IRoomGeometry = "_-0z9" (String#4829, DoABC#2)
// IDisposable = "_-0dY" (String#4382, DoABC#2)
// PlaneVisualizationLayer = "_-3FM" (String#22091, DoABC#2)
// PlaneMaterial = "_-W-" (String#8321, DoABC#2)
// PlaneVisualizationAnimationLayer = "_-1Wv" (String#5492, DoABC#2)
// _SafeStr_4864 = "finally" (String#45073, DoABC#2)
// setAnimationLayer = "_-16q" (String#16729, DoABC#2)


