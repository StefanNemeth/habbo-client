
package com.sulake.habbo.avatar.structure
{
    import flash.utils.Dictionary;
    import com.sulake.habbo.avatar.structure.figure.Palette;
    import com.sulake.habbo.avatar.structure.figure.SetType;
    import com.sulake.habbo.avatar.structure.figure.IFigurePartSet;
    import com.sulake.habbo.avatar.structure.figure.ISetType;
    import com.sulake.habbo.avatar.structure.figure.IPalette;
    import com.sulake.habbo.avatar.structure.figure.*;

    public class FigureData implements IStructureData, IFigureData 
    {

        private var _SafeStr_6867:Dictionary;
        private var _SafeStr_10066:Dictionary;

        public function FigureData()
        {
            this._SafeStr_6867 = new Dictionary();
            this._SafeStr_10066 = new Dictionary();
        }
        public function dispose():void
        {
        }
        public function parse(_arg_1:XML):Boolean
        {
            var _local_2:XML;
            var _local_3:XML;
            if (_arg_1 == null){
                return (false);
            };
            for each (_local_2 in _arg_1.colors.palette) {
                this._SafeStr_6867[String(_local_2.@id)] = new Palette(_local_2);
            };
            for each (_local_3 in _arg_1.sets.settype) {
                this._SafeStr_10066[String(_local_3.@type)] = new SetType(_local_3);
            };
            return (true);
        }
        public function injectXML(_arg_1:XML):void
        {
            var _local_2:XML;
            var _local_3:SetType;
            for each (_local_2 in _arg_1.sets.settype) {
                _local_3 = this._SafeStr_10066[String(_local_2.@type)];
                if (_local_3 != null){
                    _local_3.cleanUp(_local_2);
                }
                else {
                    this._SafeStr_10066[String(_local_2.@type)] = new SetType(_local_2);
                };
            };
            this.appendXML(_arg_1);
        }
        public function appendXML(_arg_1:XML):Boolean
        {
            var _local_2:XML;
            var _local_3:XML;
            var _local_4:Palette;
            var _local_5:SetType;
            if (_arg_1 == null){
                return (false);
            };
            for each (_local_2 in _arg_1.colors.palette) {
                _local_4 = this._SafeStr_6867[String(_local_2.@id)];
                if (_local_4 == null){
                    this._SafeStr_6867[String(_local_2.@id)] = new Palette(_local_2);
                }
                else {
                    _local_4.append(_local_2);
                };
            };
            for each (_local_3 in _arg_1.sets.settype) {
                _local_5 = this._SafeStr_10066[String(_local_3.@type)];
                if (_local_5 == null){
                    this._SafeStr_10066[String(_local_3.@type)] = new SetType(_local_3);
                }
                else {
                    _local_5.append(_local_3);
                };
            };
            return (false);
        }
        public function getMandatorySetTypeIds(_arg_1:String, _arg_2:int):Array
        {
            var _local_4:SetType;
            var _local_3:Array = new Array();
            for each (_local_4 in this._SafeStr_10066) {
                if (((_local_4) && (_local_4.isMandatory(_arg_1, _arg_2)))){
                    _local_3.push(_local_4.type);
                };
            };
            return (_local_3);
        }
        public function getDefaultPartSet(_arg_1:String, _arg_2:String):IFigurePartSet
        {
            var _local_3:SetType = (this._SafeStr_10066[_arg_1] as SetType);
            if (_local_3){
                return (_local_3.getDefaultPartSet(_arg_2));
            };
            return (null);
        }
        public function getSetType(_arg_1:String):ISetType
        {
            return (this._SafeStr_10066[_arg_1]);
        }
        public function getPalette(_arg_1:int):IPalette
        {
            return (this._SafeStr_6867[String(_arg_1)]);
        }

    }
}//package com.sulake.habbo.avatar.structure

// getSetType = "_-0CE" (String#3795, DoABC#2)
// appendXML = "_-3Hp" (String#7662, DoABC#2)
// _SafeStr_10066 = "_-1b5" (String#17938, DoABC#2)
// injectXML = "_-2X3" (String#20325, DoABC#2)
// getMandatorySetTypeIds = "_-1Qh" (String#17541, DoABC#2)
// IFigureData = "_-Ip" (String#8057, DoABC#2)
// IFigurePartSet = "_-5Y" (String#7773, DoABC#2)
// IStructureData = "_-fH" (String#8500, DoABC#2)
// ISetType = "_-Gf" (String#8011, DoABC#2)
// IPalette = "_-UT" (String#8293, DoABC#2)
// FigureData = "_-1BT" (String#836, DoABC#2)
// Palette = "_-LG" (String#8107, DoABC#2)
// _SafeStr_6867 = "_-2YU" (String#893, DoABC#2)
// isMandatory = "_-0Zr" (String#4295, DoABC#2)
// append = "_-0Hu" (String#14753, DoABC#2)
// cleanUp = "_-0oC" (String#15984, DoABC#2)
// getDefaultPartSet = "_-2J3" (String#19769, DoABC#2)


