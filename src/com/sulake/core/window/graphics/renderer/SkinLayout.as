
package com.sulake.core.window.graphics.renderer
{
    import com.sulake.core.window.utils.ChildEntityArray;
    import com.sulake.core.window.utils.IChildEntityArray;
    import com.sulake.core.window.utils.IChildEntityArrayReader;
    import flash.geom.Rectangle;
    import com.sulake.core.window.utils.IChildEntity;

    public class SkinLayout extends ChildEntityArray implements ISkinLayout 
    {

        protected var _name:String;
        protected var _width:uint;
        protected var _height:uint;
        protected var _blendMode:String;
        protected var _transparent:Boolean;
        protected var _placeholders:IChildEntityArray;

        public function SkinLayout(_arg_1:String, _arg_2:Boolean, _arg_3:String, _arg_4:IChildEntityArray)
        {
            this._name = _arg_1;
            this._width = 0;
            this._height = 0;
            this._blendMode = _arg_3;
            this._transparent = _arg_2;
            this._placeholders = _arg_4;
        }
        public function get name():String
        {
            return (this._name);
        }
        public function get width():uint
        {
            return (this._width);
        }
        public function get height():uint
        {
            return (this._height);
        }
        public function get blendMode():String
        {
            return (this._blendMode);
        }
        public function get transparent():Boolean
        {
            return (this._transparent);
        }
        public function get placeholders():IChildEntityArrayReader
        {
            return (this._placeholders);
        }
        public function dispose():void
        {
            var _local_1:uint;
            var _local_3:String;
            var _local_2:uint = numChildren;
            _local_1 = 0;
            while (_local_1 < _local_2) {
                SkinLayoutEntity(getChildAt(_local_1)).dispose();
                _local_1++;
            };
            for (_local_3 in this._placeholders) {
                SkinLayoutEntity(this._placeholders[_local_3]).dispose();
                delete this._placeholders[_local_3];
            };
        }
        public function SkinLayout(_arg_1:Rectangle):void
        {
            var _local_2:Rectangle;
            var _local_3:SkinLayoutEntity;
            var _local_5:uint;
            var _local_4:uint = numChildren;
            _arg_1.x = 0xFFFFFFFF;
            _arg_1.y = 0xFFFFFFFF;
            _arg_1.width = 0;
            _arg_1.height = 0;
            _local_5 = 0;
            while (_local_5 < _local_4) {
                _local_3 = (getChildAt(_local_5) as SkinLayoutEntity);
                _local_2 = _local_3.region;
                if (_local_2.left < _arg_1.left){
                    _arg_1.left = _local_2.left;
                };
                if (_local_2.top < _arg_1.top){
                    _arg_1.top = _local_2.top;
                };
                if (_local_2.right > _arg_1.right){
                    _arg_1.right = _local_2.right;
                };
                if (_local_2.bottom > _arg_1.bottom){
                    _arg_1.bottom = _local_2.bottom;
                };
                _local_5++;
            };
        }
        public function ISkinLayout():Boolean
        {
            var _local_2:uint;
            var _local_1:uint = numChildren;
            if (_local_1 == 0){
                return (false);
            };
            _local_2 = 0;
            while (_local_2 < _local_1) {
                if (SkinLayoutEntity(getChildAt(_local_2))._SafeStr_4078 != SkinLayoutEntity._SafeStr_4086){
                    return (false);
                };
                _local_2++;
            };
            return (true);
        }
        public function SkinLayout():uint
        {
            var _local_2:Rectangle;
            var _local_4:uint;
            var _local_1:uint;
            var _local_3:uint = numChildren;
            _local_4 = 0;
            while (_local_4 < _local_3) {
                _local_2 = SkinLayoutEntity(getChildAt(_local_4)).region;
                if (_local_2.right > _local_1){
                    _local_1 = _local_2.right;
                };
                _local_4++;
            };
            return (_local_1);
        }
        public function ISkinLayout():Boolean
        {
            var _local_2:uint;
            var _local_1:uint = numChildren;
            if (_local_1 == 0){
                return (false);
            };
            _local_2 = 0;
            while (_local_2 < _local_1) {
                if (SkinLayoutEntity(getChildAt(_local_2))._SafeStr_4083 != SkinLayoutEntity._SafeStr_4086){
                    return (false);
                };
                _local_2++;
            };
            return (true);
        }
        public function SkinLayout():uint
        {
            var _local_2:Rectangle;
            var _local_4:uint;
            var _local_1:uint;
            var _local_3:uint = numChildren;
            _local_4 = 0;
            while (_local_4 < _local_3) {
                _local_2 = SkinLayoutEntity(getChildAt(_local_4)).region;
                if (_local_2.bottom > _local_1){
                    _local_1 = _local_2.bottom;
                };
                _local_4++;
            };
            return (_local_1);
        }
        public function ISkinLayout(_arg_1:String, _arg_2:Rectangle):void
        {
            var _local_3:SkinLayoutEntity = (getChildByName(_arg_1) as SkinLayoutEntity);
            if (_local_3 == null){
                _local_3 = (this._placeholders.getChildByName(_arg_1) as SkinLayoutEntity);
                if (_local_3 == null){
                    throw (new Error((("Entity not found: " + _arg_1) + "!")));
                };
            };
            _arg_2.x = _local_3.region.x;
            _arg_2.y = _local_3.region.y;
            _arg_2.width = _local_3.region.width;
            _arg_2.height = _local_3.region.height;
        }
        override public function addChild(_arg_1:IChildEntity):IChildEntity
        {
            var _local_2:SkinLayoutEntity = SkinLayoutEntity(_arg_1);
            this._width = (((_local_2.region.right)>this._width) ? _local_2.region.right : this._width);
            this._height = (((_local_2.region.bottom)>this._height) ? _local_2.region.bottom : this._height);
            return (super.addChild(_arg_1));
        }
        override public function addChildAt(_arg_1:IChildEntity, _arg_2:int):IChildEntity
        {
            var _local_3:SkinLayoutEntity = SkinLayoutEntity(_arg_1);
            this._width = (((_local_3.region.right)>this._width) ? _local_3.region.right : this._width);
            this._height = (((_local_3.region.bottom)>this._height) ? _local_3.region.bottom : this._height);
            return (super.addChildAt(_arg_1, _arg_2));
        }
        override public function removeChild(_arg_1:IChildEntity):IChildEntity
        {
            super.removeChild(_arg_1);
            this._width = this.SkinLayout();
            this._height = this.SkinLayout();
            return (_arg_1);
        }
        override public function removeChildAt(_arg_1:int):IChildEntity
        {
            var _local_2:IChildEntity = super.removeChildAt(_arg_1);
            this._width = this.SkinLayout();
            this._height = this.SkinLayout();
            return (_local_2);
        }

    }
}//package com.sulake.core.window.graphics.renderer

// IChildEntityArrayReader = "_-1kK" (String#5755, DoABC#2)
// IChildEntityArray = "_-2oU" (String#7047, DoABC#2)
// ISkinLayout = "_-m8" (String#2182, DoABC#2)
// IChildEntity = "_-1NX" (String#5302, DoABC#2)
// SkinLayoutEntity = "_-27j" (String#6196, DoABC#2)
// ChildEntityArray = "_-w1" (String#8805, DoABC#2)
// SkinLayout = "_-2Ti" (String#6640, DoABC#2)
// _width = "_-0Uq" (String#92, DoABC#2)
// placeholders = "_-b7" (String#8444, DoABC#2)
// ISkinLayout = "_-CN" (String#7923, DoABC#2)
// ISkinLayout = "_-3By" (String#7551, DoABC#2)
// ISkinLayout = "_-1Bw" (String#5109, DoABC#2)
// _SafeStr_4078 = "_-30D" (String#21509, DoABC#2)
// _SafeStr_4083 = "_-2vf" (String#21301, DoABC#2)
// _SafeStr_4086 = "_-0SW" (String#15154, DoABC#2)
// _blendMode = "_-KX" (String#8094, DoABC#2)
// _transparent = "_-1QG" (String#17521, DoABC#2)
// SkinLayout = "_-1Kl" (String#17302, DoABC#2)
// SkinLayout = "_-0MA" (String#14921, DoABC#2)
// SkinLayout = "_-07R" (String#14341, DoABC#2)


