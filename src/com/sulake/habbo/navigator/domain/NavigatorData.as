
package com.sulake.habbo.navigator.domain
{
    import com.sulake.habbo.navigator.HabboNavigator;
    import com.sulake.habbo.communication.messages.incoming.navigator.MsgWithRequestId;
    import com.sulake.habbo.communication.messages.incoming.navigator.RoomEventData;
    import com.sulake.habbo.communication.messages.incoming.navigator.GuestRoomData;
    import com.sulake.habbo.communication.messages.incoming.navigator.PublicRoomShortData;
    import flash.utils.Dictionary;
    import com.sulake.habbo.communication.messages.incoming.navigator.OfficialRoomEntryData;
    import com.sulake.habbo.communication.messages.parser.room.engine.RoomEntryInfoMessageParser;
    import com.sulake.habbo.communication.messages.incoming.navigator.PopularRoomTagsData;
    import com.sulake.habbo.communication.messages.incoming.navigator.GuestRoomSearchResultData;
    import com.sulake.habbo.communication.messages.incoming.navigator.OfficialRoomsData;
    import com.sulake.habbo.communication.messages.incoming.navigator.FlatCategory;
    import com.sulake.habbo.communication.messages.parser.navigator.FavouritesMessageParser;
    import com.sulake.habbo.communication.messages.incoming.navigator.*;
    import com.sulake.habbo.navigator.*;
    import com.sulake.habbo.communication.messages.parser.navigator.*;

    public class NavigatorData 
    {

        private static const _SafeStr_8625:int = 10;

        private var _navigator:HabboNavigator;
        private var _SafeStr_8626:MsgWithRequestId;
        private var _roomEventData:RoomEventData;
        private var _eventMod:Boolean;
        private var _roomPicker:Boolean;
        private var _currentRoomOwner:Boolean;
        private var _avatarId:int;
        private var _enteredGuestRoom:GuestRoomData;
        private var _enteredPublicSpace:PublicRoomShortData;
        private var _publicSpaceNodeId:int;
        private var _hcMember:Boolean;
        private var _createdFlatId:int;
        private var _hotRoomPopupOpen:Boolean;
        private var _homeRoomId:int;
        private var _settingsReceived:Boolean;
        private var _allCategories:Array;
        private var _visibleCategories:Array;
        private var _SafeStr_8639:int;
        private var _SafeStr_8640:int;
        private var _favouriteIds:Dictionary;
        private var _officialRooms:Boolean;
        private var _currentRoomRating:int;
        private var _currentRoomIsStaffPick:Boolean;
        private var _adIndex:int = 0;
        private var _adRoom:OfficialRoomEntryData;

        public function NavigatorData(_arg_1:HabboNavigator)
        {
            this._allCategories = new Array();
            this._visibleCategories = new Array();
            this._favouriteIds = new Dictionary();
            super();
            this._navigator = _arg_1;
        }
        public function get canAddFavourite():Boolean
        {
            return (((!((this._enteredGuestRoom == null))) && (!(this._currentRoomOwner))));
        }
        public function get canEditRoomSettings():Boolean
        {
            return (((!((this._enteredGuestRoom == null))) && (this._currentRoomOwner)));
        }
        public function onRoomEnter(_arg_1:RoomEntryInfoMessageParser):void
        {
            this._enteredPublicSpace = null;
            this._enteredGuestRoom = null;
            this._currentRoomOwner = false;
            if (_arg_1.privateRoom){
                this._currentRoomOwner = _arg_1.owner;
            }
            else {
                this._enteredPublicSpace = _arg_1.publicSpace;
                this._roomEventData = null;
            };
        }
        public function HabboGroupInfoManager():void
        {
            if (this._roomEventData != null){
                this._roomEventData.dispose();
                this._roomEventData = null;
            };
            if (this._enteredPublicSpace != null){
                this._enteredPublicSpace.dispose();
                this._enteredPublicSpace = null;
            };
            if (this._enteredGuestRoom != null){
                this._enteredGuestRoom.dispose();
                this._enteredGuestRoom = null;
            };
            this._currentRoomOwner = false;
        }
        public function set enteredRoom(_arg_1:GuestRoomData):void
        {
            if (this._enteredGuestRoom != null){
                this._enteredGuestRoom.dispose();
            };
            this._enteredGuestRoom = _arg_1;
        }
        public function set roomEventData(_arg_1:RoomEventData):void
        {
            if (this._roomEventData != null){
                this._roomEventData.dispose();
            };
            this._roomEventData = _arg_1;
        }
        public function get popularTagsArrived():Boolean
        {
            return (((!((this._SafeStr_8626 == null))) && (!(((this._SafeStr_8626 as PopularRoomTagsData) == null)))));
        }
        public function get guestRoomSearchArrived():Boolean
        {
            return (((!((this._SafeStr_8626 == null))) && (!(((this._SafeStr_8626 as GuestRoomSearchResultData) == null)))));
        }
        public function get officialRoomsArrived():Boolean
        {
            return (((!((this._SafeStr_8626 == null))) && (!(((this._SafeStr_8626 as OfficialRoomsData) == null)))));
        }
        public function set guestRoomSearchResults(_arg_1:GuestRoomSearchResultData):void
        {
            this.disposeCurrentMsg();
            this._SafeStr_8626 = _arg_1;
            this._adRoom = _arg_1.ad;
            this._officialRooms = false;
        }
        public function set popularTags(_arg_1:PopularRoomTagsData):void
        {
            this.disposeCurrentMsg();
            this._SafeStr_8626 = _arg_1;
            this._officialRooms = false;
        }
        public function set officialRooms(_arg_1:OfficialRoomsData):void
        {
            this.disposeCurrentMsg();
            this._SafeStr_8626 = _arg_1;
            this._officialRooms = false;
        }
        private function disposeCurrentMsg():void
        {
            if (this._SafeStr_8626 == null){
                return;
            };
            this._SafeStr_8626.dispose();
            this._SafeStr_8626 = null;
        }
        public function set adRoom(_arg_1:OfficialRoomEntryData):void
        {
            this._adRoom = _arg_1;
        }
        public function get adRoom():OfficialRoomEntryData
        {
            return (this._adRoom);
        }
        public function get guestRoomSearchResults():GuestRoomSearchResultData
        {
            return ((this._SafeStr_8626 as GuestRoomSearchResultData));
        }
        public function get popularTags():PopularRoomTagsData
        {
            return ((this._SafeStr_8626 as PopularRoomTagsData));
        }
        public function get officialRooms():OfficialRoomsData
        {
            return ((this._SafeStr_8626 as OfficialRoomsData));
        }
        public function get roomEventData():RoomEventData
        {
            return (this._roomEventData);
        }
        public function get avatarId():int
        {
            return (this._avatarId);
        }
        public function get eventMod():Boolean
        {
            return (this._eventMod);
        }
        public function get roomPicker():Boolean
        {
            return (this._roomPicker);
        }
        public function get currentRoomOwner():Boolean
        {
            return (this._currentRoomOwner);
        }
        public function get enteredGuestRoom():GuestRoomData
        {
            return (this._enteredGuestRoom);
        }
        public function get enteredPublicSpace():PublicRoomShortData
        {
            return (this._enteredPublicSpace);
        }
        public function get hcMember():Boolean
        {
            return (this._hcMember);
        }
        public function get createdFlatId():int
        {
            return (this._createdFlatId);
        }
        public function get homeRoomId():int
        {
            return (this._homeRoomId);
        }
        public function get hotRoomPopupOpen():Boolean
        {
            return (this._hotRoomPopupOpen);
        }
        public function get currentRoomRating():int
        {
            return (this._currentRoomRating);
        }
        public function get publicSpaceNodeId():int
        {
            return (this._publicSpaceNodeId);
        }
        public function get settingsReceived():Boolean
        {
            return (this._settingsReceived);
        }
        public function get adIndex():int
        {
            return (this._adIndex);
        }
        public function get currentRoomIsStaffPick():Boolean
        {
            return (this._currentRoomIsStaffPick);
        }
        public function set avatarId(_arg_1:int):void
        {
            this._avatarId = _arg_1;
        }
        public function set createdFlatId(_arg_1:int):void
        {
            this._createdFlatId = _arg_1;
        }
        public function set hcMember(_arg_1:Boolean):void
        {
            this._hcMember = _arg_1;
        }
        public function set eventMod(_arg_1:Boolean):void
        {
            this._eventMod = _arg_1;
        }
        public function set roomPicker(_arg_1:Boolean):void
        {
            this._roomPicker = _arg_1;
        }
        public function set hotRoomPopupOpen(_arg_1:Boolean):void
        {
            this._hotRoomPopupOpen = _arg_1;
        }
        public function set homeRoomId(_arg_1:int):void
        {
            this._homeRoomId = _arg_1;
        }
        public function set currentRoomRating(_arg_1:int):void
        {
            this._currentRoomRating = _arg_1;
        }
        public function set publicSpaceNodeId(_arg_1:int):void
        {
            this._publicSpaceNodeId = _arg_1;
        }
        public function set settingsReceived(_arg_1:Boolean):void
        {
            this._settingsReceived = _arg_1;
        }
        public function set adIndex(_arg_1:int):void
        {
            this._adIndex = _arg_1;
        }
        public function set currentRoomIsStaffPick(_arg_1:Boolean):void
        {
            this._currentRoomIsStaffPick = _arg_1;
        }
        public function set categories(_arg_1:Array):void
        {
            var _local_2:FlatCategory;
            this._allCategories = _arg_1;
            this._visibleCategories = new Array();
            for each (_local_2 in this._allCategories) {
                if (_local_2.visible){
                    this._visibleCategories.push(_local_2);
                };
            };
        }
        public function get allCategories():Array
        {
            return (this._allCategories);
        }
        public function get visibleCategories():Array
        {
            return (this._visibleCategories);
        }
        public function IncomingMessages(_arg_1:FavouritesMessageParser):void
        {
            var _local_2:int;
            this._SafeStr_8639 = _arg_1.limit;
            this._SafeStr_8640 = _arg_1.favouriteRoomIds.length;
            this._favouriteIds = new Dictionary();
            for each (_local_2 in _arg_1.favouriteRoomIds) {
                this._favouriteIds[_local_2] = "yes";
            };
        }
        public function favouriteChanged(_arg_1:int, _arg_2:Boolean):void
        {
            this._favouriteIds[_arg_1] = ((_arg_2) ? "yes" : null);
            this._SafeStr_8640 = (this._SafeStr_8640 + ((_arg_2) ? 1 : -1));
        }
        public function isCurrentRoomFavourite():Boolean
        {
            var _local_1:int = this._enteredGuestRoom.flatId;
            return (!((this._favouriteIds[_local_1] == null)));
        }
        public function isCurrentRoomHome():Boolean
        {
            if (this._enteredGuestRoom == null){
                return (false);
            };
            var _local_1:int = this._enteredGuestRoom.flatId;
            return ((this._homeRoomId == _local_1));
        }
        public function isRoomFavourite(_arg_1:int):Boolean
        {
            return (!((this._favouriteIds[_arg_1] == null)));
        }
        public function isFavouritesFull():Boolean
        {
            return ((this._SafeStr_8640 >= this._SafeStr_8639));
        }
        public function startLoading():void
        {
            this._officialRooms = true;
        }
        public function isLoading():Boolean
        {
            return (this._officialRooms);
        }

    }
}//package com.sulake.habbo.navigator.domain

// NavigatorData = "_-1Uq" (String#5451, DoABC#2)
// PublicRoomShortData = "_-0ae" (String#4315, DoABC#2)
// GuestRoomData = "_-06S" (String#3692, DoABC#2)
// MsgWithRequestId = "_-1zv" (String#6029, DoABC#2)
// GuestRoomSearchResultData = "_-SV" (String#8256, DoABC#2)
// FavouritesMessageParser = "_-Om" (String#8181, DoABC#2)
// FlatCategory = "_-1Lo" (String#5274, DoABC#2)
// RoomEventData = "_-07q" (String#3718, DoABC#2)
// OfficialRoomEntryData = "_-0vy" (String#4767, DoABC#2)
// OfficialRoomsData = "_-pq" (String#8704, DoABC#2)
// PopularRoomTagsData = "_-1Bn" (String#5105, DoABC#2)
// privateRoom = "_-26S" (String#19271, DoABC#2)
// publicSpace = "_-1JR" (String#17253, DoABC#2)
// owner = "_-1S6" (String#17586, DoABC#2)
// adRoom = "_-m" (String#24110, DoABC#2)
// adIndex = "_-0RB" (String#15110, DoABC#2)
// flatId = "_-3CK" (String#21973, DoABC#2)
// officialRooms = "_-f3" (String#23847, DoABC#2)
// guestRoomSearchResults = "_-fX" (String#23866, DoABC#2)
// isRoomFavourite = "_-0Wv" (String#15312, DoABC#2)
// homeRoomId = "_-0jF" (String#15801, DoABC#2)
// popularTags = "_-dQ" (String#23778, DoABC#2)
// guestRoomSearchArrived = "_-019" (String#14097, DoABC#2)
// popularTagsArrived = "_-29b" (String#19388, DoABC#2)
// officialRoomsArrived = "_-18J" (String#16787, DoABC#2)
// startLoading = "_-241" (String#19177, DoABC#2)
// isLoading = "_-2Lx" (String#19882, DoABC#2)
// _avatarId = "_-0qk" (String#592, DoABC#2)
// enteredGuestRoom = "_-2Qx" (String#20085, DoABC#2)
// ad = "_-9K" (String#22592, DoABC#2)
// visibleCategories = "_-15s" (String#16692, DoABC#2)
// favouriteRoomIds = "_-0Az" (String#14487, DoABC#2)
// _adRoom = "_-0N8" (String#4022, DoABC#2)
// _homeRoomId = "_-zQ" (String#8867, DoABC#2)
// RoomEntryInfoMessageParser = "_-2Z9" (String#6747, DoABC#2)
// enteredPublicSpace = "_-2Gp" (String#19674, DoABC#2)
// roomEventData = "_-0tV" (String#16179, DoABC#2)
// currentRoomRating = "_-0zd" (String#16413, DoABC#2)
// isCurrentRoomFavourite = "_-0ul" (String#16227, DoABC#2)
// roomPicker = "_-2QD" (String#20055, DoABC#2)
// currentRoomIsStaffPick = "_-0QZ" (String#15085, DoABC#2)
// canEditRoomSettings = "_-1Wi" (String#17767, DoABC#2)
// canAddFavourite = "_-1mo" (String#18413, DoABC#2)
// currentRoomOwner = "_-oK" (String#24205, DoABC#2)
// eventMod = "_-167" (String#16700, DoABC#2)
// isFavouritesFull = "_-10D" (String#16472, DoABC#2)
// publicSpaceNodeId = "_-1m2" (String#18380, DoABC#2)
// _SafeStr_8625 = "_-07r" (String#14357, DoABC#2)
// _SafeStr_8626 = "_-0Wj" (String#15306, DoABC#2)
// _roomEventData = "_-2Ln" (String#19876, DoABC#2)
// _eventMod = "_-C2" (String#22693, DoABC#2)
// _roomPicker = "_-12n" (String#16572, DoABC#2)
// _enteredGuestRoom = "_-2x2" (String#21350, DoABC#2)
// _enteredPublicSpace = "_-px" (String#24271, DoABC#2)
// _publicSpaceNodeId = "_-1kT" (String#18307, DoABC#2)
// _hcMember = "_-jQ" (String#24015, DoABC#2)
// _createdFlatId = "_-23n" (String#19168, DoABC#2)
// _hotRoomPopupOpen = "_-3B2" (String#21924, DoABC#2)
// _settingsReceived = "_-042" (String#14203, DoABC#2)
// _allCategories = "_-Wy" (String#8348, DoABC#2)
// _visibleCategories = "_-2QX" (String#20067, DoABC#2)
// _SafeStr_8639 = "_-1Zy" (String#17889, DoABC#2)
// _SafeStr_8640 = "_-0bz" (String#15511, DoABC#2)
// _officialRooms = "_-0tt" (String#16199, DoABC#2)
// _currentRoomRating = "_-2fn" (String#20684, DoABC#2)
// _currentRoomIsStaffPick = "_-1je" (String#18270, DoABC#2)
// _adIndex = "_-jd" (String#24022, DoABC#2)
// onRoomEnter = "_-El" (String#460, DoABC#2)
// HabboGroupInfoManager = "_-0Na" (String#356, DoABC#2)
// enteredRoom = "_-7F" (String#22511, DoABC#2)
// disposeCurrentMsg = "_-0Qp" (String#15094, DoABC#2)
// hcMember = "_-Pz" (String#23249, DoABC#2)
// createdFlatId = "_-0bB" (String#15484, DoABC#2)
// hotRoomPopupOpen = "_-3ET" (String#22054, DoABC#2)
// settingsReceived = "_-197" (String#16822, DoABC#2)
// IncomingMessages = "_-2ms" (String#7018, DoABC#2)
// favouriteChanged = "_-GF" (String#22861, DoABC#2)
// isCurrentRoomHome = "_-1kn" (String#18322, DoABC#2)


