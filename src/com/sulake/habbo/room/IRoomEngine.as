
package com.sulake.habbo.room
{
    import com.sulake.core.runtime.IUnknown;
    import flash.events.IEventDispatcher;
    import flash.display.DisplayObject;
    import com.sulake.room.utils.IRoomGeometry;
    import flash.geom.Point;
    import com.sulake.room.utils.IVector3d;
    import flash.geom.Rectangle;
    import com.sulake.room.object.IRoomObject;
    import com.sulake.core.utils.Map;

    public interface IRoomEngine extends IUnknown 
    {

        function get events():IEventDispatcher;
        function get isInitialized():Boolean;
        function get activeRoomId():int;
        function get activeRoomCategory():int;
        function createRoomCanvas(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:int, _arg_5:int, _arg_6:int):DisplayObject;
        function modifyRoomCanvas(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:int, _arg_5:int):Boolean;
        function setRoomCanvasMask(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:Boolean):void;
        function getRoomCanvasGeometry(_arg_1:int, _arg_2:int, _arg_3:int):IRoomGeometry;
        function getRoomCanvasScreenOffset(_arg_1:int, _arg_2:int, _arg_3:int):Point;
        function setRoomCanvasScreenOffset(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:Point):Boolean;
        function handleRoomCanvasMouseEvent(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:String, _arg_5:Boolean, _arg_6:Boolean, _arg_7:Boolean, _arg_8:Boolean):void;
        function setActiveRoom(_arg_1:int, _arg_2:int):void;
        function getRoomNumberValue(_arg_1:int, _arg_2:int, _arg_3:String):Number;
        function getRoomStringValue(_arg_1:int, _arg_2:int, _arg_3:String):String;
        function getFurnitureIcon(_arg_1:int, _arg_2:IGetImageListener, _arg_3:String=null):ImageResult;
        function getWallItemIcon(_arg_1:int, _arg_2:IGetImageListener, _arg_3:String=null):ImageResult;
        function getFurnitureImage(_arg_1:int, _arg_2:IVector3d, _arg_3:int, _arg_4:IGetImageListener, _arg_5:uint=0, _arg_6:String=null, _arg_7:int=-1, _arg_8:int=-1):ImageResult;
        function getGenericRoomObjectImage(_arg_1:String, _arg_2:String, _arg_3:IVector3d, _arg_4:int, _arg_5:IGetImageListener, _arg_6:uint=0, _arg_7:String=null, _arg_8:int=-1, _arg_9:int=-1):ImageResult;
        function getWallItemImage(_arg_1:int, _arg_2:IVector3d, _arg_3:int, _arg_4:IGetImageListener, _arg_5:uint=0, _arg_6:String=null, _arg_7:int=-1, _arg_8:int=-1):ImageResult;
        function getPetImage(_arg_1:int, _arg_2:int, _arg_3:IVector3d, _arg_4:int, _arg_5:IGetImageListener, _arg_6:uint=0):ImageResult;
        function getRoomImage(_arg_1:String, _arg_2:String, _arg_3:String, _arg_4:int, _arg_5:IGetImageListener, _arg_6:String=null):ImageResult;
        function getRoomObjectImage(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:int, _arg_5:IVector3d, _arg_6:int, _arg_7:IGetImageListener, _arg_8:uint=0):ImageResult;
        function getRoomObjectBoundingRectangle(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:int, _arg_5:int):Rectangle;
        function getRoomObjectScreenLocation(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:int, _arg_5:int):Point;
        function getActiveRoomBoundingRectangle(_arg_1:int):Rectangle;
        function getRoomObjectCount(_arg_1:int, _arg_2:int, _arg_3:int):int;
        function getRoomObject(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:int):IRoomObject;
        function getRoomObjectWithIndex(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:int):IRoomObject;
        function modifyRoomObject(_arg_1:int, _arg_2:int, _arg_3:String):Boolean;
        function modifyRoomObjectDataWithMap(_arg_1:int, _arg_2:int, _arg_3:String, _arg_4:Map):Boolean;
        function modifyRoomObjectData(_arg_1:int, _arg_2:int, _arg_3:String):Boolean;
        function deleteRoomObject(_arg_1:int, _arg_2:int):Boolean;
        function initializeRoomObjectInsert(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:String=null):Boolean;
        function cancelRoomObjectInsert():void;
        function selectAvatar(_arg_1:int, _arg_2:int, _arg_3:int):void;
        function selectRoomObject(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:int):void;
        function loadRoomResources(_arg_1:String):Array;
        function isPublicRoomWorldType(_arg_1:String):Boolean;
        function getWorldType(_arg_1:int, _arg_2:int):String;
        function getSelectedObjectData(_arg_1:int, _arg_2:int):ISelectedRoomObjectData;
        function getSelectedAvatarId():int;
        function updateObjectRoomColor(_arg_1:int, _arg_2:int, _arg_3:uint, _arg_4:int, _arg_5:Boolean):Boolean;
        function getPetColor(_arg_1:int, _arg_2:int):PetColorResult;
        function addObjectFurniture(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:int, _arg_5:IVector3d, _arg_6:IVector3d, _arg_7:int, _arg_8:String, _arg_9:Number=NaN, _arg_10:int=-1, _arg_11:Boolean=false):Boolean;
        function changeObjectState(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:int):void;
        function disposeObjectFurniture(_arg_1:int, _arg_2:int, _arg_3:int):void;
        function addObjectWallItem(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:int, _arg_5:IVector3d, _arg_6:IVector3d, _arg_7:int, _arg_8:String, _arg_9:Boolean=false):Boolean;
        function updateObjectWallItemLocation(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:IVector3d):Boolean;
        function disposeObjectWallItem(_arg_1:int, _arg_2:int, _arg_3:int):void;
        function addObjectUser(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:IVector3d, _arg_5:IVector3d, _arg_6:Number, _arg_7:int, _arg_8:String=null):Boolean;
        function updateObjectUserFigure(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:String, _arg_5:String=null, _arg_6:String=null):Boolean;
        function updateObjectUserPosture(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:String, _arg_5:String=""):Boolean;
        function updateObjectUserGesture(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:int):Boolean;
        function updateObjectUserEffect(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:int, _arg_5:int=0):Boolean;
        function disposeObjectUser(_arg_1:int, _arg_2:int, _arg_3:int):void;
        function updateObjectRoom(_arg_1:int, _arg_2:int, _arg_3:String=null, _arg_4:String=null, _arg_5:String=null, _arg_6:Boolean=false):Boolean;
        function getFurnitureType(_arg_1:int):String;
        function getWallItemType(_arg_1:int, _arg_2:String=null):String;
        function useRoomObjectInActiveRoom(_arg_1:int, _arg_2:int):Boolean;
        function initializeRoom(_arg_1:int, _arg_2:int, _arg_3:XML):void;
        function disposeRoom(_arg_1:int, _arg_2:int):void;

    }
}//package com.sulake.habbo.room

// getPetColor = "_-0Ef" (String#3842, DoABC#2)
// getSelectedObjectData = "_-2oq" (String#899, DoABC#2)
// ImageResult = "_-31w" (String#21576, DoABC#2)
// IVector3d = "_-hf" (String#8547, DoABC#2)
// updateObjectUserFigure = "_-hw" (String#2161, DoABC#2)
// ISelectedRoomObjectData = "_-J6" (String#8063, DoABC#2)
// isPublicRoomWorldType = "_-G6" (String#7996, DoABC#2)
// disposeRoom = "_-2ya" (String#904, DoABC#2)
// getRoomNumberValue = "_-1tf" (String#1777, DoABC#2)
// modifyRoomCanvas = "_-2lc" (String#6995, DoABC#2)
// handleRoomCanvasMouseEvent = "_-2JZ" (String#6430, DoABC#2)
// getActiveRoomBoundingRectangle = "_-2Ul" (String#6662, DoABC#2)
// loadRoomResources = "_-2u6" (String#7162, DoABC#2)
// getWorldType = "_-1VC" (String#5459, DoABC#2)
// getFurnitureType = "_-3-V" (String#7294, DoABC#2)
// PetColorResult = "_-06Y" (String#3693, DoABC#2)
// IRoomGeometry = "_-0z9" (String#4829, DoABC#2)
// IGetImageListener = "_-2i7" (String#6909, DoABC#2)
// initializeRoom = "_-1SM" (String#1690, DoABC#2)
// activeRoomId = "_-kJ" (String#2172, DoABC#2)
// activeRoomCategory = "_-1qo" (String#1770, DoABC#2)
// disposeObjectFurniture = "_-0Sj" (String#1477, DoABC#2)
// disposeObjectWallItem = "_-0aH" (String#1502, DoABC#2)
// disposeObjectUser = "_-Jw" (String#2086, DoABC#2)
// addObjectFurniture = "_-0G1" (String#1439, DoABC#2)
// addObjectWallItem = "_-J0" (String#2084, DoABC#2)
// addObjectUser = "_-0kK" (String#1540, DoABC#2)
// updateObjectUserGesture = "_-0Yi" (String#1498, DoABC#2)
// updateObjectUserEffect = "_-3-m" (String#1983, DoABC#2)
// updateObjectUserPosture = "_-356" (String#1995, DoABC#2)
// changeObjectState = "_-3Dq" (String#2025, DoABC#2)
// createRoomCanvas = "_-vj" (String#8798, DoABC#2)
// setRoomCanvasMask = "_-0uE" (String#4728, DoABC#2)
// getRoomCanvasGeometry = "_-1Qw" (String#5373, DoABC#2)
// getRoomObjectBoundingRectangle = "_-0PC" (String#4075, DoABC#2)
// getRoomCanvasScreenOffset = "_-3FD" (String#7616, DoABC#2)
// setRoomCanvasScreenOffset = "_-2P0" (String#6544, DoABC#2)
// updateObjectRoomColor = "_-o" (String#2192, DoABC#2)
// updateObjectRoom = "_-DR" (String#2076, DoABC#2)
// getRoomObject = "_-1qD" (String#866, DoABC#2)
// updateObjectWallItemLocation = "_-26n" (String#1814, DoABC#2)
// getPetImage = "_-0Zc" (String#437, DoABC#2)
// getSelectedAvatarId = "_-2j0" (String#6933, DoABC#2)
// selectAvatar = "_-1aj" (String#5572, DoABC#2)
// modifyRoomObjectData = "_-0Eh" (String#3843, DoABC#2)
// deleteRoomObject = "_-1YS" (String#5529, DoABC#2)
// getRoomObjectCount = "_-1Hy" (String#1654, DoABC#2)
// getRoomObjectWithIndex = "_-cJ" (String#2140, DoABC#2)
// modifyRoomObject = "_-09k" (String#3753, DoABC#2)
// useRoomObjectInActiveRoom = "_-2p8" (String#7061, DoABC#2)
// modifyRoomObjectDataWithMap = "_-1Vg" (String#5468, DoABC#2)
// getRoomObjectImage = "_-4G" (String#7750, DoABC#2)
// getWallItemType = "_-0BC" (String#3783, DoABC#2)
// getRoomObjectScreenLocation = "_-3l" (String#7742, DoABC#2)
// cancelRoomObjectInsert = "_-0w6" (String#4772, DoABC#2)
// initializeRoomObjectInsert = "_-QC" (String#8205, DoABC#2)
// getRoomStringValue = "_-Ht" (String#2080, DoABC#2)
// isInitialized = "_-1Cr" (String#840, DoABC#2)


