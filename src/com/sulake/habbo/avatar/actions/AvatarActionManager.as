
package com.sulake.habbo.avatar.actions
{
    import com.sulake.core.assets.IAssetLibrary;
    import flash.utils.Dictionary;

    public class AvatarActionManager 
    {

        private var _assets:IAssetLibrary;
        private var _SafeStr_5141:Dictionary;
        private var _avatarType:String;
        private var _SafeStr_9918:ActionDefinition;

        public function AvatarActionManager(_arg_1:IAssetLibrary, _arg_2:String, _arg_3:XML)
        {
            var _local_4:XML;
            var _local_5:String;
            var _local_6:ActionDefinition;
            super();
            this._assets = _arg_1;
            this._SafeStr_5141 = new Dictionary();
            this._avatarType = _arg_2;
            for each (_local_4 in _arg_3.action) {
                _local_5 = String(_local_4.@state);
                if (_local_5 != ""){
                    _local_6 = new ActionDefinition(_local_4);
                    this._SafeStr_5141[_local_5] = _local_6;
                };
            };
            this.parseActionOffsets();
        }
        private function parseActionOffsets():void
        {
            var _local_1:ActiveActionData;
            var _local_2:ActionDefinition;
            var _local_3:String;
            var _local_4:XML;
            var _local_5:String;
            var _local_6:int;
            var _local_7:int;
            var _local_8:int;
            var _local_9:Number;
            var _local_10:XML;
            for each (_local_2 in this._SafeStr_5141) {
                _local_3 = _local_2.state;
                if (this._assets.hasAsset(("action_offset_" + _local_3))){
                    _local_4 = (this._assets.getAssetByName(("action_offset_" + _local_3)).content as XML);
                    if (_local_4.@avatartype == this._avatarType){
                        for each (_local_10 in _local_4.offset) {
                            _local_5 = String(_local_10.@size);
                            _local_6 = parseInt(_local_10.@direction);
                            _local_7 = parseInt(_local_10.@x);
                            _local_8 = parseInt(_local_10.@y);
                            _local_9 = Number(_local_10.@z);
                            _local_2.IActionDefinition(_local_5, _local_6, new Array(_local_7, _local_8, _local_9));
                        };
                    };
                };
            };
        }
        public function getActionDefinition(_arg_1:String):ActionDefinition
        {
            var _local_2:ActionDefinition;
            for each (_local_2 in this._SafeStr_5141) {
                if (_local_2.id == _arg_1){
                    return (_local_2);
                };
            };
            return (null);
        }
        public function getActionDefinitionWithState(_arg_1:String):ActionDefinition
        {
            return (this._SafeStr_5141[_arg_1]);
        }
        public function getDefaultAction():ActionDefinition
        {
            var _local_1:ActionDefinition;
            if (this._SafeStr_9918){
                return (this._SafeStr_9918);
            };
            for each (_local_1 in this._SafeStr_5141) {
                if (_local_1.isDefault){
                    this._SafeStr_9918 = _local_1;
                    return (_local_1);
                };
            };
            return (null);
        }
        public function getCanvasOffsets(_arg_1:Array, _arg_2:String, _arg_3:int):Array
        {
            var _local_4:Array;
            var _local_5:ActiveActionData;
            var _local_6:ActionDefinition;
            var _local_7:int;
            _local_7 = 0;
            while (_local_7 < _arg_1.length) {
                _local_5 = (_arg_1[_local_7] as ActiveActionData);
                _local_6 = (this._SafeStr_5141[_local_5.actionType] as ActionDefinition);
                if (((!((_local_6 == null))) && (!((_local_6.IActionDefinition(_arg_2, _arg_3) == null))))){
                    _local_4 = _local_6.IActionDefinition(_arg_2, _arg_3);
                };
                _local_7++;
            };
            return (_local_4);
        }
        public function sortActions(_arg_1:Array):Array
        {
            var _local_3:IActiveActionData;
            var _local_4:ActionDefinition;
            _arg_1 = this.filterActions(_arg_1);
            var _local_2:Array = new Array();
            for each (_local_3 in _arg_1) {
                _local_4 = this._SafeStr_5141[_local_3.actionType];
                if (_local_4 != null){
                    _local_3.definition = _local_4;
                    _local_2.push(_local_3);
                };
            };
            _local_2.sort(this.orderByPrecedence);
            return (_local_2);
        }
        private function filterActions(_arg_1:Array):Array
        {
            var _local_4:ActiveActionData;
            var _local_5:ActionDefinition;
            var _local_6:int;
            var _local_7:String;
            var _local_2:Array = new Array();
            var _local_3:Array = new Array();
            _local_6 = 0;
            while (_local_6 < _arg_1.length) {
                _local_4 = (_arg_1[_local_6] as ActiveActionData);
                _local_5 = (this._SafeStr_5141[_local_4.actionType] as ActionDefinition);
                if (_local_5 != null){
                    _local_3 = _local_3.concat(_local_5.IActionDefinition(_local_4.actionParameter));
                };
                _local_6++;
            };
            _local_6 = 0;
            while (_local_6 < _arg_1.length) {
                _local_4 = (_arg_1[_local_6] as ActiveActionData);
                _local_7 = _local_4.actionType;
                if (_local_4.actionType == "fx"){
                    _local_7 = (_local_7 + ("." + _local_4.actionParameter));
                };
                if (_local_3.indexOf(_local_7) == -1){
                    _local_2.push(_local_4);
                };
                _local_6++;
            };
            return (_local_2);
        }
        private function orderByPrecedence(_arg_1:IActiveActionData, _arg_2:IActiveActionData):Number
        {
            var _local_3:Number = _arg_1.definition.precedence;
            var _local_4:Number = _arg_2.definition.precedence;
            if (_local_3 < _local_4){
                return (1);
            };
            if (_local_3 > _local_4){
                return (-1);
            };
            return (0);
        }

    }
}//package com.sulake.habbo.avatar.actions

// ActionDefinition = "_-1nw" (String#864, DoABC#2)
// IActiveActionData = "_-1An" (String#5087, DoABC#2)
// ActiveActionData = "_-22B" (String#6089, DoABC#2)
// AvatarActionManager = "_-1H3" (String#17154, DoABC#2)
// getCanvasOffsets = "_-0gi" (String#4439, DoABC#2)
// _SafeStr_5141 = "_-32J" (String#626, DoABC#2)
// actionParameter = "_-2Oa" (String#6531, DoABC#2)
// orderByPrecedence = "_-Ex" (String#7971, DoABC#2)
// getActionDefinition = "_-1Yl" (String#17839, DoABC#2)
// IActionDefinition = "_-30r" (String#7323, DoABC#2)
// IActionDefinition = "_-336" (String#7368, DoABC#2)
// isDefault = "_-Dn" (String#7947, DoABC#2)
// IActionDefinition = "_-0Rn" (String#4130, DoABC#2)
// _avatarType = "_-Ms" (String#8138, DoABC#2)
// _SafeStr_9918 = "_-1ni" (String#862, DoABC#2)
// parseActionOffsets = "_-1Bu" (String#16936, DoABC#2)
// getActionDefinitionWithState = "_-K4" (String#23008, DoABC#2)
// getDefaultAction = "_-2dH" (String#20575, DoABC#2)
// sortActions = "_-OU" (String#2099, DoABC#2)
// filterActions = "_-2LV" (String#19868, DoABC#2)


