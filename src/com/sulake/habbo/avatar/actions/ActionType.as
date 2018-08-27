
package com.sulake.habbo.avatar.actions
{
    public class ActionType 
    {

        private var _id:int;
        private var _value:int;
        private var _prevents:Array;
        private var _preventHeadTurn:Boolean = true;
        private var _isAnimated:Boolean = true;

        public function ActionType(_arg_1:XML)
        {
            this._prevents = [];
            super();
            this._id = parseInt(_arg_1.@value);
            this._value = parseInt(_arg_1.@value);
            var _local_2:String = String(_arg_1.@prevents);
            if (_local_2 != ""){
                this._prevents = _local_2.split(",");
            };
            this._preventHeadTurn = (String(_arg_1.@preventheadturn) == "true");
            var _local_3:String = String(_arg_1.@animated);
            if (_local_3 == ""){
                this._isAnimated = true;
            }
            else {
                this._isAnimated = (_local_3 == "true");
            };
        }
        public function get id():int
        {
            return (this._id);
        }
        public function get value():int
        {
            return (this._value);
        }
        public function get prevents():Array
        {
            return (this._prevents);
        }
        public function get preventHeadTurn():Boolean
        {
            return (this._preventHeadTurn);
        }
        public function get isAnimated():Boolean
        {
            return (this._isAnimated);
        }

    }
}//package com.sulake.habbo.avatar.actions

// ActionType = "_-0Jp" (String#813, DoABC#2)
// _value = "_-3Ao" (String#188, DoABC#2)
// _isAnimated = "_-2v8" (String#21283, DoABC#2)
// preventHeadTurn = "_-1Cd" (String#16970, DoABC#2)
// isAnimated = "_-0q7" (String#4640, DoABC#2)


