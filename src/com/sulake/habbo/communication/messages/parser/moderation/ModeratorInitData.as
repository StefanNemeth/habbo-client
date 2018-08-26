
package com.sulake.habbo.communication.messages.parser.moderation
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.habbo.communication.messages.incoming.moderation.OffenceCategoryData;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class ModeratorInitData implements IDisposable 
    {

        private var _messageTemplates:Array;
        private var _roomMessageTemplates:Array;
        private var _issues:Array;
        private var _offenceCategories:Array;
        private var _cfhPermission:Boolean;
        private var _chatlogsPermission:Boolean;
        private var _alertPermission:Boolean;
        private var _kickPermission:Boolean;
        private var _banPermission:Boolean;
        private var _roomAlertPermission:Boolean;
        private var _roomKickPermission:Boolean;
        private var _disposed:Boolean;

        public function ModeratorInitData(_arg_1:IMessageDataWrapper)
        {
            var _local_2:IssueInfoMessageParser = new IssueInfoMessageParser();
            this._issues = [];
            this._messageTemplates = [];
            this._roomMessageTemplates = [];
            this._offenceCategories = [];
            var _local_3:int = _arg_1.readInteger();
            var _local_4:int;
            while (_local_4 < _local_3) {
                if (_local_2.parse(_arg_1)){
                    this._issues.push(_local_2.issueData);
                };
                _local_4++;
            };
            _local_3 = _arg_1.readInteger();
            _local_4 = 0;
            while (_local_4 < _local_3) {
                this._messageTemplates.push(_arg_1.readString());
                _local_4++;
            };
            _local_3 = _arg_1.readInteger();
            _local_4 = 0;
            while (_local_4 < _local_3) {
                this._offenceCategories.push(new OffenceCategoryData(_arg_1));
                _local_4++;
            };
            this._cfhPermission = _arg_1.readBoolean();
            this._chatlogsPermission = _arg_1.readBoolean();
            this._alertPermission = _arg_1.readBoolean();
            this._kickPermission = _arg_1.readBoolean();
            this._banPermission = _arg_1.readBoolean();
            this._roomAlertPermission = _arg_1.readBoolean();
            this._roomKickPermission = _arg_1.readBoolean();
            _local_3 = _arg_1.readInteger();
            _local_4 = 0;
            while (_local_4 < _local_3) {
                this._roomMessageTemplates.push(_arg_1.readString());
                _local_4++;
            };
        }
        public function dispose():void
        {
            var _local_1:OffenceCategoryData;
            if (this._disposed){
                return;
            };
            this._disposed = true;
            this._messageTemplates = null;
            this._roomMessageTemplates = null;
            this._issues = null;
            for each (_local_1 in this._offenceCategories) {
                _local_1.dispose();
            };
            this._offenceCategories = null;
        }
        public function get disposed():Boolean
        {
            return (this._disposed);
        }
        public function get messageTemplates():Array
        {
            return (this._messageTemplates);
        }
        public function get roomMessageTemplates():Array
        {
            return (this._roomMessageTemplates);
        }
        public function get issues():Array
        {
            return (this._issues);
        }
        public function get offenceCategories():Array
        {
            return (this._offenceCategories);
        }
        public function get cfhPermission():Boolean
        {
            return (this._cfhPermission);
        }
        public function get chatlogsPermission():Boolean
        {
            return (this._chatlogsPermission);
        }
        public function get alertPermission():Boolean
        {
            return (this._alertPermission);
        }
        public function get kickPermission():Boolean
        {
            return (this._kickPermission);
        }
        public function get banPermission():Boolean
        {
            return (this._banPermission);
        }
        public function get roomAlertPermission():Boolean
        {
            return (this._roomAlertPermission);
        }
        public function get roomKickPermission():Boolean
        {
            return (this._roomKickPermission);
        }

    }
}//package com.sulake.habbo.communication.messages.parser.moderation

// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// ModeratorInitData = "_-0W" (String#4229, DoABC#2)
// IssueInfoMessageParser = "_-2NS" (String#6511, DoABC#2)
// OffenceCategoryData = "_-10g" (String#4888, DoABC#2)
// IDisposable = "_-0dY" (String#4382, DoABC#2)
// readString = "_-2y7" (String#1973, DoABC#2)
// readBoolean = "_-0ZR" (String#1499, DoABC#2)
// _messageTemplates = "_-38H" (String#21814, DoABC#2)
// _roomMessageTemplates = "_-fG" (String#23858, DoABC#2)
// _offenceCategories = "_-Xh" (String#23549, DoABC#2)
// _cfhPermission = "_-0pq" (String#16047, DoABC#2)
// _chatlogsPermission = "_-0ez" (String#15627, DoABC#2)
// _alertPermission = "_-0yB" (String#16359, DoABC#2)
// _kickPermission = "_-2LC" (String#19856, DoABC#2)
// _banPermission = "_-18" (String#16774, DoABC#2)
// _roomAlertPermission = "_-1gt" (String#18171, DoABC#2)
// _roomKickPermission = "_-2w5" (String#21312, DoABC#2)
// issueData = "_-0Ah" (String#14476, DoABC#2)
// messageTemplates = "_-oF" (String#24201, DoABC#2)
// roomMessageTemplates = "_-yF" (String#24624, DoABC#2)
// offenceCategories = "_-sF" (String#24370, DoABC#2)
// cfhPermission = "_-0zz" (String#16426, DoABC#2)
// chatlogsPermission = "_-Cg" (String#22712, DoABC#2)
// alertPermission = "_-1B8" (String#16904, DoABC#2)
// kickPermission = "_-0-P" (String#14029, DoABC#2)
// banPermission = "_-1Gj" (String#17141, DoABC#2)
// roomAlertPermission = "_-2DT" (String#19546, DoABC#2)
// roomKickPermission = "_-0tA" (String#16166, DoABC#2)


