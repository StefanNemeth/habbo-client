
package com.sulake.habbo.avatar.actions
{
    public class ActiveActionData implements IActiveActionData 
    {

        private var _actionType:String = "";
        private var _actionParameter:String = "";
        private var _definition:IActionDefinition;
        private var _startFrame:int = 0;
        private var _overridingAction:String;

        public function ActiveActionData(_arg_1:String, _arg_2:String="", _arg_3:int=0)
        {
            this._actionType = _arg_1;
            this._actionParameter = _arg_2;
            this._startFrame = _arg_3;
        }
        public function get actionType():String
        {
            return (this._actionType);
        }
        public function get actionParameter():String
        {
            return (this._actionParameter);
        }
        public function get definition():IActionDefinition
        {
            return (this._definition);
        }
        public function get id():String
        {
            if (this._definition == null){
                return ("");
            };
            return (((this._definition.id + "_") + this._actionParameter));
        }
        public function set actionParameter(_arg_1:String):void
        {
            this._actionParameter = _arg_1;
        }
        public function set definition(_arg_1:IActionDefinition):void
        {
            this._definition = _arg_1;
        }
        public function dispose():void
        {
            this._actionType = null;
            this._actionParameter = null;
            this._definition = null;
        }
        public function get startFrame():int
        {
            return (this._startFrame);
        }
        public function get overridingAction():String
        {
            return (this._overridingAction);
        }
        public function set overridingAction(_arg_1:String):void
        {
            this._overridingAction = _arg_1;
        }

    }
}//package com.sulake.habbo.avatar.actions

// IActiveActionData = "_-1An" (String#5087, DoABC#2)
// ActiveActionData = "_-22B" (String#6089, DoABC#2)
// IActionDefinition = "_-2ON" (String#6527, DoABC#2)
// _actionType = "_-9M" (String#7851, DoABC#2)
// actionParameter = "_-2Oa" (String#6531, DoABC#2)
// startFrame = "_-1Rg" (String#5390, DoABC#2)
// overridingAction = "_-3Dz" (String#7595, DoABC#2)
// _definition = "_-36L" (String#21742, DoABC#2)
// _startFrame = "_-1Wt" (String#17774, DoABC#2)
// _overridingAction = "_-ta" (String#24431, DoABC#2)


