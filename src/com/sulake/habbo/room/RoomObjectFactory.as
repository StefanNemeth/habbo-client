
package com.sulake.habbo.room
{
    import com.sulake.core.runtime.Component;
    import com.sulake.room.IRoomObjectFactory;
    import com.sulake.core.utils.Map;
    import com.sulake.core.runtime.IContext;
    import com.sulake.room.object.logic.IRoomObjectEventHandler;
    import com.sulake.habbo.room.object.logic.furniture.FurnitureLogic;
    import com.sulake.habbo.room.object.RoomObjectLogicEnum;
    import com.sulake.habbo.room.object.logic.furniture.FurnitureMultiStateLogic;
    import com.sulake.habbo.room.object.logic.furniture.FurniturePlaceholderLogic;
    import com.sulake.habbo.room.object.logic.AvatarLogic;
    import com.sulake.habbo.room.object.logic.PetLogic;
    import com.sulake.habbo.room.object.logic.furniture.FurnitureRandomStateLogic;
    import com.sulake.habbo.room.object.logic.furniture.FurnitureCreditLogic;
    import com.sulake.habbo.room.object.logic.furniture.FurnitureStickieLogic;
    import com.sulake.habbo.room.object.logic.furniture.FurniturePresentLogic;
    import com.sulake.habbo.room.object.logic.furniture.FurnitureTrophyLogic;
    import com.sulake.habbo.room.object.logic.furniture.FurnitureTeaserLogic;
    import com.sulake.habbo.room.object.logic.furniture.FurnitureEcotronBoxLogic;
    import com.sulake.habbo.room.object.logic.furniture.FurnitureDiceLogic;
    import com.sulake.habbo.room.object.logic.furniture.FurnitureHockeyScoreLogic;
    import com.sulake.habbo.room.object.logic.furniture.FurnitureHabboWheelLogic;
    import com.sulake.habbo.room.object.logic.furniture.FurnitureQuestVendingWallItemLogic;
    import com.sulake.habbo.room.object.logic.furniture.FurnitureOneWayDoorLogic;
    import com.sulake.habbo.room.object.logic.furniture.FurniturePlanetSystemLogic;
    import com.sulake.habbo.room.object.logic.furniture.FurnitureWindowLogic;
    import com.sulake.habbo.room.object.logic.furniture.FurnitureRoomDimmerLogic;
    import com.sulake.habbo.room.object.logic.room.RoomTileCursorLogic;
    import com.sulake.habbo.room.object.logic.room.SelectionArrowLogic;
    import com.sulake.habbo.room.object.logic.furniture.FurnitureSoundMachineLogic;
    import com.sulake.habbo.room.object.logic.furniture.FurnitureJukeboxLogic;
    import com.sulake.habbo.room.object.logic.furniture.FurnitureSongDiskLogic;
    import com.sulake.habbo.room.object.logic.furniture.FurniturePushableLogic;
    import com.sulake.habbo.room.object.logic.furniture.FurnitureClothingChangeLogic;
    import com.sulake.habbo.room.object.logic.furniture.FurnitureCounterClockLogic;
    import com.sulake.habbo.room.object.logic.furniture.FurnitureScoreBoardLogic;
    import com.sulake.habbo.room.object.logic.furniture.FurnitureIceStormLogic;
    import com.sulake.habbo.room.object.logic.furniture.FurnitureFireworksLogic;
    import com.sulake.habbo.room.object.logic.furniture.FurnitureRoomBillboardLogic;
    import com.sulake.habbo.room.object.logic.furniture.FurnitureRoomBackgroundLogic;
    import com.sulake.habbo.room.object.logic.furniture.FurnitureWelcomeGiftLogic;
    import com.sulake.habbo.room.object.logic.furniture.FurnitureFloorHoleLogic;
    import com.sulake.habbo.room.object.logic.room.RoomLogic;
    import com.sulake.habbo.room.object.logic.room.publicroom.PublicRoomLogic;
    import com.sulake.habbo.room.object.logic.room.publicroom.PublicRoomParkLogic;
    import com.sulake.room.RoomObjectManager;
    import com.sulake.room.IRoomObjectManager;

    public class RoomObjectFactory extends Component implements IRoomObjectFactory 
    {

        private var _SafeStr_13541:Map;
        private var _SafeStr_13542:Map;
        private var _SafeStr_13543:Array;

        public function RoomObjectFactory(_arg_1:IContext, _arg_2:uint=0)
        {
            this._SafeStr_13541 = new Map();
            this._SafeStr_13542 = new Map();
            this._SafeStr_13543 = [];
            super(_arg_1, _arg_2);
        }
        public function addObjectEventListener(_arg_1:Function):void
        {
            var _local_2:String;
            if (this._SafeStr_13543.indexOf(_arg_1) < 0){
                this._SafeStr_13543.push(_arg_1);
                if (_arg_1 != null){
                    for each (_local_2 in this._SafeStr_13542.getKeys()) {
                        events.addEventListener(_local_2, _arg_1);
                    };
                };
            };
        }
        public function removeObjectEventListener(_arg_1:Function):void
        {
            var _local_2:String;
            var _local_3:int = this._SafeStr_13543.indexOf(_arg_1);
            if (_local_3 >= 0){
                this._SafeStr_13543.splice(_local_3, 1);
                if (_arg_1 != null){
                    for each (_local_2 in this._SafeStr_13542.getKeys()) {
                        events.removeEventListener(_local_2, _arg_1);
                    };
                };
            };
        }
        private function addTrackedEventType(_arg_1:String):void
        {
            var _local_2:Function;
            if (this._SafeStr_13542.getValue(_arg_1) == null){
                this._SafeStr_13542.add(_arg_1, true);
                for each (_local_2 in this._SafeStr_13543) {
                    if (_local_2 != null){
                        events.addEventListener(_arg_1, _local_2);
                    };
                };
            };
        }
        public function createRoomObjectLogic(_arg_1:String):IRoomObjectEventHandler
        {
            var _local_4:IRoomObjectEventHandler;
            var _local_5:Array;
            var _local_6:String;
            var _local_2:Class;
            switch (_arg_1){
                case RoomObjectLogicEnum._SafeStr_13009:
                    _local_2 = FurnitureLogic;
                    break;
                case RoomObjectLogicEnum._SafeStr_13010:
                    _local_2 = FurnitureMultiStateLogic;
                    break;
                case RoomObjectLogicEnum._SafeStr_13012:
                    _local_2 = FurniturePlaceholderLogic;
                    break;
                case RoomObjectLogicEnum._SafeStr_13040:
                case RoomObjectLogicEnum.BOT:
                    _local_2 = AvatarLogic;
                    break;
                case RoomObjectLogicEnum._SafeStr_6769:
                    _local_2 = PetLogic;
                    break;
                case RoomObjectLogicEnum._SafeStr_13011:
                    _local_2 = FurnitureRandomStateLogic;
                    break;
                case RoomObjectLogicEnum._SafeStr_13013:
                    _local_2 = FurnitureCreditLogic;
                    break;
                case RoomObjectLogicEnum._SafeStr_13014:
                    _local_2 = FurnitureStickieLogic;
                    break;
                case RoomObjectLogicEnum._SafeStr_13015:
                    _local_2 = FurniturePresentLogic;
                    break;
                case RoomObjectLogicEnum._SafeStr_13016:
                    _local_2 = FurnitureTrophyLogic;
                    break;
                case RoomObjectLogicEnum._SafeStr_13032:
                    _local_2 = FurnitureTeaserLogic;
                    break;
                case RoomObjectLogicEnum._SafeStr_13017:
                    _local_2 = FurnitureEcotronBoxLogic;
                    break;
                case RoomObjectLogicEnum._SafeStr_13018:
                    _local_2 = FurnitureDiceLogic;
                    break;
                case RoomObjectLogicEnum._SafeStr_13019:
                    _local_2 = FurnitureHockeyScoreLogic;
                    break;
                case RoomObjectLogicEnum._SafeStr_13020:
                    _local_2 = FurnitureHabboWheelLogic;
                    break;
                case RoomObjectLogicEnum._SafeStr_13021:
                    _local_2 = FurnitureQuestVendingWallItemLogic;
                    break;
                case RoomObjectLogicEnum._SafeStr_13022:
                    _local_2 = FurnitureOneWayDoorLogic;
                    break;
                case RoomObjectLogicEnum._SafeStr_13023:
                    _local_2 = FurniturePlanetSystemLogic;
                    break;
                case RoomObjectLogicEnum._SafeStr_13024:
                    _local_2 = FurnitureWindowLogic;
                    break;
                case RoomObjectLogicEnum._SafeStr_13025:
                    _local_2 = FurnitureRoomDimmerLogic;
                    break;
                case RoomObjectLogicEnum._SafeStr_13043:
                    _local_2 = RoomTileCursorLogic;
                    break;
                case RoomObjectLogicEnum._SafeStr_13044:
                    _local_2 = SelectionArrowLogic;
                    break;
                case RoomObjectLogicEnum._SafeStr_13026:
                    _local_2 = FurnitureSoundMachineLogic;
                    break;
                case RoomObjectLogicEnum._SafeStr_13027:
                    _local_2 = FurnitureJukeboxLogic;
                    break;
                case RoomObjectLogicEnum._SafeStr_13035:
                    _local_2 = FurnitureSongDiskLogic;
                    break;
                case RoomObjectLogicEnum._SafeStr_13028:
                    _local_2 = FurniturePushableLogic;
                    break;
                case RoomObjectLogicEnum._SafeStr_13029:
                    _local_2 = FurnitureClothingChangeLogic;
                    break;
                case RoomObjectLogicEnum._SafeStr_13030:
                    _local_2 = FurnitureCounterClockLogic;
                    break;
                case RoomObjectLogicEnum._SafeStr_13031:
                    _local_2 = FurnitureScoreBoardLogic;
                    break;
                case RoomObjectLogicEnum._SafeStr_13033:
                    _local_2 = FurnitureIceStormLogic;
                    break;
                case RoomObjectLogicEnum._SafeStr_13034:
                    _local_2 = FurnitureFireworksLogic;
                    break;
                case RoomObjectLogicEnum._SafeStr_13036:
                    _local_2 = FurnitureRoomBillboardLogic;
                    break;
                case RoomObjectLogicEnum._SafeStr_13037:
                    _local_2 = FurnitureRoomBackgroundLogic;
                    break;
                case RoomObjectLogicEnum._SafeStr_13038:
                    _local_2 = FurnitureWelcomeGiftLogic;
                    break;
                case RoomObjectLogicEnum._SafeStr_13039:
                    _local_2 = FurnitureFloorHoleLogic;
                    break;
                case RoomObjectLogicEnum.ROOM:
                    _local_2 = RoomLogic;
                    break;
                case RoomObjectLogicEnum._SafeStr_13041:
                    _local_2 = PublicRoomLogic;
                    break;
                case RoomObjectLogicEnum._SafeStr_13042:
                    _local_2 = PublicRoomParkLogic;
                    break;
            };
            if (_local_2 == null){
                return (null);
            };
            var _local_3:Object = new (_local_2)();
            if ((_local_3 is IRoomObjectEventHandler)){
                _local_4 = (_local_3 as IRoomObjectEventHandler);
                _local_4.eventDispatcher = this.events;
                if (this._SafeStr_13541.getValue(_arg_1) == null){
                    this._SafeStr_13541.add(_arg_1, true);
                    _local_5 = _local_4.getEventTypes();
                    for each (_local_6 in _local_5) {
                        this.addTrackedEventType(_local_6);
                    };
                };
                return (_local_4);
            };
            return (null);
        }
        public function createRoomObjectManager():IRoomObjectManager
        {
            return (new RoomObjectManager());
        }

    }
}//package com.sulake.habbo.room

// _SafeStr_13009 = "_-0QJ" (String#15076, DoABC#2)
// _SafeStr_13010 = "_-1vv" (String#18793, DoABC#2)
// _SafeStr_13011 = "_-39o" (String#21876, DoABC#2)
// _SafeStr_13012 = "_-17Z" (String#16757, DoABC#2)
// _SafeStr_13013 = "_-0Gp" (String#14712, DoABC#2)
// _SafeStr_13014 = "_-1t7" (String#18682, DoABC#2)
// _SafeStr_13015 = "_-0AZ" (String#14471, DoABC#2)
// _SafeStr_13016 = "_-0sZ" (String#16144, DoABC#2)
// _SafeStr_13017 = "_-37d" (String#21792, DoABC#2)
// _SafeStr_13018 = "_-2IX" (String#19748, DoABC#2)
// _SafeStr_13019 = "_-323" (String#21582, DoABC#2)
// _SafeStr_13020 = "_-1YZ" (String#17833, DoABC#2)
// _SafeStr_13021 = "_-2Zo" (String#20432, DoABC#2)
// _SafeStr_13022 = "_-31X" (String#21560, DoABC#2)
// _SafeStr_13023 = "_-0Tb" (String#15194, DoABC#2)
// _SafeStr_13024 = "_-27H" (String#19303, DoABC#2)
// _SafeStr_13025 = "_-0hS" (String#15726, DoABC#2)
// _SafeStr_13026 = "_-3Al" (String#21910, DoABC#2)
// _SafeStr_13027 = "_-1A9" (String#16864, DoABC#2)
// _SafeStr_13028 = "_-cu" (String#23751, DoABC#2)
// _SafeStr_13029 = "_-2-M" (String#18985, DoABC#2)
// _SafeStr_13030 = "_-2aT" (String#20462, DoABC#2)
// _SafeStr_13031 = "_-05i" (String#14270, DoABC#2)
// _SafeStr_13032 = "_-1w" (String#18797, DoABC#2)
// _SafeStr_13033 = "_-xt" (String#24610, DoABC#2)
// _SafeStr_13034 = "_-17B" (String#16742, DoABC#2)
// _SafeStr_13035 = "_-2Xl" (String#20348, DoABC#2)
// _SafeStr_13036 = "_-1dQ" (String#18032, DoABC#2)
// _SafeStr_13037 = "_-2P3" (String#20004, DoABC#2)
// _SafeStr_13038 = "_-369" (String#21736, DoABC#2)
// _SafeStr_13039 = "_-2MP" (String#19902, DoABC#2)
// _SafeStr_13040 = "_-0u9" (String#16210, DoABC#2)
// _SafeStr_13041 = "_-106" (String#16470, DoABC#2)
// _SafeStr_13042 = "_-3Bi" (String#21950, DoABC#2)
// _SafeStr_13043 = "_-1ON" (String#17447, DoABC#2)
// _SafeStr_13044 = "_-1yj" (String#18917, DoABC#2)
// addObjectEventListener = "_-Jk" (String#8078, DoABC#2)
// _SafeStr_13541 = "_-2jx" (String#20843, DoABC#2)
// _SafeStr_13542 = "_-1Gv" (String#17147, DoABC#2)
// _SafeStr_13543 = "_-2Z5" (String#20401, DoABC#2)
// removeObjectEventListener = "_-1wN" (String#5964, DoABC#2)
// addTrackedEventType = "_-3It" (String#22234, DoABC#2)
// createRoomObjectLogic = "_-0ly" (String#4548, DoABC#2)
// createRoomObjectManager = "_-1Ry" (String#1688, DoABC#2)
// IRoomObjectManager = "_-iT" (String#8568, DoABC#2)
// IRoomObjectEventHandler = "_-2c8" (String#6797, DoABC#2)
// RoomObjectManager = "_-0zf" (String#16415, DoABC#2)
// FurnitureLogic = "_-001" (String#14053, DoABC#2)
// FurnitureMultiStateLogic = "_-23" (String#6104, DoABC#2)
// FurnitureWelcomeGiftLogic = "_-1hA" (String#18181, DoABC#2)
// FurnitureDiceLogic = "_-QR" (String#23266, DoABC#2)
// FurnitureFireworksLogic = "_-306" (String#21505, DoABC#2)
// FurnitureCreditLogic = "_-2CV" (String#19504, DoABC#2)
// FurnitureTeaserLogic = "_-1I1" (String#17193, DoABC#2)
// SelectionArrowLogic = "_-2pr" (String#21076, DoABC#2)
// FurnitureScoreBoardLogic = "_-2V0" (String#20238, DoABC#2)
// RoomTileCursorLogic = "_-VF" (String#23459, DoABC#2)
// FurnitureStickieLogic = "_-1Zz" (String#17890, DoABC#2)
// FurnitureHabboWheelLogic = "_-2Wg" (String#20311, DoABC#2)
// FurnitureSoundMachineLogic = "_-0MI" (String#14925, DoABC#2)
// FurnitureEcotronBoxLogic = "_-2eN" (String#20618, DoABC#2)
// RoomObjectLogicEnum = "_-0HH" (String#14730, DoABC#2)
// FurnitureRandomStateLogic = "_-26H" (String#19264, DoABC#2)
// FurnitureRoomBackgroundLogic = "_-0o6" (String#4595, DoABC#2)
// RoomLogic = "_-Qn" (String#8222, DoABC#2)
// PublicRoomLogic = "_-2QI" (String#6566, DoABC#2)
// PublicRoomParkLogic = "_-0Yp" (String#15393, DoABC#2)
// PetLogic = "_-2tA" (String#21208, DoABC#2)
// FurnitureTrophyLogic = "_-RK" (String#23298, DoABC#2)
// FurniturePresentLogic = "_-1BH" (String#16909, DoABC#2)
// FurniturePlaceholderLogic = "_-jm" (String#24026, DoABC#2)
// FurnitureClothingChangeLogic = "_-2JY" (String#19792, DoABC#2)
// FurnitureFloorHoleLogic = "_-2e-" (String#20603, DoABC#2)
// FurnitureRoomBillboardLogic = "_-1Ll" (String#5273, DoABC#2)
// FurnitureHockeyScoreLogic = "_-XA" (String#23529, DoABC#2)
// FurnitureWindowLogic = "_-1Xo" (String#17808, DoABC#2)
// FurnitureIceStormLogic = "_-32s" (String#21614, DoABC#2)
// FurnitureQuestVendingWallItemLogic = "_-31D" (String#21546, DoABC#2)
// FurniturePushableLogic = "_-0PS" (String#15041, DoABC#2)
// FurniturePlanetSystemLogic = "_-G4" (String#22856, DoABC#2)
// FurnitureRoomDimmerLogic = "_-1rc" (String#18613, DoABC#2)
// FurnitureJukeboxLogic = "_-1uC" (String#18724, DoABC#2)
// FurnitureOneWayDoorLogic = "_-15q" (String#16690, DoABC#2)
// AvatarLogic = "_-2iP" (String#20784, DoABC#2)
// FurnitureSongDiskLogic = "_-2hP" (String#20748, DoABC#2)
// FurnitureCounterClockLogic = "_-2Hi" (String#19713, DoABC#2)
// IRoomObjectFactory = "_-2Bh" (String#6281, DoABC#2)
// _SafeStr_6769 = "_-1Y9" (String#17821, DoABC#2)
// Component = "_-19A" (String#5060, DoABC#2)


