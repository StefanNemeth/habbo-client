
package com.sulake.habbo.room.object.visualization.room.rasterizer.basic
{
    import com.sulake.core.runtime.IDisposable;
    import flash.display.BitmapData;
    import flash.geom.ColorTransform;
    import flash.geom.Point;
    import com.sulake.room.utils.IVector3d;

    public class PlaneVisualizationLayer implements IDisposable 
    {

        public static const _SafeStr_4860:int = 0;
        public static const _SafeStr_4863:int = 1;
        public static const _SafeStr_4862:int = 2;
        public static const ALIGN_DEFAULT:int = _SafeStr_4863;//1

        private var _material:PlaneMaterial = null;
        private var _color:uint = 0;
        private var _offset:int = 0;
        private var _align:int = 1;
        private var _bitmapData:BitmapData = null;
        private var _disposed:Boolean = false;

        public function PlaneVisualizationLayer(_arg_1:PlaneMaterial, _arg_2:uint, _arg_3:int, _arg_4:int=0)
        {
            this._material = _arg_1;
            this._offset = _arg_4;
            this._align = _arg_3;
            this._color = _arg_2;
        }
        public function get offset():int
        {
            return (this._offset);
        }
        public function get align():int
        {
            return (this._align);
        }
        public function get disposed():Boolean
        {
            return (this._disposed);
        }
        public function dispose():void
        {
            this._disposed = true;
            this._material = null;
            if (this._bitmapData != null){
                this._bitmapData.dispose();
                this._bitmapData = null;
            };
        }
        public function clearCache():void
        {
            if (this._bitmapData != null){
                this._bitmapData.dispose();
                this._bitmapData = null;
            };
        }
        public function render(_arg_1:BitmapData, _arg_2:int, _arg_3:int, _arg_4:IVector3d, _arg_5:Boolean):BitmapData
        {
            var _local_11:Number;
            var _local_12:Number;
            var _local_13:Number;
            var _local_14:ColorTransform;
            var _local_6:uint = (this._color >> 16);
            var _local_7:uint = ((this._color >> 8) & 0xFF);
            var _local_8:uint = (this._color & 0xFF);
            var _local_9:Boolean;
            if ((((((_local_6 < 0xFF)) || ((_local_7 < 0xFF)))) || ((_local_8 < 0xFF)))){
                _local_9 = true;
            };
            if ((((((_arg_1 == null)) || (!((_arg_1.width == _arg_2))))) || (!((_arg_1.height == _arg_3))))){
                _arg_1 = null;
            };
            var _local_10:BitmapData;
            if (this._material != null){
                if (_local_9){
                    _local_10 = this._material.render(null, _arg_2, _arg_3, _arg_4, _arg_5, this.offset, (this.align == _SafeStr_4863));
                }
                else {
                    _local_10 = this._material.render(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5, this.offset, (this.align == _SafeStr_4863));
                };
                if (((!((_local_10 == null))) && (!((_local_10 == _arg_1))))){
                    if (this._bitmapData != null){
                        this._bitmapData.dispose();
                    };
                    this._bitmapData = _local_10.clone();
                    _local_10 = this._bitmapData;
                };
            }
            else {
                if (_arg_1 == null){
                    if (((((!((this._bitmapData == null))) && ((this._bitmapData.width == _arg_2)))) && ((this._bitmapData.height == _arg_3)))){
                        return (this._bitmapData);
                    };
                    if (this._bitmapData != null){
                        this._bitmapData.dispose();
                    };
                    this._bitmapData = new BitmapData(_arg_2, _arg_3, true, 0xFFFFFFFF);
                    _local_10 = this._bitmapData;
                }
                else {
                    _arg_1.fillRect(_arg_1.rect, 0xFFFFFFFF);
                    _local_10 = _arg_1;
                };
            };
            if (_local_10 != null){
                if (_local_9){
                    _local_11 = (_local_6 / 0xFF);
                    _local_12 = (_local_7 / 0xFF);
                    _local_13 = (_local_8 / 0xFF);
                    _local_14 = new ColorTransform(_local_11, _local_12, _local_13);
                    _local_10.colorTransform(_local_10.rect, _local_14);
                    if (((!((_arg_1 == null))) && (!((_local_10 == _arg_1))))){
                        _arg_1.copyPixels(_local_10, _local_10.rect, new Point(0, 0), null, null, true);
                        _local_10 = _arg_1;
                    };
                };
            };
            return (_local_10);
        }

    }
}//package com.sulake.habbo.room.object.visualization.room.rasterizer.basic

// IVector3d = "_-hf" (String#8547, DoABC#2)
// IDisposable = "_-0dY" (String#4382, DoABC#2)
// PlaneVisualizationLayer = "_-3FM" (String#22091, DoABC#2)
// PlaneMaterial = "_-W-" (String#8321, DoABC#2)
// _disposed = "_-6m" (String#31, DoABC#2)
// _SafeStr_4860 = "_-0HE" (String#14729, DoABC#2)
// _SafeStr_4862 = "_-3BX" (String#7541, DoABC#2)
// _SafeStr_4863 = "_-0Ny" (String#4045, DoABC#2)


