
package com.sulake.habbo.room
{
    import com.sulake.room.IRoomContentLoader;
    import com.sulake.habbo.session.furniture.IFurniDataListener;
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.core.utils.Map;
    import com.sulake.core.assets.AssetLibrary;
    import com.sulake.room.object.IRoomObjectVisualizationFactory;
    import flash.events.IEventDispatcher;
    import flash.utils.Dictionary;
    import com.sulake.habbo.room.utils.PublicRoomData;
    import com.sulake.habbo.session.ISessionDataManager;
    import com.sulake.habbo.configuration.IHabboConfigurationManager;
    import com.sulake.room.object.visualization.utils.IGraphicAssetCollection;
    import com.sulake.habbo.session.furniture.IFurnitureData;
    import flash.events.Event;
    import com.sulake.habbo.room.object.RoomObjectCategoryEnum;
    import com.sulake.habbo.room.object.RoomObjectVisualizationEnum;
    import com.sulake.core.assets.AssetLibraryCollection;
    import com.sulake.room.events.RoomContentLoadedEvent;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.core.utils.LibraryLoader;
    import flash.net.URLRequest;
    import com.sulake.core.utils.LibraryLoaderEvent;
    import com.sulake.core.Core;
    import com.sulake.core.assets.IAsset;
    import flash.display.BitmapData;

    public class RoomContentLoader implements IRoomContentLoader, IFurniDataListener, IDisposable 
    {

        public static const RCL_LOADER_READY:String = "RCL_LOADER_READY";
        private static const RCL_PUBLICROOM_:String = "RCL_PUBLICROOM_";
        private static const _SafeStr_13287:int = 0;
        private static const _SafeStr_7894:int = 1;
        private static const _SafeStr_5891:int = 2;
        private static const _SafeStr_13288:String = "place_holder";
        private static const _SafeStr_13289:String = "wall_place_holder";
        private static const _SafeStr_13290:String = "pet_place_holder";
        private static const PLACE_HOLDER_DEFAULT:String = _SafeStr_13288;//"place_holder"
        private static const _SafeStr_13291:String = "room";
        private static const TILE_CURSOR:String = "tile_cursor";
        private static const _SafeStr_13292:String = "selection_arrow";

        private var _baseUrl:String;
        private var _SafeStr_13293:Map = null;
        private var _events:Map = null;
        private var _assetLibrary:AssetLibrary = null;
        private var _SafeStr_13294:Map = null;
        private var _SafeStr_13295:Map = null;
        private var _visualizationFactory:IRoomObjectVisualizationFactory = null;
        private var _state:int = 0;
        private var _SafeStr_13297:IEventDispatcher = null;
        private var _disposed:Boolean = false;
        private var _SafeStr_13298:Boolean = false;
        private var _SafeStr_13299:Map = null;
        private var _SafeStr_13300:Dictionary;
        private var _SafeStr_13301:Map = null;
        private var _wallItems:Dictionary;
        private var _SafeStr_13302:Map = null;
        private var _pets:Dictionary;
        private var _SafeStr_13303:Map = null;
        private var _SafeStr_13304:PublicRoomData = null;
        private var _SafeStr_13305:Map = null;
        private var _SafeStr_13306:Map = null;
        private var _SafeStr_13307:Map = null;
        private var _SafeStr_13308:Map = null;
        private var _SafeStr_13309:Map = null;
        private var _SafeStr_13310:String;
        private var _SafeStr_13311:String;
        private var _publicRoomLoadUrlBase:String;
        private var _publicRoomLoadNameTemplate:String;
        private var _SafeStr_13312:Array;
        private var _SafeStr_13313:Array;
        private var _SafeStr_13314:Boolean = false;
        private var _sessionDataManager:ISessionDataManager;

        public function RoomContentLoader(_arg_1:String)
        {
            this._SafeStr_13300 = new Dictionary();
            this._wallItems = new Dictionary();
            this._pets = new Dictionary();
            this._SafeStr_13312 = ["hh_people_pool", "hh_people_pool_calippo", "hh_paalu", "hh_people_paalu"];
            this._SafeStr_13313 = ["room_public", "room_public_park", "room_public_pool"];
            super();
            this._baseUrl = _arg_1;
            this._SafeStr_13293 = new Map();
            this._events = new Map();
            this._assetLibrary = new AssetLibrary("room_engine");
            this._SafeStr_13299 = new Map();
            this._SafeStr_13301 = new Map();
            this._SafeStr_13302 = new Map();
            this.initPetData();
            this._SafeStr_13309 = new Map();
            this._SafeStr_13306 = new Map();
            this._SafeStr_13307 = new Map();
            this._SafeStr_13308 = new Map();
            this._SafeStr_13295 = new Map();
            this._SafeStr_13294 = new Map();
            this._SafeStr_13305 = new Map();
        }
        public function set sessionDataManager(_arg_1:ISessionDataManager):void
        {
            this._sessionDataManager = _arg_1;
            if (this._SafeStr_13314){
                this._SafeStr_13314 = false;
                this.initFurnitureData();
            };
        }
        public function get disposed():Boolean
        {
            return (this._disposed);
        }
        public function set visualizationFactory(_arg_1:IRoomObjectVisualizationFactory):void
        {
            this._visualizationFactory = _arg_1;
        }
        public function initialize(_arg_1:IEventDispatcher, _arg_2:IHabboConfigurationManager):void
        {
            if (this._state >= _SafeStr_7894){
                return;
            };
            this._SafeStr_13297 = _arg_1;
            this._SafeStr_13310 = _arg_2.getKey("flash.dynamic.download.url", "furniture/");
            this._SafeStr_13311 = _arg_2.getKey("flash.dynamic.download.name.template", "%typeid%.swf");
            this._publicRoomLoadUrlBase = _arg_2.getKey("public.room.dynamic.download.url", "");
            this._publicRoomLoadNameTemplate = _arg_2.getKey("public.room.dynamic.download.name.template", "%typeid%.swf");
            this._state = _SafeStr_7894;
            this.initFurnitureData();
        }
        private function initPetData():void
        {
            var _local_3:String;
            var _local_1:Array = ["spider", "turtle", "chicken", "frog", "dragon", "horse", "monkey", "monster", "monsterplant", "bunnyeaster", "bunnyevil", "bunnydepressed", "bunnylove", "pigeongood", "pigeonevil", "bearbaby", "terrierbaby", "pikachupet1", "smallb", "gnome", "wolfbabe", "pokemon_mewblu", "pkmnentei", "penguin", "guineapig12", "elephants", "ducky123456", "bbwibb", "pokmn_mew", "slendermn", "puppybaby", "kittenbaby", "pigletbaby", "haloompa", "fools", "pterosaur", "velociraptor", "cow"];
            var _local_2:int = 8;
            for each (_local_3 in _local_1) {
                this._pets[_local_3] = _local_2;
                this._SafeStr_13302.add(_local_2, _local_3);
                _local_2++;
            };
            this._SafeStr_13303 = new Map();
        }
        private function initFurnitureData():void
        {
            if (this._sessionDataManager == null){
                this._SafeStr_13314 = true;
                return;
            };
            var _local_1:Array = this._sessionDataManager.getFurniData(this);
            if (_local_1 == null){
                return;
            };
            this.populateFurniData(_local_1);
            this._SafeStr_13298 = true;
            this.continueInitilization();
        }
        public function dispose():void
        {
            var _local_1:String;
            var _local_2:int;
            var _local_3:int;
            var _local_4:AssetLibrary;
            var _local_5:IGraphicAssetCollection;
            if (this._SafeStr_13293 != null){
                _local_2 = this._SafeStr_13293.length;
                _local_3 = 0;
                while (_local_3 < _local_2) {
                    _local_4 = (this._SafeStr_13293.getWithIndex(_local_3) as AssetLibrary);
                    if (_local_4 != null){
                        _local_4.dispose();
                    };
                    _local_3++;
                };
                this._SafeStr_13293.dispose();
                this._SafeStr_13293 = null;
            };
            if (this._events != null){
                this._events.dispose();
                this._events = null;
            };
            if (this._SafeStr_13299 != null){
                this._SafeStr_13299.dispose();
                this._SafeStr_13299 = null;
            };
            if (this._SafeStr_13301 != null){
                this._SafeStr_13301.dispose();
                this._SafeStr_13301 = null;
            };
            if (this._SafeStr_13302 != null){
                this._SafeStr_13302.dispose();
                this._SafeStr_13302 = null;
            };
            if (this._SafeStr_13303 != null){
                this._SafeStr_13303.dispose();
                this._SafeStr_13303 = null;
            };
            if (this._assetLibrary != null){
                this._assetLibrary.dispose();
                this._assetLibrary = null;
            };
            if (this._SafeStr_13306 != null){
                this._SafeStr_13306.dispose();
                this._SafeStr_13306 = null;
            };
            if (this._SafeStr_13307 != null){
                this._SafeStr_13307.dispose();
                this._SafeStr_13307 = null;
            };
            if (this._SafeStr_13308 != null){
                this._SafeStr_13308.dispose();
                this._SafeStr_13308 = null;
            };
            if (this._SafeStr_13309 != null){
                this._SafeStr_13309.dispose();
                this._SafeStr_13309 = null;
            };
            if (this._SafeStr_13295 != null){
                _local_2 = this._SafeStr_13295.length;
                _local_3 = 0;
                while (_local_3 < _local_2) {
                    _local_5 = (this._SafeStr_13295.getWithIndex(_local_3) as IGraphicAssetCollection);
                    if (_local_5 != null){
                        _local_5.dispose();
                    };
                    _local_3++;
                };
                this._SafeStr_13295.dispose();
                this._SafeStr_13295 = null;
            };
            if (this._SafeStr_13294 != null){
                this._SafeStr_13294.dispose();
                this._SafeStr_13294 = null;
            };
            if (this._SafeStr_13300 != null){
                for (_local_1 in this._SafeStr_13300) {
                    delete this._SafeStr_13300[_local_1];
                };
                this._SafeStr_13300 = null;
            };
            if (this._wallItems != null){
                for (_local_1 in this._wallItems) {
                    delete this._wallItems[_local_1];
                };
                this._wallItems = null;
            };
            if (this._pets != null){
                for (_local_1 in this._pets) {
                    delete this._pets[_local_1];
                };
                this._pets = null;
            };
            this._SafeStr_13297 = null;
            this._sessionDataManager = null;
            this._disposed = true;
        }
        private function populateFurniData(_arg_1:Array):void
        {
            var _local_2:IFurnitureData;
            var _local_3:int;
            var _local_4:String;
            var _local_5:int;
            var _local_6:String;
            var _local_7:String;
            var _local_8:int;
            for each (_local_2 in _arg_1) {
                _local_3 = _local_2.id;
                _local_4 = _local_2.name;
                if (_local_2.colourIndex > 0){
                    _local_4 = ((_local_4 + "*") + _local_2.colourIndex);
                };
                _local_5 = _local_2.revision;
                _local_6 = _local_2.adUrl;
                if (((!((_local_6 == null))) && ((_local_6.length > 0)))){
                    this._SafeStr_13309.add(_local_4, _local_6);
                };
                _local_7 = _local_2.name;
                if (_local_2.type == "s"){
                    this._SafeStr_13299.add(_local_3, _local_4);
                    if (this._SafeStr_13300[_local_7] == null){
                        this._SafeStr_13300[_local_7] = 1;
                    };
                }
                else {
                    if (_local_2.type == "i"){
                        if (_local_4 == "post.it"){
                            _local_4 = "post_it";
                            _local_7 = "post_it";
                        };
                        if (_local_4 == "post.it.vd"){
                            _local_4 = "post_it_vd";
                            _local_7 = "post_it_vd";
                        };
                        this._SafeStr_13301.add(_local_3, _local_4);
                        if (this._wallItems[_local_7] == null){
                            this._wallItems[_local_7] = 1;
                        };
                    };
                };
                _local_8 = this._SafeStr_13306.getValue(_local_7);
                if (_local_5 > _local_8){
                    this._SafeStr_13306.remove(_local_7);
                    this._SafeStr_13306.add(_local_7, _local_5);
                };
            };
        }
        private function continueInitilization():void
        {
            if (this._SafeStr_13298){
                this._state = _SafeStr_5891;
                if (this._SafeStr_13297 != null){
                    this._SafeStr_13297.dispatchEvent(new Event(RCL_LOADER_READY));
                };
            };
        }
        public function setRoomObjectAlias(_arg_1:String, _arg_2:String):void
        {
            if (this._SafeStr_13307 != null){
                this._SafeStr_13307.remove(_arg_1);
                this._SafeStr_13307.add(_arg_1, _arg_2);
            };
            if (this._SafeStr_13308 != null){
                this._SafeStr_13308.remove(_arg_2);
                this._SafeStr_13308.add(_arg_2, _arg_1);
            };
        }
        private function getRoomObjectAlias(_arg_1:String):String
        {
            var _local_2:String;
            if (this._SafeStr_13307 != null){
                _local_2 = (this._SafeStr_13307.getValue(_arg_1) as String);
            };
            if (_local_2 == null){
                _local_2 = _arg_1;
            };
            return (_local_2);
        }
        private function getRoomObjectOriginalName(_arg_1:String):String
        {
            var _local_2:String;
            if (this._SafeStr_13308 != null){
                _local_2 = (this._SafeStr_13308.getValue(_arg_1) as String);
            };
            if (_local_2 == null){
                _local_2 = _arg_1;
            };
            return (_local_2);
        }
        public function getObjectCategory(_arg_1:String):int
        {
            if (_arg_1 == null){
                return (RoomObjectCategoryEnum._SafeStr_4962);
            };
            if (this._SafeStr_13300[_arg_1] != null){
                return (RoomObjectCategoryEnum._SafeStr_4329);
            };
            if (this._wallItems[_arg_1] != null){
                return (RoomObjectCategoryEnum._SafeStr_4330);
            };
            if (this._pets[_arg_1] != null){
                return (RoomObjectCategoryEnum.OBJECT_CATEGORY_USER);
            };
            if (_arg_1.indexOf("poster") == 0){
                return (RoomObjectCategoryEnum._SafeStr_4330);
            };
            if (((!((this._SafeStr_13304 == null))) && ((((this._SafeStr_13304.type == _arg_1)) || (this._SafeStr_13304.hasWorldType(_arg_1)))))){
                return (RoomObjectCategoryEnum._SafeStr_13133);
            };
            if (_arg_1 == "room"){
                return (RoomObjectCategoryEnum._SafeStr_13133);
            };
            if (_arg_1 == "user"){
                return (RoomObjectCategoryEnum.OBJECT_CATEGORY_USER);
            };
            if (_arg_1 == "pet"){
                return (RoomObjectCategoryEnum.OBJECT_CATEGORY_USER);
            };
            if (_arg_1 == "bot"){
                return (RoomObjectCategoryEnum.OBJECT_CATEGORY_USER);
            };
            if ((((_arg_1 == "tile_cursor")) || ((_arg_1 == "selection_arrow")))){
                return (RoomObjectCategoryEnum._SafeStr_13134);
            };
            return (RoomObjectCategoryEnum._SafeStr_4962);
        }
        public function getPlaceHolderType(_arg_1:String):String
        {
            if (this._SafeStr_13300[_arg_1] != null){
                return (_SafeStr_13288);
            };
            if (this._wallItems[_arg_1] != null){
                return (_SafeStr_13289);
            };
            if (this._pets[_arg_1] != null){
                return (_SafeStr_13290);
            };
            if (((!((this._SafeStr_13304 == null))) && ((((this._SafeStr_13304.type == _arg_1)) || (this._SafeStr_13304.hasWorldType(_arg_1)))))){
                return (_SafeStr_13291);
            };
            return (PLACE_HOLDER_DEFAULT);
        }
        public function getPlaceHolderTypes():Array
        {
            return ([_SafeStr_13288, _SafeStr_13289, _SafeStr_13290, _SafeStr_13291, TILE_CURSOR, _SafeStr_13292]);
        }
        public function getActiveObjectType(_arg_1:int):String
        {
            var _local_2:String = (this._SafeStr_13299.getValue(_arg_1) as String);
            return (this.getObjectType(_local_2));
        }
        public function getWallItemType(_arg_1:int, _arg_2:String=null):String
        {
            var _local_3:String = (this._SafeStr_13301.getValue(_arg_1) as String);
            if ((((_local_3 == "poster")) && (!((_arg_2 == null))))){
                _local_3 = (_local_3 + _arg_2);
            };
            return (this.getObjectType(_local_3));
        }
        public function getPetType(_arg_1:int):String
        {
            return ((this._SafeStr_13302.getValue(_arg_1) as String));
        }
        public function getPetColor(_arg_1:int, _arg_2:int):PetColorResult
        {
            var _local_3:Map = this._SafeStr_13303[_arg_1];
            if (_local_3 != null){
                return ((_local_3[_arg_2] as PetColorResult));
            };
            return (null);
        }
        public function getActiveObjectColorIndex(_arg_1:int):int
        {
            var _local_2:String = (this._SafeStr_13299.getValue(_arg_1) as String);
            return (this.getObjectColorIndex(_local_2));
        }
        public function getWallItemColorIndex(_arg_1:int):int
        {
            var _local_2:String = (this._SafeStr_13301.getValue(_arg_1) as String);
            return (this.getObjectColorIndex(_local_2));
        }
        public function getRoomObjectAdURL(_arg_1:String):String
        {
            if (this._SafeStr_13309.getValue(_arg_1) != null){
                return (this._SafeStr_13309.getValue(_arg_1));
            };
            return ("");
        }
        private function getObjectType(_arg_1:String):String
        {
            if (_arg_1 == null){
                return (null);
            };
            var _local_2:int = _arg_1.indexOf("*");
            if (_local_2 >= 0){
                _arg_1 = _arg_1.substr(0, _local_2);
            };
            return (_arg_1);
        }
        private function getObjectColorIndex(_arg_1:String):int
        {
            if (_arg_1 == null){
                return (-1);
            };
            var _local_2:int;
            var _local_3:int = _arg_1.indexOf("*");
            if (_local_3 >= 0){
                _local_2 = int(_arg_1.substr((_local_3 + 1)));
            };
            return (_local_2);
        }
        public function getContentType(_arg_1:String):String
        {
            return (_arg_1);
        }
        public function getPublicRoomContentType(_arg_1:String):String
        {
            if (((!((this._SafeStr_13304 == null))) && (this._SafeStr_13304.hasWorldType((RCL_PUBLICROOM_ + _arg_1))))){
                return (this._SafeStr_13304.type);
            };
            return (_arg_1);
        }
        public function hasInternalContent(_arg_1:String):Boolean
        {
            if ((((((_arg_1 == RoomObjectVisualizationEnum._SafeStr_13040)) || ((_arg_1 == RoomObjectVisualizationEnum._SafeStr_6769)))) || ((_arg_1 == RoomObjectVisualizationEnum.BOT)))){
                return (true);
            };
            return (false);
        }
        private function getObjectRevision(_arg_1:String):int
        {
            var _local_3:int;
            var _local_2:int = this.getObjectCategory(_arg_1);
            if ((((_local_2 == RoomObjectCategoryEnum._SafeStr_4329)) || ((_local_2 == RoomObjectCategoryEnum._SafeStr_4330)))){
                if (_arg_1.indexOf("poster") == 0){
                    _arg_1 = "poster";
                };
                return (this._SafeStr_13306.getValue(_arg_1));
            };
            return (0);
        }
        private function getObjectContentURLs(_arg_1:String):Array
        {
            var _local_2:String;
            var _local_3:int;
            var _local_4:String;
            var _local_5:String;
            var _local_6:int;
            var _local_7:Array;
            var _local_8:Array;
            var _local_9:int;
            var _local_10:String;
            _local_2 = this.getContentType(_arg_1);
            switch (_local_2){
                case _SafeStr_13288:
                    return (["PlaceHolderFurniture.swf"]);
                case _SafeStr_13289:
                    return (["PlaceHolderWallItem.swf"]);
                case _SafeStr_13290:
                    return (["PlaceHolderPet.swf"]);
                case _SafeStr_13291:
                    return (["HabboRoomContent.swf"]);
                case TILE_CURSOR:
                    return (["TileCursor.swf"]);
                case _SafeStr_13292:
                    return (["SelectionArrow.swf"]);
                default:
                    _local_3 = this.getObjectCategory(_local_2);
                    if ((((_local_3 == RoomObjectCategoryEnum._SafeStr_4329)) || ((_local_3 == RoomObjectCategoryEnum._SafeStr_4330)))){
                        _local_4 = this.getRoomObjectAlias(_local_2);
                        _local_5 = this._SafeStr_13311;
                        _local_5 = _local_5.replace(/%typeid%/, _local_4);
                        _local_6 = this.getObjectRevision(_local_2);
                        _local_5 = _local_5.replace(/%revision%/, _local_6);
                        return ([(this._SafeStr_13310 + _local_5)]);
                    };
                    if (_local_3 == RoomObjectCategoryEnum.OBJECT_CATEGORY_USER){
                        return ([(_local_2 + ".swf")]);
                    };
                    _local_7 = _local_2.split(",");
                    _local_8 = [];
                    _local_9 = 0;
                    while (_local_9 < _local_7.length) {
                        _local_10 = this._publicRoomLoadNameTemplate;
                        _local_10 = _local_10.replace(/%typeid%/, _local_7[_local_9]);
                        _local_8.push((this._publicRoomLoadUrlBase + _local_10));
                        _local_9++;
                    };
                    return (_local_8);
            };
        }
        public function insertObjectContent(_arg_1:int, _arg_2:int, _arg_3:IAssetLibrary):Boolean
        {
            var _local_6:Event;
            var _local_7:IEventDispatcher;
            var _local_4:String = this.getAssetLibraryType(_arg_3);
            switch (_arg_2){
                case RoomObjectCategoryEnum._SafeStr_4329:
                    this._SafeStr_13299[_arg_1] = _local_4;
                    break;
                case RoomObjectCategoryEnum._SafeStr_4330:
                    this._SafeStr_13301[_arg_1] = _local_4;
                    break;
                default:
                    throw (new Error((("Registering content library for unsupported category " + _arg_2) + "!")));
            };
            var _local_5:AssetLibraryCollection = (this.addAssetLibraryCollection(_local_4, null) as AssetLibraryCollection);
            if (_local_5){
                _local_5.addAssetLibrary(_arg_3);
                if (this.initializeGraphicAssetCollection(_local_4, _arg_3)){
                    switch (_arg_2){
                        case RoomObjectCategoryEnum._SafeStr_4329:
                            if (this._SafeStr_13300[_local_4] == null){
                                this._SafeStr_13300[_local_4] = 1;
                            };
                            break;
                        case RoomObjectCategoryEnum._SafeStr_4330:
                            if (this._wallItems[_local_4] == null){
                                this._wallItems[_local_4] = 1;
                            };
                            break;
                        default:
                            throw (new Error((("Registering content library for unsupported category " + _arg_2) + "!")));
                    };
                    _local_6 = new RoomContentLoadedEvent(RoomContentLoadedEvent.RCLE_SUCCESS, _local_4);
                    _local_7 = this.getAssetLibraryEventDispatcher(_local_4, true);
                    if (_local_7){
                        _local_7.dispatchEvent(_local_6);
                    };
                    return (true);
                };
            };
            return (false);
        }
        public function loadObjectContent(_arg_1:String, _arg_2:IEventDispatcher):Boolean
        {
            var _local_5:Array;
            var _local_6:int;
            var _local_7:LibraryLoader;
            var _local_8:String;
            var _local_3:String;
            if (((_arg_1) && ((_arg_1.indexOf(",") >= 0)))){
                _local_3 = _arg_1;
                _arg_1 = _local_3.split(",")[0];
            };
            if (this._SafeStr_13305.getValue(_arg_1) != null){
                this._SafeStr_13304 = (this._SafeStr_13305.getValue(_arg_1) as PublicRoomData);
            };
            if (((!((this.getAssetLibrary(_arg_1) == null))) || (!((this.getAssetLibraryEventDispatcher(_arg_1) == null))))){
                return (false);
            };
            var _local_4:AssetLibraryCollection = (this.addAssetLibraryCollection(_arg_1, _arg_2) as AssetLibraryCollection);
            if (_local_4 == null){
                return (false);
            };
            if (_local_3 != null){
                _local_5 = this.getObjectContentURLs(_local_3);
            }
            else {
                _local_5 = this.getObjectContentURLs(_arg_1);
            };
            if (((!((_local_5 == null))) && ((_local_5.length > 0)))){
                _local_4.addEventListener(AssetLibrary._SafeStr_8758, this.onContentLoaded);
                _local_6 = 0;
                while (_local_6 < _local_5.length) {
                    _local_7 = new LibraryLoader();
                    _local_8 = _local_5[_local_6];
                    _local_7.load(new URLRequest(_local_8));
                    _local_4.loadFromFile(_local_7, true);
                    _local_7.addEventListener(LibraryLoaderEvent.LIBRARY_LOADER_EVENT_ERROR, this.onContentLoadError);
                    _local_6++;
                };
                return (true);
            };
            return (false);
        }
        public function loadLegacyContent(_arg_1:String, _arg_2:IEventDispatcher):Array
        {
            var _local_6:String;
            var _local_7:String;
            var _local_3:Array = _arg_1.split(",");
            var _local_4:Array = new Array();
            var _local_5:int;
            while (_local_5 < _local_3.length) {
                if ((((_local_3[_local_5].toString().length > 0)) && ((this._SafeStr_13312.indexOf(_local_3[_local_5]) == -1)))){
                    _local_6 = _local_3[_local_5].toString();
                    while (_local_6.indexOf(" ") >= 0) {
                        if (_local_6.indexOf(" ") == 0){
                            _local_6 = _local_6.substr(1, (_local_6.length - 1));
                        }
                        else {
                            if (_local_6.indexOf(" ") == (_local_6.length - 1)){
                                _local_6 = _local_6.substr(0, (_local_6.length - 2));
                            };
                        };
                    };
                    _local_4.push(_local_6);
                };
                _local_5++;
            };
            if (_local_4.length > 0){
                _local_7 = _local_4[0];
                _local_5 = 1;
                while (_local_5 < _local_4.length) {
                    _local_7 = (_local_7 + ",");
                    _local_7 = (_local_7 + _local_4[_local_5]);
                    _local_5++;
                };
                if (this.loadObjectContent(_local_7, _arg_2)){
                    return ([_local_4[0]]);
                };
            };
            return ([]);
        }
        private function onContentLoadError(_arg_1:Event):void
        {
            var _local_4:String;
            var _local_5:Array;
            var _local_2:LibraryLoader = LibraryLoader(_arg_1.target);
            var _local_3:Array = this.getPlaceHolderTypes();
            for each (_local_4 in _local_3) {
                _local_5 = this.getObjectContentURLs(_local_4);
                if ((((((_local_5.length > 0)) && (!((_local_2.url == null))))) && ((_local_2.url.indexOf(_local_5[0]) == 0)))){
                    Core.crash(("Failed to load asset: " + _local_2.url), Core._SafeStr_9852);
                    return;
                };
            };
        }
        private function onContentLoaded(_arg_1:Event):void
        {
            if (this.disposed){
                return;
            };
            var _local_2:IAssetLibrary = (_arg_1.target as IAssetLibrary);
            if (_local_2 == null){
                return;
            };
            var _local_3:RoomContentLoadedEvent;
            var _local_4:Boolean;
            var _local_5:String = this.getAssetLibraryType(_local_2);
            _local_5 = this.getRoomObjectOriginalName(_local_5);
            if (_local_5 != null){
                _local_4 = this.initializeGraphicAssetCollection(_local_5, _local_2);
            };
            if (_local_4){
                if (this._SafeStr_13313.indexOf(this.getVisualizationType(_local_5)) >= 0){
                    this.extractPublicRoomDataFromLoadedContent(_local_5, _local_2);
                }
                else {
                    if (this._pets[_local_5] != null){
                        this.extractPetDataFromLoadedContent(_local_5);
                    };
                };
                _local_3 = new RoomContentLoadedEvent(RoomContentLoadedEvent.RCLE_SUCCESS, _local_5);
            }
            else {
                _local_3 = new RoomContentLoadedEvent(RoomContentLoadedEvent.RCLE_FAILURE, _local_5);
            };
            var _local_6:IEventDispatcher = this.getAssetLibraryEventDispatcher(_local_5, true);
            if (((!((_local_6 == null))) && (!((_local_3 == null))))){
                _local_6.dispatchEvent(_local_3);
            };
        }
        private function extractPetDataFromLoadedContent(_arg_1:String):void
        {
            var _local_3:Map;
            var _local_4:Array;
            var _local_5:String;
            var _local_6:int;
            var _local_7:Array;
            var _local_2:IGraphicAssetCollection = this.getGraphicAssetCollection(_arg_1);
            if (_local_2 != null){
                _local_3 = new Map();
                _local_4 = _local_2.getPaletteNames();
                for each (_local_5 in _local_4) {
                    _local_7 = _local_2.getPaletteColors(_local_5);
                    if (((!((_local_7 == null))) && ((_local_7.length >= 2)))){
                        _local_3.add(_local_5, new PetColorResult(_local_7[0], _local_7[1]));
                    };
                };
                _local_6 = this._pets[_arg_1];
                this._SafeStr_13303.add(_local_6, _local_3);
            };
        }
        private function extractPublicRoomDataFromLoadedContent(_arg_1:String, _arg_2:IAssetLibrary):void
        {
            var _local_3:XML = this.getVisualizationXML(_arg_1);
            var _local_4:PublicRoomData = this.extractPublicRoomFromXML(_arg_1, _local_3);
            this._SafeStr_13305.add(_arg_1, _local_4);
            this._SafeStr_13304 = _local_4;
            this.extractPublicRoomFurniture(_arg_1, _arg_2);
        }
        private function extractPublicRoomFurniture(_arg_1:String, _arg_2:IAssetLibrary):int
        {
            var _local_6:String;
            var _local_7:String;
            if (_arg_2 == null){
                return (0);
            };
            var _local_3:Array = _arg_2.nameArray;
            var _local_4:int;
            var _local_5:int;
            while (_local_5 < _local_3.length) {
                _local_6 = _local_3[_local_5];
                if (_local_6.indexOf("_index") > 0){
                    _local_7 = _local_6.slice(0, _local_6.indexOf("_index"));
                    if (this.extractObjectContent(_arg_1, _local_7)){
                        _local_4++;
                    };
                };
                _local_5++;
            };
            return (_local_4);
        }
        private function initializeGraphicAssetCollection(_arg_1:String, _arg_2:IAssetLibrary):Boolean
        {
            var _local_5:XML;
            if ((((_arg_1 == null)) || ((_arg_2 == null)))){
                return (false);
            };
            var _local_3:Boolean;
            var _local_4:IGraphicAssetCollection = this.createGraphicAssetCollection(_arg_1, _arg_2);
            if (_local_4 != null){
                _local_5 = this.getAssetXML(_arg_1);
                if (_local_4.define(_local_5)){
                    _local_3 = true;
                }
                else {
                    this.disposeGraphicAssetCollection(_arg_1);
                };
            };
            return (_local_3);
        }
        public function extractObjectContent(_arg_1:String, _arg_2:String):Boolean
        {
            var _local_3:IAssetLibrary = this.getAssetLibrary(_arg_1);
            this._SafeStr_13294.add(_arg_2, _arg_1);
            if (this.initializeGraphicAssetCollection(_arg_2, _local_3)){
                return (true);
            };
            this._SafeStr_13294.remove(_arg_2);
            return (false);
        }
        private function getAssetLibraryName(_arg_1:String):String
        {
            return (("RoomContentLoader " + _arg_1));
        }
        private function getAssetLibrary(_arg_1:String):IAssetLibrary
        {
            var _local_4:String;
            var _local_2:String = this.getContentType(_arg_1);
            _local_2 = this.getRoomObjectOriginalName(_local_2);
            var _local_3:IAssetLibrary = (this._SafeStr_13293.getValue(this.getAssetLibraryName(_local_2)) as IAssetLibrary);
            if (_local_3 == null){
                _local_4 = this._SafeStr_13294.getValue(_local_2);
                if (_local_4 != null){
                    _local_2 = this.getContentType(_local_4);
                    _local_3 = (this._SafeStr_13293.getValue(this.getAssetLibraryName(_local_2)) as IAssetLibrary);
                };
            };
            return (_local_3);
        }
        private function addAssetLibraryCollection(_arg_1:String, _arg_2:IEventDispatcher):IAssetLibrary
        {
            var _local_3:String = this.getContentType(_arg_1);
            var _local_4:IAssetLibrary = this.getAssetLibrary(_arg_1);
            if (_local_4 != null){
                return (_local_4);
            };
            var _local_5:String = this.getAssetLibraryName(_local_3);
            _local_4 = new AssetLibraryCollection(_local_5);
            this._SafeStr_13293.add(_local_5, _local_4);
            if (((!((_arg_2 == null))) && ((this.getAssetLibraryEventDispatcher(_arg_1) == null)))){
                this._events.add(_local_3, _arg_2);
            };
            return (_local_4);
        }
        private function getAssetLibraryEventDispatcher(_arg_1:String, _arg_2:Boolean=false):IEventDispatcher
        {
            var _local_3:String = this.getContentType(_arg_1);
            if (!_arg_2){
                return (this._events.getValue(_local_3));
            };
            return (this._events.remove(_local_3));
        }
        private function getAssetLibraryType(_arg_1:IAssetLibrary):String
        {
            if (_arg_1 == null){
                return (null);
            };
            var _local_2:IAsset = _arg_1.getAssetByName("index");
            if (_local_2 == null){
                return (null);
            };
            var _local_3:XML = (_local_2.content as XML);
            if (_local_3 == null){
                return (null);
            };
            return (_local_3.@type);
        }
        public function getVisualizationType(_arg_1:String):String
        {
            if (_arg_1 == null){
                return (null);
            };
            var _local_2:IAssetLibrary = this.getAssetLibrary(_arg_1);
            if (_local_2 == null){
                return (null);
            };
            var _local_3:IAsset = _local_2.getAssetByName((_arg_1 + "_index"));
            if (_local_3 == null){
                _local_3 = _local_2.getAssetByName("index");
            };
            if (_local_3 == null){
                return (null);
            };
            var _local_4:XML = (_local_3.content as XML);
            if (_local_4 == null){
                return (null);
            };
            return (_local_4.@visualization);
        }
        public function getLogicType(_arg_1:String):String
        {
            if (_arg_1 == null){
                return (null);
            };
            var _local_2:IAssetLibrary = this.getAssetLibrary(_arg_1);
            if (_local_2 == null){
                return (null);
            };
            var _local_3:IAsset = _local_2.getAssetByName((_arg_1 + "_index"));
            if (_local_3 == null){
                _local_3 = _local_2.getAssetByName("index");
            };
            if (_local_3 == null){
                return (null);
            };
            var _local_4:XML = (_local_3.content as XML);
            if (_local_4 == null){
                return (null);
            };
            return (_local_4.@logic);
        }
        public function getVisualizationXML(_arg_1:String):XML
        {
            return (this.getXML(_arg_1, "_visualization"));
        }
        public function getAssetXML(_arg_1:String):XML
        {
            return (this.getXML(_arg_1, "_assets"));
        }
        public function getLogicXML(_arg_1:String):XML
        {
            return (this.getXML(_arg_1, "_logic"));
        }
        private function getXML(_arg_1:String, _arg_2:String):XML
        {
            var _local_3:IAssetLibrary = this.getAssetLibrary(_arg_1);
            if (_local_3 == null){
                return (null);
            };
            var _local_4:String = this.getContentType(_arg_1);
            var _local_5:String = this.getRoomObjectAlias(_local_4);
            var _local_6:IAsset = _local_3.getAssetByName((_local_5 + _arg_2));
            if (_local_6 == null){
                return (null);
            };
            var _local_7:XML = (_local_6.content as XML);
            if (_local_7 == null){
                return (null);
            };
            return (_local_7);
        }
        public function addGraphicAsset(_arg_1:String, _arg_2:String, _arg_3:BitmapData, _arg_4:Boolean):Boolean
        {
            var _local_5:IGraphicAssetCollection = this.getGraphicAssetCollection(_arg_1);
            if (_local_5 != null){
                return (_local_5.addAsset(_arg_2, _arg_3, _arg_4));
            };
            return (false);
        }
        private function createGraphicAssetCollection(_arg_1:String, _arg_2:IAssetLibrary):IGraphicAssetCollection
        {
            var _local_3:IGraphicAssetCollection = this.getGraphicAssetCollection(_arg_1);
            if (_local_3 != null){
                return (_local_3);
            };
            if (_arg_2 == null){
                return (null);
            };
            _local_3 = this._visualizationFactory.createGraphicAssetCollection();
            if (_local_3 != null){
                _local_3.assetLibrary = _arg_2;
                this._SafeStr_13295.add(_arg_1, _local_3);
            };
            return (_local_3);
        }
        public function getGraphicAssetCollection(_arg_1:String):IGraphicAssetCollection
        {
            var _local_2:String = this.getContentType(_arg_1);
            return ((this._SafeStr_13295.getValue(_local_2) as IGraphicAssetCollection));
        }
        private function disposeGraphicAssetCollection(_arg_1:String):Boolean
        {
            var _local_3:IGraphicAssetCollection;
            var _local_2:String = this.getContentType(_arg_1);
            if (this._SafeStr_13295[_local_2] != null){
                _local_3 = this._SafeStr_13295.remove(_local_2);
                if (_local_3 != null){
                    _local_3.dispose();
                };
                return (true);
            };
            return (false);
        }
        private function extractPublicRoomFromXML(_arg_1:String, _arg_2:XML):PublicRoomData
        {
            var _local_6:XML;
            var _local_7:String;
            var _local_8:Number;
            var _local_9:Number;
            var _local_3:XMLList = _arg_2.layoutData;
            var _local_4:PublicRoomData = new PublicRoomData(_arg_1);
            var _local_5:int;
            while (_local_5 < _local_3.length()) {
                _local_6 = _local_3[_local_5];
                _local_7 = (RCL_PUBLICROOM_ + String(_local_6.@name));
                _local_8 = 32;
                _local_9 = 1;
                if (String(_local_6.@size) != ""){
                    _local_8 = parseInt(_local_6.@size);
                };
                if (String(_local_6.@heightScale) != ""){
                    _local_9 = parseFloat(_local_6.@heightScale);
                };
                _local_4.addWorld(_local_7, _local_8, _local_9);
                _local_5++;
            };
            return (_local_4);
        }
        public function isPublicRoomWorldType(_arg_1:String):Boolean
        {
            if (this.getObjectCategory((RCL_PUBLICROOM_ + _arg_1)) == RoomObjectCategoryEnum._SafeStr_13133){
                return (true);
            };
            return (false);
        }
        public function getPublicRoomWorldHeightScale(_arg_1:String):Number
        {
            if (this._SafeStr_13304 != null){
                return (this._SafeStr_13304.getWorldHeightScale((RCL_PUBLICROOM_ + _arg_1)));
            };
            return (1);
        }
        public function getPublicRoomWorldSize(_arg_1:String):int
        {
            if (this._SafeStr_13304 != null){
                return (this._SafeStr_13304.getWorldScale((RCL_PUBLICROOM_ + _arg_1)));
            };
            return (32);
        }
        public function furniDataReady():void
        {
            this.initFurnitureData();
        }
        public function setActiveObjectType(_arg_1:int, _arg_2:String):void
        {
            this._SafeStr_13299.remove(_arg_1);
            this._SafeStr_13299.add(_arg_1, _arg_2);
        }

    }
}//package com.sulake.habbo.room

// onContentLoadError = "_-2TD" (String#6628, DoABC#2)
// getPetColor = "_-0Ef" (String#3842, DoABC#2)
// ISessionDataManager = "_-Bk" (String#7907, DoABC#2)
// IFurnitureData = "_-pe" (String#8701, DoABC#2)
// _SafeStr_13040 = "_-0u9" (String#16210, DoABC#2)
// _SafeStr_13133 = "_-2xl" (String#21386, DoABC#2)
// _SafeStr_13134 = "_-VH" (String#23461, DoABC#2)
// createGraphicAssetCollection = "_-Ba" (String#2071, DoABC#2)
// addWorld = "_-1uk" (String#18747, DoABC#2)
// hasWorldType = "_-0E2" (String#14609, DoABC#2)
// getWorldScale = "_-2bc" (String#20509, DoABC#2)
// getWorldHeightScale = "_-cl" (String#23744, DoABC#2)
// setRoomObjectAlias = "_-3Kt" (String#7720, DoABC#2)
// RCL_LOADER_READY = "_-1Df" (String#17010, DoABC#2)
// RCL_PUBLICROOM_ = "_-27y" (String#19328, DoABC#2)
// _SafeStr_13287 = "_-0Sq" (String#15163, DoABC#2)
// _SafeStr_13288 = "_-2xK" (String#21363, DoABC#2)
// _SafeStr_13289 = "_-0da" (String#15568, DoABC#2)
// _SafeStr_13290 = "_-3Ay" (String#21918, DoABC#2)
// _SafeStr_13291 = "_-0FU" (String#14665, DoABC#2)
// _SafeStr_13292 = "_-2fm" (String#20683, DoABC#2)
// _SafeStr_13293 = "_-1I-" (String#17192, DoABC#2)
// _SafeStr_13294 = "_-1Er" (String#17064, DoABC#2)
// _SafeStr_13295 = "_-1zQ" (String#18944, DoABC#2)
// _visualizationFactory = "_-fh" (String#2154, DoABC#2)
// _SafeStr_13297 = "_-1tq" (String#18711, DoABC#2)
// _SafeStr_13298 = "_-0LC" (String#14881, DoABC#2)
// _SafeStr_13299 = "_-1kM" (String#18304, DoABC#2)
// _SafeStr_13300 = "var" (String#47165, DoABC#2)
// _SafeStr_13301 = "_-0j2" (String#15793, DoABC#2)
// _SafeStr_13302 = "_-2pf" (String#21066, DoABC#2)
// _SafeStr_13303 = "_-2iC" (String#20779, DoABC#2)
// _SafeStr_13304 = "_-0qC" (String#16057, DoABC#2)
// _SafeStr_13305 = "_-02X" (String#14143, DoABC#2)
// _SafeStr_13306 = "_-29E" (String#19374, DoABC#2)
// _SafeStr_13307 = "_-0Ue" (String#15230, DoABC#2)
// _SafeStr_13308 = "_-0SX" (String#15155, DoABC#2)
// _SafeStr_13309 = "_-174" (String#16738, DoABC#2)
// _SafeStr_13310 = "_-P7" (String#23211, DoABC#2)
// _SafeStr_13311 = "_-2u4" (String#21242, DoABC#2)
// _SafeStr_13312 = "_-3GR" (String#22140, DoABC#2)
// _SafeStr_13313 = "_-2U3" (String#20202, DoABC#2)
// _SafeStr_13314 = "_-3Ag" (String#21908, DoABC#2)
// initPetData = "_-0na" (String#15959, DoABC#2)
// initFurnitureData = "_-1G9" (String#17121, DoABC#2)
// visualizationFactory = "_-2q6" (String#21085, DoABC#2)
// getFurniData = "_-07h" (String#3715, DoABC#2)
// populateFurniData = "_-0Qu" (String#15098, DoABC#2)
// continueInitilization = "_-1Lp" (String#17349, DoABC#2)
// getRoomObjectAlias = "_-0Xu" (String#15351, DoABC#2)
// getRoomObjectOriginalName = "_-K9" (String#23012, DoABC#2)
// getObjectCategory = "_-3LR" (String#22345, DoABC#2)
// getPlaceHolderType = "_-0dn" (String#4388, DoABC#2)
// getActiveObjectType = "_-0em" (String#15616, DoABC#2)
// getObjectType = "_-0d7" (String#15554, DoABC#2)
// getActiveObjectColorIndex = "_-1IK" (String#17208, DoABC#2)
// getObjectColorIndex = "_-1ma" (String#18404, DoABC#2)
// getWallItemColorIndex = "_-263" (String#6163, DoABC#2)
// getRoomObjectAdURL = "_-0se" (String#4700, DoABC#2)
// getContentType = "_-0mQ" (String#4557, DoABC#2)
// getPublicRoomContentType = "_-0ta" (String#16183, DoABC#2)
// hasInternalContent = "_-21J" (String#6071, DoABC#2)
// getObjectRevision = "_-2AG" (String#19414, DoABC#2)
// getObjectContentURLs = "_-1dR" (String#18033, DoABC#2)
// insertObjectContent = "_-Vs" (String#8317, DoABC#2)
// getAssetLibraryType = "_-0op" (String#16004, DoABC#2)
// addAssetLibraryCollection = "_-0sK" (String#16136, DoABC#2)
// initializeGraphicAssetCollection = "_-fn" (String#23880, DoABC#2)
// getAssetLibraryEventDispatcher = "_-3AH" (String#21893, DoABC#2)
// loadObjectContent = "_-1ZT" (String#5553, DoABC#2)
// getAssetLibrary = "_-b9" (String#23674, DoABC#2)
// onContentLoaded = "_-0mw" (String#4565, DoABC#2)
// loadLegacyContent = "_-1nL" (String#18438, DoABC#2)
// getVisualizationType = "_-1HN" (String#5197, DoABC#2)
// extractPublicRoomDataFromLoadedContent = "_-35H" (String#21704, DoABC#2)
// extractPetDataFromLoadedContent = "_-0ow" (String#16009, DoABC#2)
// getGraphicAssetCollection = "_-0bl" (String#4341, DoABC#2)
// getPaletteNames = "_-113" (String#4896, DoABC#2)
// getPaletteColors = "_-1mh" (String#5793, DoABC#2)
// getVisualizationXML = "_-Np" (String#8161, DoABC#2)
// extractPublicRoomFromXML = "_-0J2" (String#14802, DoABC#2)
// extractPublicRoomFurniture = "_-1wp" (String#18837, DoABC#2)
// extractObjectContent = "_-2Ar" (String#19436, DoABC#2)
// define = "_-19s" (String#5075, DoABC#2)
// disposeGraphicAssetCollection = "_-2Q4" (String#20046, DoABC#2)
// getAssetLibraryName = "_-2th" (String#21229, DoABC#2)
// getLogicType = "_-3CB" (String#7555, DoABC#2)
// getLogicXML = "_-3P" (String#7733, DoABC#2)
// addGraphicAsset = "_-1ul" (String#18748, DoABC#2)
// isPublicRoomWorldType = "_-G6" (String#7996, DoABC#2)
// getPublicRoomWorldHeightScale = "_-0KP" (String#14855, DoABC#2)
// getPublicRoomWorldSize = "_-1ld" (String#18360, DoABC#2)
// setActiveObjectType = "_-ep" (String#23837, DoABC#2)
// AssetLibraryCollection = "_-2Pg" (String#6555, DoABC#2)
// IRoomContentLoader = "_-6z" (String#7806, DoABC#2)
// RoomContentLoadedEvent = "_-0sn" (String#16153, DoABC#2)
// IGraphicAssetCollection = "_-24o" (String#6134, DoABC#2)
// RoomObjectVisualizationEnum = "_-0hb" (String#4459, DoABC#2)
// PetColorResult = "_-06Y" (String#3693, DoABC#2)
// IFurniDataListener = "_-02J" (String#3612, DoABC#2)
// RoomContentLoader = "_-22f" (String#6100, DoABC#2)
// IDisposable = "_-0dY" (String#4382, DoABC#2)
// PublicRoomData = "_-3Dv" (String#920, DoABC#2)
// _SafeStr_4329 = "_-bN" (String#23687, DoABC#2)
// _SafeStr_4330 = "_-0cQ" (String#15531, DoABC#2)
// _disposed = "_-6m" (String#31, DoABC#2)
// getXML = "_-2Oe" (String#6532, DoABC#2)
// _SafeStr_4962 = "_-1WC" (String#17750, DoABC#2)
// sessionDataManager = "_-0pX" (String#4623, DoABC#2)
// getAssetXML = "_-1XT" (String#364, DoABC#2)
// _SafeStr_5891 = "_-1Ny" (String#852, DoABC#2)
// _SafeStr_6769 = "_-1Y9" (String#17821, DoABC#2)
// LibraryLoader = "_-T1" (String#8267, DoABC#2)
// RCLE_SUCCESS = "_-2gW" (String#20711, DoABC#2)
// RCLE_FAILURE = "_-2Qp" (String#20081, DoABC#2)
// getPetType = "_-1qN" (String#867, DoABC#2)
// getWallItemType = "_-0BC" (String#3783, DoABC#2)
// _SafeStr_7894 = "_-2EZ" (String#1840, DoABC#2)
// IRoomObjectVisualizationFactory = "_-T7" (String#8269, DoABC#2)
// colourIndex = "_-1Ye" (String#5534, DoABC#2)
// adUrl = "_-0pg" (String#4626, DoABC#2)
// furniDataReady = "_-1V2" (String#5456, DoABC#2)
// RoomObjectCategoryEnum = "_-1eh" (String#5639, DoABC#2)
// _sessionDataManager = "_-0kq" (String#149, DoABC#2)
// _SafeStr_8758 = "_-2H5" (String#19688, DoABC#2)
// addAssetLibrary = "_-1xU" (String#18869, DoABC#2)
// crash = "_-1--" (String#16429, DoABC#2)
// _SafeStr_9852 = "_-5s" (String#22458, DoABC#2)


