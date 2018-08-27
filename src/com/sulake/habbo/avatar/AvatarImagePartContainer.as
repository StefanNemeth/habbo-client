
package com.sulake.habbo.avatar
{
    import com.sulake.habbo.avatar.structure.figure.IPartColor;
    import com.sulake.habbo.avatar.actions.IActionDefinition;
    import flash.geom.ColorTransform;

    public class AvatarImagePartContainer 
    {

        private var _bodyPartId:String;
        private var _partType:String;
        private var _flippedPartType:String;
        private var _partId:String;
        private var _color:IPartColor;
        private var _frames:Array;
        private var _action:IActionDefinition;
        private var _isColorable:Boolean;
        private var _isBlendable:Boolean;
        private var _blendTransform:ColorTransform;
        private var _paletteMapId:int;

        public function AvatarImagePartContainer(_arg_1:String, _arg_2:String, _arg_3:String, _arg_4:IPartColor, _arg_5:Array, _arg_6:IActionDefinition, _arg_7:Boolean, _arg_8:int, _arg_9:String="", _arg_10:Boolean=false, _arg_11:Number=1)
        {
            this._bodyPartId = _arg_1;
            this._partType = _arg_2;
            this._partId = _arg_3;
            this._color = _arg_4;
            this._frames = _arg_5;
            this._action = _arg_6;
            this._isColorable = _arg_7;
            this._paletteMapId = _arg_8;
            this._flippedPartType = _arg_9;
            this._isBlendable = _arg_10;
            this._blendTransform = new ColorTransform(1, 1, 1, _arg_11);
            if (this._frames == null){
                Logger.log("Null frame list");
            };
            if (this._partType == "ey"){
                this._isColorable = false;
            };
        }
        public function getFrameIndex(_arg_1:int):int
        {
            return (this._frames[(_arg_1 % this._frames.length)]);
        }
        public function get frames():Array
        {
            return (this._frames);
        }
        public function get bodyPartId():String
        {
            return (this._bodyPartId);
        }
        public function get _SafeStr_7968():String
        {
            return (this._partType);
        }
        public function get partId():String
        {
            return (this._partId);
        }
        public function get color():IPartColor
        {
            return (this._color);
        }
        public function get action():IActionDefinition
        {
            return (this._action);
        }
        public function set isColorable(_arg_1:Boolean):void
        {
            this._isColorable = _arg_1;
        }
        public function get isColorable():Boolean
        {
            return (this._isColorable);
        }
        public function get paletteMapId():int
        {
            return (this._paletteMapId);
        }
        public function get flippedPartType():String
        {
            return (this._flippedPartType);
        }
        public function get isBlendable():Boolean
        {
            return (this._isBlendable);
        }
        public function get blendTransform():ColorTransform
        {
            return (this._blendTransform);
        }

    }
}//package com.sulake.habbo.avatar

// _flippedPartType = "_-0V8" (String#15248, DoABC#2)
// _blendTransform = "_-1wq" (String#18838, DoABC#2)
// IPartColor = "_-1dO" (String#5620, DoABC#2)
// AvatarImagePartContainer = "_-39w" (String#7510, DoABC#2)
// IActionDefinition = "_-2ON" (String#6527, DoABC#2)
// isColorable = "_-0df" (String#4384, DoABC#2)
// _paletteMapId = "_-05C" (String#3669, DoABC#2)
// _isColorable = "_-iV" (String#2165, DoABC#2)
// _bodyPartId = "_-Ys" (String#8390, DoABC#2)
// _partType = "_-0tU" (String#4717, DoABC#2)
// _partId = "_-4y" (String#7763, DoABC#2)
// _SafeStr_7968 = "include" (String#45700, DoABC#2)
// bodyPartId = "_-219" (String#19057, DoABC#2)
// partId = "_-0hk" (String#15738, DoABC#2)
// getFrameIndex = "_-38K" (String#21816, DoABC#2)
// flippedPartType = "_-39x" (String#21882, DoABC#2)
// paletteMapId = "_-0GZ" (String#14702, DoABC#2)
// isBlendable = "_-2Ao" (String#19434, DoABC#2)
// blendTransform = "_-qp" (String#24308, DoABC#2)


