
package com.sulake.habbo.moderation
{
    import com.sulake.core.utils.Map;
    import flash.utils.Timer;
    import flash.events.TimerEvent;
    import com.sulake.habbo.communication.messages.parser.moderation.IssueMessageData;
    import com.sulake.habbo.communication.messages.outgoing.moderator.ReleaseIssuesMessageComposer;
    import com.sulake.habbo.sound.HabboSoundTypesEnum;
    import flash.utils.getTimer;
    import flash.events.Event;
    import com.sulake.habbo.communication.messages.outgoing.moderator.CloseIssuesMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.moderator.PickIssuesMessageComposer;

    public class IssueManager 
    {

        public static const _SafeStr_11933:String = "issue_bundle_open";
        public static const _SafeStr_11935:String = "issue_bundle_my";
        public static const _SafeStr_11932:String = "issue_bundle_picked";
        public static const _SafeStr_11946:int = 15000;

        private var _SafeStr_11757:ModerationManager;
        private var _SafeStr_11929:IssueBrowser;
        private var _issues:Map;
        private var _SafeStr_11947:Map;
        private var _SafeStr_11948:Map;
        private var _SafeStr_11949:Array;
        private var _SafeStr_11950:Array;
        private var _SafeStr_11951:Map;
        private var _SafeStr_11952:int = 1;
        private var _SafeStr_11953:int;
        private var _SafeStr_11954:Timer;

        public function IssueManager(_arg_1:ModerationManager)
        {
            this._SafeStr_11757 = _arg_1;
            this._issues = new Map();
            this._SafeStr_11947 = new Map();
            this._SafeStr_11948 = new Map();
            this._SafeStr_11929 = new IssueBrowser(this, this._SafeStr_11757.windowManager, this._SafeStr_11757.assets);
            this._SafeStr_11949 = [];
            this._SafeStr_11950 = [];
            this._SafeStr_11951 = new Map();
            this._SafeStr_11953 = parseInt(this._SafeStr_11757.configuration.getKey("chf.score.updatefactor", "60"));
            this._SafeStr_11954 = new Timer(_SafeStr_11946, 0);
            this._SafeStr_11954.addEventListener(TimerEvent.TIMER, this.updatePriorities);
            this._SafeStr_11954.start();
        }
        public function init():void
        {
            this._SafeStr_11929.show();
        }
        public function pickBundle(_arg_1:int, _arg_2:Boolean=false, _arg_3:int=0):void
        {
            var _local_4:IssueBundle = (this._SafeStr_11947.getValue(_arg_1) as IssueBundle);
            if (_local_4 == null){
                return;
            };
            this.sendPick(_local_4.getIssueIds(), _arg_2, _arg_3);
            this._SafeStr_11949 = this._SafeStr_11949.concat(_local_4.getIssueIds());
        }
        public function autoPick(_arg_1:Boolean=false, _arg_2:int=0):void
        {
            var _local_4:IssueBundle;
            var _local_5:IssueBundle;
            var _local_3:Array = this._SafeStr_11947.Map();
            for each (_local_5 in _local_3) {
                if ((((_local_5.state == IssueMessageData._SafeStr_7173)) && ((((_local_4 == null)) || ((_local_5.prioritySum > _local_4.prioritySum)))))){
                    _local_4 = _local_5;
                };
            };
            if (_local_4 == null){
                return;
            };
            this.pickBundle(_local_4.id, _arg_1, _arg_2);
        }
        public function releaseAll():void
        {
            var _local_3:IssueBundle;
            if (this._SafeStr_11947 == null){
                return;
            };
            var _local_1:int = this._SafeStr_11757.sessionDataManager.userId;
            var _local_2:Array = [];
            for each (_local_3 in this._SafeStr_11947) {
                if ((((_local_3.state == IssueMessageData._SafeStr_7174)) && ((_local_3.pickerUserId == _local_1)))){
                    _local_2 = _local_2.concat(_local_3.getIssueIds());
                };
            };
            this.sendRelease(_local_2);
        }
        public function releaseBundle(_arg_1:int):void
        {
            if (this._SafeStr_11947 == null){
                return;
            };
            var _local_2:IssueBundle = (this._SafeStr_11947.getValue(_arg_1) as IssueBundle);
            if (_local_2 == null){
                return;
            };
            this.sendRelease(_local_2.getIssueIds());
        }
        private function sendRelease(_arg_1:Array):void
        {
            if ((((((((_arg_1 == null)) || ((_arg_1.length == 0)))) || ((this._SafeStr_11757 == null)))) || ((this._SafeStr_11757.connection == null)))){
                return;
            };
            this._SafeStr_11757.connection.send(new ReleaseIssuesMessageComposer(_arg_1));
            this._SafeStr_11950 = this._SafeStr_11950.concat(_arg_1);
        }
        public function playSound(_arg_1:IssueMessageData):void
        {
            if (this._issues[_arg_1.issueId] != null){
                return;
            };
            if ((((this._SafeStr_11929 == null)) || (!(this._SafeStr_11929.IssueBrowser())))){
                this._SafeStr_11757.soundManager.playSound(HabboSoundTypesEnum._SafeStr_11957);
            };
        }
        public function updateIssue(_arg_1:IssueMessageData):void
        {
            var _local_3:IssueBundle;
            var _local_4:IssueBundle;
            var _local_5:int;
            var _local_6:Array;
            var _local_7:Boolean;
            var _local_8:IssueBundle;
            var _local_9:int;
            if (_arg_1 == null){
                return;
            };
            this._issues.remove(_arg_1.issueId);
            this._issues.add(_arg_1.issueId, _arg_1);
            var _local_2:int = int(this._SafeStr_11948.getValue(_arg_1.issueId));
            if (_local_2 != 0){
                _local_3 = (this._SafeStr_11947.getValue(_local_2) as IssueBundle);
                if (_local_3 != null){
                    if (this.validateBundle(_local_3, _arg_1)){
                        _local_3.updateIssue(_arg_1);
                    }
                    else {
                        _local_3.removeIssue(_arg_1.issueId);
                        if (_local_3.getIssueCount() == 0){
                            this._SafeStr_11947.remove(_local_3.id);
                            this.removeHandler(_local_3.id);
                        };
                        this._SafeStr_11948.remove(_arg_1.issueId);
                        _local_3 = null;
                    };
                };
            };
            if (_arg_1.state == IssueMessageData._SafeStr_7175){
                this._issues.remove(_arg_1.issueId);
                return;
            };
            if (_local_3 == null){
                for each (_local_4 in this._SafeStr_11947) {
                    if (this.validateBundle(_local_4, _arg_1)){
                        _local_3 = _local_4;
                        _local_3.updateIssue(_arg_1);
                        this._SafeStr_11948.add(_arg_1.issueId, _local_3.id);
                        break;
                    };
                };
            };
            if (_local_3 == null){
                _local_2 = this._SafeStr_11952++;
                _local_3 = new IssueBundle(_local_2, _arg_1);
                this._SafeStr_11948.add(_arg_1.issueId, _local_2);
                this._SafeStr_11947.add(_local_2, _local_3);
            };
            if (_local_3 == null){
                return;
            };
            if (this._SafeStr_11949.indexOf(_arg_1.issueId) != -1){
                this.handleBundle(_local_3.id);
                _local_5 = this._SafeStr_11757.sessionDataManager.userId;
                if (_local_5 != _arg_1.pickerUserId){
                    if (_arg_1.state == IssueMessageData._SafeStr_7174){
                        this.unhandleBundle(_local_3.id);
                    };
                };
            };
            if (_arg_1.state == IssueMessageData._SafeStr_7173){
                _local_6 = this.getBundles(_SafeStr_11935);
                _local_7 = false;
                for each (_local_8 in _local_6) {
                    if (this.validateBundle(_local_8, _arg_1, true)){
                        _local_7 = true;
                        break;
                    };
                };
                _local_9 = this._SafeStr_11950.indexOf(_arg_1.issueId);
                if ((((_local_9 == -1)) && (_local_7))){
                    this.sendPick([_arg_1.issueId]);
                }
                else {
                    this._SafeStr_11950.splice(_local_9, 1);
                };
            };
            this.updateHandler(_local_3.id);
            this._SafeStr_11929.update();
        }
        public function updatePriorities(_arg_1:Event=null):void
        {
            var _local_3:Number;
            var _local_4:IssueMessageData;
            if ((((this._SafeStr_11757 == null)) || ((this._SafeStr_11757.configuration == null)))){
                return;
            };
            var _local_2:int = getTimer();
            for each (_local_4 in this._issues) {
                if (_local_4 != null){
                    _local_3 = ((_local_2 - _local_4.timeStamp) / 1000);
                    _local_4.temporalPriority = int((_local_3 / this._SafeStr_11953));
                };
            };
            if (this._SafeStr_11929 != null){
                this._SafeStr_11929.update();
            };
        }
        private function updateHandler(_arg_1:int):void
        {
            var _local_2:IssueHandler = (this._SafeStr_11951.getValue(_arg_1) as IssueHandler);
            if (_local_2 != null){
                _local_2.update();
            };
        }
        public function removeHandler(_arg_1:int):void
        {
            var _local_2:IssueHandler = (this._SafeStr_11951.remove(_arg_1) as IssueHandler);
            if (_local_2 != null){
                _local_2.dispose();
                _local_2 = null;
            };
        }
        public function removeIssue(_arg_1:int):void
        {
            var _local_3:IssueBundle;
            if (this._issues == null){
                return;
            };
            var _local_2:int = this._SafeStr_11948.getValue(_arg_1);
            if (_local_2 != 0){
                _local_3 = (this._SafeStr_11947.getValue(_local_2) as IssueBundle);
                if (_local_3 != null){
                    _local_3.removeIssue(_arg_1);
                    if (_local_3.getIssueCount() == 0){
                        this._SafeStr_11947.remove(_local_3.id);
                    };
                };
            };
            this._issues.remove(_arg_1);
            this._SafeStr_11929.update();
        }
        public function getBundles(_arg_1:String):Array
        {
            var _local_4:IssueBundle;
            if (this._SafeStr_11947 == null){
                return ([]);
            };
            var _local_2:Array = [];
            var _local_3:int = this._SafeStr_11757.sessionDataManager.userId;
            for each (_local_4 in this._SafeStr_11947) {
                switch (_arg_1){
                    case _SafeStr_11933:
                        if (_local_4.state == IssueMessageData._SafeStr_7173){
                            _local_2.push(_local_4);
                        };
                        break;
                    case _SafeStr_11935:
                        if ((((_local_4.state == IssueMessageData._SafeStr_7174)) && ((_local_4.pickerUserId == _local_3)))){
                            _local_2.push(_local_4);
                        };
                        break;
                    case _SafeStr_11932:
                        if ((((_local_4.state == IssueMessageData._SafeStr_7174)) && (!((_local_4.pickerUserId == _local_3))))){
                            _local_2.push(_local_4);
                        };
                        break;
                };
            };
            return (_local_2);
        }
        public function handleBundle(_arg_1:int):void
        {
            var _local_2:IssueBundle = (this._SafeStr_11947.getValue(_arg_1) as IssueBundle);
            if (_local_2 == null){
                return;
            };
            var _local_3:IssueHandler = new IssueHandler(this._SafeStr_11757, _local_2);
            this.removeHandler(_arg_1);
            this._SafeStr_11951.add(_arg_1, _local_3);
            this._SafeStr_11757.windowTracker.show(_local_3, null, false, false, false);
            this._SafeStr_11949 = [];
        }
        public function unhandleBundle(_arg_1:int):void
        {
            var _local_2:IssueBundle = (this._SafeStr_11947.getValue(_arg_1) as IssueBundle);
            if (_local_2 == null){
                return;
            };
            var _local_3:IssueHandler = this._SafeStr_11951.remove(_arg_1);
            if (_local_3 != null){
                _local_3.dispose();
            };
        }
        public function closeBundle(_arg_1:int, _arg_2:int):void
        {
            var _local_3:IssueBundle = (this._SafeStr_11947.getValue(_arg_1) as IssueBundle);
            if (_local_3 == null){
                return;
            };
            this.sendClose(_local_3.getIssueIds(), _arg_2);
        }
        public function closeIssue(_arg_1:int, _arg_2:int):void
        {
            this.sendClose([_arg_1], _arg_2);
        }
        private function sendClose(_arg_1:Array, _arg_2:int):void
        {
            if ((((((_arg_1 == null)) || ((this._SafeStr_11757 == null)))) || ((this._SafeStr_11757.connection == null)))){
                return;
            };
            this._SafeStr_11757.connection.send(new CloseIssuesMessageComposer(_arg_1, _arg_2));
        }
        private function sendPick(_arg_1:Array, _arg_2:Boolean=false, _arg_3:int=0):void
        {
            if ((((((_arg_1 == null)) || ((this._SafeStr_11757 == null)))) || ((this._SafeStr_11757.connection == null)))){
                return;
            };
            this._SafeStr_11757.connection.send(new PickIssuesMessageComposer(_arg_1, _arg_2, _arg_3));
        }
        private function validateBundle(_arg_1:IssueBundle, _arg_2:IssueMessageData, _arg_3:Boolean=false):Boolean
        {
            if (_arg_2.reportedUserId == 0){
                return (false);
            };
            if (_arg_1.reportedUserId != _arg_2.reportedUserId){
                return (false);
            };
            if (!_arg_3){
                if (_arg_1.state != _arg_2.state){
                    return (false);
                };
                if (_arg_1.pickerUserId != _arg_2.pickerUserId){
                    return (false);
                };
            };
            return (true);
        }
        public function autoHandle(_arg_1:int):void
        {
            var _local_3:IssueBundle;
            var _local_5:IssueBundle;
            var _local_2:Array = this._SafeStr_11947.Map();
            var _local_4:int = this._SafeStr_11757.sessionDataManager.userId;
            for each (_local_5 in _local_2) {
                if ((((((((_local_5.state == IssueMessageData._SafeStr_7174)) && ((_local_5.pickerUserId == _local_4)))) && (!((_local_5.id == _arg_1))))) && ((((_local_3 == null)) || ((_local_5.prioritySum > _local_3.prioritySum)))))){
                    _local_3 = _local_5;
                };
            };
            if (_local_3 == null){
                this.autoPick();
                return;
            };
            this.handleBundle(_local_3.id);
        }
        public function issuePickFailed(_arg_1:Array):Boolean
        {
            var _local_4:IssueMessageData;
            var _local_5:int;
            var _local_6:String;
            var _local_7:int;
            var _local_8:IssueBundle;
            var _local_9:IssueBundle;
            var _local_10:Array;
            var _local_11:int;
            var _local_12:int;
            var _local_13:IssueHandler;
            if (!_arg_1){
                return (false);
            };
            var _local_2:Boolean;
            var _local_3:int = this._SafeStr_11757.sessionDataManager.userId;
            for each (_local_4 in _arg_1) {
                _local_5 = _local_4.issueId;
                _local_6 = _local_4.pickerUserName;
                _local_7 = _local_4.pickerUserId;
                if (((!((_local_7 == -1))) && (!((_local_7 == _local_3))))){
                    _local_2 = true;
                };
                _local_8 = null;
                for each (_local_9 in this._SafeStr_11947) {
                    _local_10 = _local_9.getIssueIds();
                    if (_local_10 != null){
                        for each (_local_11 in _local_10) {
                            if (_local_5 == _local_11){
                                _local_8 = _local_9;
                                break;
                            };
                        };
                    };
                };
                if (_local_8 != null){
                    _local_12 = _local_8.id;
                    _local_13 = (this._SafeStr_11951.getValue(_local_12) as IssueHandler);
                    if (_local_13 != null){
                        _local_13.dispose();
                    };
                    this.releaseBundle(_local_12);
                };
            };
            return (_local_2);
        }

    }
}//package com.sulake.habbo.moderation

// windowTracker = "_-1CG" (String#16953, DoABC#2)
// _SafeStr_11757 = "_-6S" (String#2051, DoABC#2)
// updateIssue = "_-3KL" (String#22296, DoABC#2)
// issuePickFailed = "_-1oX" (String#18478, DoABC#2)
// autoPick = "_-Ot" (String#23201, DoABC#2)
// removeIssue = "_-25y" (String#19257, DoABC#2)
// removeHandler = "_-mr" (String#24145, DoABC#2)
// closeBundle = "_-06c" (String#14311, DoABC#2)
// releaseBundle = "_-2Nx" (String#19962, DoABC#2)
// getIssueCount = "_-3HT" (String#22178, DoABC#2)
// getIssueIds = "_-2Xm" (String#20349, DoABC#2)
// _SafeStr_11929 = "_-0lg" (String#591, DoABC#2)
// getBundles = "_-10W" (String#16484, DoABC#2)
// _SafeStr_11932 = "_-1DP" (String#17000, DoABC#2)
// _SafeStr_11933 = "_-2AY" (String#19428, DoABC#2)
// _SafeStr_11935 = "_-25j" (String#19247, DoABC#2)
// releaseAll = "_-1dx" (String#18055, DoABC#2)
// pickBundle = "_-cd" (String#23737, DoABC#2)
// handleBundle = "_-2Z7" (String#20403, DoABC#2)
// _SafeStr_11946 = "_-2S3" (String#20121, DoABC#2)
// _SafeStr_11947 = "_-0Nu" (String#14985, DoABC#2)
// _SafeStr_11948 = "_-1W6" (String#17747, DoABC#2)
// _SafeStr_11949 = "_-Xv" (String#23557, DoABC#2)
// _SafeStr_11950 = "_-1GU" (String#17134, DoABC#2)
// _SafeStr_11951 = "_-bU" (String#23693, DoABC#2)
// _SafeStr_11952 = "_-ek" (String#23832, DoABC#2)
// _SafeStr_11953 = "_-2ID" (String#19736, DoABC#2)
// _SafeStr_11954 = "_-3AT" (String#21899, DoABC#2)
// sendPick = "_-1nA" (String#18431, DoABC#2)
// sendRelease = "_-1sD" (String#18641, DoABC#2)
// _SafeStr_11957 = "_-0BV" (String#14505, DoABC#2)
// validateBundle = "_-1ZE" (String#17862, DoABC#2)
// unhandleBundle = "_-3Az" (String#21919, DoABC#2)
// updateHandler = "_-2Wj" (String#20313, DoABC#2)
// sendClose = "_-wB" (String#24537, DoABC#2)
// closeIssue = "_-0-y" (String#14050, DoABC#2)
// autoHandle = "_-29S" (String#19382, DoABC#2)
// HabboSoundTypesEnum = "_-0vP" (String#16253, DoABC#2)
// PickIssuesMessageComposer = "_-0iu" (String#15787, DoABC#2)
// ReleaseIssuesMessageComposer = "_-0Vg" (String#15265, DoABC#2)
// CloseIssuesMessageComposer = "_-1BQ" (String#16915, DoABC#2)
// IssueMessageData = "_-0K1" (String#3952, DoABC#2)
// IssueBrowser = "_-3Jw" (String#7700, DoABC#2)
// IssueHandler = "_-2xf" (String#7231, DoABC#2)
// IssueBundle = "_-1x4" (String#18850, DoABC#2)
// IssueBrowser = "_-2i4" (String#897, DoABC#2)
// Map = "_-2U9" (String#20205, DoABC#2)
// sessionDataManager = "_-0pX" (String#4623, DoABC#2)
// soundManager = "_-1sN" (String#5892, DoABC#2)
// issueId = "_-1yh" (String#18916, DoABC#2)
// _SafeStr_7173 = "_-bS" (String#23691, DoABC#2)
// _SafeStr_7174 = "_-Tr" (String#23401, DoABC#2)
// _SafeStr_7175 = "_-1BF" (String#16908, DoABC#2)
// pickerUserId = "_-4E" (String#22387, DoABC#2)
// pickerUserName = "_-6G" (String#22476, DoABC#2)
// temporalPriority = "_-1v7" (String#18761, DoABC#2)


