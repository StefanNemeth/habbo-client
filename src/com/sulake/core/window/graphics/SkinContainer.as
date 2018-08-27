
package com.sulake.core.window.graphics
{
    import com.sulake.core.assets.IAssetLibrary;
    import flash.utils.Dictionary;
    import com.sulake.core.assets.IAsset;
    import com.sulake.core.window.graphics.renderer.ISkinRenderer;
    import com.sulake.core.window.utils.DefaultAttStruct;
    import com.sulake.core.window.utils.TypeCodeTable;
    import com.sulake.core.window.utils.StateCodeTable;
    import com.sulake.core.window.graphics.renderer.BitmapSkinRenderer;
    import com.sulake.core.window.graphics.renderer.BitmapDataRenderer;
    import com.sulake.core.window.graphics.renderer.FillSkinRenderer;
    import com.sulake.core.window.graphics.renderer.TextSkinRenderer;
    import com.sulake.core.window.graphics.renderer.LabelRenderer;
    import com.sulake.core.window.graphics.renderer.ShapeSkinRenderer;
    import com.sulake.core.window.graphics.renderer.SkinRenderer;
    import com.sulake.core.window.graphics.renderer.NullSkinRenderer;
    import com.sulake.core.window.enum.WindowState;
    import com.sulake.core.window.enum.WindowStyle;
    import com.sulake.core.window.graphics.renderer.*;

    public class SkinContainer implements ISkinContainer 
    {

        private static const _SafeStr_9559:uint = 8;
        private static const _SafeStr_9560:String = "skin";
        private static const get:String = "bitmap";
        private static const _SafeStr_9561:String = "fill";
        private static const _SafeStr_9562:String = "text";
        private static const _SafeStr_9563:String = "label";
        private static const _SafeStr_9564:String = "shape";
        private static const RENDERER_TYPE_UNKNOWN:String = "unknown";
        private static const RENDERER_TYPE_NULL:String = "null";
        protected static var _SafeStr_9565:Array;

        private var _disposed:Boolean = false;
        private var _assetLibrary:IAssetLibrary;
        private var _SafeStr_9566:Dictionary;
        private var _SafeStr_9567:Dictionary;
        private var _SafeStr_9568:Dictionary;
        private var _SafeStr_9569:Dictionary;
        private var _SafeStr_9570:Dictionary;
        private var _SafeStr_9571:Dictionary;
        private var _SafeStr_9572:Dictionary;

        public function SkinContainer(_arg_1:XML, _arg_2:IAssetLibrary)
        {
            var _local_3:XMLList;
            var _local_4:uint;
            var _local_5:XML;
            var _local_6:XMLList;
            var _local_7:String;
            var _local_8:String;
            var _local_9:uint;
            var _local_10:uint;
            var _local_11:String;
            var _local_12:String;
            var _local_13:IAsset;
            var _local_14:ISkinRenderer;
            var _local_15:String;
            var _local_16:Class;
            var _local_17:DefaultAttStruct;
            var _local_18:uint;
            super();
            this._assetLibrary = _arg_2;
            this._SafeStr_9566 = new Dictionary();
            this._SafeStr_9567 = new Dictionary();
            this._SafeStr_9569 = new Dictionary();
            this._SafeStr_9570 = new Dictionary();
            TypeCodeTable.fillTables(this._SafeStr_9569, this._SafeStr_9570);
            this._SafeStr_9571 = new Dictionary();
            this._SafeStr_9572 = new Dictionary();
            StateCodeTable.fillTables(this._SafeStr_9571, this._SafeStr_9572);
            this._SafeStr_9568 = new Dictionary();
            this._SafeStr_9568[_SafeStr_9560] = BitmapSkinRenderer;
            this._SafeStr_9568[get] = BitmapDataRenderer;
            this._SafeStr_9568[_SafeStr_9561] = FillSkinRenderer;
            this._SafeStr_9568[_SafeStr_9562] = TextSkinRenderer;
            this._SafeStr_9568[_SafeStr_9563] = LabelRenderer;
            this._SafeStr_9568[_SafeStr_9564] = ShapeSkinRenderer;
            this._SafeStr_9568[RENDERER_TYPE_UNKNOWN] = SkinRenderer;
            this._SafeStr_9568[RENDERER_TYPE_NULL] = NullSkinRenderer;
            if (_SafeStr_9565 == null){
                _SafeStr_9565 = new Array();
                _SafeStr_9565.push(WindowState._SafeStr_9479);
                _SafeStr_9565.push(WindowState._SafeStr_9399);
                _SafeStr_9565.push(WindowState._SafeStr_6248);
                _SafeStr_9565.push(WindowState._SafeStr_9258);
                _SafeStr_9565.push(WindowState._SafeStr_5004);
                _SafeStr_9565.push(WindowState._SafeStr_9170);
                _SafeStr_9565.push(WindowState._SafeStr_4586);
                _SafeStr_9565.push(WindowState._SafeStr_4075);
            };
            if (_arg_1 != null){
                _local_3 = _arg_1.child("component");
                _local_4 = _local_3.length();
                if (_local_4 > 0){
                    _local_18 = 0;
                    while (_local_18 < _local_4) {
                        _local_5 = _local_3[_local_18];
                        _local_7 = _local_5.attribute("type");
                        _local_8 = _local_5.attribute("style");
                        _local_9 = (_local_5.attribute("blend") as uint);
                        _local_10 = (_local_5.attribute("color") as uint);
                        _local_11 = _local_5.attribute("asset");
                        _local_12 = _local_5.attribute("layout");
                        _local_15 = _local_5.attribute("renderer");
                        _local_6 = _local_5.child("states");
                        _local_16 = this._SafeStr_9568[_local_15];
                        if (_local_16){
                            _local_14 = new (_local_16)(_local_12);
                            if (_local_14){
                                _local_13 = this._assetLibrary.getAssetByName(_local_11);
                                _local_14.parse(_local_13, _local_6, this._assetLibrary);
                            };
                        };
                        _local_17 = new DefaultAttStruct();
                        _local_17._SafeStr_9574 = ((_local_5.@treshold[0]) ? uint(_local_5.@treshold[0]) : 10);
                        _local_17.background = ((_local_5.@background[0]) ? (_local_5.@background[0] == "true") : false);
                        _local_17.blend = ((_local_5.@blend[0]) ? Number(_local_5.@blend[0]) : 1);
                        _local_17.color = ((_local_5.@color[0]) ? uint(_local_5.@color[0]) : 0xFFFFFF);
                        _local_17.width_min = ((_local_5.@width_min[0]) ? int(_local_5.@width_min[0]) : int.MIN_VALUE);
                        _local_17.width_max = ((_local_5.@width_max[0]) ? int(_local_5.@width_max[0]) : int.MAX_VALUE);
                        _local_17.height_min = ((_local_5.@height_min[0]) ? int(_local_5.@height_min[0]) : int.MIN_VALUE);
                        _local_17.height_max = ((_local_5.@height_max[0]) ? int(_local_5.@height_max[0]) : int.MAX_VALUE);
                        this.addSkinRenderer(this._SafeStr_9569[_local_7], uint(_local_8), _local_14, _local_17);
                        _local_18++;
                    };
                };
            };
        }
        public function get disposed():Boolean
        {
            return (this._disposed);
        }
        public function dispose():void
        {
            this._SafeStr_9566 = null;
            this._SafeStr_9567 = null;
            this._assetLibrary = null;
            this._disposed = true;
        }
        public function addSkinRenderer(_arg_1:uint, _arg_2:uint, _arg_3:ISkinRenderer, _arg_4:DefaultAttStruct):void
        {
            if (this._SafeStr_9566[_arg_1] == null){
                this._SafeStr_9566[_arg_1] = new Array(_SafeStr_9559);
            };
            this._SafeStr_9566[_arg_1][_arg_2] = _arg_3;
            if (this._SafeStr_9567[_arg_1] == null){
                this._SafeStr_9567[_arg_1] = new Array(_SafeStr_9559);
            };
            this._SafeStr_9567[_arg_1][_arg_2] = _arg_4;
        }
        public function getSkinRendererByTypeAndStyle(_arg_1:uint, _arg_2:uint):ISkinRenderer
        {
            var _local_4:ISkinRenderer;
            var _local_3:Array = this._SafeStr_9566[_arg_1];
            if (_local_3){
                _local_4 = _local_3[_arg_2];
                if (((!(_local_4)) && (!((_arg_2 == WindowStyle._SafeStr_9310))))){
                    _local_4 = _local_3[WindowStyle._SafeStr_9310];
                };
            };
            return (_local_4);
        }
        public function getDefaultAttributesByTypeAndStyle(_arg_1:uint, _arg_2:uint):DefaultAttStruct
        {
            var _local_4:DefaultAttStruct;
            var _local_3:Array = this._SafeStr_9567[_arg_1];
            if (_local_3){
                _local_4 = _local_3[_arg_2];
                if (((!(_local_4)) && (!((_arg_2 == WindowStyle._SafeStr_9310))))){
                    _local_4 = _local_3[WindowStyle._SafeStr_9310];
                };
            };
            return (_local_4);
        }
        public function getTheActualState(_arg_1:uint, _arg_2:uint, _arg_3:uint):uint
        {
            var _local_5:uint;
            var _local_4:ISkinRenderer = this.getSkinRendererByTypeAndStyle(_arg_1, _arg_2);
            if (_local_4){
                for each (_local_5 in _SafeStr_9565) {
                    if ((_arg_3 & _local_5) == _local_5){
                        if (_local_4.isStateDrawable(_local_5)){
                            return (_local_5);
                        };
                    };
                };
            };
            return (0);
        }

    }
}//package com.sulake.core.window.graphics

// DefaultAttStruct = "_-2e0" (String#20604, DoABC#2)
// ISkinContainer = "_-us" (String#8781, DoABC#2)
// SkinContainer = "_-9E" (String#7847, DoABC#2)
// ISkinRenderer = "_-1uJ" (String#1780, DoABC#2)
// WindowState = "_-1Kt" (String#5262, DoABC#2)
// WindowStyle = "_-10b" (String#4885, DoABC#2)
// SkinRenderer = "_-bE" (String#8445, DoABC#2)
// ShapeSkinRenderer = "_-0oe" (String#4606, DoABC#2)
// LabelRenderer = "_-1NN" (String#5301, DoABC#2)
// TextSkinRenderer = "_-wx" (String#8824, DoABC#2)
// FillSkinRenderer = "_-08m" (String#3735, DoABC#2)
// NullSkinRenderer = "_-2bq" (String#6791, DoABC#2)
// TypeCodeTable = "_-0bK" (String#4329, DoABC#2)
// BitmapSkinRenderer = "_-CQ" (String#7925, DoABC#2)
// StateCodeTable = "_-fd" (String#23872, DoABC#2)
// isStateDrawable = "_-0hI" (String#4452, DoABC#2)
// _SafeStr_4075 = "_-0DX" (String#14589, DoABC#2)
// _SafeStr_4586 = "_-22X" (String#19111, DoABC#2)
// _SafeStr_5004 = "_-0Yv" (String#15399, DoABC#2)
// _SafeStr_6248 = "_-3J9" (String#22246, DoABC#2)
// _SafeStr_9170 = "_-2FR" (String#19621, DoABC#2)
// _SafeStr_9258 = "const" (String#44694, DoABC#2)
// _SafeStr_9310 = "_-2-h" (String#19000, DoABC#2)
// _SafeStr_9399 = "_-1WJ" (String#17754, DoABC#2)
// _SafeStr_9479 = "_-H4" (String#22893, DoABC#2)
// getSkinRendererByTypeAndStyle = "_-0j" (String#4480, DoABC#2)
// getDefaultAttributesByTypeAndStyle = "_-Sn" (String#8262, DoABC#2)
// getTheActualState = "_-0Or" (String#4067, DoABC#2)
// _SafeStr_9559 = "_-19L" (String#16829, DoABC#2)
// _SafeStr_9560 = "_-13q" (String#16610, DoABC#2)
// _SafeStr_9561 = "_-2HR" (String#19702, DoABC#2)
// _SafeStr_9562 = "_-1MI" (String#17371, DoABC#2)
// _SafeStr_9563 = "_-322" (String#21581, DoABC#2)
// _SafeStr_9564 = "_-P8" (String#23212, DoABC#2)
// _SafeStr_9565 = "_-0GP" (String#14698, DoABC#2)
// _SafeStr_9566 = "_-aO" (String#23648, DoABC#2)
// _SafeStr_9567 = "_-1I" (String#17191, DoABC#2)
// _SafeStr_9568 = "_-4S" (String#22395, DoABC#2)
// _SafeStr_9569 = "_-2mC" (String#20926, DoABC#2)
// _SafeStr_9570 = "_-0DQ" (String#14586, DoABC#2)
// _SafeStr_9571 = "_-KK" (String#23019, DoABC#2)
// _SafeStr_9572 = "_-2kM" (String#20860, DoABC#2)
// fillTables = "_-15n" (String#16687, DoABC#2)
// _SafeStr_9574 = "_-2pO" (String#21053, DoABC#2)
// addSkinRenderer = "_-08E" (String#14373, DoABC#2)


