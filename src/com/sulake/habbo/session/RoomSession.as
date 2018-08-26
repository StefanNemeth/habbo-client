
package com.sulake.habbo.session
{
    import com.sulake.core.communication.connection.IConnection;
    import com.sulake.core.utils.Map;
    import com.sulake.habbo.tracking.IHabboTracking;
    import com.sulake.habbo.session.events.RoomSessionEvent;
    import com.sulake.habbo.communication.messages.outgoing.room.session.OpenConnectionMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.room.session.OpenFlatConnectionMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.room.chat.ChatMessageComposer;
    import flash.utils.getTimer;
    import com.sulake.habbo.communication.messages.outgoing.room.avatar.ChangeMottoMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.room.chat.ShoutMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.room.chat.WhisperMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.room.chat.StartTypingMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.room.chat.CancelTypingMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.room.avatar.WaveMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.room.avatar.SignMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.room.avatar.DanceMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.room.furniture.CreditFurniRedeemMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.room.furniture.PresentOpenMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.room.furniture.OpenPetPackageMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.room.engine.ViralTeaserFoundMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.room.furniture.RoomDimmerGetPresetsMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.room.furniture.RoomDimmerSavePresetMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.room.furniture.RoomDimmerChangeStateMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.tracking.EventLogMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.poll.VoteAnswerMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.poll.PollStartComposer;
    import com.sulake.habbo.communication.messages.outgoing.poll.PollRejectComposer;
    import com.sulake.habbo.communication.messages.outgoing.poll.PollAnswerComposer;
    import com.sulake.habbo.communication.messages.outgoing.room.action.KickUserMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.room.action.KickBotMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.room.action.BanUserMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.room.action.AssignRightsMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.room.action.RemoveRightsMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.room.action.LetUserInMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.room.engine.RemovePetFromFlatMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.room.engine.GetPetCommandsMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.room.session.QuitMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.room.session.ChangeQueueMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.room.engine.SetClothingChangeDataMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.users.GetUserNotificationsMessageComposer;

    public class RoomSession implements IRoomSession 
    {

        private const _SafeStr_13604:int = 2500;

        private var _connection:IConnection;
        private var _roomId:int = 0;
        private var _roomCategory:int = 0;
        private var _password:String = "";
        private var _roomResources:String = "";
        private var _state:String = "RSE_CREATED";
        private var _SafeStr_13605:UserDataManager;
        private var _isRoomOwner:Boolean = false;
        private var _isRoomController:Boolean = false;
        private var _isTradingRoom:Boolean = false;
        private var _isSpectatorMode:Boolean = false;
        private var _arePetsAllowed:Boolean = false;
        private var _SafeStr_13611:Map;
        private var _SafeStr_5098:int;
        private var _habboTracking:IHabboTracking;

        public function RoomSession(_arg_1:int, _arg_2:int, _arg_3:IHabboTracking, _arg_4:String="", _arg_5:String="")
        {
            this._SafeStr_13611 = new Map();
            super();
            this._roomId = _arg_1;
            this._roomCategory = _arg_2;
            this._habboTracking = _arg_3;
            this._password = _arg_4;
            this._roomResources = _arg_5;
            this._SafeStr_13605 = new UserDataManager();
        }
        public function set connection(_arg_1:IConnection):void
        {
            if (_arg_1 == null){
                return;
            };
            this._connection = _arg_1;
            if (this._SafeStr_13605 != null){
                this._SafeStr_13605.connection = _arg_1;
            };
        }
        public function dispose():void
        {
            this._connection = null;
            if (this._SafeStr_13605 != null){
                this._SafeStr_13605.dispose();
                this._SafeStr_13605 = null;
            };
            if (this._SafeStr_13611 != null){
                this._SafeStr_13611.dispose();
                this._SafeStr_13611 = null;
            };
        }
        public function get roomId():int
        {
            return (this._roomId);
        }
        public function get roomCategory():int
        {
            return (this._roomCategory);
        }
        public function get roomResources():String
        {
            return (this._roomResources);
        }
        public function get state():String
        {
            return (this._state);
        }
        public function start():Boolean
        {
            if ((((this._state == RoomSessionEvent.RSE_CREATED)) && (!((this._connection == null))))){
                this._state = RoomSessionEvent.RSE_STARTED;
                if (this.isPrivateRoom){
                    return (this.RoomSession());
                };
                return (this.RoomSession(this._roomId, 0, true));
            };
            return (false);
        }
        public function reset(_arg_1:int, _arg_2:int):void
        {
            if (((!((_arg_1 == this._roomId))) || (!((_arg_2 == this._roomCategory))))){
                this._roomId = _arg_1;
                this._roomCategory = _arg_2;
                this._isRoomOwner = false;
                this._isRoomController = false;
                this._isTradingRoom = false;
                this._isSpectatorMode = false;
            };
        }
        private function RoomSession(_arg_1:int, _arg_2:int, _arg_3:Boolean):Boolean
        {
            if (this._connection == null){
                return (false);
            };
            this._connection.send(new OpenConnectionMessageComposer(_arg_3, _arg_1, _arg_2));
            return (true);
        }
        private function RoomSession():Boolean
        {
            if (this._connection == null){
                return (false);
            };
            this._connection.send(new OpenFlatConnectionMessageComposer(this._roomId, this._password));
            return (true);
        }
        public function RoomSession(_arg_1:String):void
        {
            this._connection.send(new ChatMessageComposer(_arg_1, this._SafeStr_5098));
            this._SafeStr_13611.add(this._SafeStr_5098, getTimer());
            this._SafeStr_5098++;
        }
        public function RoomSession(_arg_1:String):void
        {
            this._connection.send(new ChangeMottoMessageComposer(_arg_1));
        }
        public function RoomSession(_arg_1:int):void
        {
            var _local_3:int;
            var _local_2:Object = this._SafeStr_13611.remove(_arg_1);
            if (_local_2 != null){
                _local_3 = getTimer();
                if ((_local_3 - int(_local_2)) > this._SafeStr_13604){
                    if (this._habboTracking != null){
                        this._habboTracking.chatLagDetected(_local_3);
                    };
                };
            };
        }
        public function RoomSession(_arg_1:String):void
        {
            this._connection.send(new ShoutMessageComposer(_arg_1));
        }
        public function RoomSession(_arg_1:String, _arg_2:String):void
        {
            this._connection.send(new WhisperMessageComposer(_arg_1, _arg_2));
        }
        public function RoomSession(_arg_1:Boolean):void
        {
            if (_arg_1){
                this._connection.send(new StartTypingMessageComposer(this._roomId, this._roomCategory));
            }
            else {
                this._connection.send(new CancelTypingMessageComposer(this._roomId, this._roomCategory));
            };
        }
        public function RoomSession():void
        {
            this._connection.send(new WaveMessageComposer());
        }
        public function RoomSession(_arg_1:int):void
        {
            if ((((_arg_1 >= 0)) && ((_arg_1 <= 14)))){
                this._connection.send(new SignMessageComposer(_arg_1));
            };
        }
        public function RoomSession(_arg_1:int):void
        {
            this._connection.send(new DanceMessageComposer(_arg_1));
        }
        public function RoomSession(_arg_1:int):void
        {
            this._connection.send(new CreditFurniRedeemMessageComposer(_arg_1));
        }
        public function RoomSession(_arg_1:int):void
        {
            this._connection.send(new PresentOpenMessageComposer(_arg_1));
        }
        public function RoomSession(_arg_1:int, _arg_2:String):void
        {
            this._connection.send(new OpenPetPackageMessageComposer(_arg_1, _arg_2));
        }
        public function RoomSession():void
        {
            this._connection.send(new ViralTeaserFoundMessageComposer());
        }
        public function RoomSession():void
        {
            this._connection.send(new RoomDimmerGetPresetsMessageComposer(this._roomId, this._roomCategory));
        }
        public function RoomSession(_arg_1:int, _arg_2:int, _arg_3:uint, _arg_4:int, _arg_5:Boolean):void
        {
            var _local_6:String = ("000000" + _arg_3.toString(16).toUpperCase());
            var _local_7:String = ("#" + _local_6.substr((_local_6.length - 6)));
            this._connection.send(new RoomDimmerSavePresetMessageComposer(_arg_1, _arg_2, _local_7, _arg_4, _arg_5, this._roomId, this._roomCategory));
        }
        public function RoomSession():void
        {
            this._connection.send(new RoomDimmerChangeStateMessageComposer(this._roomId, this._roomCategory));
        }
        public function RoomSession(_arg_1:String, _arg_2:String, _arg_3:String, _arg_4:String=null, _arg_5:int=0):void
        {
            this._connection.send(new EventLogMessageComposer(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5));
        }
        public function RoomSession(_arg_1:int):void
        {
            this._connection.send(new VoteAnswerMessageComposer(_arg_1));
        }
        public function RoomSession(_arg_1:int):void
        {
            this._connection.send(new PollStartComposer(_arg_1));
        }
        public function RoomSession(_arg_1:int):void
        {
            this._connection.send(new PollRejectComposer(_arg_1));
        }
        public function RoomSession(_arg_1:int, _arg_2:int, _arg_3:Array):void
        {
            this._connection.send(new PollAnswerComposer(_arg_1, _arg_2, _arg_3));
        }
        public function RoomSession(_arg_1:int):void
        {
            this._connection.send(new KickUserMessageComposer(_arg_1, this.roomId, this.roomCategory));
        }
        public function RoomSession(_arg_1:int):void
        {
            this._connection.send(new KickBotMessageComposer(_arg_1));
        }
        public function RoomSession(_arg_1:int):void
        {
            this._connection.send(new BanUserMessageComposer(_arg_1, this.roomId, this.roomCategory));
        }
        public function RoomSession(_arg_1:int):void
        {
            this._connection.send(new AssignRightsMessageComposer(_arg_1));
        }
        public function RoomSession(_arg_1:int):void
        {
            var _local_2:Array = new Array();
            _local_2.push(_arg_1);
            var _local_3:RemoveRightsMessageComposer = new RemoveRightsMessageComposer(_local_2);
            this._connection.send(_local_3);
        }
        public function RoomSession(_arg_1:String, _arg_2:Boolean):void
        {
            this._connection.send(new LetUserInMessageComposer(_arg_1, _arg_2));
        }
        public function RoomSession(_arg_1:int):void
        {
            this._connection.send(new RemovePetFromFlatMessageComposer(_arg_1));
        }
        public function RoomSession(_arg_1:int):void
        {
            this._connection.send(new GetPetCommandsMessageComposer(_arg_1));
        }
        public function RoomSession():void
        {
            if (this._connection != null){
                this._connection.send(new QuitMessageComposer());
            };
        }
        public function RoomSession(_arg_1:int):void
        {
            if (this._connection == null){
                return;
            };
            this._connection.send(new ChangeQueueMessageComposer(_arg_1));
        }
        public function RoomSession(_arg_1:int, _arg_2:String, _arg_3:String):void
        {
            if (this._connection == null){
                return;
            };
            var _local_4:SetClothingChangeDataMessageComposer = new SetClothingChangeDataMessageComposer(_arg_1, _arg_2, _arg_3);
            this._connection.send(_local_4);
            _local_4.dispose();
            _local_4 = null;
        }
        public function sendGetUserNotifications():void
        {
            if (this._connection == null){
                return;
            };
            var _local_1:GetUserNotificationsMessageComposer = new GetUserNotificationsMessageComposer();
            this._connection.send(_local_1);
            _local_1.dispose();
            _local_1 = null;
        }
        public function get userDataManager():IUserDataManager
        {
            return ((this._SafeStr_13605 as IUserDataManager));
        }
        public function set isRoomOwner(_arg_1:Boolean):void
        {
            this._isRoomOwner = _arg_1;
        }
        public function get isRoomOwner():Boolean
        {
            return (this._isRoomOwner);
        }
        public function set isRoomController(_arg_1:Boolean):void
        {
            this._isRoomController = _arg_1;
        }
        public function get isRoomController():Boolean
        {
            return (this._isRoomController);
        }
        public function get isTradingRoom():Boolean
        {
            return (this._isTradingRoom);
        }
        public function get isPrivateRoom():Boolean
        {
            return ((this._roomCategory == 0));
        }
        public function set isTradingRoom(_arg_1:Boolean):void
        {
            this._isTradingRoom = _arg_1;
        }
        public function get isSpectatorMode():Boolean
        {
            return (this._isSpectatorMode);
        }
        public function set isSpectatorMode(_arg_1:Boolean):void
        {
            this._isSpectatorMode = _arg_1;
        }
        public function get arePetsAllowed():Boolean
        {
            return (this._arePetsAllowed);
        }
        public function set arePetsAllowed(_arg_1:Boolean):void
        {
            this._arePetsAllowed = _arg_1;
        }

    }
}//package com.sulake.habbo.session

// IRoomSession = "_-2e4" (String#6835, DoABC#2)
// RoomSession = "_-2wJ" (String#7207, DoABC#2)
// _SafeStr_13604 = "_-1JY" (String#17259, DoABC#2)
// _SafeStr_13605 = "_-36R" (String#21745, DoABC#2)
// _isRoomOwner = "_-1fq" (String#1738, DoABC#2)
// _isRoomController = "_-2YY" (String#6736, DoABC#2)
// _isTradingRoom = "_-19D" (String#16826, DoABC#2)
// _isSpectatorMode = "_-FL" (String#7978, DoABC#2)
// _arePetsAllowed = "_-1Xm" (String#17807, DoABC#2)
// _SafeStr_13611 = "_-2Je" (String#19796, DoABC#2)
// RoomSession = "_-2Z1" (String#20397, DoABC#2)
// RoomSession = "_-em" (String#23834, DoABC#2)
// chatLagDetected = "_-1JX" (String#5231, DoABC#2)
// ChatMessageComposer = "_-Fl" (String#22841, DoABC#2)
// IUserDataManager = "_-YM" (String#8379, DoABC#2)
// StartTypingMessageComposer = "_-1Sh" (String#17610, DoABC#2)
// RemoveRightsMessageComposer = "_-1Op" (String#17460, DoABC#2)
// PollStartComposer = "_-332" (String#21622, DoABC#2)
// CreditFurniRedeemMessageComposer = "_-1Xf" (String#17801, DoABC#2)
// WaveMessageComposer = "_-15Q" (String#16672, DoABC#2)
// SignMessageComposer = "_-1A" (String#16857, DoABC#2)
// ViralTeaserFoundMessageComposer = "_-05s" (String#14277, DoABC#2)
// PresentOpenMessageComposer = "_-3FS" (String#22097, DoABC#2)
// GetPetCommandsMessageComposer = "_-1Mp" (String#17393, DoABC#2)
// SetClothingChangeDataMessageComposer = "_-3j" (String#22363, DoABC#2)
// CancelTypingMessageComposer = "_-0Wi" (String#15305, DoABC#2)
// RoomDimmerSavePresetMessageComposer = "_-3LP" (String#22343, DoABC#2)
// RemovePetFromFlatMessageComposer = "_-1so" (String#18669, DoABC#2)
// VoteAnswerMessageComposer = "_-25A" (String#19226, DoABC#2)
// KickUserMessageComposer = "_-3GC" (String#22127, DoABC#2)
// QuitMessageComposer = "_-FM" (String#22827, DoABC#2)
// ChangeQueueMessageComposer = "_-0MP" (String#14930, DoABC#2)
// ShoutMessageComposer = "_-0W7" (String#15283, DoABC#2)
// WhisperMessageComposer = "_-3C4" (String#21963, DoABC#2)
// RoomDimmerGetPresetsMessageComposer = "_-0zU" (String#16406, DoABC#2)
// RoomDimmerChangeStateMessageComposer = "_-IN" (String#22945, DoABC#2)
// PollAnswerComposer = "_-0P6" (String#15030, DoABC#2)
// GetUserNotificationsMessageComposer = "_-Wh" (String#23513, DoABC#2)
// OpenPetPackageMessageComposer = "_-uW" (String#24471, DoABC#2)
// KickBotMessageComposer = "_-0To" (String#15200, DoABC#2)
// BanUserMessageComposer = "_-3DU" (String#22014, DoABC#2)
// ChangeMottoMessageComposer = "_-25K" (String#19231, DoABC#2)
// PollRejectComposer = "_-2EB" (String#19574, DoABC#2)
// OpenConnectionMessageComposer = "_-0d8" (String#15555, DoABC#2)
// AssignRightsMessageComposer = "_-34R" (String#21675, DoABC#2)
// LetUserInMessageComposer = "_-2kS" (String#20862, DoABC#2)
// DanceMessageComposer = "_-05v" (String#14278, DoABC#2)
// UserDataManager = "_-3BN" (String#7536, DoABC#2)
// OpenFlatConnectionMessageComposer = "_-0HY" (String#14739, DoABC#2)
// RSE_CREATED = "_-1XM" (String#17790, DoABC#2)
// RSE_STARTED = "_-oj" (String#24224, DoABC#2)
// _SafeStr_5098 = "_-0RZ" (String#4124, DoABC#2)
// RoomSession = "_-0C0" (String#1425, DoABC#2)
// IHabboTracking = "_-0fl" (String#4419, DoABC#2)
// RoomSession = "_-FR" (String#7981, DoABC#2)
// userDataManager = "_-lZ" (String#8636, DoABC#2)
// isRoomController = "_-xz" (String#8838, DoABC#2)
// isRoomOwner = "_-ZP" (String#8405, DoABC#2)
// isSpectatorMode = "_-10C" (String#4874, DoABC#2)
// isTradingRoom = "_-0eT" (String#4400, DoABC#2)
// arePetsAllowed = "_-1f7" (String#5646, DoABC#2)
// RoomSession = "_-2Ye" (String#1898, DoABC#2)
// _roomResources = "_-1mQ" (String#5788, DoABC#2)
// roomResources = "_-9r" (String#7860, DoABC#2)
// RoomSession = "_-Zi" (String#8411, DoABC#2)
// RoomSession = "_-3Es" (String#7609, DoABC#2)
// RoomSession = "_-0nV" (String#4580, DoABC#2)
// RoomSession = "_-3D4" (String#7576, DoABC#2)
// RoomSession = "_-3BE" (String#7533, DoABC#2)
// RoomSession = "_-1UA" (String#5435, DoABC#2)
// RoomSession = "_-0Bn" (String#3791, DoABC#2)
// RoomSession = "_-2qY" (String#7086, DoABC#2)
// RoomSession = "_-1SB" (String#5401, DoABC#2)
// RoomSession = "_-2gO" (String#6879, DoABC#2)
// RoomSession = "_-0KK" (String#3961, DoABC#2)
// RoomSession = "_-2W0" (String#6684, DoABC#2)
// RoomSession = "_-3-1" (String#7287, DoABC#2)
// RoomSession = "_-1Hb" (String#5200, DoABC#2)
// RoomSession = "_-32C" (String#7350, DoABC#2)
// RoomSession = "_-MI" (String#8128, DoABC#2)
// RoomSession = "_-Tm" (String#8281, DoABC#2)
// RoomSession = "_-YS" (String#8382, DoABC#2)
// RoomSession = "_-q5" (String#8711, DoABC#2)
// RoomSession = "_-mX" (String#8653, DoABC#2)
// isPrivateRoom = "_-1Wr" (String#5489, DoABC#2)
// RoomSession = "_-mI" (String#8649, DoABC#2)
// RoomSession = "_-1Ys" (String#5539, DoABC#2)
// RoomSession = "_-0A0" (String#3758, DoABC#2)
// RoomSession = "_-0uH" (String#4730, DoABC#2)
// RoomSession = "_-23-" (String#6105, DoABC#2)
// RoomSession = "_-3A4" (String#7513, DoABC#2)
// RoomSession = "_-0ug" (String#4736, DoABC#2)
// RoomSession = "_-IP" (String#8047, DoABC#2)
// RoomSession = "_-0Tt" (String#4177, DoABC#2)
// EventLogMessageComposer = "_-2lH" (String#6984, DoABC#2)


