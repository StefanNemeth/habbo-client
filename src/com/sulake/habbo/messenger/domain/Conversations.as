
package com.sulake.habbo.messenger.domain
{
    import com.sulake.habbo.messenger.Util;
    import com.sulake.habbo.messenger.*;

    public class Conversations 
    {

        private static var _SafeStr_4673:int = 1;

        private var _SafeStr_4674:IConversationsDeps;
        private var _openConversations:Array;
        private var _closedConversations:Array;
        private var _startIndex:int;

        public function Conversations(_arg_1:IConversationsDeps)
        {
            this._openConversations = new Array();
            this._closedConversations = new Array();
            super();
            this._SafeStr_4674 = _arg_1;
        }
        public function changeStartIndex(_arg_1:int):void
        {
            this._startIndex = (this._startIndex + _arg_1);
        }
        public function setSelected(_arg_1:Conversation):void
        {
            this.clearSelections();
            _arg_1.setSelected(true);
            var _local_2:int = this._openConversations.indexOf(_arg_1);
            while ((this._startIndex + this._SafeStr_4674.getTabCount()) <= _local_2) {
                this._startIndex++;
            };
        }
        public function closeConversation():void
        {
            var _local_2:int;
            var _local_1:Conversation = this.findSelectedConversation();
            if (_local_1 != null){
                _local_2 = this._openConversations.indexOf(_local_1);
                Util.remove(this._openConversations, _local_1);
                this._closedConversations.push(_local_1);
                _local_1.setSelected(false);
                while (_local_2 >= 0) {
                    if (this._openConversations[_local_2] != null){
                        this._openConversations[_local_2].setSelected(true);
                        break;
                    };
                    _local_2--;
                };
            };
            this.fixStartIndex();
        }
        public function addTestUser():void
        {
            this.addConversation(_SafeStr_4673++);
        }
        public function addConversation(_arg_1:int):Conversation
        {
            var _local_2:Boolean = (((this._closedConversations.length == 0)) && ((this._openConversations.length == 0)));
            var _local_3:Conversation = this.addConversationInt(_arg_1);
            if (_local_3 == null){
                return (null);
            };
            if (this._openConversations.length == 1){
                this._openConversations[0].setSelected(true);
            };
            if (_local_2){
                _local_3.addMessage(new Message(Message._SafeStr_4668, 0, this._SafeStr_4674.getText("messenger.moderationinfo"), ""));
            };
            return (_local_3);
        }
        public function findConversation(_arg_1:int):Conversation
        {
            var _local_2:Conversation;
            for each (_local_2 in this._openConversations) {
                if (_local_2.id == _arg_1){
                    return (_local_2);
                };
            };
            return (null);
        }
        public function addMessageAndUpdateView(_arg_1:Message):void
        {
            var _local_2:int = this._openConversations.length;
            var _local_3:Conversation = this.addConversation(_arg_1.senderId);
            if (_local_3 == null){
                Logger.log((("Received message from non friend " + _arg_1.senderId) + ". Ignoring"));
                return;
            };
            var _local_4:Boolean = _local_3.newMessageArrived;
            _local_3.setNewMessageArrived(true);
            _local_3.addMessage(_arg_1);
            this._SafeStr_4674.addMsgToView(_local_3, _arg_1);
            if (((!((_local_2 == this._openConversations.length))) || (!((_local_4 == _local_3.newMessageArrived))))){
                this._SafeStr_4674.refresh(false);
            };
        }
        public function setOnlineStatusAndUpdateView(_arg_1:int, _arg_2:Boolean):void
        {
            var _local_3:Conversation = this.findConversation(_arg_1);
            if (_local_3 == null){
                _local_3 = this.findClosedConversation(_arg_1);
            };
            if (_local_3 == null){
                return;
            };
            var _local_4:Message = this.getOnlineInfoMsg(_arg_2);
            _local_3.addMessage(_local_4);
            this._SafeStr_4674.addMsgToView(_local_3, _local_4);
        }
        public function setFollowingAllowedAndUpdateView(_arg_1:int, _arg_2:Boolean):void
        {
            var _local_3:Conversation = this.findConversation(_arg_1);
            if (_local_3 == null){
                _local_3 = this.findClosedConversation(_arg_1);
            };
            if (_local_3 == null){
                return;
            };
            _local_3.followingAllowed = _arg_2;
            if (_local_3.selected){
                this._SafeStr_4674.refresh(false);
            };
        }
        public function findSelectedConversation():Conversation
        {
            var _local_1:Conversation;
            for each (_local_1 in this._openConversations) {
                if (_local_1.selected){
                    return (_local_1);
                };
            };
            return (null);
        }
        public function get openConversations():Array
        {
            return (this._openConversations);
        }
        public function get startIndex():int
        {
            return (this._startIndex);
        }
        private function clearSelections():void
        {
            var _local_1:Conversation;
            for each (_local_1 in this._openConversations) {
                _local_1.setSelected(false);
            };
        }
        private function findClosedConversation(_arg_1:int):Conversation
        {
            var _local_2:Conversation;
            for each (_local_2 in this._closedConversations) {
                if (_local_2.id == _arg_1){
                    return (_local_2);
                };
            };
            return (null);
        }
        private function addConversationInt(_arg_1:int):Conversation
        {
            var _local_2:Conversation = this.findConversation(_arg_1);
            if (_local_2 != null){
                return (_local_2);
            };
            _local_2 = this.findClosedConversation(_arg_1);
            if (_local_2 != null){
                Util.remove(this._closedConversations, _local_2);
                this._openConversations.push(_local_2);
                return (_local_2);
            };
            _local_2 = this._SafeStr_4674.createConversation(_arg_1);
            if (_local_2 == null){
                return (null);
            };
            this._openConversations.push(_local_2);
            return (_local_2);
        }
        private function fixStartIndex():void
        {
            this._startIndex = Math.min(this._startIndex, (this._openConversations.length - this._SafeStr_4674.getTabCount()));
            this._startIndex = Math.max(0, this._startIndex);
        }
        private function getOnlineInfoMsg(_arg_1:Boolean):Message
        {
            return (new Message(Message._SafeStr_4670, 0, this.getOnlineText(_arg_1), Util.getFormattedNow()));
        }
        private function getOnlineText(_arg_1:Boolean):String
        {
            return (this._SafeStr_4674.getText(((_arg_1) ? "messenger.notification.online" : "messenger.notification.offline")));
        }

    }
}//package com.sulake.habbo.messenger.domain

// IConversationsDeps = "_-16j" (String#5011, DoABC#2)
// Util = "_-1ve" (String#445, DoABC#2)
// Message = "_-0r8" (String#4665, DoABC#2)
// Conversations = "_-3Fq" (String#7628, DoABC#2)
// Conversation = "_-Ej" (String#7965, DoABC#2)
// refresh = "_-s9" (String#189, DoABC#2)
// senderId = "_-2GI" (String#19654, DoABC#2)
// getTabCount = "_-FK" (String#7977, DoABC#2)
// createConversation = "_-Qw" (String#8225, DoABC#2)
// addMsgToView = "_-nV" (String#8668, DoABC#2)
// _SafeStr_4668 = "_-F2" (String#22815, DoABC#2)
// _SafeStr_4670 = "_-256" (String#19223, DoABC#2)
// _SafeStr_4673 = "_-v7" (String#24496, DoABC#2)
// _SafeStr_4674 = "_-2UU" (String#620, DoABC#2)
// _openConversations = "_-2ZF" (String#20407, DoABC#2)
// changeStartIndex = "_-Mo" (String#23118, DoABC#2)
// clearSelections = "_-2cc" (String#6803, DoABC#2)
// closeConversation = "_-0gA" (String#15679, DoABC#2)
// findSelectedConversation = "_-0wy" (String#16309, DoABC#2)
// fixStartIndex = "_-0b2" (String#15476, DoABC#2)
// addTestUser = "_-0h7" (String#15714, DoABC#2)
// addConversation = "_-230" (String#19135, DoABC#2)
// addConversationInt = "_-00v" (String#14091, DoABC#2)
// addMessage = "_-1Jl" (String#17266, DoABC#2)
// findConversation = "_-2LL" (String#19861, DoABC#2)
// addMessageAndUpdateView = "_-2aB" (String#20449, DoABC#2)
// newMessageArrived = "_-0XG" (String#4255, DoABC#2)
// setNewMessageArrived = "_-0rH" (String#4668, DoABC#2)
// setOnlineStatusAndUpdateView = "_-03o" (String#14194, DoABC#2)
// findClosedConversation = "_-KF" (String#23014, DoABC#2)
// getOnlineInfoMsg = "_-0sj" (String#16150, DoABC#2)
// setFollowingAllowedAndUpdateView = "_-26j" (String#19280, DoABC#2)
// followingAllowed = "_-1-Z" (String#1598, DoABC#2)
// openConversations = "_-0FN" (String#14660, DoABC#2)
// startIndex = "_-1UD" (String#17675, DoABC#2)
// getOnlineText = "_-2Zd" (String#20425, DoABC#2)
// getFormattedNow = "_-1y3" (String#18889, DoABC#2)


