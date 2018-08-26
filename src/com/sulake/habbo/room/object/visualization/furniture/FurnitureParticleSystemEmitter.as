
package com.sulake.habbo.room.object.visualization.furniture
{
    import flash.geom.Vector3D;
    import flash.utils.Dictionary;

    public class FurnitureParticleSystemEmitter extends FurnitureParticleSystemParticle 
    {

        public static const _SafeStr_12766:String = "cone";
        public static const _SafeStr_12767:String = "plane";
        public static const _SafeStr_12768:String = "sphere";

        private var _name:String;
        private var _roomObjectSpriteId:int = -1;
        private var _SafeStr_12770:Number;
        private var _direction:Vector3D;
        private var _SafeStr_12771:Number = 0.1;
        private var _SafeStr_12772:Number;
        private var _SafeStr_12773:Number;
        private var _SafeStr_12774:String;
        private var _SafeStr_12775:Array;
        private var _particles:Array;
        private var _SafeStr_12777:int;
        private var _SafeStr_12778:int;
        private var _SafeStr_12779:int;
        private var _SafeStr_12780:int = 10;
        private var _energy:Number = 1;
        private var _hasIgnited:Boolean = false;
        private var _SafeStr_12781:int = 1;

        public function FurnitureParticleSystemEmitter(_arg_1:String="", _arg_2:int=-1)
        {
            this._particles = [];
            super();
            this._name = _arg_1;
            this._roomObjectSpriteId = _arg_2;
            this._SafeStr_12775 = [];
        }
        override public function dispose():void
        {
            var _local_1:FurnitureParticleSystemParticle;
            for each (_local_1 in this._particles) {
                _local_1.dispose();
            };
            this._particles = null;
            this._direction = null;
            this._SafeStr_12775 = null;
            super.dispose();
        }
        public function setup(_arg_1:int, _arg_2:int, _arg_3:Number, _arg_4:Vector3D, _arg_5:Number, _arg_6:Number, _arg_7:String, _arg_8:Number, _arg_9:int, _arg_10:int):void
        {
            this._SafeStr_12777 = _arg_1;
            this._SafeStr_12778 = _arg_2;
            this._SafeStr_12770 = _arg_3;
            this._direction = _arg_4;
            this._direction.normalize();
            this._SafeStr_12772 = _arg_5;
            this._SafeStr_12773 = _arg_6;
            this._SafeStr_12774 = _arg_7;
            this._SafeStr_12780 = _arg_9;
            this._energy = _arg_8;
            this._SafeStr_12781 = _arg_10;
            this.reset();
        }
        public function reset():void
        {
            var _local_1:FurnitureParticleSystemParticle;
            for each (_local_1 in this._particles) {
                _local_1.dispose();
            };
            this._particles = [];
            this._SafeStr_12779 = 0;
            this._hasIgnited = false;
            this.init(0, 0, 0, this._direction, this._SafeStr_12770, this._SafeStr_12771, this._SafeStr_12780, true);
        }
        public function configureParticle(_arg_1:int, _arg_2:Boolean, _arg_3:Array, _arg_4:Boolean):void
        {
            var _local_5:Dictionary = new Dictionary();
            _local_5["lifeTime"] = _arg_1;
            _local_5["isEmitter"] = _arg_2;
            _local_5["frames"] = _arg_3;
            _local_5["fade"] = _arg_4;
            this._SafeStr_12775.push(_local_5);
        }
        override protected function ignite():void
        {
            this._hasIgnited = true;
            if ((this._SafeStr_12779 < this._SafeStr_12777)){
                if (this.age > 1){
                    this.releaseParticles(this, this.direction);
                };
            };
        }
        private function releaseParticles(_arg_1:FurnitureParticleSystemParticle, _arg_2:Vector3D=null):void
        {
            var _local_4:FurnitureParticleSystemParticle;
            var _local_5:Dictionary;
            var _local_6:int;
            var _local_9:Array;
            if (!_arg_2){
                _arg_2 = new Vector3D();
            };
            var _local_3:Vector3D = new Vector3D();
            var _local_7:Boolean;
            var _local_8:Boolean;
            _local_5 = this.getRandomParticleConfiguration();
            var _local_10:int;
            while (_local_10 < this._SafeStr_12778) {
                switch (this._SafeStr_12774){
                    case _SafeStr_12766:
                        _local_3.x = ((this.randomBoolean(0.5)) ? Math.random() : -(Math.random()));
                        _local_3.y = -((Math.random() + 1));
                        _local_3.z = ((this.randomBoolean(0.5)) ? Math.random() : -(Math.random()));
                        break;
                    case _SafeStr_12767:
                        _local_3.x = ((this.randomBoolean(0.5)) ? Math.random() : -(Math.random()));
                        _local_3.y = 0;
                        _local_3.z = ((this.randomBoolean(0.5)) ? Math.random() : -(Math.random()));
                        break;
                    case _SafeStr_12768:
                        _local_3.x = ((this.randomBoolean(0.5)) ? Math.random() : -(Math.random()));
                        _local_3.y = ((this.randomBoolean(0.5)) ? Math.random() : -(Math.random()));
                        _local_3.z = ((this.randomBoolean(0.5)) ? Math.random() : -(Math.random()));
                        break;
                };
                _local_3.normalize();
                _local_4 = new FurnitureParticleSystemParticle();
                if (_local_5){
                    _local_6 = Math.floor(((Math.random() * _local_5["lifeTime"]) + 10));
                    _local_7 = _local_5["isEmitter"];
                    _local_9 = _local_5["frames"];
                    _local_8 = _local_5["fade"];
                }
                else {
                    _local_6 = Math.floor(((Math.random() * 20) + 10));
                    _local_7 = false;
                    _local_9 = [];
                };
                _local_4.init(_arg_1.x, _arg_1.y, _arg_1.z, _local_3, this._energy, this._SafeStr_12771, _local_6, _local_7, _local_9, _local_8);
                this._particles.push(_local_4);
                this._SafeStr_12779++;
                _local_10++;
            };
        }
        private function getRandomParticleConfiguration():Dictionary
        {
            var _local_1:int = Math.floor((Math.random() * this._SafeStr_12775.length));
            return (this._SafeStr_12775[_local_1]);
        }
        override public function update():void
        {
            super.update();
            this.accumulateForces();
            this.verlet();
            this.satisfyConstraints();
            if (((!(isAlive)) && ((this._SafeStr_12779 < this._SafeStr_12777)))){
                if ((this.age % this._SafeStr_12781) == 0){
                    this.releaseParticles(this, this.direction);
                };
            };
        }
        public function verlet():void
        {
            var _local_2:FurnitureParticleSystemParticle;
            var _local_3:Number;
            var _local_4:Number;
            var _local_5:Number;
            if (((isAlive) || ((this._SafeStr_12779 < this._SafeStr_12777)))){
                _local_3 = this.x;
                _local_4 = this.y;
                _local_5 = this.z;
                this.x = (((2 - this._SafeStr_12773) * this.x) - ((1 - this._SafeStr_12773) * this.lastX));
                this.y = ((((2 - this._SafeStr_12773) * this.y) - ((1 - this._SafeStr_12773) * this.lastY)) + ((this._SafeStr_12772 * this._SafeStr_12771) * this._SafeStr_12771));
                this.z = (((2 - this._SafeStr_12773) * this.z) - ((1 - this._SafeStr_12773) * this.lastZ));
                this.lastX = _local_3;
                this.lastY = _local_4;
                this.lastZ = _local_5;
            };
            var _local_1:Array = [];
            for each (_local_2 in this._particles) {
                _local_2.update();
                _local_3 = _local_2.x;
                _local_4 = _local_2.y;
                _local_5 = _local_2.z;
                _local_2.x = (((2 - this._SafeStr_12773) * _local_2.x) - ((1 - this._SafeStr_12773) * _local_2.lastX));
                _local_2.y = ((((2 - this._SafeStr_12773) * _local_2.y) - ((1 - this._SafeStr_12773) * _local_2.lastY)) + ((this._SafeStr_12772 * this._SafeStr_12771) * this._SafeStr_12771));
                _local_2.z = (((2 - this._SafeStr_12773) * _local_2.z) - ((1 - this._SafeStr_12773) * _local_2.lastZ));
                _local_2.lastX = _local_3;
                _local_2.lastY = _local_4;
                _local_2.lastZ = _local_5;
                if ((((_local_2.y > 10)) || (!(_local_2.isAlive)))){
                    _local_1.push(_local_2);
                };
            };
            for each (_local_2 in _local_1) {
                if (_local_2.isEmitter){
                };
                this._particles.splice(this._particles.indexOf(_local_2), 1);
                _local_2.dispose();
            };
        }
        private function satisfyConstraints():void
        {
        }
        private function accumulateForces():void
        {
            var _local_1:FurnitureParticleSystemParticle;
            for each (_local_1 in this._particles) {
            };
        }
        public function get particles():Array
        {
            return (this._particles);
        }
        public function get hasIgnited():Boolean
        {
            return (this._hasIgnited);
        }
        private function randomBoolean(_arg_1:Number):Boolean
        {
            return ((Math.random() < _arg_1));
        }
        public function get roomObjectSpriteId():int
        {
            return (this._roomObjectSpriteId);
        }

    }
}//package com.sulake.habbo.room.object.visualization.furniture

// _hasIgnited = "_-dn" (String#8481, DoABC#2)
// roomObjectSpriteId = "_-39b" (String#21865, DoABC#2)
// hasIgnited = "_-6T" (String#22482, DoABC#2)
// configureParticle = "_-0Ms" (String#14948, DoABC#2)
// ignite = "_-338" (String#7370, DoABC#2)
// isAlive = "_-2ki" (String#20873, DoABC#2)
// lastX = "_-32g" (String#21604, DoABC#2)
// lastY = "_-1kv" (String#18328, DoABC#2)
// lastZ = "_-1B6" (String#16903, DoABC#2)
// _SafeStr_12766 = "_-1L-" (String#17312, DoABC#2)
// _SafeStr_12767 = "_-027" (String#14130, DoABC#2)
// _SafeStr_12768 = "_-1Os" (String#17463, DoABC#2)
// _roomObjectSpriteId = "_-16Y" (String#16720, DoABC#2)
// _SafeStr_12770 = "_-2t5" (String#21204, DoABC#2)
// _SafeStr_12771 = "_-02S" (String#14140, DoABC#2)
// _SafeStr_12772 = "_-25u" (String#19254, DoABC#2)
// _SafeStr_12773 = "_-14Y" (String#16637, DoABC#2)
// _SafeStr_12774 = "_-0LG" (String#14884, DoABC#2)
// _SafeStr_12775 = "_-1QS" (String#17530, DoABC#2)
// _particles = "_-FB" (String#22821, DoABC#2)
// _SafeStr_12777 = "_-90" (String#22580, DoABC#2)
// _SafeStr_12778 = "_-2Hu" (String#19723, DoABC#2)
// _SafeStr_12779 = "_-0cH" (String#15524, DoABC#2)
// _SafeStr_12780 = "_-XU" (String#23543, DoABC#2)
// _SafeStr_12781 = "_-2LE" (String#19857, DoABC#2)
// releaseParticles = "_-0CZ" (String#14551, DoABC#2)
// getRandomParticleConfiguration = "_-17D" (String#16743, DoABC#2)
// randomBoolean = "_-aF" (String#23643, DoABC#2)
// accumulateForces = "_-i8" (String#23971, DoABC#2)
// verlet = "_-3JB" (String#22248, DoABC#2)
// satisfyConstraints = "_-4j" (String#22406, DoABC#2)
// FurnitureParticleSystemParticle = "_-0Ku" (String#3974, DoABC#2)
// FurnitureParticleSystemEmitter = "_-0q" (String#4636, DoABC#2)


