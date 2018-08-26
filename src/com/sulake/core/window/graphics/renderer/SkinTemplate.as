
package com.sulake.core.window.graphics.renderer
{
    import com.sulake.core.window.utils.ChildEntityArray;
    import com.sulake.core.assets.IAsset;

    public class SkinTemplate extends ChildEntityArray implements ISkinTemplate 
    {

        protected var _name:String;
        protected var _tags:Array;
        protected var _asset:IAsset;

        public function SkinTemplate(_arg_1:String, _arg_2:IAsset)
        {
            this._name = _arg_1;
            this._tags = new Array();
            this._asset = _arg_2;
        }
        public function get id():uint
        {
            return (0);
        }
        public function get name():String
        {
            return (this._name);
        }
        public function get tags():Array
        {
            return (this._tags);
        }
        public function get asset():IAsset
        {
            return (this._asset);
        }
        public function dispose():void
        {
            var _local_2:uint;
            var _local_1:uint = this.numChildren;
            _local_2 = 0;
            while (_local_2 < _local_1) {
                this.removeChildAt(0);
                _local_2++;
            };
            this._asset = null;
            this._tags = null;
            this._name = null;
        }

    }
}//package com.sulake.core.window.graphics.renderer

// ISkinTemplate = "_-31I" (String#1988, DoABC#2)
// ChildEntityArray = "_-w1" (String#8805, DoABC#2)
// SkinTemplate = "_-1Oy" (String#5332, DoABC#2)
// _tags = "_-1NU" (String#163, DoABC#2)
// _asset = "_-1S7" (String#442, DoABC#2)


