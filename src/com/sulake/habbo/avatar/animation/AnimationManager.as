
package com.sulake.habbo.avatar.animation
{
    import flash.utils.Dictionary;
    import com.sulake.habbo.avatar.AvatarStructure;

    public class AnimationManager implements IAnimationManager 
    {

        private var _animations:Dictionary;

        public function AnimationManager()
        {
            this._animations = new Dictionary();
        }
        public function registerAnimation(_arg_1:AvatarStructure, _arg_2:XML):Boolean
        {
            var _local_3:String = String(_arg_2.@name);
            this._animations[_local_3] = new Animation(_arg_1, _arg_2);
            return (true);
        }
        public function getAnimation(_arg_1:String):IAnimation
        {
            return (this._animations[_arg_1]);
        }
        public function getLayerData(_arg_1:String, _arg_2:int, _arg_3:String):IAnimationLayerData
        {
            var _local_4:Animation = (this._animations[_arg_1] as Animation);
            if (_local_4 != null){
                return (_local_4.getLayerData(_arg_2, _arg_3));
            };
            return (null);
        }
        public function get animations():Dictionary
        {
            return (this._animations);
        }

    }
}//package com.sulake.habbo.avatar.animation

// IAnimationManager = "_-271" (String#6183, DoABC#2)
// AvatarStructure = "_-2PN" (String#6550, DoABC#2)
// Animation = "_-2Eu" (String#1841, DoABC#2)
// IAnimationLayerData = "_-14E" (String#4961, DoABC#2)
// IAnimation = "_-2l8" (String#6983, DoABC#2)
// AnimationManager = "_-2gx" (String#6890, DoABC#2)
// getLayerData = "_-0Qg" (String#1470, DoABC#2)
// getAnimation = "_-35m" (String#7425, DoABC#2)
// _animations = "_-3JT" (String#7694, DoABC#2)
// registerAnimation = "_-3Jo" (String#22276, DoABC#2)


