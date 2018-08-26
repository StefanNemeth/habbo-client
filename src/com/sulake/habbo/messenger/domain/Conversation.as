
package com.sulake.habbo.messenger.domain
{
    import com.sulake.habbo.messenger.IConversation;
    import com.sulake.core.runtime.IDisposable;

    public class Conversation implements IConversation, IDisposable 
    {

        private var _id:int;
        private var _name:String;
        private var _followingAllowed:Boolean;
        private var _figure:String;
        private var _messages:Array;
        private var _newMessageArrived:Boolean;
        private var _selected:Boolean;
        private var _disposed:Boolean;

        public function Conversation(_arg_1:int, _arg_2:String, _arg_3:String, _arg_4:Boolean)
        {
            this._messages = new Array();
            super();
            this._id = _arg_1;
            this._name = _arg_2;
            this._figure = _arg_3;
            this._followingAllowed = _arg_4;
        }
        public function addMessage(_arg_1:Message):void
        {
            this._messages.push(_arg_1);
        }
        public function setSelected(_arg_1:Boolean):void
        {
            if (_arg_1){
                this._newMessageArrived = false;
            };
            this._selected = _arg_1;
        }
        public function setNewMessageArrived(_arg_1:Boolean):void
        {
            if (this._selected){
                this._newMessageArrived = false;
            }
            else {
                this._newMessageArrived = _arg_1;
            };
        }
        public function dispose():void
        {
            if (this._disposed){
                return;
            };
            this._disposed = true;
            this._messages = null;
        }
        public function get id():int
        {
            return (this._id);
        }
        public function get name():String
        {
            return (this._name);
        }
        public function get selected():Boolean
        {
            return (this._selected);
        }
        public function get messages():Array
        {
            return (this._messages);
        }
        public function get newMessageArrived():Boolean
        {
            return (this._newMessageArrived);
        }
        public function get figure():String
        {
            return (this._figure);
        }
        public function get followingAllowed():Boolean
        {
            return (this._followingAllowed);
        }
        public function get disposed():Boolean
        {
            return (this._disposed);
        }
        public function set followingAllowed(_arg_1:Boolean):void
        {
            this._followingAllowed = _arg_1;
        }

    }
}//package com.sulake.habbo.messenger.domain

// IConversation = "_-1me" (String#5792, DoABC#2)
// Message = "_-0r8" (String#4665, DoABC#2)
// Conversation = "_-Ej" (String#7965, DoABC#2)
// IDisposable = "_-0dY" (String#4382, DoABC#2)
// _figure = "_-20u" (String#75, DoABC#2)
// addMessage = "_-1Jl" (String#17266, DoABC#2)
// newMessageArrived = "_-0XG" (String#4255, DoABC#2)
// setNewMessageArrived = "_-0rH" (String#4668, DoABC#2)
// followingAllowed = "_-1-Z" (String#1598, DoABC#2)
// _followingAllowed = "_-0eO" (String#1518, DoABC#2)
// _messages = "_-1AO" (String#835, DoABC#2)
// _newMessageArrived = "_-3F9" (String#7615, DoABC#2)


