
package com.sulake.habbo.room.object
{
    import com.sulake.core.runtime.Component;
    import com.sulake.room.object.IRoomObjectVisualizationFactory;
    import com.sulake.habbo.avatar.IAvatarRenderManager;
    import com.sulake.core.utils.Map;
    import com.sulake.iid.IIDAvatarRenderManager;
    import com.sulake.core.runtime.IContext;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.room.object.visualization.IRoomObjectVisualizationData;
    import com.sulake.core.runtime.IID;
    import com.sulake.core.runtime.IUnknown;
    import com.sulake.habbo.room.object.visualization.room.RoomVisualization;
    import com.sulake.habbo.room.object.visualization.room.publicroom.PublicRoomVisualization;
    import com.sulake.habbo.room.object.visualization.room.publicroom.PublicRoomParkVisualization;
    import com.sulake.habbo.room.object.visualization.room.publicroom.PublicRoomPoolVisualization;
    import com.sulake.habbo.room.object.visualization.avatar.AvatarVisualization;
    import com.sulake.habbo.room.object.visualization.pet.PetVisualization;
    import com.sulake.habbo.room.object.visualization.pet.AnimatedPetVisualization;
    import com.sulake.habbo.room.object.visualization.furniture.FurnitureVisualization;
    import com.sulake.habbo.room.object.visualization.furniture.AnimatedFurnitureVisualization;
    import com.sulake.habbo.room.object.visualization.furniture.ResettingAnimatedFurnitureVisualization;
    import com.sulake.habbo.room.object.visualization.furniture.FurniturePosterVisualization;
    import com.sulake.habbo.room.object.visualization.furniture.FurnitureHabboWheelVisualization;
    import com.sulake.habbo.room.object.visualization.furniture.FurnitureValRandomizerVisualization;
    import com.sulake.habbo.room.object.visualization.furniture.FurnitureBottleVisualization;
    import com.sulake.habbo.room.object.visualization.furniture.FurniturePlanetSystemVisualization;
    import com.sulake.habbo.room.object.visualization.furniture.FurnitureQueueTileVisualization;
    import com.sulake.habbo.room.object.visualization.furniture.FurniturePartyBeamerVisualization;
    import com.sulake.habbo.room.object.visualization.furniture.FurnitureCuboidVisualization;
    import com.sulake.habbo.room.object.visualization.furniture.FurnitureGiftWrappedVisualization;
    import com.sulake.habbo.room.object.visualization.furniture.FurnitureCounterClockVisualization;
    import com.sulake.habbo.room.object.visualization.furniture.FurnitureWaterAreaVisualization;
    import com.sulake.habbo.room.object.visualization.furniture.FurnitureScoreBoardVisualization;
    import com.sulake.habbo.room.object.visualization.furniture.FurnitureFireworksVisualization;
    import com.sulake.habbo.room.object.visualization.furniture.FurnitureRoomBillboardVisualization;
    import com.sulake.habbo.room.object.visualization.furniture.FurnitureRoomBackgroundVisualization;
    import com.sulake.habbo.room.object.visualization.furniture.FurnitureStickieVisualization;
    import com.sulake.room.object.visualization.IRoomObjectGraphicVisualization;
    import com.sulake.habbo.room.object.visualization.avatar.AvatarVisualizationData;
    import com.sulake.habbo.room.object.visualization.pet.PetVisualizationData;
    import com.sulake.habbo.room.object.visualization.pet.AnimatedPetVisualizationData;
    import com.sulake.habbo.room.object.visualization.furniture.FurnitureVisualizationData;
    import com.sulake.habbo.room.object.visualization.furniture.AnimatedFurnitureVisualizationData;
    import com.sulake.habbo.room.object.visualization.room.publicroom.PublicRoomVisualizationData;
    import com.sulake.habbo.room.object.visualization.room.RoomVisualizationData;
    import com.sulake.room.object.visualization.utils.GraphicAssetCollection;
    import com.sulake.room.object.visualization.utils.IGraphicAssetCollection;

    public class RoomObjectVisualizationFactory extends Component implements IRoomObjectVisualizationFactory 
    {

        private var _SafeStr_13135:IAvatarRenderManager = null;
        private var _visualizationDatas:Map;
        private var _SafeStr_13136:Boolean = true;

        public function RoomObjectVisualizationFactory(_arg_1:IContext, _arg_2:uint=0, _arg_3:IAssetLibrary=null)
        {
            super(_arg_1, _arg_2, _arg_3);
            this._SafeStr_13136 = (_arg_2 == 0);
            this._visualizationDatas = new Map();
            queueInterface(new IIDAvatarRenderManager(), this.avatarReady);
        }
        override public function dispose():void
        {
            var _local_1:IRoomObjectVisualizationData;
            var _local_2:int;
            super.dispose();
            if (this._SafeStr_13135 != null){
                release(new IIDAvatarRenderManager());
                this._SafeStr_13135 = null;
            };
            if (this._visualizationDatas != null){
                _local_1 = null;
                _local_2 = 0;
                while (_local_2 < this._visualizationDatas.length) {
                    _local_1 = (this._visualizationDatas.getWithIndex(_local_2) as IRoomObjectVisualizationData);
                    if (_local_1 != null){
                        _local_1.dispose();
                    };
                    _local_2++;
                };
                this._visualizationDatas.dispose();
                this._visualizationDatas = null;
            };
        }
        private function avatarReady(_arg_1:IID=null, _arg_2:IUnknown=null):void
        {
            if (disposed){
                return;
            };
            this._SafeStr_13135 = (_arg_2 as IAvatarRenderManager);
        }
        public function createRoomObjectVisualization(_arg_1:String):IRoomObjectGraphicVisualization
        {
            var _local_2:Class;
            switch (_arg_1){
                case RoomObjectVisualizationEnum.ROOM:
                    _local_2 = RoomVisualization;
                    break;
                case RoomObjectVisualizationEnum._SafeStr_13041:
                    _local_2 = PublicRoomVisualization;
                    break;
                case RoomObjectVisualizationEnum._SafeStr_13042:
                    _local_2 = PublicRoomParkVisualization;
                    break;
                case RoomObjectVisualizationEnum._SafeStr_13057:
                    _local_2 = PublicRoomPoolVisualization;
                    break;
                case RoomObjectVisualizationEnum._SafeStr_13040:
                    _local_2 = AvatarVisualization;
                    break;
                case RoomObjectVisualizationEnum.BOT:
                    _local_2 = AvatarVisualization;
                    break;
                case RoomObjectVisualizationEnum._SafeStr_6769:
                    _local_2 = PetVisualization;
                    break;
                case RoomObjectVisualizationEnum._SafeStr_13056:
                    _local_2 = AnimatedPetVisualization;
                    break;
                case RoomObjectVisualizationEnum._SafeStr_13045:
                    _local_2 = FurnitureVisualization;
                    break;
                case RoomObjectVisualizationEnum._SafeStr_13046:
                    _local_2 = AnimatedFurnitureVisualization;
                    break;
                case RoomObjectVisualizationEnum._SafeStr_13047:
                    _local_2 = ResettingAnimatedFurnitureVisualization;
                    break;
                case RoomObjectVisualizationEnum._SafeStr_13048:
                    _local_2 = FurniturePosterVisualization;
                    break;
                case RoomObjectVisualizationEnum._SafeStr_13020:
                    _local_2 = FurnitureHabboWheelVisualization;
                    break;
                case RoomObjectVisualizationEnum._SafeStr_13049:
                    _local_2 = FurnitureValRandomizerVisualization;
                    break;
                case RoomObjectVisualizationEnum._SafeStr_13050:
                    _local_2 = FurnitureBottleVisualization;
                    break;
                case RoomObjectVisualizationEnum._SafeStr_13023:
                    _local_2 = FurniturePlanetSystemVisualization;
                    break;
                case RoomObjectVisualizationEnum._SafeStr_13051:
                    _local_2 = FurnitureQueueTileVisualization;
                    break;
                case RoomObjectVisualizationEnum._SafeStr_13052:
                    _local_2 = FurniturePartyBeamerVisualization;
                    break;
                case RoomObjectVisualizationEnum._SafeStr_13053:
                    _local_2 = FurnitureCuboidVisualization;
                    break;
                case RoomObjectVisualizationEnum._SafeStr_13054:
                    _local_2 = FurnitureGiftWrappedVisualization;
                    break;
                case RoomObjectVisualizationEnum._SafeStr_13030:
                    _local_2 = FurnitureCounterClockVisualization;
                    break;
                case RoomObjectVisualizationEnum._SafeStr_13055:
                    _local_2 = FurnitureWaterAreaVisualization;
                    break;
                case RoomObjectVisualizationEnum._SafeStr_13031:
                    _local_2 = FurnitureScoreBoardVisualization;
                    break;
                case RoomObjectVisualizationEnum._SafeStr_13034:
                    _local_2 = FurnitureFireworksVisualization;
                    break;
                case RoomObjectVisualizationEnum._SafeStr_13036:
                    _local_2 = FurnitureRoomBillboardVisualization;
                    break;
                case RoomObjectVisualizationEnum._SafeStr_13037:
                    _local_2 = FurnitureRoomBackgroundVisualization;
                    break;
                case RoomObjectVisualizationEnum._SafeStr_13014:
                    _local_2 = FurnitureStickieVisualization;
                    break;
            };
            if (_local_2 == null){
                return (null);
            };
            var _local_3:Object = new (_local_2)();
            if ((_local_3 is IRoomObjectGraphicVisualization)){
                return ((_local_3 as IRoomObjectGraphicVisualization));
            };
            return (null);
        }
        public function getRoomObjectVisualizationData(_arg_1:String, _arg_2:String, _arg_3:XML):IRoomObjectVisualizationData
        {
            var _local_6:IRoomObjectVisualizationData;
            var _local_7:AvatarVisualizationData;
            var _local_8:PetVisualizationData;
            var _local_9:AnimatedPetVisualizationData;
            var _local_4:IRoomObjectVisualizationData;
            _local_4 = (this._visualizationDatas.getValue(_arg_1) as IRoomObjectVisualizationData);
            if (_local_4 != null){
                return (_local_4);
            };
            var _local_5:Class;
            switch (_arg_2){
                case RoomObjectVisualizationEnum._SafeStr_13045:
                case RoomObjectVisualizationEnum._SafeStr_13054:
                case RoomObjectVisualizationEnum._SafeStr_13036:
                case RoomObjectVisualizationEnum._SafeStr_13037:
                case RoomObjectVisualizationEnum._SafeStr_13014:
                    _local_5 = FurnitureVisualizationData;
                    break;
                case RoomObjectVisualizationEnum._SafeStr_13046:
                case RoomObjectVisualizationEnum._SafeStr_13047:
                case RoomObjectVisualizationEnum._SafeStr_13048:
                case RoomObjectVisualizationEnum._SafeStr_13020:
                case RoomObjectVisualizationEnum._SafeStr_13049:
                case RoomObjectVisualizationEnum._SafeStr_13050:
                case RoomObjectVisualizationEnum._SafeStr_13023:
                case RoomObjectVisualizationEnum._SafeStr_13051:
                case RoomObjectVisualizationEnum._SafeStr_13052:
                case RoomObjectVisualizationEnum._SafeStr_13030:
                case RoomObjectVisualizationEnum._SafeStr_13055:
                case RoomObjectVisualizationEnum._SafeStr_13031:
                case RoomObjectVisualizationEnum._SafeStr_13034:
                    _local_5 = AnimatedFurnitureVisualizationData;
                    break;
                case RoomObjectVisualizationEnum._SafeStr_13057:
                case RoomObjectVisualizationEnum._SafeStr_13042:
                case RoomObjectVisualizationEnum._SafeStr_13041:
                    _local_5 = PublicRoomVisualizationData;
                    break;
                case RoomObjectVisualizationEnum.ROOM:
                    _local_5 = RoomVisualizationData;
                    break;
                case RoomObjectVisualizationEnum._SafeStr_13040:
                    _local_5 = AvatarVisualizationData;
                    break;
                case RoomObjectVisualizationEnum.BOT:
                    _local_5 = AvatarVisualizationData;
                    break;
                case RoomObjectVisualizationEnum._SafeStr_6769:
                    _local_5 = PetVisualizationData;
                    break;
                case RoomObjectVisualizationEnum._SafeStr_13056:
                    _local_5 = AnimatedPetVisualizationData;
                    break;
            };
            if (_local_5 == null){
                return (null);
            };
            _local_4 = new (_local_5)();
            if (_local_4 != null){
                _local_6 = null;
                _local_6 = (_local_4 as IRoomObjectVisualizationData);
                if (!_local_6.initialize(_arg_3)){
                    _local_6.dispose();
                    return (null);
                };
                if ((_local_6 is AvatarVisualizationData)){
                    _local_7 = (_local_4 as AvatarVisualizationData);
                    _local_7.avatarRenderer = this._SafeStr_13135;
                }
                else {
                    if ((_local_6 is PetVisualizationData)){
                        _local_8 = (_local_4 as PetVisualizationData);
                        _local_8.avatarRenderer = this._SafeStr_13135;
                    }
                    else {
                        if ((_local_6 is AnimatedPetVisualizationData)){
                            _local_9 = (_local_4 as AnimatedPetVisualizationData);
                            _local_9.commonAssets = assets;
                        };
                    };
                };
                if (this._SafeStr_13136){
                    this._visualizationDatas.add(_arg_1, _local_6);
                };
                return (_local_6);
            };
            return (null);
        }
        public function createGraphicAssetCollection():IGraphicAssetCollection
        {
            return (new GraphicAssetCollection());
        }

    }
}//package com.sulake.habbo.room.object

// IID = "_-3KV" (String#7712, DoABC#2)
// _SafeStr_13014 = "_-1t7" (String#18682, DoABC#2)
// _SafeStr_13020 = "_-1YZ" (String#17833, DoABC#2)
// _SafeStr_13023 = "_-0Tb" (String#15194, DoABC#2)
// _SafeStr_13030 = "_-2aT" (String#20462, DoABC#2)
// _SafeStr_13031 = "_-05i" (String#14270, DoABC#2)
// _SafeStr_13034 = "_-17B" (String#16742, DoABC#2)
// _SafeStr_13036 = "_-1dQ" (String#18032, DoABC#2)
// _SafeStr_13037 = "_-2P3" (String#20004, DoABC#2)
// _SafeStr_13040 = "_-0u9" (String#16210, DoABC#2)
// _SafeStr_13041 = "_-106" (String#16470, DoABC#2)
// _SafeStr_13042 = "_-3Bi" (String#21950, DoABC#2)
// _SafeStr_13045 = "_-05G" (String#14254, DoABC#2)
// _SafeStr_13046 = "_-1Vt" (String#17738, DoABC#2)
// _SafeStr_13047 = "_-00w" (String#14092, DoABC#2)
// _SafeStr_13048 = "_-0Cq" (String#14564, DoABC#2)
// _SafeStr_13049 = "_-1dj" (String#18046, DoABC#2)
// _SafeStr_13050 = "_-bV" (String#23694, DoABC#2)
// _SafeStr_13051 = "_-2Ft" (String#19638, DoABC#2)
// _SafeStr_13052 = "_-XG" (String#23533, DoABC#2)
// _SafeStr_13053 = "_-1zE" (String#18936, DoABC#2)
// _SafeStr_13054 = "_-1vj" (String#18786, DoABC#2)
// _SafeStr_13055 = "_-cK" (String#23727, DoABC#2)
// _SafeStr_13056 = "_-6n" (String#22490, DoABC#2)
// _SafeStr_13057 = "_-1F5" (String#17075, DoABC#2)
// _SafeStr_13135 = "_-0Cz" (String#14568, DoABC#2)
// _SafeStr_13136 = "_-1xc" (String#18873, DoABC#2)
// avatarReady = "_-1Yt" (String#17846, DoABC#2)
// createRoomObjectVisualization = "_-0ao" (String#4319, DoABC#2)
// getRoomObjectVisualizationData = "_-1Qq" (String#5368, DoABC#2)
// createGraphicAssetCollection = "_-Ba" (String#2071, DoABC#2)
// IRoomObjectVisualizationData = "_-26A" (String#6167, DoABC#2)
// IRoomObjectGraphicVisualization = "_-rv" (String#8734, DoABC#2)
// IGraphicAssetCollection = "_-24o" (String#6134, DoABC#2)
// PetVisualizationData = "_-l7" (String#8627, DoABC#2)
// RoomVisualizationData = "_-0T2" (String#4161, DoABC#2)
// PublicRoomVisualizationData = "_-Uv" (String#8302, DoABC#2)
// FurnitureVisualizationData = "_-0d0" (String#4371, DoABC#2)
// FurnitureVisualization = "_-1sy" (String#5900, DoABC#2)
// AnimatedFurnitureVisualization = "_-0y2" (String#4811, DoABC#2)
// AnimatedPetVisualization = "_-4Y" (String#7757, DoABC#2)
// AvatarVisualizationData = "_-1dS" (String#5621, DoABC#2)
// FurniturePlanetSystemVisualization = "_-1AX" (String#5085, DoABC#2)
// FurnitureRoomBillboardVisualization = "_-1iK" (String#5718, DoABC#2)
// FurnitureScoreBoardVisualization = "_-0z7" (String#4827, DoABC#2)
// FurnitureValRandomizerVisualization = "_-22J" (String#6091, DoABC#2)
// AnimatedFurnitureVisualizationData = "_-nI" (String#8663, DoABC#2)
// AnimatedPetVisualizationData = "_-1K9" (String#5246, DoABC#2)
// FurnitureQueueTileVisualization = "_-1bL" (String#5582, DoABC#2)
// RoomVisualization = "_-0ky" (String#4520, DoABC#2)
// PublicRoomVisualization = "_-0TW" (String#4167, DoABC#2)
// PublicRoomPoolVisualization = "_-29a" (String#6241, DoABC#2)
// FurnitureGiftWrappedVisualization = "_-32z" (String#7365, DoABC#2)
// FurniturePartyBeamerVisualization = "_-25b" (String#6153, DoABC#2)
// FurnitureRoomBackgroundVisualization = "_-0Jt" (String#3948, DoABC#2)
// GraphicAssetCollection = "_-2uG" (String#7165, DoABC#2)
// FurnitureCounterClockVisualization = "_-2GS" (String#6376, DoABC#2)
// ResettingAnimatedFurnitureVisualization = "_-27x" (String#6201, DoABC#2)
// FurnitureWaterAreaVisualization = "_-3U" (String#7735, DoABC#2)
// FurnitureStickieVisualization = "_-Wl" (String#8343, DoABC#2)
// FurnitureHabboWheelVisualization = "_-1TZ" (String#5424, DoABC#2)
// FurniturePosterVisualization = "_-0wi" (String#4784, DoABC#2)
// PetVisualization = "_-0i2" (String#4467, DoABC#2)
// PublicRoomParkVisualization = "_-2vl" (String#7193, DoABC#2)
// FurnitureBottleVisualization = "_-1KT" (String#5253, DoABC#2)
// AvatarVisualization = "_-2SE" (String#6613, DoABC#2)
// FurnitureCuboidVisualization = "_-1uL" (String#18731, DoABC#2)
// RoomObjectVisualizationEnum = "_-0hb" (String#4459, DoABC#2)
// FurnitureFireworksVisualization = "_-2tu" (String#7158, DoABC#2)
// avatarRenderer = "_-Jv" (String#23003, DoABC#2)
// IAvatarRenderManager = "_-C9" (String#7915, DoABC#2)
// _SafeStr_6769 = "_-1Y9" (String#17821, DoABC#2)
// Component = "_-19A" (String#5060, DoABC#2)
// IRoomObjectVisualizationFactory = "_-T7" (String#8269, DoABC#2)


