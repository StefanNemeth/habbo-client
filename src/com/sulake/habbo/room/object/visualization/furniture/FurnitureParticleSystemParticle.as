
package com.sulake.habbo.room.object.visualization.furniture
{
    import flash.geom.Vector3D;
    import com.sulake.room.object.visualization.utils.IGraphicAsset;

    public class FurnitureParticleSystemParticle 
    {

        private var _x:Number;
        private var _y:Number;
        private var _z:Number;
        private var _lastX:Number;
        private var _lastY:Number;
        private var _lastZ:Number;
        private var _hasMoved:Boolean = false;
        private var _direction:Vector3D;
        private var _age:int = 0;
        private var _SafeStr_12757:int;
        private var _isEmitter:Boolean = false;
        private var _fade:Boolean = false;
        private var _SafeStr_6839:Number;
        private var _alphaMultiplier:Number = 1;
        private var _frames:Array;

        public function get fade():Boolean
        {
            return (this._fade);
        }
        public function get alphaMultiplier():Number
        {
            return (this._alphaMultiplier);
        }
        public function get direction():Vector3D
        {
            return (this._direction);
        }
        public function get age():int
        {
            return (this._age);
        }
        public function init(_arg_1:Number, _arg_2:Number, _arg_3:Number, _arg_4:Vector3D, _arg_5:Number, _arg_6:Number, _arg_7:int, _arg_8:Boolean=false, _arg_9:Array=null, _arg_10:Boolean=false):void
        {
            this._x = _arg_1;
            this._y = _arg_2;
            this._z = _arg_3;
            this._direction = new Vector3D(_arg_4.x, _arg_4.y, _arg_4.z);
            this._direction.scaleBy(_arg_5);
            this._lastX = (this._x - (this._direction.x * _arg_6));
            this._lastY = (this._y - (this._direction.y * _arg_6));
            this._lastZ = (this._z - (this._direction.z * _arg_6));
            this._age = 0;
            this._hasMoved = false;
            this._SafeStr_12757 = _arg_7;
            this._isEmitter = _arg_8;
            this._frames = _arg_9;
            this._fade = _arg_10;
            this._alphaMultiplier = 1;
            this._SafeStr_6839 = (0.5 + (Math.random() * 0.5));
        }
        public function update():void
        {
            this._age++;
            if (this._age == this._SafeStr_12757){
                this.ignite();
            };
            if (this._fade){
                if ((this._age / this._SafeStr_12757) > this._SafeStr_6839){
                    this._alphaMultiplier = ((this._SafeStr_12757 - this._age) / (this._SafeStr_12757 * (1 - this._SafeStr_6839)));
                };
            };
        }
        public function getAsset():IGraphicAsset
        {
            if (((this._frames) && ((this._frames.length > 0)))){
                return (this._frames[(this._age % this._frames.length)]);
            };
            return (null);
        }
        protected function ignite():void
        {
        }
        public function get isEmitter():Boolean
        {
            return (this._isEmitter);
        }
        public function get isAlive():Boolean
        {
            return ((this._age <= this._SafeStr_12757));
        }
        public function dispose():void
        {
            this._direction = null;
        }
        public function get x():Number
        {
            return (this._x);
        }
        public function get y():Number
        {
            return (this._y);
        }
        public function get z():Number
        {
            return (this._z);
        }
        public function set x(_arg_1:Number):void
        {
            this._x = _arg_1;
        }
        public function set y(_arg_1:Number):void
        {
            this._y = _arg_1;
        }
        public function set z(_arg_1:Number):void
        {
            this._z = _arg_1;
        }
        public function get lastX():Number
        {
            return (this._lastX);
        }
        public function set lastX(_arg_1:Number):void
        {
            this._hasMoved = true;
            this._lastX = _arg_1;
        }
        public function get lastY():Number
        {
            return (this._lastY);
        }
        public function set lastY(_arg_1:Number):void
        {
            this._hasMoved = true;
            this._lastY = _arg_1;
        }
        public function get lastZ():Number
        {
            return (this._lastZ);
        }
        public function set lastZ(_arg_1:Number):void
        {
            this._hasMoved = true;
            this._lastZ = _arg_1;
        }
        public function get hasMoved():Boolean
        {
            return (this._hasMoved);
        }
        public function toString():String
        {
            return ([this._x, this._y, this._z].toString());
        }

    }
}//package com.sulake.habbo.room.object.visualization.furniture

// _lastX = "_-1M4" (String#17361, DoABC#2)
// _lastY = "_-3JP" (String#22261, DoABC#2)
// _lastZ = "_-lW" (String#24091, DoABC#2)
// _hasMoved = "_-2Iy" (String#19763, DoABC#2)
// _SafeStr_12757 = "_-2t7" (String#21205, DoABC#2)
// _isEmitter = "_-2k8" (String#20853, DoABC#2)
// _fade = "_-2Hy" (String#19726, DoABC#2)
// ignite = "_-338" (String#7370, DoABC#2)
// isAlive = "_-2ki" (String#20873, DoABC#2)
// lastX = "_-32g" (String#21604, DoABC#2)
// lastY = "_-1kv" (String#18328, DoABC#2)
// lastZ = "_-1B6" (String#16903, DoABC#2)
// hasMoved = "_-yC" (String#24622, DoABC#2)
// IGraphicAsset = "_-1HF" (String#5195, DoABC#2)
// FurnitureParticleSystemParticle = "_-0Ku" (String#3974, DoABC#2)
// _y = "_-02f" (String#64, DoABC#2)
// _z = "_-0kf" (String#215, DoABC#2)
// _SafeStr_6839 = "_-2dx" (String#6832, DoABC#2)
// _age = "_-07p" (String#581, DoABC#2)


