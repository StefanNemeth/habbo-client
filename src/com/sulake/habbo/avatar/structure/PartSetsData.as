
package com.sulake.habbo.avatar.structure
{
    import flash.utils.Dictionary;
    import com.sulake.habbo.avatar.structure.parts.PartDefinition;
    import com.sulake.habbo.avatar.structure.parts.ActivePartSet;
    import com.sulake.habbo.avatar.actions.IActionDefinition;
    import com.sulake.habbo.avatar.actions.ActionDefinition;
    import com.sulake.habbo.avatar.structure.parts.*;

    public class PartSetsData implements IStructureData 
    {

        private var _parts:Dictionary;
        private var _activePartSets:Dictionary;

        public function PartSetsData()
        {
            this._parts = new Dictionary();
            this._activePartSets = new Dictionary();
        }
        public function parse(_arg_1:XML):Boolean
        {
            var _local_2:XML;
            var _local_3:XML;
            if (_arg_1 == null){
                return (false);
            };
            for each (_local_2 in _arg_1.partSet[0].part) {
                this._parts[String(_local_2.@["set-type"])] = new PartDefinition(_local_2);
            };
            for each (_local_3 in _arg_1.activePartSet) {
                this._activePartSets[String(_local_3.@id)] = new ActivePartSet(_local_3);
            };
            return (true);
        }
        public function appendXML(_arg_1:XML):Boolean
        {
            var _local_2:XML;
            var _local_3:XML;
            if (_arg_1 == null){
                return (false);
            };
            for each (_local_2 in _arg_1.partSet[0].part) {
                this._parts[String(_local_2.@["set-type"])] = new PartDefinition(_local_2);
            };
            for each (_local_3 in _arg_1.activePartSet) {
                this._activePartSets[String(_local_3.@id)] = new ActivePartSet(_local_3);
            };
            return (false);
        }
        public function getActiveParts(_arg_1:IActionDefinition):Array
        {
            var _local_2:ActivePartSet = this._activePartSets[_arg_1.activePartSet];
            if (_local_2 != null){
                return (_local_2.parts);
            };
            return ([]);
        }
        public function getPartDefinition(_arg_1:String):PartDefinition
        {
            return ((this._parts[_arg_1] as PartDefinition));
        }
        public function addPartDefinition(_arg_1:XML):PartDefinition
        {
            var _local_2:String = String(_arg_1.@["set-type"]);
            if (this._parts[_local_2] == null){
                this._parts[_local_2] = new PartDefinition(_arg_1);
            };
            return (this._parts[_local_2]);
        }
        public function get parts():Dictionary
        {
            return (this._parts);
        }
        public function get activePartSets():Dictionary
        {
            return (this._activePartSets);
        }
        public function getActivePartSet(_arg_1:ActionDefinition):ActivePartSet
        {
            return ((this._activePartSets[_arg_1.activePartSet] as ActivePartSet));
        }

    }
}//package com.sulake.habbo.avatar.structure

// appendXML = "_-3Hp" (String#7662, DoABC#2)
// _activePartSets = "_-0aG" (String#15449, DoABC#2)
// getActiveParts = "_-21V" (String#19074, DoABC#2)
// getPartDefinition = "_-2sz" (String#21199, DoABC#2)
// addPartDefinition = "_-En" (String#22804, DoABC#2)
// activePartSets = "_-2v9" (String#21284, DoABC#2)
// getActivePartSet = "_-09B" (String#14415, DoABC#2)
// IStructureData = "_-fH" (String#8500, DoABC#2)
// ActionDefinition = "_-1nw" (String#864, DoABC#2)
// IActionDefinition = "_-2ON" (String#6527, DoABC#2)
// PartSetsData = "_-18G" (String#5042, DoABC#2)
// PartDefinition = "_-2TQ" (String#6632, DoABC#2)
// ActivePartSet = "_-kb" (String#8617, DoABC#2)


