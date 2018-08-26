
package com.sulake.habbo.room.object.visualization.furniture
{
    import flash.utils.Dictionary;
    import com.sulake.room.object.IRoomObject;
    import com.sulake.room.object.IRoomObjectModel;
    import com.sulake.habbo.room.object.RoomObjectVariableEnum;

    public class FurnitureFireworksVisualization extends AnimatedFurnitureVisualization 
    {

        private var _SafeStr_12735:Dictionary;
        private var _SafeStr_12736:FurnitureParticleSystem;

        override public function dispose():void
        {
            var _local_1:FurnitureParticleSystem;
            super.dispose();
            this._SafeStr_12736 = null;
            if (this._SafeStr_12735){
                for each (_local_1 in this._SafeStr_12735) {
                    _local_1.dispose();
                };
                this._SafeStr_12735 = null;
            };
        }
        override protected function updateObject(_arg_1:Number, _arg_2:Number):Boolean
        {
            var _local_3:Boolean;
            if (super.updateObject(_arg_1, _arg_2)){
                _local_3 = false;
                if (!this._SafeStr_12735){
                    this.readDefinition();
                    this._SafeStr_12736 = this._SafeStr_12735[_arg_1];
                    _local_3 = true;
                }
                else {
                    if (_arg_1 != _SafeStr_4369){
                        if (this._SafeStr_12736){
                            this._SafeStr_12736.reset();
                        };
                        this._SafeStr_12736 = this._SafeStr_12735[_arg_1];
                        _local_3 = true;
                    };
                };
                return (true);
            };
            return (false);
        }
        override protected function updateSprites(_arg_1:int, _arg_2:Boolean, _arg_3:int):void
        {
            super.updateSprites(_arg_1, _arg_2, _arg_3);
            if (this._SafeStr_12736){
                this._SafeStr_12736.updateSprites();
            };
        }
        override protected function updateAnimation(_arg_1:Number):int
        {
            if (this._SafeStr_12736){
                this._SafeStr_12736.updateAnimation();
            };
            return (super.updateAnimation(_arg_1));
        }
        override protected function setAnimation(_arg_1:int):void
        {
            if (this._SafeStr_12736){
                this._SafeStr_12736.setAnimation(_arg_1);
            };
            super.setAnimation(_arg_1);
        }
        override protected function getSpriteYOffset(_arg_1:int, _arg_2:int, _arg_3:int):int
        {
            if (((this._SafeStr_12736) && (this._SafeStr_12736.controlsSprite(_arg_3)))){
                return (this._SafeStr_12736.getSpriteYOffset(_arg_1, _arg_2, _arg_3));
            };
            return (super.getSpriteYOffset(_arg_1, _arg_2, _arg_3));
        }
        private function readDefinition():Boolean
        {
            var _local_5:FurnitureParticleSystem;
            var _local_6:int;
            var _local_7:XML;
            var _local_1:IRoomObject = object;
            if (_local_1 == null){
                return (false);
            };
            var _local_2:IRoomObjectModel = _local_1.getModel();
            if (_local_2 == null){
                return (false);
            };
            var _local_3:String = _local_2.getString(RoomObjectVariableEnum._SafeStr_12453);
            if (_local_3.length == 0){
                Logger.log("No Particle System Data Found.");
                return (false);
            };
            var _local_4:XML = XML(_local_3);
            this._SafeStr_12735 = new Dictionary();
            for each (_local_7 in _local_4.particlesystem) {
                if (!_local_7.hasOwnProperty("@size")){
                    Logger.log("Particle System does not have size property!");
                }
                else {
                    _local_6 = int(_local_7.@size);
                    _local_5 = new FurnitureParticleSystem(this);
                    _local_5.parseData(_local_7);
                    this._SafeStr_12735[_local_6] = _local_5;
                };
            };
            return (true);
        }

    }
}//package com.sulake.habbo.room.object.visualization.furniture

// _SafeStr_12453 = "_-C4" (String#22694, DoABC#2)
// updateSprites = "_-03G" (String#805, DoABC#2)
// readDefinition = "_-hC" (String#8539, DoABC#2)
// _SafeStr_12735 = "_-jG" (String#24010, DoABC#2)
// _SafeStr_12736 = "_-0cZ" (String#15537, DoABC#2)
// controlsSprite = "_-0ob" (String#15999, DoABC#2)
// parseData = "_-fY" (String#23867, DoABC#2)
// RoomObjectVariableEnum = "_-1MH" (String#17370, DoABC#2)
// IRoomObjectModel = "_-253" (String#6141, DoABC#2)
// AnimatedFurnitureVisualization = "_-0y2" (String#4811, DoABC#2)
// FurnitureFireworksVisualization = "_-2tu" (String#7158, DoABC#2)
// FurnitureParticleSystem = "_-0Db" (String#3819, DoABC#2)
// updateAnimation = "_-XZ" (String#166, DoABC#2)
// _SafeStr_4369 = "_-bP" (String#23689, DoABC#2)
// setAnimation = "_-ON" (String#252, DoABC#2)
// getSpriteYOffset = "_-3IZ" (String#251, DoABC#2)


