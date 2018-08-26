
package com.sulake.habbo.roomevents.userdefinedroomevents.conditions
{
    import com.sulake.habbo.roomevents.userdefinedroomevents.ElementTypeHolder;
    import com.sulake.habbo.roomevents.userdefinedroomevents.Element;
    import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.ConditionDefinition;
    import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.Triggerable;

    public class ConditionTypes implements ElementTypeHolder 
    {

        private var _types:Array;

        public function ConditionTypes()
        {
            this._types = new Array();
            super();
            this._types.push(new ActorIsOnFurni());
            this._types.push(new FurnisHaveAvatars());
            this._types.push(new StatesMatch());
            this._types.push(new TimeElapsedMore());
            this._types.push(new TimeElapsedLess());
            this._types.push(new UserCountIn());
            this._types.push(new ActorIsInTeam());
            this._types.push(new HasStackedFurnis());
            this._types.push(new StuffTypeMatches());
            this._types.push(new StuffsInFormation());
        }
        public function get types():Array
        {
            return (this._types);
        }
        public function getByCode(_arg_1:int):ConditionType
        {
            var _local_2:ConditionType;
            for each (_local_2 in this._types) {
                if (_local_2.code == _arg_1){
                    return (_local_2);
                };
            };
            return (null);
        }
        public function getElementByCode(_arg_1:int):Element
        {
            return (this.getByCode(_arg_1));
        }
        public function acceptTriggerable(_arg_1:Triggerable):Boolean
        {
            return (!(((_arg_1 as ConditionDefinition) == null)));
        }
        public function getKey():String
        {
            return ("condition");
        }

    }
}//package com.sulake.habbo.roomevents.userdefinedroomevents.conditions

// Triggerable = "_-2oD" (String#7043, DoABC#2)
// Element = "_-zj" (String#8875, DoABC#2)
// ElementTypeHolder = "_-0P4" (String#4071, DoABC#2)
// ConditionDefinition = "_-Lz" (String#8123, DoABC#2)
// ConditionTypes = "_-246" (String#6125, DoABC#2)
// ConditionType = "_-262" (String#6162, DoABC#2)
// FurnisHaveAvatars = "_-3F" (String#7612, DoABC#2)
// ActorIsOnFurni = "_-WT" (String#8331, DoABC#2)
// StuffTypeMatches = "_-0kd" (String#4513, DoABC#2)
// TimeElapsedMore = "_-0zj" (String#4842, DoABC#2)
// HasStackedFurnis = "_-zW" (String#8868, DoABC#2)
// StatesMatch = "_-1vt" (String#5956, DoABC#2)
// ActorIsInTeam = "_-1TB" (String#5418, DoABC#2)
// TimeElapsedLess = "_-0SR" (String#4148, DoABC#2)
// _types = "_-2L9" (String#1860, DoABC#2)
// types = "_-36Y" (String#21749, DoABC#2)
// getByCode = "_-3KG" (String#22292, DoABC#2)
// code = "_-12Y" (String#4926, DoABC#2)
// getElementByCode = "_-2v7" (String#7181, DoABC#2)
// acceptTriggerable = "_-29f" (String#6243, DoABC#2)


