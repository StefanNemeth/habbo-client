
package com.sulake.habbo.avatar.actions
{
    import com.sulake.core.utils.Map;
    import flash.utils.Dictionary;

    public class ActionDefinition implements IActionDefinition 
    {

        private var _id:String;
        private var _state:String;
        private var _precedence:int;
        private var _activePartSet:String;
        private var _assetPartDefinition:String;
        private var _lay:String;
        private var _geometryType:String;
        private var _isMain:Boolean = false;
        private var _isDefault:Boolean = false;
        private var _isAnimation:Boolean = false;
        private var _prevents:Array;
        private var _preventHeadTurn:Boolean;
        private var _SafeStr_9904:Map;
        private var _types:Dictionary;
        private var _SafeStr_6969:Dictionary;
        private var _SafeStr_9905:String = "";

        public function ActionDefinition(_arg_1:XML)
        {
            var _local_3:XML;
            var _local_4:XML;
            var _local_5:String;
            var _local_6:String;
            var _local_7:String;
            this._prevents = new Array();
            this._types = new Dictionary();
            this._SafeStr_6969 = new Dictionary();
            super();
            this._id = String(_arg_1.@id);
            this._state = String(_arg_1.@state);
            this._precedence = parseInt(_arg_1.@precedence);
            this._activePartSet = String(_arg_1.@activepartset);
            this._assetPartDefinition = String(_arg_1.@assetpartdefinition);
            this._lay = String(_arg_1.@lay);
            this._geometryType = String(_arg_1.@geometrytype);
            this._isMain = Boolean(parseInt(_arg_1.@main));
            this._isDefault = Boolean(parseInt(_arg_1.@_SafeStr_9906));
            this._isAnimation = Boolean(parseInt(_arg_1.@animation));
            this._preventHeadTurn = Boolean(String((_arg_1.@preventheadturn == "true")));
            var _local_2:String = String(_arg_1.@prevents);
            if (_local_2 != ""){
                this._prevents = _local_2.split(",");
            };
            for each (_local_3 in _arg_1.param) {
                _local_5 = String(_local_3.@id);
                _local_6 = String(_local_3.@value);
                if (_local_5 == "default"){
                    this._SafeStr_9905 = _local_6;
                }
                else {
                    this._SafeStr_6969[_local_5] = _local_6;
                };
            };
            for each (_local_4 in _arg_1.type) {
                _local_7 = String(_local_4.@id);
                this._types[_local_7] = new ActionType(_local_4);
            };
        }
        public function IActionDefinition(_arg_1:String, _arg_2:int, _arg_3:Array):void
        {
            if (this._SafeStr_9904 == null){
                this._SafeStr_9904 = new Map();
            };
            if (this._SafeStr_9904.getValue(_arg_1) == null){
                this._SafeStr_9904.add(_arg_1, new Map());
            };
            var _local_4:Map = this._SafeStr_9904.getValue(_arg_1);
            _local_4.add(_arg_2, _arg_3);
        }
        public function IActionDefinition(_arg_1:String, _arg_2:int):Array
        {
            if (this._SafeStr_9904 == null){
                return (null);
            };
            var _local_3:Map = (this._SafeStr_9904.getValue(_arg_1) as Map);
            if (_local_3 == null){
                return (null);
            };
            return ((_local_3.getValue(_arg_2) as Array));
        }
        public function getParameterValue(_arg_1:String):String
        {
            if (_arg_1 == ""){
                return ("");
            };
            var _local_2:String = this._SafeStr_6969[_arg_1];
            if (_local_2 == null){
                _local_2 = this._SafeStr_9905;
            };
            return (_local_2);
        }
        private function getTypePrevents(_arg_1:String):Array
        {
            if (_arg_1 == ""){
                return ([]);
            };
            var _local_2:ActionType = this._types[_arg_1];
            if (_local_2 != null){
                return (_local_2.prevents);
            };
            return ([]);
        }
        public function toString():String
        {
            return ((((((((((((((((((((((((("[ActionDefinition]\n" + "id:           ") + this.id) + "\n") + "state:        ") + this.state) + "\n") + "main:         ") + this.isMain) + "\n") + "default:      ") + this.isDefault) + "\n") + "geometry:     ") + this.state) + "\n") + "precedence:   ") + this.precedence) + "\n") + "activepartset:") + this.activePartSet) + "\n") + "activepartdef:") + this.assetPartDefinition) + ""));
        }
        public function get id():String
        {
            return (this._id);
        }
        public function get state():String
        {
            return (this._state);
        }
        public function get precedence():int
        {
            return (this._precedence);
        }
        public function get activePartSet():String
        {
            return (this._activePartSet);
        }
        public function get isMain():Boolean
        {
            return (this._isMain);
        }
        public function get isDefault():Boolean
        {
            return (this._isDefault);
        }
        public function get assetPartDefinition():String
        {
            return (this._assetPartDefinition);
        }
        public function get lay():String
        {
            return (this._lay);
        }
        public function get geometryType():String
        {
            return (this._geometryType);
        }
        public function get isAnimation():Boolean
        {
            return (this._isAnimation);
        }
        public function IActionDefinition(_arg_1:String=""):Array
        {
            return (this._prevents.concat(this.getTypePrevents(_arg_1)));
        }
        public function IActionDefinition(_arg_1:String=""):Boolean
        {
            if (_arg_1 == ""){
                return (this._preventHeadTurn);
            };
            var _local_2:ActionType = this._types[_arg_1];
            if (_local_2 != null){
                return (_local_2.preventHeadTurn);
            };
            return (this._preventHeadTurn);
        }
        public function IActionDefinition(_arg_1:String):Boolean
        {
            if (_arg_1 == ""){
                return (true);
            };
            var _local_2:ActionType = this._types[_arg_1];
            if (_local_2 != null){
                return (_local_2.IActionDefinition);
            };
            return (true);
        }

    }
}//package com.sulake.habbo.avatar.actions

// ActionType = "_-0Jp" (String#813, DoABC#2)
// ActionDefinition = "_-1nw" (String#864, DoABC#2)
// IActionDefinition = "_-2ON" (String#6527, DoABC#2)
// _types = "_-2L9" (String#1860, DoABC#2)
// _SafeStr_6969 = "_-0uz" (String#1576, DoABC#2)
// isMain = "_-00N" (String#3570, DoABC#2)
// _isMain = "_-37V" (String#7459, DoABC#2)
// _geometryType = "_-2pF" (String#7065, DoABC#2)
// isAnimation = "_-1QB" (String#5356, DoABC#2)
// assetPartDefinition = "_-1ID" (String#5210, DoABC#2)
// preventHeadTurn = "_-1Cd" (String#16970, DoABC#2)
// IActionDefinition = "_-0q7" (String#4640, DoABC#2)
// _precedence = "_-1RV" (String#17564, DoABC#2)
// _activePartSet = "_-0hW" (String#15728, DoABC#2)
// _assetPartDefinition = "_-1Y8" (String#17820, DoABC#2)
// _lay = "_-2uW" (String#21262, DoABC#2)
// _isDefault = "_-mC" (String#24118, DoABC#2)
// _isAnimation = "_-1cP" (String#17987, DoABC#2)
// _SafeStr_9904 = "_-16y" (String#1623, DoABC#2)
// _SafeStr_9905 = "_-0Z6" (String#15407, DoABC#2)
// _SafeStr_9906 = "default" (String#139, DoABC#2)
// IActionDefinition = "_-30r" (String#7323, DoABC#2)
// IActionDefinition = "_-336" (String#7368, DoABC#2)
// getParameterValue = "_-1M2" (String#17360, DoABC#2)
// getTypePrevents = "_-3GO" (String#22138, DoABC#2)
// isDefault = "_-Dn" (String#7947, DoABC#2)
// IActionDefinition = "_-0Rn" (String#4130, DoABC#2)
// IActionDefinition = "_-S-" (String#8246, DoABC#2)


