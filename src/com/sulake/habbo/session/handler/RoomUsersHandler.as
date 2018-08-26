
package com.sulake.habbo.session.handler
{
    import com.sulake.habbo.communication.messages.incoming.room.engine.UsersMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.room.engine.UserRemoveMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.users.HabboUserBadgesMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.navigator.DoorbellMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.room.engine.UserChangeMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.users.UserNameChangedMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.room.pets.PetInfoMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.room.pets.PetCommandsMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.room.pets.PetPlacingErrorEvent;
    import com.sulake.habbo.communication.messages.incoming.friendlist.NewBuddyRequestEvent;
    import com.sulake.habbo.communication.messages.incoming.room.action.DanceMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.room.engine.FavoriteMembershipUpdateMessageEvent;
    import com.sulake.core.communication.connection.IConnection;
    import com.sulake.habbo.session.IRoomHandlerListener;
    import com.sulake.habbo.session.events.RoomSessionFavouriteGroupUpdateEvent;
    import com.sulake.habbo.communication.messages.parser.room.engine.FavouriteMembershipUpdateMessageParser;
    import com.sulake.habbo.session.IRoomSession;
    import com.sulake.habbo.session.IUserData;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.room.engine.UserMessageData;
    import com.sulake.habbo.session.UserData;
    import com.sulake.habbo.communication.messages.parser.room.engine.UsersMessageParser;
    import com.sulake.habbo.session.events.RoomSessionUserDataUpdateEvent;
    import com.sulake.habbo.communication.messages.parser.room.engine.UserRemoveMessageParser;
    import com.sulake.habbo.session.events.RoomSessionUserBadgesEvent;
    import com.sulake.habbo.session.events.RoomSessionDoorbellEvent;
    import com.sulake.habbo.session.events.RoomSessionUserFigureUpdateEvent;
    import com.sulake.habbo.communication.messages.parser.users.UserNameChangedMessageParser;
    import com.sulake.habbo.communication.messages.parser.room.pets.PetInfoMessageParser;
    import com.sulake.habbo.session.PetInfo;
    import com.sulake.habbo.session.events.RoomSessionPetInfoUpdateEvent;
    import com.sulake.habbo.communication.messages.parser.room.pets.PetCommandsMessageParser;
    import com.sulake.habbo.session.events.RoomSessionPetCommandsUpdateEvent;
    import com.sulake.habbo.session.events.RoomSessionErrorMessageEvent;
    import com.sulake.habbo.communication.messages.parser.friendlist.NewBuddyRequestMessageParser;
    import com.sulake.habbo.communication.messages.incoming.friendlist.FriendRequestData;
    import com.sulake.habbo.session.events.RoomSessionFriendRequestEvent;
    import com.sulake.habbo.communication.messages.parser.room.action.DanceMessageParser;
    import com.sulake.habbo.session.events.RoomSessionDanceEvent;

    public class RoomUsersHandler extends BaseHandler 
    {

        public function RoomUsersHandler(_arg_1:IConnection, _arg_2:IRoomHandlerListener)
        {
            super(_arg_1, _arg_2);
            if (_arg_1 == null){
                return;
            };
            _arg_1.addMessageEvent(new UsersMessageEvent(this.RoomMessageHandler));
            _arg_1.addMessageEvent(new UserRemoveMessageEvent(this.RoomMessageHandler));
            _arg_1.addMessageEvent(new HabboUserBadgesMessageEvent(this.InfostandWidget));
            _arg_1.addMessageEvent(new DoorbellMessageEvent(this.IncomingMessages));
            _arg_1.addMessageEvent(new UserChangeMessageEvent(this.onUserChange));
            _arg_1.addMessageEvent(new UserNameChangedMessageEvent(this.onUserNameChange));
            _arg_1.addMessageEvent(new PetInfoMessageEvent(this.InfostandWidget));
            _arg_1.addMessageEvent(new PetCommandsMessageEvent(this.onEnabledPetCommands));
            _arg_1.addMessageEvent(new PetPlacingErrorEvent(this.onPetPlacingError));
            _arg_1.addMessageEvent(new NewBuddyRequestEvent(this.onFriendRequest));
            _arg_1.addMessageEvent(new DanceMessageEvent(this.RoomMessageHandler));
            _arg_1.addMessageEvent(new FavoriteMembershipUpdateMessageEvent(this.onFavoriteMembershipUpdate));
        }
        private function onFavoriteMembershipUpdate(_arg_1:IMessageEvent):void
        {
            var _local_5:RoomSessionFavouriteGroupUpdateEvent;
            var _local_2:FavouriteMembershipUpdateMessageParser = FavoriteMembershipUpdateMessageEvent(_arg_1).getParser();
            var _local_3:IRoomSession = listener.getSession(_xxxRoomId, _SafeStr_6312);
            if (_local_3 == null){
                return;
            };
            var _local_4:IUserData = _local_3.userDataManager.getUserDataByIndex(_local_2.roomIndex);
            if (_local_4 == null){
                return;
            };
            _local_4.groupID = ("" + _local_2.habboGroupId);
            if (((listener) && (listener.events))){
                _local_5 = new RoomSessionFavouriteGroupUpdateEvent(_local_3, _local_2.roomIndex, _local_2.habboGroupId, _local_2.status);
                listener.events.dispatchEvent(_local_5);
            };
        }
        private function RoomMessageHandler(_arg_1:IMessageEvent):void
        {
            var _local_6:UserMessageData;
            var _local_7:UserData;
            var _local_2:UsersMessageEvent = (_arg_1 as UsersMessageEvent);
            if (_local_2 == null){
                return;
            };
            var _local_3:UsersMessageParser = _local_2.getParser();
            var _local_4:IRoomSession = listener.getSession(_xxxRoomId, _SafeStr_6312);
            if (_local_4 == null){
                return;
            };
            var _local_5:int;
            while (_local_5 < _local_3.UsersMessageParser()) {
                _local_6 = _local_3.UsersMessageParser(_local_5);
                _local_7 = new UserData(_local_6.id);
                _local_7.name = _local_6.name;
                _local_7.custom = _local_6.custom;
                _local_7.achievementScore = _local_6.achievementScore;
                _local_7.figure = _local_6.figure;
                _local_7.type = _local_6.userType;
                _local_7.webID = _local_6.webID;
                _local_7.groupID = _local_6.groupID;
                _local_7.groupStatus = _local_6.groupStatus;
                _local_7.sex = _local_6.sex;
                _local_7.xp = _local_6.xp;
                _local_4.userDataManager.setUserData(_local_7);
                _local_5++;
            };
            listener.events.dispatchEvent(new RoomSessionUserDataUpdateEvent(_local_4));
        }
        private function RoomMessageHandler(_arg_1:IMessageEvent):void
        {
            var _local_2:UserRemoveMessageEvent = (_arg_1 as UserRemoveMessageEvent);
            if (_local_2 == null){
                return;
            };
            var _local_3:IRoomSession = listener.getSession(_xxxRoomId, _SafeStr_6312);
            if (_local_3 == null){
                return;
            };
            var _local_4:int = (_local_2.getParser() as UserRemoveMessageParser).id;
            _local_3.userDataManager.removeUserDataByIndex(_local_4);
        }
        private function InfostandWidget(_arg_1:IMessageEvent):void
        {
            var _local_2:HabboUserBadgesMessageEvent = (_arg_1 as HabboUserBadgesMessageEvent);
            if (_local_2 == null){
                return;
            };
            var _local_3:IRoomSession = listener.getSession(_xxxRoomId, _SafeStr_6312);
            if (_local_3 == null){
                return;
            };
            _local_3.userDataManager.setUserBadges(_local_2.userId, _local_2.badges);
            listener.events.dispatchEvent(new RoomSessionUserBadgesEvent(_local_3, _local_2.userId, _local_2.badges));
        }
        private function IncomingMessages(_arg_1:IMessageEvent):void
        {
            var _local_2:DoorbellMessageEvent = (_arg_1 as DoorbellMessageEvent);
            if (_local_2 == null){
                return;
            };
            if (_local_2.userName == ""){
                return;
            };
            var _local_3:IRoomSession = listener.getSession(_xxxRoomId, _SafeStr_6312);
            if (_local_3 == null){
                return;
            };
            listener.events.dispatchEvent(new RoomSessionDoorbellEvent(RoomSessionDoorbellEvent.RSDE_DOORBELL, _local_3, _local_2.userName));
        }
        private function onUserChange(_arg_1:IMessageEvent):void
        {
            var _local_2:UserChangeMessageEvent = (_arg_1 as UserChangeMessageEvent);
            if (_local_2 == null){
                return;
            };
            var _local_3:IRoomSession = listener.getSession(_xxxRoomId, _SafeStr_6312);
            if (_local_3 == null){
                return;
            };
            if (_local_2.id >= 0){
                _local_3.userDataManager.updateFigure(_local_2.id, _local_2.figure, _local_2.sex);
                _local_3.userDataManager.updateCustom(_local_2.id, _local_2.customInfo);
                _local_3.userDataManager.updateAchievementScore(_local_2.id, _local_2.achievementScore);
                listener.events.dispatchEvent(new RoomSessionUserFigureUpdateEvent(_local_3, _local_2.id, _local_2.figure, _local_2.sex, _local_2.customInfo, _local_2.achievementScore));
            };
        }
        private function onUserNameChange(_arg_1:IMessageEvent):void
        {
            var _local_2:UserNameChangedMessageEvent = (_arg_1 as UserNameChangedMessageEvent);
            if (_local_2 == null){
                return;
            };
            var _local_3:UserNameChangedMessageParser = _local_2.getParser();
            var _local_4:IRoomSession = listener.getSession(_xxxRoomId, _SafeStr_6312);
            if (_local_4 == null){
                return;
            };
            _local_4.userDataManager.updateNameByIndex(_local_3.id, _local_3.newName);
        }
        private function InfostandWidget(_arg_1:IMessageEvent):void
        {
            var _local_2:IRoomSession = listener.getSession(_xxxRoomId, _SafeStr_6312);
            if (_local_2 == null){
                return;
            };
            var _local_3:PetInfoMessageEvent = (_arg_1 as PetInfoMessageEvent);
            if (_local_3 == null){
                return;
            };
            var _local_4:PetInfoMessageParser = _local_3.getParser();
            var _local_5:PetInfo = new PetInfo();
            _local_5.petId = _local_4.petId;
            _local_5.level = _local_4.level;
            _local_5.levelMax = _local_4.maxLevel;
            _local_5.experience = _local_4.experience;
            _local_5.experienceMax = _local_4.experienceRequiredToLevel;
            _local_5.energy = _local_4.energy;
            _local_5.energyMax = _local_4.maxEnergy;
            _local_5.nutrition = _local_4.nutrition;
            _local_5.nutritionMax = _local_4.maxNutrition;
            _local_5.ownerId = _local_4.ownerId;
            _local_5.ownerName = _local_4.ownerName;
            _local_5.respect = _local_4.respect;
            _local_5.age = _local_4.age;
            listener.events.dispatchEvent(new RoomSessionPetInfoUpdateEvent(_local_2, _local_5));
        }
        private function onEnabledPetCommands(_arg_1:IMessageEvent):void
        {
            var _local_2:IRoomSession = listener.getSession(_xxxRoomId, _SafeStr_6312);
            if (_local_2 == null){
                return;
            };
            var _local_3:PetCommandsMessageEvent = (_arg_1 as PetCommandsMessageEvent);
            if (_local_3 == null){
                return;
            };
            var _local_4:PetCommandsMessageParser = _local_3.getParser();
            if (_local_4 != null){
                listener.events.dispatchEvent(new RoomSessionPetCommandsUpdateEvent(_local_2, _local_4.petId, _local_4.allCommands, _local_4.enabledCommands));
            };
        }
        private function onPetPlacingError(_arg_1:PetPlacingErrorEvent):void
        {
            var _local_3:String;
            if ((((_arg_1 == null)) || ((_arg_1.getParser() == null)))){
                return;
            };
            var _local_2:IRoomSession = listener.getSession(_xxxRoomId, _SafeStr_6312);
            if (_local_2 == null){
                return;
            };
            switch (_arg_1.getParser().errorCode){
                case 0:
                    _local_3 = RoomSessionErrorMessageEvent.RSEME_PETS_FORBIDDEN_IN_HOTEL;
                    break;
                case 1:
                    _local_3 = RoomSessionErrorMessageEvent.RSEME_PETS_FORBIDDEN_IN_FLAT;
                    break;
                case 2:
                    _local_3 = RoomSessionErrorMessageEvent.RSEME_MAX_PETS;
                    break;
                case 3:
                    _local_3 = RoomSessionErrorMessageEvent.RSEME_NO_FREE_TILES_FOR_PET;
                    break;
                case 4:
                    _local_3 = RoomSessionErrorMessageEvent.RSEME_SELECTED_TILE_NOT_FREE_FOR_PET;
                    break;
            };
            if (_local_3 != null){
                listener.events.dispatchEvent(new RoomSessionErrorMessageEvent(_local_3, _local_2));
            };
        }
        private function onFriendRequest(_arg_1:NewBuddyRequestEvent):void
        {
            if (((((!(_arg_1)) || (!(listener)))) || (!(listener.events)))){
                return;
            };
            var _local_2:NewBuddyRequestMessageParser = _arg_1.getParser();
            if (!_local_2){
                return;
            };
            var _local_3:IRoomSession = listener.getSession(_xxxRoomId, _SafeStr_6312);
            if (!_local_3){
                return;
            };
            var _local_4:FriendRequestData = _local_2.req;
            if (!_local_4){
                return;
            };
            listener.events.dispatchEvent(new RoomSessionFriendRequestEvent(_local_3, _local_4.requestId, _local_4.requestId, _local_4.requesterName));
        }
        private function RoomMessageHandler(_arg_1:DanceMessageEvent):void
        {
            var _local_2:DanceMessageParser = _arg_1.getParser();
            var _local_3:IRoomSession = listener.getSession(_xxxRoomId, _SafeStr_6312);
            listener.events.dispatchEvent(new RoomSessionDanceEvent(_local_3, _local_2.userId, _local_2.danceStyle));
        }

    }
}//package com.sulake.habbo.session.handler

// IRoomSession = "_-2e4" (String#6835, DoABC#2)
// BaseHandler = "_-1Mx" (String#5291, DoABC#2)
// RoomUsersHandler = "_-328" (String#7348, DoABC#2)
// IRoomHandlerListener = "_-3Fo" (String#7627, DoABC#2)
// RoomSessionDanceEvent = "_-nx" (String#24188, DoABC#2)
// RoomSessionDoorbellEvent = "_-30k" (String#7320, DoABC#2)
// RoomSessionUserDataUpdateEvent = "_-10F" (String#16473, DoABC#2)
// RoomSessionFriendRequestEvent = "_-31R" (String#21557, DoABC#2)
// RoomSessionErrorMessageEvent = "_-2Xn" (String#6720, DoABC#2)
// RoomSessionUserBadgesEvent = "_-0-O" (String#14028, DoABC#2)
// UserChangeMessageEvent = "_-a9" (String#23638, DoABC#2)
// UserNameChangedMessageParser = "_-1TI" (String#17637, DoABC#2)
// UserNameChangedMessageEvent = "_-1J2" (String#17238, DoABC#2)
// FriendRequestData = "_-1aw" (String#17931, DoABC#2)
// NewBuddyRequestEvent = "_-1iS" (String#5721, DoABC#2)
// NewBuddyRequestMessageParser = "_-2Qd" (String#6572, DoABC#2)
// IUserData = "_-0n7" (String#4570, DoABC#2)
// UserRemoveMessageParser = "_-0h" (String#4445, DoABC#2)
// RoomSessionPetInfoUpdateEvent = "_-Xz" (String#23559, DoABC#2)
// RoomSessionPetCommandsUpdateEvent = "_-AD" (String#22626, DoABC#2)
// PetInfo = "_-1Wo" (String#5487, DoABC#2)
// FavoriteMembershipUpdateMessageEvent = "_-1tm" (String#18707, DoABC#2)
// PetCommandsMessageEvent = "_-V3" (String#23451, DoABC#2)
// PetCommandsMessageParser = "_-fp" (String#8509, DoABC#2)
// UsersMessageParser = "_-3Iv" (String#7687, DoABC#2)
// HabboUserBadgesMessageEvent = "_-1fc" (String#5656, DoABC#2)
// RoomSessionUserFigureUpdateEvent = "_-387" (String#21808, DoABC#2)
// UserRemoveMessageEvent = "_-2U" (String#20197, DoABC#2)
// DanceMessageEvent = "_-1dk" (String#18047, DoABC#2)
// PetPlacingErrorEvent = "_-1XB" (String#17784, DoABC#2)
// UserData = "_-2Mt" (String#19922, DoABC#2)
// UserMessageData = "_-0WX" (String#4238, DoABC#2)
// UsersMessageEvent = "_-2MA" (String#19891, DoABC#2)
// DanceMessageParser = "_-1U0" (String#5432, DoABC#2)
// DoorbellMessageEvent = "_-03C" (String#14170, DoABC#2)
// RoomSessionFavouriteGroupUpdateEvent = "_-0xo" (String#16346, DoABC#2)
// FavouriteMembershipUpdateMessageParser = "_-0I" (String#3916, DoABC#2)
// PetInfoMessageParser = "_-0zJ" (String#4833, DoABC#2)
// PetInfoMessageEvent = "_-94" (String#22583, DoABC#2)
// requestId = "_-li" (String#24099, DoABC#2)
// userType = "_-0Dh" (String#14596, DoABC#2)
// petId = "_-JP" (String#8074, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// UsersMessageParser = "_-xV" (String#24590, DoABC#2)
// UsersMessageParser = "_-0C8" (String#14534, DoABC#2)
// custom = "_-1sW" (String#5894, DoABC#2)
// webID = "_-2uI" (String#7166, DoABC#2)
// sex = "_-0tG" (String#4712, DoABC#2)
// groupID = "_-37J" (String#7452, DoABC#2)
// groupStatus = "_-1Sq" (String#5411, DoABC#2)
// achievementScore = "_-16Z" (String#5005, DoABC#2)
// habboGroupId = "_-PC" (String#23215, DoABC#2)
// customInfo = "_-2Mk" (String#19916, DoABC#2)
// RSDE_DOORBELL = "_-0bt" (String#15507, DoABC#2)
// ownerName = "_-1e1" (String#1730, DoABC#2)
// req = "_-8J" (String#22555, DoABC#2)
// danceStyle = "_-0M0" (String#14915, DoABC#2)
// RSEME_PETS_FORBIDDEN_IN_HOTEL = "_-7b" (String#22526, DoABC#2)
// RSEME_PETS_FORBIDDEN_IN_FLAT = "_-2Zv" (String#20437, DoABC#2)
// RSEME_MAX_PETS = "_-LM" (String#23061, DoABC#2)
// RSEME_NO_FREE_TILES_FOR_PET = "_-lQ" (String#24085, DoABC#2)
// RSEME_SELECTED_TILE_NOT_FREE_FOR_PET = "_-2DI" (String#19538, DoABC#2)
// allCommands = "_-2QF" (String#20056, DoABC#2)
// enabledCommands = "_-0yX" (String#16375, DoABC#2)
// newName = "_-2Fm" (String#19634, DoABC#2)
// _SafeStr_6312 = "_-2JJ" (String#19781, DoABC#2)
// userDataManager = "_-lZ" (String#8636, DoABC#2)
// RoomMessageHandler = "_-1eu" (String#1735, DoABC#2)
// RoomMessageHandler = "_-2FD" (String#6347, DoABC#2)
// InfostandWidget = "_-8z" (String#2063, DoABC#2)
// IncomingMessages = "_-nT" (String#8667, DoABC#2)
// onUserChange = "_-0uf" (String#827, DoABC#2)
// onUserNameChange = "_-37e" (String#2005, DoABC#2)
// InfostandWidget = "_-0dE" (String#1512, DoABC#2)
// onEnabledPetCommands = "_-0-k" (String#14043, DoABC#2)
// onPetPlacingError = "_-1rR" (String#18603, DoABC#2)
// onFriendRequest = "_-0iR" (String#15770, DoABC#2)
// RoomMessageHandler = "_-1cS" (String#5609, DoABC#2)
// onFavoriteMembershipUpdate = "_-xl" (String#24602, DoABC#2)
// getUserDataByIndex = "_-1XZ" (String#5510, DoABC#2)
// setUserData = "_-Hx" (String#8038, DoABC#2)
// removeUserDataByIndex = "_-1he" (String#5701, DoABC#2)
// setUserBadges = "_-2Fj" (String#6358, DoABC#2)
// updateFigure = "_-15u" (String#1619, DoABC#2)
// updateCustom = "_-0N7" (String#4021, DoABC#2)
// updateAchievementScore = "_-1bB" (String#5581, DoABC#2)
// updateNameByIndex = "_-2vz" (String#7201, DoABC#2)
// levelMax = "_-2dd" (String#6823, DoABC#2)
// maxLevel = "_-2ur" (String#21271, DoABC#2)
// experienceMax = "_-1bq" (String#5596, DoABC#2)
// experienceRequiredToLevel = "_-RG" (String#23294, DoABC#2)
// energyMax = "_-8m" (String#7836, DoABC#2)
// maxEnergy = "_-Ns" (String#23159, DoABC#2)
// nutrition = "_-0yZ" (String#4819, DoABC#2)
// nutritionMax = "_-1m9" (String#5783, DoABC#2)
// maxNutrition = "_-LR" (String#23063, DoABC#2)
// ownerId = "_-0Kl" (String#3968, DoABC#2)
// requesterName = "_-1ki" (String#18318, DoABC#2)


