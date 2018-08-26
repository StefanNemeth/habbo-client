
package com.sulake.habbo.avatar.structure.figure
{
    import com.sulake.core.utils.Map;
    import flash.utils.Dictionary;

    public class SetType implements ISetType 
    {

        private var _partSets:Map;
        private var _type:String;
        private var _paletteID:int;
        private var _SafeStr_7048:Dictionary;

        public function SetType(_arg_1:XML)
        {
            this._type = String(_arg_1.@type);
            this._paletteID = parseInt(_arg_1.@paletteid);
            this._SafeStr_7048 = new Dictionary();
            this._SafeStr_7048["F"] = new Dictionary();
            this._SafeStr_7048["M"] = new Dictionary();
            this._SafeStr_7048["F"][0] = Boolean(parseInt(_arg_1.@mand_f_0));
            this._SafeStr_7048["F"][1] = Boolean(parseInt(_arg_1.@mand_f_1));
            this._SafeStr_7048["M"][0] = Boolean(parseInt(_arg_1.@mand_m_0));
            this._SafeStr_7048["M"][1] = Boolean(parseInt(_arg_1.@mand_m_1));
            this._partSets = new Map();
            this.append(_arg_1);
        }
        public function dispose():void
        {
            var _local_1:FigurePartSet;
            for each (_local_1 in this._partSets.Map()) {
                _local_1.dispose();
            };
            this._partSets.dispose();
            this._partSets = null;
        }
        public function cleanUp(_arg_1:XML):void
        {
            var _local_2:XML;
            var _local_3:String;
            var _local_4:FigurePartSet;
            for each (_local_2 in _arg_1["set"]) {
                _local_3 = String(_local_2.@id);
                _local_4 = this._partSets.getValue(_local_3);
                if (_local_4 != null){
                    _local_4.dispose();
                    this._partSets.remove(_local_3);
                };
            };
        }
        public function append(_arg_1:XML):void
        {
            var _local_2:XML;
            for each (_local_2 in _arg_1["set"]) {
                this._partSets.add(String(_local_2.@id), new FigurePartSet(_local_2, this._type));
            };
        }
        public function getDefaultPartSet(_arg_1:String):IFigurePartSet
        {
            var _local_4:IFigurePartSet;
            var _local_2:Array = this._partSets.getKeys();
            var _local_3:int = (_local_2.length - 1);
            while (_local_3 >= 0) {
                _local_4 = this._partSets.getValue(_local_2[_local_3]);
                if (((((_local_4) && ((_local_4.clubLevel == 0)))) && ((((_local_4.gender == _arg_1)) || ((_local_4.gender == "U")))))){
                    return (_local_4);
                };
                _local_3--;
            };
            return (null);
        }
        public function getPartSet(_arg_1:int):IFigurePartSet
        {
            return (this._partSets.getValue(String(_arg_1)));
        }
        public function get type():String
        {
            return (this._type);
        }
        public function get paletteID():int
        {
            return (this._paletteID);
        }
        public function isMandatory(_arg_1:String, _arg_2:int):Boolean
        {
            return (this._SafeStr_7048[_arg_1.toUpperCase()][Math.min(_arg_2, 1)]);
        }
        public function get partSets():Map
        {
            return (this._partSets);
        }

    }
}//package com.sulake.habbo.avatar.structure.figure

// IFigurePartSet = "_-5Y" (String#7773, DoABC#2)
// ISetType = "_-Gf" (String#8011, DoABC#2)
// FigurePartSet = "_-0fB" (String#4410, DoABC#2)
// Map = "_-2U9" (String#20205, DoABC#2)
// getPartSet = "_-72" (String#7807, DoABC#2)
// isMandatory = "_-0Zr" (String#4295, DoABC#2)
// paletteID = "_-0BG" (String#3784, DoABC#2)
// partSets = "_-0L3" (String#3979, DoABC#2)
// append = "_-0Hu" (String#14753, DoABC#2)
// _paletteID = "_-py" (String#24272, DoABC#2)
// _SafeStr_7048 = "_-1qP" (String#18559, DoABC#2)
// cleanUp = "_-0oC" (String#15984, DoABC#2)
// getDefaultPartSet = "_-2J3" (String#19769, DoABC#2)


