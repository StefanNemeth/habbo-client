
package com.sulake.habbo.avatar.structure
{
    import flash.utils.Dictionary;
    import com.sulake.habbo.avatar.structure.animation.AnimationAction;
    import com.sulake.habbo.avatar.actions.IActionDefinition;
    import com.sulake.habbo.avatar.structure.animation.*;

    public class AnimationData implements IStructureData 
    {

        private var _SafeStr_5141:Dictionary;

        public function AnimationData()
        {
            this._SafeStr_5141 = new Dictionary();
        }
        public function parse(_arg_1:XML):Boolean
        {
            var _local_2:XML;
            if (_arg_1 == null){
                return (false);
            };
            for each (_local_2 in _arg_1.action) {
                this._SafeStr_5141[String(_local_2.@id)] = new AnimationAction(_local_2);
            };
            return (true);
        }
        public function appendXML(_arg_1:XML):Boolean
        {
            var _local_2:XML;
            if (_arg_1 == null){
                return (false);
            };
            for each (_local_2 in _arg_1.action) {
                this._SafeStr_5141[String(_local_2.@id)] = new AnimationAction(_local_2);
            };
            return (true);
        }
        public function getAction(_arg_1:IActionDefinition):AnimationAction
        {
            return (this._SafeStr_5141[_arg_1.assetPartDefinition]);
        }

    }
}//package com.sulake.habbo.avatar.structure

// appendXML = "_-3Hp" (String#7662, DoABC#2)
// IStructureData = "_-fH" (String#8500, DoABC#2)
// IActionDefinition = "_-2ON" (String#6527, DoABC#2)
// AnimationData = "_-vF" (String#948, DoABC#2)
// AnimationAction = "_-11k" (String#4910, DoABC#2)
// _SafeStr_5141 = "_-32J" (String#626, DoABC#2)
// getAction = "_-e3" (String#23805, DoABC#2)
// assetPartDefinition = "_-1ID" (String#5210, DoABC#2)


