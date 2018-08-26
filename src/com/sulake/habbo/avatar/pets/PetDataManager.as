
package com.sulake.habbo.avatar.pets
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.core.utils.Map;
    import com.sulake.core.assets.AssetLibraryCollection;
    import com.sulake.habbo.avatar.AvatarRenderManager;
    import com.sulake.core.utils.LibraryLoader;
    import com.sulake.core.utils.LibraryLoaderEvent;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.habbo.avatar.enum.AvatarScaleType;
    import flash.net.URLRequest;
    import flash.events.Event;

    public class PetDataManager implements IPetDataManager, IDisposable 
    {

        private var _species:Map;
        private var _assets:AssetLibraryCollection;
        private var _SafeStr_8865:Array;
        private var _SafeStr_8954:Array;
        private var _RoomInstance:AvatarRenderManager;
        private var _SafeStr_10023:Map;
        private var _SafeStr_10024:Array;
        private var _disposed:Boolean = false;

        public function PetDataManager(_arg_1:AvatarRenderManager, _arg_2:AssetLibraryCollection)
        {
            this._species = new Map();
            this._SafeStr_8865 = [];
            this._RoomInstance = _arg_1;
            this._SafeStr_8954 = [];
            this._assets = _arg_2;
            this._SafeStr_10023 = new Map();
            this._SafeStr_10024 = [];
        }
        public function get disposed():Boolean
        {
            return (this._disposed);
        }
        public function dispose():void
        {
            var _local_1:LibraryLoader;
            if (this._disposed){
                return;
            };
            this._assets = null;
            this._RoomInstance = null;
            this._SafeStr_8865 = null;
            this._species.dispose();
            this._species = null;
            if (this._SafeStr_8954 != null){
                for each (_local_1 in this._SafeStr_8954) {
                    _local_1.removeEventListener(LibraryLoaderEvent.LIBRARY_LOADER_EVENT_COMPLETE, this.onLoaderComplete);
                    _local_1.removeEventListener(LibraryLoaderEvent.LIBRARY_LOADER_EVENT_ERROR, this.onContentLoadError);
                };
            };
            this._SafeStr_8954 = null;
            this._SafeStr_10023.dispose();
            this._SafeStr_10023 = null;
            this._SafeStr_10024 = null;
            this._disposed = true;
        }
        public function reset():void
        {
            this.init();
        }
        public function init():void
        {
            var _local_2:XmlAsset;
            var _local_3:XML;
            var _local_4:int;
            var _local_1:Array = this._assets.getAssetsByName("petData");
            for each (_local_2 in _local_1) {
                if (_local_2 != null){
                    _local_3 = (_local_2.content as XML);
                    _local_4 = int(_local_3.@species);
                    if (this._species.getValue(_local_4) == null){
                        this._species.add(_local_4, new PetData(_local_3));
                    };
                };
            };
        }
        public function PetDataManager(_arg_1:IPetDataListener=null):void
        {
            if ((((_arg_1 == null)) || ((this._SafeStr_8865 == null)))){
                return;
            };
            var _local_2:int = this._SafeStr_8865.indexOf(_arg_1);
            if (_local_2 != -1){
                this._SafeStr_8865.splice(_local_2, 1);
            };
        }
        private function PetDataManager():void
        {
            var _local_1:IPetDataListener;
            while (this._SafeStr_8865.length > 0) {
                _local_1 = (this._SafeStr_8865.pop() as IPetDataListener);
                if (((!((_local_1 == null))) && (!(_local_1.disposed)))){
                    _local_1.petDataReady();
                };
            };
        }
        public function PetDataManager(_arg_1:int, _arg_2:IPetDataListener=null):IPetData
        {
            var _local_3:IPetData = (this._species.getValue(_arg_1) as IPetData);
            if (_local_3 == null){
                this.assetsReady(_arg_1, AvatarScaleType._SafeStr_4336, _arg_2);
            };
            return (_local_3);
        }
        public function PetDataManager(_arg_1:int, _arg_2:int, _arg_3:uint):String
        {
            if (this.disposed){
                return ("");
            };
            var _local_4:PetData = this._species.getValue(_arg_1);
            if (_local_4 == null){
                Logger.log(("Could not find Pet Data: " + _arg_1));
                return ("");
            };
            var _local_5:Breed = _local_4.findBreed(_arg_2);
            if (_local_5 == null){
                return ("");
            };
            var _local_6:String = _local_5.avatarFigureString;
            if (_local_6 == null){
                return ("");
            };
            var _local_7:PetColor = _local_4.findColor(_arg_3);
            if (_local_7 == null){
                return (_local_6);
            };
            var _local_8:Array = _local_6.split(".");
            return (_local_8.join((_local_7.figurePartPaletteColorId + ".")));
        }
        public function PetDataManager(figureData:XML):void
        {
            var targetSets:Array;
            var targetPalette:XML;
            var speciesKeys:Array;
            var key:int;
            var petData:PetData;
            var petColorData:PetColor;
            var breed:Breed;
            var colorValue:String;
            var color:XML;
            var colorId:int;
            var avatarFigureString:String;
            var targetSetName:String;
            var figureTargetSet:XML;
            var figurePart:XML;
            var setId:int;
            var figureSet:XML;
            targetSets = ["pbd", "phd", "ptl"];
            targetPalette = figureData.colors.palette.(@id == "1")[0];
            speciesKeys = this._species.getKeys();
            for each (key in speciesKeys) {
                petData = this._species.getValue(key);
                if (petData != null){
                    for each (petColorData in petData.colors) {
                        colorValue = petColorData.rgb.toString(16);
                        color = targetPalette.color.(text() == colorValue)[0];
                        if (color == null){
                            colorId = (targetPalette.children().length() + 1);
                            color = new (XML)((('<color club="0" selectable="1">' + colorValue) + "</color>"));
                            color.@id = colorId;
                            color.@index = colorId;
                            targetPalette.appendChild(color);
                        };
                        petColorData.figurePartPaletteColorId = parseInt(color.@id);
                    };
                    for each (breed in petData.breeds) {
                        avatarFigureString = "";
                        for each (targetSetName in targetSets) {
                            figureTargetSet = figureData.sets.settype.(@type == targetSetName)[0];
                            if (figureTargetSet == null){
                                Logger.log(("Could not find Figure Target Set for populating Pet Data: " + targetSetName));
                            }
                            else {
                                figurePart = figureTargetSet.set.part.(@id == petData.species).((hasOwnProperty("palettemapid")) && ((@palettemapid == breed.patternId)))[0];
                                if (figurePart == null){
                                };
                                setId = (figureTargetSet.children().length() + 1);
                                figureSet = <set gender="U" club="0" colorable="1" selectable="1"/>
                                ;
                                figureSet.@id = setId;
                                figurePart = <part colorable="1" colorindex="1" index="1"/>
                                ;
                                figurePart.@id = petData.species;
                                figurePart.@breed = breed.id;
                                figurePart.@type = targetSetName;
                                if (breed.patternId >= 0){
                                    figurePart.@palettemapid = breed.patternId;
                                };
                                figureSet.appendChild(figurePart);
                                figureTargetSet.appendChild(figureSet);
                                avatarFigureString = (avatarFigureString + ((((targetSetName + "-") + setId) + "-") + "."));
                            };
                        };
                        breed.avatarFigureString = avatarFigureString;
                    };
                };
            };
        }
        public function get species():Map
        {
            return (this._species);
        }
        public function assetsReady(_arg_1:int, _arg_2:String, _arg_3:IPetDataListener=null):Boolean
        {
            var _local_5:int;
            var _local_6:String;
            var _local_8:LibraryLoader;
            var _local_4:Array = [];
            switch (_arg_1){
                case 0:
                    _local_4.push("h_dog.swf");
                    break;
                case 1:
                    _local_4.push("h_dog.swf");
                    _local_4.push("h_cat.swf");
                    break;
                case 2:
                    _local_4.push("h_dog.swf");
                    _local_4.push("h_croco.swf");
                    break;
                case 3:
                    _local_4.push("h_terrier.swf");
                    break;
                case 4:
                    _local_4.push("h_bear.swf");
                    break;
                case 5:
                    _local_4.push("h_pig.swf");
                    break;
                case 6:
                    _local_4.push("h_lion.swf");
                    break;
                case 7:
                    _local_4.push("h_rhino.swf");
                    break;
            };
            if (_arg_2 == AvatarScaleType._SafeStr_4337){
                _local_5 = 0;
                while (_local_5 < _local_4.length) {
                    _local_4[_local_5] = ("s" + _local_4[_local_5]);
                    _local_5++;
                };
            };
            _local_4.push("pets_palettes.swf");
            var _local_7:Boolean = true;
            for each (_local_6 in _local_4) {
                if (this._SafeStr_10024.indexOf(_local_6) == -1){
                    _local_7 = false;
                    if (this._SafeStr_10023.getValue(_local_6) == null){
                        _local_8 = new LibraryLoader();
                        this._assets.loadFromFile(_local_8);
                        _local_8.addEventListener(LibraryLoaderEvent.LIBRARY_LOADER_EVENT_COMPLETE, this.onLoaderComplete);
                        _local_8.addEventListener(LibraryLoaderEvent.LIBRARY_LOADER_EVENT_ERROR, this.onContentLoadError);
                        _local_8.load(new URLRequest(_local_6));
                        this._SafeStr_8954.push(_local_8);
                        this._SafeStr_10023.add(_local_6, _local_8);
                        if (((!((_arg_3 == null))) && ((this._SafeStr_8865.indexOf(_arg_3) == -1)))){
                            this._SafeStr_8865.push(_arg_3);
                        };
                    };
                };
            };
            return (_local_7);
        }
        private function unregisterLoadingAssets(_arg_1:LibraryLoader):void
        {
            var _local_3:String;
            var _local_4:String;
            var _local_5:LibraryLoader;
            var _local_2:Array = new Array();
            for each (_local_3 in this._SafeStr_10023.getKeys()) {
                _local_5 = this._SafeStr_10023.getValue(_local_3);
                if (_arg_1 == _local_5){
                    _local_2.push(_local_3);
                };
            };
            for each (_local_4 in _local_2) {
                this._SafeStr_10023.remove(_local_4);
            };
        }
        private function onContentLoadError(_arg_1:Event):void
        {
            var _local_2:LibraryLoader = (_arg_1.target as LibraryLoader);
            _local_2.removeEventListener(LibraryLoaderEvent.LIBRARY_LOADER_EVENT_COMPLETE, this.onLoaderComplete);
            _local_2.removeEventListener(LibraryLoaderEvent.LIBRARY_LOADER_EVENT_ERROR, this.onContentLoadError);
            var _local_3:int = this._SafeStr_8954.indexOf(_local_2);
            if (_local_3 != -1){
                this._SafeStr_8954.splice(_local_3, 1);
                this.unregisterLoadingAssets(_local_2);
            };
        }
        private function onLoaderComplete(_arg_1:Event):void
        {
            var _local_2:LibraryLoader = (_arg_1.target as LibraryLoader);
            _local_2.removeEventListener(LibraryLoaderEvent.LIBRARY_LOADER_EVENT_COMPLETE, this.onLoaderComplete);
            _local_2.removeEventListener(LibraryLoaderEvent.LIBRARY_LOADER_EVENT_ERROR, this.onContentLoadError);
            this._SafeStr_10024.push(_local_2.url);
            var _local_3:int = this._SafeStr_8954.indexOf(_local_2);
            if (_local_3 >= 0){
                this._SafeStr_8954.splice(_local_3, 1);
                this.unregisterLoadingAssets(_local_2);
            };
            if (this._SafeStr_8954.length == 0){
                this._RoomInstance.resetPetData();
                this.PetDataManager();
            };
        }

    }
}//package com.sulake.habbo.avatar.pets

// _species = "_-2BX" (String#6277, DoABC#2)
// findColor = "_-217" (String#19055, DoABC#2)
// findBreed = "_-pk" (String#24262, DoABC#2)
// _SafeStr_10023 = "_-2eZ" (String#20628, DoABC#2)
// _SafeStr_10024 = "_-3LD" (String#22334, DoABC#2)
// onLoaderComplete = "_-1gp" (String#5681, DoABC#2)
// onContentLoadError = "_-2TD" (String#6628, DoABC#2)
// PetDataManager = "_-dC" (String#23768, DoABC#2)
// assetsReady = "_-0jq" (String#15821, DoABC#2)
// PetDataManager = "_-0Qm" (String#15092, DoABC#2)
// figurePartPaletteColorId = "_-1K6" (String#17277, DoABC#2)
// PetDataManager = "_-0OV" (String#15007, DoABC#2)
// unregisterLoadingAssets = "_-xq" (String#24607, DoABC#2)
// resetPetData = "_-0tj" (String#16192, DoABC#2)
// PetData = "_-01G" (String#1387, DoABC#2)
// AvatarScaleType = "_-2lF" (String#20893, DoABC#2)
// AssetLibraryCollection = "_-2Pg" (String#6555, DoABC#2)
// IPetDataManager = "_-03y" (String#3647, DoABC#2)
// PetDataManager = "_-1Vw" (String#5470, DoABC#2)
// IPetData = "_-0mZ" (String#4560, DoABC#2)
// IPetDataListener = "_-r6" (String#8726, DoABC#2)
// PetColor = "_-2Cu" (String#6304, DoABC#2)
// Breed = "_-0vW" (String#4757, DoABC#2)
// IDisposable = "_-0dY" (String#4382, DoABC#2)
// _SafeStr_4336 = "_-1wM" (String#18815, DoABC#2)
// _SafeStr_4337 = "_-1dF" (String#18025, DoABC#2)
// rgb = "_-1zC" (String#1788, DoABC#2)
// LibraryLoader = "_-T1" (String#8267, DoABC#2)
// PetDataManager = "_-2Tw" (String#6646, DoABC#2)
// petDataReady = "_-0Wh" (String#4242, DoABC#2)
// _RoomInstance = "_-32W" (String#628, DoABC#2)
// _SafeStr_8865 = "_-0RW" (String#1471, DoABC#2)
// PetDataManager = "_-1Hc" (String#1653, DoABC#2)
// _SafeStr_8954 = "_-3CG" (String#2020, DoABC#2)


