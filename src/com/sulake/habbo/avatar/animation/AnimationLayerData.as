
package com.sulake.habbo.avatar.animation
{
    import com.sulake.habbo.avatar.actions.IActiveActionData;
    import flash.utils.Dictionary;
    import com.sulake.habbo.avatar.actions.ActiveActionData;
    import com.sulake.habbo.avatar.AvatarStructure;
    import com.sulake.habbo.avatar.actions.IActionDefinition;

    public class AnimationLayerData implements IAnimationLayerData 
    {

        public static const _SafeStr_7953:String = "bodypart";
        public static const _SafeStr_7954:String = "fx";

        private var _id:String;
        private var _action:IActiveActionData;
        private var _animationFrame:int;
        private var _dx:int;
        private var _dy:int;
        private var _dz:int;
        private var _directionOffset:int;
        private var _type:String;
        private var _base:String;
        private var _frameCounter:int;
        private var _items:Dictionary;

        public function AnimationLayerData(_arg_1:AvatarStructure, _arg_2:XML, _arg_3:String, _arg_4:int, _arg_5:IActionDefinition)
        {
            var _local_6:XML;
            var _local_7:String;
            this._items = new Dictionary();
            super();
            this._frameCounter = _arg_4;
            this._id = String(_arg_2.@id);
            this._animationFrame = parseInt(_arg_2.@frame);
            this._dx = parseInt(_arg_2.@dx);
            this._dy = parseInt(_arg_2.@dy);
            this._dz = parseInt(_arg_2.@dz);
            this._directionOffset = parseInt(_arg_2.@dd);
            this._type = _arg_3;
            this._base = String(_arg_2.@base);
            for each (_local_6 in _arg_2.item) {
                this._items[String(_local_6.@id)] = String(_local_6.@base);
            };
            _local_7 = "";
            if (this._base != ""){
                _local_7 = String(this.AnimationLayerData());
            };
            if (_arg_5 != null){
                this._action = new ActiveActionData(_arg_5.state, this.base);
                this._action.definition = _arg_5;
            };
        }
        public function get items():Dictionary
        {
            return (this._items);
        }
        private function AnimationLayerData():int
        {
            var _local_1:int;
            var _local_2:int;
            while (_local_2 < this._base.length) {
                _local_1 = (_local_1 + this._base.charCodeAt(_local_2));
                _local_2++;
            };
            return (_local_1);
        }
        public function get id():String
        {
            return (this._id);
        }
        public function get animationFrame():int
        {
            return (this._animationFrame);
        }
        public function get dx():int
        {
            return (this._dx);
        }
        public function get dy():int
        {
            return (this._dy);
        }
        public function get dz():int
        {
            return (this._dz);
        }
        public function get directionOffset():int
        {
            return (this._directionOffset);
        }
        public function get type():String
        {
            return (this._type);
        }
        public function get base():String
        {
            return (this._base);
        }
        public function get action():IActiveActionData
        {
            return (this._action);
        }

    }
}//package com.sulake.habbo.avatar.animation

// AvatarStructure = "_-2PN" (String#6550, DoABC#2)
// IAnimationLayerData = "_-14E" (String#4961, DoABC#2)
// IActiveActionData = "_-1An" (String#5087, DoABC#2)
// ActiveActionData = "_-22B" (String#6089, DoABC#2)
// IActionDefinition = "_-2ON" (String#6527, DoABC#2)
// AnimationLayerData = "_-3DH" (String#919, DoABC#2)
// animationFrame = "_-gS" (String#8520, DoABC#2)
// directionOffset = "_-25H" (String#6148, DoABC#2)
// _animationFrame = "_-1J0" (String#5222, DoABC#2)
// _SafeStr_7953 = "_-2oY" (String#21026, DoABC#2)
// _SafeStr_7954 = "_-dN" (String#23775, DoABC#2)
// _dy = "_-2Hh" (String#1847, DoABC#2)
// _dz = "_-p8" (String#8693, DoABC#2)
// _directionOffset = "_-0Rv" (String#1472, DoABC#2)
// _frameCounter = "_-2HG" (String#884, DoABC#2)
// AnimationLayerData = "_-0Mr" (String#14947, DoABC#2)


