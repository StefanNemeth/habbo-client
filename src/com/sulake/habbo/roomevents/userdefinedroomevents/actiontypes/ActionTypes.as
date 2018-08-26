
package com.sulake.habbo.roomevents.userdefinedroomevents.actiontypes
{
    import com.sulake.habbo.roomevents.userdefinedroomevents.ElementTypeHolder;
    import com.sulake.habbo.roomevents.userdefinedroomevents.Element;
    import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.ActionDefinition;
    import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.Triggerable;

    public class ActionTypes implements ElementTypeHolder 
    {

        private var _types:Array;

        public function ActionTypes()
        {
            this._types = new Array();
            super();
            this._types.push(new ToggleFurniState());
            this._types.push(new Reset());
            this._types.push(new SetFurniStateTo());
            this._types.push(new MoveFurni());
            this._types.push(new GiveScore());
            this._types.push(new Chat());
            this._types.push(new Teleport());
            this._types.push(new JoinTeam());
            this._types.push(new LeaveTeam());
            this._types.push(new Chase());
            this._types.push(new Flee());
            this._types.push(new MoveToDirection());
            this._types.push(new GiveScoreToPredefinedTeam());
            this._types.push(new ToggleToRandomState());
            this._types.push(new MoveFurniTo());
        }
        public function get types():Array
        {
            return (this._types);
        }
        public function getByCode(_arg_1:int):ActionType
        {
            var _local_2:ActionType;
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
            return (!(((_arg_1 as ActionDefinition) == null)));
        }
        public function getKey():String
        {
            return ("action");
        }

    }
}//package com.sulake.habbo.roomevents.userdefinedroomevents.actiontypes

// Triggerable = "_-2oD" (String#7043, DoABC#2)
// Element = "_-zj" (String#8875, DoABC#2)
// ActionType = "_-0Jp" (String#813, DoABC#2)
// ElementTypeHolder = "_-0P4" (String#4071, DoABC#2)
// ActionTypes = "_-0vr" (String#4765, DoABC#2)
// ActionDefinition = "_-1nw" (String#864, DoABC#2)
// MoveFurni = "_-9H" (String#7850, DoABC#2)
// GiveScore = "_-3A7" (String#7514, DoABC#2)
// Teleport = "_-0Su" (String#4157, DoABC#2)
// SetFurniStateTo = "_-38X" (String#7483, DoABC#2)
// ToggleFurniState = "_-0S1" (String#4137, DoABC#2)
// LeaveTeam = "_-U3" (String#8285, DoABC#2)
// Chat = "_-2hB" (String#6895, DoABC#2)
// ToggleToRandomState = "_-0X" (String#4249, DoABC#2)
// MoveToDirection = "_-3Gl" (String#7641, DoABC#2)
// Reset = "_-0Hg" (String#3911, DoABC#2)
// GiveScoreToPredefinedTeam = "_-25" (String#6139, DoABC#2)
// Chase = "_-1PE" (String#5337, DoABC#2)
// JoinTeam = "_-0Rr" (String#4133, DoABC#2)
// _types = "_-2L9" (String#1860, DoABC#2)
// types = "_-36Y" (String#21749, DoABC#2)
// getByCode = "_-3KG" (String#22292, DoABC#2)
// code = "_-12Y" (String#4926, DoABC#2)
// getElementByCode = "_-2v7" (String#7181, DoABC#2)
// acceptTriggerable = "_-29f" (String#6243, DoABC#2)


