
package com.sulake.habbo.friendbar.utils
{
    import com.sulake.core.runtime.IUnknown;
    import com.sulake.habbo.session.IUserData;
    import com.sulake.iid.IIDHabboFriendList;
    import com.sulake.habbo.friendlist.IHabboFriendList;
    import com.sulake.core.runtime.IID;
    import com.sulake.iid.IIDHabboNavigator;
    import com.sulake.habbo.navigator.IHabboNavigator;
    import com.sulake.iid.IIDHabboQuestEngine;
    import com.sulake.habbo.quest.IHabboQuestEngine;
    import com.sulake.iid.IIDRoomEngine;
    import com.sulake.habbo.room.IRoomEngine;
    import com.sulake.iid.IIDHabboRoomSessionManager;
    import com.sulake.habbo.session.IRoomSessionManager;
    import com.sulake.habbo.session.IRoomSession;
    import com.sulake.habbo.room.object.RoomObjectCategoryEnum;
    import com.sulake.iid.IIDHabboEventStream;
    import com.sulake.habbo.friendbar.stream.IHabboEventStream;

    public class LinkResolver 
    {

        private static var _UNKNOWN:IUnknown;

        public static function set unknown(_arg_1:IUnknown):void
        {
            _UNKNOWN = _arg_1;
        }
        public static function open(linkTarget:LinkTarget):Boolean
        {
            var ownAvatarId:int;
            var userData:IUserData;
            var roomId:int;
            var roomCategory:int;
            if (((!(_UNKNOWN)) || (_UNKNOWN.disposed))){
                return (false);
            };
            if (!linkTarget){
                return (false);
            };
            var returnValue:Boolean;
            switch (linkTarget.type){
                case LinkTarget.NONE:
                    break;
                case LinkTarget._SafeStr_10974:
                    _UNKNOWN.queueInterface(new IIDHabboFriendList(), function (_arg_1:IID, _arg_2:IUnknown):void
                    {
                        IHabboFriendList(_arg_2).openFriendList();
                        _arg_2.release(_arg_1);
                    });
                    break;
                case LinkTarget.ROOM:
                    _UNKNOWN.queueInterface(new IIDHabboNavigator(), function (_arg_1:IID, _arg_2:IUnknown):void
                    {
                        IHabboNavigator(_arg_2).goToRoom(linkTarget.identifier, false);
                        _arg_2.release(_arg_1);
                    });
                    break;
                case LinkTarget.ACHIEVEMENTS:
                    _UNKNOWN.queueInterface(new IIDHabboQuestEngine(), function (_arg_1:IID, _arg_2:IUnknown):void
                    {
                        IHabboQuestEngine(_arg_2).showAchievements();
                        _arg_2.release(_arg_1);
                    });
                    break;
                case LinkTarget._SafeStr_10975:
                    ownAvatarId = linkTarget.identifier;
                    roomId = 0;
                    roomCategory = 0;
                    _UNKNOWN.queueInterface(new IIDRoomEngine(), function (_arg_1:IID, _arg_2:IUnknown):void
                    {
                        roomId = IRoomEngine(_arg_2).activeRoomId;
                        roomCategory = IRoomEngine(_arg_2).activeRoomCategory;
                        _arg_2.release(_arg_1);
                    });
                    _UNKNOWN.queueInterface(new IIDHabboRoomSessionManager(), function (_arg_1:IID, _arg_2:IUnknown):void
                    {
                        var _local_3:IRoomSession = IRoomSessionManager(_arg_2).getSession(roomId, roomCategory);
                        if (((!((_local_3 == null))) && (!((_local_3.userDataManager == null))))){
                            userData = _local_3.userDataManager.getUserData(ownAvatarId);
                        };
                        _arg_2.release(_arg_1);
                    });
                    if (userData != null){
                        _UNKNOWN.queueInterface(new IIDRoomEngine(), function (_arg_1:IID, _arg_2:IUnknown):void
                        {
                            IRoomEngine(_arg_2).selectRoomObject(roomId, roomCategory, userData.id, RoomObjectCategoryEnum.OBJECT_CATEGORY_USER);
                            _arg_2.release(_arg_1);
                        });
                        _UNKNOWN.queueInterface(new IIDHabboEventStream(), function (_arg_1:IID, _arg_2:IUnknown):void
                        {
                            IHabboEventStream(_arg_2).visible = false;
                            _arg_2.release(_arg_1);
                        });
                    };
                    break;
                case LinkTarget.RSFRE_FRIEND_REQUEST:
                    _UNKNOWN.queueInterface(new IIDHabboFriendList(), function (_arg_1:IID, _arg_2:IUnknown):void
                    {
                        IHabboFriendList(_arg_2).askForAFriend(linkTarget.identifier, linkTarget.extraData);
                        _arg_2.release(_arg_1);
                    });
                    returnValue = true;
                    break;
                default:
                    throw (new Error("Don't forget to implement new link target types!"));
            };
            return (returnValue);
        }

    }
}//package com.sulake.habbo.friendbar.utils

// IID = "_-3KV" (String#7712, DoABC#2)
// _SafeStr_10974 = "_-0Ib" (String#14784, DoABC#2)
// _SafeStr_10975 = "_-2Dk" (String#19556, DoABC#2)
// showAchievements = "_-1xg" (String#5986, DoABC#2)
// IRoomSession = "_-2e4" (String#6835, DoABC#2)
// IHabboEventStream = "_-2Uk" (String#6661, DoABC#2)
// LinkResolver = "_-0WN" (String#4235, DoABC#2)
// IUserData = "_-0n7" (String#4570, DoABC#2)
// LinkTarget = "_-1HG" (String#1650, DoABC#2)
// IHabboNavigator = "_-2rk" (String#7118, DoABC#2)
// RSFRE_FRIEND_REQUEST = "_-2Wu" (String#20318, DoABC#2)
// goToRoom = "_-2Jw" (String#6438, DoABC#2)
// activeRoomId = "_-kJ" (String#2172, DoABC#2)
// activeRoomCategory = "_-1qo" (String#1770, DoABC#2)
// getUserData = "_-1-1" (String#4848, DoABC#2)
// userDataManager = "_-lZ" (String#8636, DoABC#2)
// askForAFriend = "_-3Iw" (String#7688, DoABC#2)
// IHabboQuestEngine = "_-2tn" (String#7154, DoABC#2)
// IHabboFriendList = "_-29N" (String#6237, DoABC#2)
// RoomObjectCategoryEnum = "_-1eh" (String#5639, DoABC#2)


