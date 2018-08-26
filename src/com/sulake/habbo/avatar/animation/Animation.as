
package com.sulake.habbo.avatar.animation
{
    import com.sulake.core.utils.Map;
    import com.sulake.habbo.avatar.AvatarStructure;
    import com.sulake.habbo.avatar.actions.IActionDefinition;

    public class Animation implements IAnimation 
    {

        private var _id:String;
        private var _description:String;
        private var _frames:Array;
        private var _spriteData:Array;
        private var _avatarData:AvatarDataContainer;
        private var _canvasData:Array;
        private var _directionData:DirectionDataContainer;
        private var _shadowData:ShadowDataContainer;
        private var _removeData:Array;
        private var _addData:Array;
        private var _SafeStr_8320:Map;
        private var _overrideFrames:Map;

        public function Animation(_arg_1:AvatarStructure, _arg_2:XML)
        {
            var _local_3:XML;
            var _local_4:XML;
            var _local_5:XML;
            var _local_6:XML;
            var _local_7:XML;
            var _local_8:String;
            var _local_9:String;
            var _local_10:Array;
            this._frames = [];
            this._spriteData = [];
            this._canvasData = [];
            this._removeData = [];
            this._addData = [];
            super();
            this._id = String(_arg_2.@name);
            if (_arg_2.hasOwnProperty("@desc")){
                this._description = String(_arg_2.@desc);
            }
            else {
                this._description = this._id;
            };
            if (_arg_2.hasOwnProperty("sprite")){
                for each (_local_3 in _arg_2.sprite) {
                    this._spriteData.push(new SpriteDataContainer((this as IAnimation), _local_3));
                };
            };
            if (_arg_2.hasOwnProperty("avatar")){
                this._avatarData = new AvatarDataContainer(_arg_2.avatar[0]);
            };
            if (_arg_2.hasOwnProperty("canvas")){
                for each (_local_4 in _arg_2.canvas) {
                    this._canvasData.push(new CanvasDataContainer(_local_4));
                };
            };
            if (_arg_2.hasOwnProperty("direction")){
                this._directionData = new DirectionDataContainer(_arg_2.direction[0]);
            };
            if (_arg_2.hasOwnProperty("shadow")){
                this._shadowData = new ShadowDataContainer(_arg_2.shadow[0]);
            };
            if (_arg_2.hasOwnProperty("remove")){
                for each (_local_5 in _arg_2.remove) {
                    this._removeData.push(String(_local_5.@id));
                };
            };
            if (_arg_2.hasOwnProperty("add")){
                for each (_local_6 in _arg_2.add) {
                    this._addData.push(new AddDataContainer(_local_6));
                };
            };
            if (_arg_2.hasOwnProperty("override")){
                this._overrideFrames = new Map();
                this._SafeStr_8320 = new Map();
                for each (_local_7 in _arg_2.override) {
                    _local_8 = _local_7.@name;
                    _local_9 = _local_7.@override;
                    this._SafeStr_8320.add(_local_9, _local_8);
                    _local_10 = new Array();
                    this.parseFrames(_local_10, _local_7.frame, _arg_1);
                    this._overrideFrames.add(_local_8, _local_10);
                };
            };
            this.parseFrames(this._frames, _arg_2.frame, _arg_1);
        }
        private function parseFrames(_arg_1:Array, _arg_2:XMLList, _arg_3:AvatarStructure):void
        {
            var _local_4:Array;
            var _local_5:IActionDefinition;
            var _local_7:XML;
            var _local_8:XML;
            var _local_9:XML;
            var _local_10:AnimationLayerData;
            var _local_11:AnimationLayerData;
            var _local_6:int;
            for each (_local_7 in _arg_2) {
                _local_4 = new Array();
                for each (_local_8 in _local_7.bodypart) {
                    _local_5 = _arg_3.getActionDefinition(String(_local_8.@action));
                    _local_10 = new AnimationLayerData(_arg_3, _local_8, AnimationLayerData._SafeStr_7953, _local_6, _local_5);
                    _local_4.push(_local_10);
                };
                for each (_local_9 in _local_7.fx) {
                    _local_5 = _arg_3.getActionDefinition(String(_local_9.@action));
                    _local_11 = new AnimationLayerData(_arg_3, _local_9, AnimationLayerData._SafeStr_7954, _local_6, _local_5);
                    _local_4.push(_local_11);
                    if (_local_5 != null){
                    };
                };
                _arg_1.push(_local_4);
                _local_6++;
            };
        }
        public function frameCount(_arg_1:String=null):int
        {
            var _local_2:Array;
            if (!_arg_1){
                return (this._frames.length);
            };
            if (this._overrideFrames){
                _local_2 = this._overrideFrames.getValue(_arg_1);
                if (_local_2){
                    return (_local_2.length);
                };
            };
            return (0);
        }
        public function hasOverriddenActions():Boolean
        {
            if (!this._SafeStr_8320){
                return (false);
            };
            return ((this._SafeStr_8320.length > 0));
        }
        public function overriddenActionNames():Array
        {
            if (!this._SafeStr_8320){
                return (null);
            };
            return (this._SafeStr_8320.getKeys());
        }
        public function overridingAction(_arg_1:String):String
        {
            if (!this._SafeStr_8320){
                return (null);
            };
            return (this._SafeStr_8320.getValue(_arg_1));
        }
        private function getFrame(_arg_1:int, _arg_2:String=null):Array
        {
            var _local_4:Array;
            var _local_3:Array = [];
            if (!_arg_2){
                if (this._frames.length > 0){
                    _local_3 = this._frames[(_arg_1 % this._frames.length)];
                };
            }
            else {
                _local_4 = (this._overrideFrames.getValue(_arg_2) as Array);
                if (((_local_4) && ((_local_4.length > 0)))){
                    _local_3 = _local_4[(_arg_1 % _local_4.length)];
                };
            };
            return (_local_3);
        }
        public function getAnimatedBodyPartIds(_arg_1:int, _arg_2:String=null):Array
        {
            var _local_4:AnimationLayerData;
            var _local_5:AddDataContainer;
            var _local_3:Array = new Array();
            for each (_local_4 in this.getFrame(_arg_1, _arg_2)) {
                if (_local_4.type == AnimationLayerData._SafeStr_7953){
                    _local_3.push(_local_4.id);
                }
                else {
                    if (_local_4.type == AnimationLayerData._SafeStr_7954){
                        for each (_local_5 in this._addData) {
                            if (_local_5.id == _local_4.id){
                                _local_3.push(_local_5.align);
                            };
                        };
                    };
                };
            };
            return (_local_3);
        }
        public function getLayerData(_arg_1:int, _arg_2:String, _arg_3:String=null):AnimationLayerData
        {
            var _local_4:AnimationLayerData;
            var _local_5:AddDataContainer;
            for each (_local_4 in this.getFrame(_arg_1, _arg_3)) {
                if (_local_4.id == _arg_2){
                    return ((_local_4 as AnimationLayerData));
                };
                if (_local_4.type == AnimationLayerData._SafeStr_7954){
                    for each (_local_5 in this._addData) {
                        if ((((_local_5.align == _arg_2)) && ((_local_5.id == _local_4.id)))){
                            return ((_local_4 as AnimationLayerData));
                        };
                    };
                };
            };
            return (null);
        }
        public function hasSpriteData():Boolean
        {
            return (!((this._spriteData == null)));
        }
        public function hasAvatarData():Boolean
        {
            return (!((this._avatarData == null)));
        }
        public function hasCanvasData():Boolean
        {
            return (!((this._canvasData == null)));
        }
        public function hasDirectionData():Boolean
        {
            return (!((this._directionData == null)));
        }
        public function hasShadowData():Boolean
        {
            return (!((this._shadowData == null)));
        }
        public function hasRemoveData():Boolean
        {
            return (!((this._removeData == null)));
        }
        public function hasAddData():Boolean
        {
            return (!((this._addData == null)));
        }
        public function getAddData(_arg_1:String):AddDataContainer
        {
            var _local_2:AddDataContainer;
            for each (_local_2 in this._addData) {
                if (_local_2.id == _arg_1){
                    return (_local_2);
                };
            };
            return (null);
        }
        public function get id():String
        {
            return (this._id);
        }
        public function get spriteData():Array
        {
            return (this._spriteData);
        }
        public function get avatarData():AvatarDataContainer
        {
            return (this._avatarData);
        }
        public function get canvasData():Array
        {
            return (this._canvasData);
        }
        public function get directionData():DirectionDataContainer
        {
            return (this._directionData);
        }
        public function get shadowData():ShadowDataContainer
        {
            return (this._shadowData);
        }
        public function get removeData():Array
        {
            return (this._removeData);
        }
        public function get addData():Array
        {
            return (this._addData);
        }
        public function get description():String
        {
            return (this._description);
        }

    }
}//package com.sulake.habbo.avatar.animation

// AvatarStructure = "_-2PN" (String#6550, DoABC#2)
// Animation = "_-2Eu" (String#1841, DoABC#2)
// IAnimation = "_-2l8" (String#6983, DoABC#2)
// IActionDefinition = "_-2ON" (String#6527, DoABC#2)
// AddDataContainer = "_-13k" (String#4948, DoABC#2)
// AnimationLayerData = "_-3DH" (String#919, DoABC#2)
// CanvasDataContainer = "_-1-d" (String#16452, DoABC#2)
// SpriteDataContainer = "_-0cR" (String#15532, DoABC#2)
// DirectionDataContainer = "_-1Kf" (String#17300, DoABC#2)
// AvatarDataContainer = "_-39H" (String#21857, DoABC#2)
// ShadowDataContainer = "_-0Ne" (String#14977, DoABC#2)
// getFrame = "_-3Jk" (String#923, DoABC#2)
// getLayerData = "_-0Qg" (String#1470, DoABC#2)
// _description = "_-1a7" (String#164, DoABC#2)
// overridingAction = "_-3Dz" (String#7595, DoABC#2)
// _SafeStr_7953 = "_-2oY" (String#21026, DoABC#2)
// _SafeStr_7954 = "_-dN" (String#23775, DoABC#2)
// removeData = "_-09h" (String#3752, DoABC#2)
// _spriteData = "_-ug" (String#24478, DoABC#2)
// _avatarData = "_-1Fy" (String#17114, DoABC#2)
// _canvasData = "_-Nj" (String#23154, DoABC#2)
// _directionData = "_-0RQ" (String#15118, DoABC#2)
// _shadowData = "_-2iu" (String#20803, DoABC#2)
// _removeData = "_-2IE" (String#19737, DoABC#2)
// _addData = "_-ZL" (String#23610, DoABC#2)
// _SafeStr_8320 = "_-1wg" (String#18830, DoABC#2)
// parseFrames = "_-a4" (String#23634, DoABC#2)
// getActionDefinition = "_-1Yl" (String#17839, DoABC#2)
// frameCount = "_-0C7" (String#14533, DoABC#2)
// hasOverriddenActions = "_-1WW" (String#17760, DoABC#2)
// overriddenActionNames = "_-2OC" (String#19974, DoABC#2)
// getAnimatedBodyPartIds = "_-0AX" (String#14469, DoABC#2)
// hasSpriteData = "_-0B" (String#3777, DoABC#2)
// hasAvatarData = "_-0wo" (String#4786, DoABC#2)
// hasCanvasData = "_-3AB" (String#7518, DoABC#2)
// hasDirectionData = "_-1O5" (String#5312, DoABC#2)
// hasShadowData = "_-2Ci" (String#6298, DoABC#2)
// hasRemoveData = "_-RP" (String#8234, DoABC#2)
// hasAddData = "_-2rO" (String#7110, DoABC#2)
// getAddData = "_-1Ie" (String#17220, DoABC#2)
// spriteData = "_-2BE" (String#6273, DoABC#2)
// avatarData = "_-0Ip" (String#14793, DoABC#2)
// canvasData = "_-1zx" (String#6030, DoABC#2)
// directionData = "_-0qL" (String#16063, DoABC#2)
// shadowData = "_-0T7" (String#15176, DoABC#2)
// addData = "_-2Py" (String#6561, DoABC#2)


