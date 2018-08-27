
package com.sulake.habbo.room.utils
{
    import com.sulake.core.utils.Map;

    public class RoomInstanceData 
    {

        private var _roomId:int = 0;
        private var _roomCategory:int = 0;
        private var _tileHeightMap:TileHeightMap = null;
        private var _legacyGeometry:LegacyWallGeometry = null;
        private var _roomCamera:RoomCamera = null;
        private var _selectedObject:SelectedRoomObjectData = null;
        private var _placedObject:SelectedRoomObjectData = null;
        private var _worldType:String = null;
        private var _SafeStr_13191:Map;
        private var _SafeStr_13192:Map;

        public function RoomInstanceData(_arg_1:int, _arg_2:int)
        {
            this._SafeStr_13191 = new Map();
            this._SafeStr_13192 = new Map();
            super();
            this._roomId = _arg_1;
            this._roomCategory = _arg_2;
            this._legacyGeometry = new LegacyWallGeometry();
            this._roomCamera = new RoomCamera();
        }
        public function get roomId():int
        {
            return (this._roomId);
        }
        public function get roomCategory():int
        {
            return (this._roomCategory);
        }
        public function get tileHeightMap():TileHeightMap
        {
            return (this._tileHeightMap);
        }
        public function set tileHeightMap(_arg_1:TileHeightMap):void
        {
            if (this._tileHeightMap != null){
                this._tileHeightMap.dispose();
            };
            this._tileHeightMap = _arg_1;
        }
        public function get legacyGeometry():LegacyWallGeometry
        {
            return (this._legacyGeometry);
        }
        public function get roomCamera():RoomCamera
        {
            return (this._roomCamera);
        }
        public function get worldType():String
        {
            return (this._worldType);
        }
        public function set worldType(_arg_1:String):void
        {
            this._worldType = _arg_1;
        }
        public function get selectedObject():SelectedRoomObjectData
        {
            return (this._selectedObject);
        }
        public function set selectedObject(_arg_1:SelectedRoomObjectData):void
        {
            if (this._selectedObject != null){
                this._selectedObject.dispose();
            };
            this._selectedObject = _arg_1;
        }
        public function get placedObject():SelectedRoomObjectData
        {
            return (this._placedObject);
        }
        public function set placedObject(_arg_1:SelectedRoomObjectData):void
        {
            if (this._placedObject != null){
                this._placedObject.dispose();
            };
            this._placedObject = _arg_1;
        }
        public function dispose():void
        {
            if (this._tileHeightMap != null){
                this._tileHeightMap.dispose();
                this._tileHeightMap = null;
            };
            if (this._legacyGeometry != null){
                this._legacyGeometry.dispose();
                this._legacyGeometry = null;
            };
            if (this._roomCamera != null){
                this._roomCamera.dispose();
                this._roomCamera = null;
            };
            if (this._selectedObject != null){
                this._selectedObject.dispose();
                this._selectedObject = null;
            };
            if (this._placedObject != null){
                this._placedObject.dispose();
                this._placedObject = null;
            };
            if (this._SafeStr_13191 != null){
                this._SafeStr_13191.dispose();
                this._SafeStr_13191 = null;
            };
            if (this._SafeStr_13192 != null){
                this._SafeStr_13192.dispose();
                this._SafeStr_13192 = null;
            };
        }
        public function addFurnitureData(_arg_1:FurnitureData):void
        {
            if (_arg_1 != null){
                this._SafeStr_13191.remove(_arg_1.id);
                this._SafeStr_13191.add(_arg_1.id, _arg_1);
            };
        }
        public function getFurnitureData():FurnitureData
        {
            if (this._SafeStr_13191.length > 0){
                return (this.getFurnitureDataWithId(this._SafeStr_13191.getKey(0)));
            };
            return (null);
        }
        public function getFurnitureDataWithId(_arg_1:int):FurnitureData
        {
            return (this._SafeStr_13191.remove(_arg_1));
        }
        public function addWallItemData(_arg_1:FurnitureData):void
        {
            if (_arg_1 != null){
                this._SafeStr_13192.remove(_arg_1.id);
                this._SafeStr_13192.add(_arg_1.id, _arg_1);
            };
        }
        public function getWallItemData():FurnitureData
        {
            if (this._SafeStr_13192.length > 0){
                return (this.getWallItemDataWithId(this._SafeStr_13192.getKey(0)));
            };
            return (null);
        }
        public function getWallItemDataWithId(_arg_1:int):FurnitureData
        {
            return (this._SafeStr_13192.remove(_arg_1));
        }

    }
}//package com.sulake.habbo.room.utils

// _tileHeightMap = "_-Fm" (String#22842, DoABC#2)
// _legacyGeometry = "_-2E-" (String#19567, DoABC#2)
// _roomCamera = "_-1gu" (String#18172, DoABC#2)
// _selectedObject = "_-1vB" (String#18765, DoABC#2)
// _placedObject = "_-n3" (String#24156, DoABC#2)
// _SafeStr_13191 = "_-1bH" (String#17947, DoABC#2)
// _SafeStr_13192 = "_-2JX" (String#19791, DoABC#2)
// legacyGeometry = "_-2lx" (String#20915, DoABC#2)
// roomCamera = "_-0wp" (String#16304, DoABC#2)
// worldType = "_-3B4" (String#21926, DoABC#2)
// selectedObject = "_-1gs" (String#18170, DoABC#2)
// placedObject = "_-1MB" (String#17366, DoABC#2)
// addFurnitureData = "_-0Av" (String#14485, DoABC#2)
// getFurnitureDataWithId = "_-0Xe" (String#15342, DoABC#2)
// addWallItemData = "_-1vL" (String#18770, DoABC#2)
// getWallItemDataWithId = "_-0vM" (String#16251, DoABC#2)
// SelectedRoomObjectData = "_-0MS" (String#4010, DoABC#2)
// LegacyWallGeometry = "_-2Nh" (String#6515, DoABC#2)
// TileHeightMap = "_-0Bg" (String#3789, DoABC#2)
// RoomCamera = "_-1FW" (String#17096, DoABC#2)
// FurnitureData = "_-sW" (String#2211, DoABC#2)
// RoomInstanceData = "_-1Yu" (String#5540, DoABC#2)
// getFurnitureData = "_-40" (String#7745, DoABC#2)
// getWallItemData = "_-Hc" (String#8029, DoABC#2)


