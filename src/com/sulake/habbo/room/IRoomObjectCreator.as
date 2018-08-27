
package com.sulake.habbo.room
{
    import com.sulake.room.utils.IVector3d;

    public interface IRoomObjectCreator 
    {

        function addObjectFurniture(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:int, _arg_5:IVector3d, _arg_6:IVector3d, _arg_7:int, _arg_8:String, _arg_9:Number=NaN, _arg_10:int=-1, _arg_11:Boolean=false):Boolean;
        function addObjectFurnitureByName(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:String, _arg_5:IVector3d, _arg_6:IVector3d, _arg_7:int, _arg_8:String, _arg_9:Number=NaN):Boolean;
        function updateObjectFurniture(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:IVector3d, _arg_5:IVector3d, _arg_6:int, _arg_7:String, _arg_8:Number=NaN):Boolean;
        function updateObjectFurnitureLocation(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:IVector3d, _arg_5:IVector3d):Boolean;
        function disposeObjectFurniture(_arg_1:int, _arg_2:int, _arg_3:int):void;
        function addObjectWallItem(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:int, _arg_5:IVector3d, _arg_6:IVector3d, _arg_7:int, _arg_8:String, _arg_9:Boolean=false):Boolean;
        function updateObjectWallItem(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:IVector3d, _arg_5:IVector3d, _arg_6:int, _arg_7:String):Boolean;
        function updateObjectWallItemData(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:String):Boolean;
        function updateObjectWallItemLocation(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:IVector3d):Boolean;
        function disposeObjectWallItem(_arg_1:int, _arg_2:int, _arg_3:int):void;
        function addObjectUser(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:IVector3d, _arg_5:IVector3d, _arg_6:Number, _arg_7:int, _arg_8:String=null):Boolean;
        function updateObjectUser(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:IVector3d, _arg_5:IVector3d, _arg_6:IVector3d=null, _arg_7:Number=NaN):Boolean;
        function updateObjectUserFlatControl(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:String):Boolean;
        function updateObjectUserFigure(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:String, _arg_5:String=null, _arg_6:String=null):Boolean;
        function updateObjectUserAction(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:String, _arg_5:int, _arg_6:String=null):Boolean;
        function updateObjectUserPosture(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:String, _arg_5:String=""):Boolean;
        function updateObjectUserGesture(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:int):Boolean;
        function updateObjectPetGesture(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:String):Boolean;
        function updateObjectUserEffect(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:int, _arg_5:int=0):Boolean;
        function disposeObjectUser(_arg_1:int, _arg_2:int, _arg_3:int):void;
        function updateObjectRoom(_arg_1:int, _arg_2:int, _arg_3:String=null, _arg_4:String=null, _arg_5:String=null, _arg_6:Boolean=false):Boolean;
        function updateObjectRoomColor(_arg_1:int, _arg_2:int, _arg_3:uint, _arg_4:int, _arg_5:Boolean):Boolean;
        function updateObjectRoomVisibilities(_arg_1:int, _arg_2:int, _arg_3:Boolean, _arg_4:Boolean=true):Boolean;
        function updateObjectRoomPlaneThicknesses(_arg_1:int, _arg_2:int, _arg_3:Number, _arg_4:Number):Boolean;
        function setRoomObjectAlias(_arg_1:String, _arg_2:String):void;

    }
}//package com.sulake.habbo.room

// IRoomObjectCreator = "_-0Nw" (String#4044, DoABC#2)
// IVector3d = "_-hf" (String#8547, DoABC#2)
// addObjectFurnitureByName = "_-0A-" (String#3757, DoABC#2)
// updateObjectFurniture = "_-136" (String#4935, DoABC#2)
// updateObjectFurnitureLocation = "_-2BD" (String#6272, DoABC#2)
// updateObjectWallItem = "_-1Nf" (String#5305, DoABC#2)
// updateObjectWallItemData = "_-0Op" (String#4066, DoABC#2)
// updateObjectUser = "_-1tl" (String#5916, DoABC#2)
// updateObjectUserFlatControl = "_-TO" (String#8274, DoABC#2)
// updateObjectUserFigure = "_-hw" (String#2161, DoABC#2)
// updateObjectUserAction = "_-2vR" (String#7185, DoABC#2)
// updateObjectPetGesture = "_-2gz" (String#6891, DoABC#2)
// updateObjectRoomVisibilities = "_-0jE" (String#4485, DoABC#2)
// updateObjectRoomPlaneThicknesses = "_-25z" (String#6160, DoABC#2)
// setRoomObjectAlias = "_-3Kt" (String#7720, DoABC#2)
// disposeObjectFurniture = "_-0Sj" (String#1477, DoABC#2)
// disposeObjectWallItem = "_-0aH" (String#1502, DoABC#2)
// disposeObjectUser = "_-Jw" (String#2086, DoABC#2)
// addObjectFurniture = "_-0G1" (String#1439, DoABC#2)
// addObjectWallItem = "_-J0" (String#2084, DoABC#2)
// addObjectUser = "_-0kK" (String#1540, DoABC#2)
// updateObjectUserGesture = "_-0Yi" (String#1498, DoABC#2)
// updateObjectUserEffect = "_-3-m" (String#1983, DoABC#2)
// updateObjectUserPosture = "_-356" (String#1995, DoABC#2)
// updateObjectRoomColor = "_-o" (String#2192, DoABC#2)
// updateObjectRoom = "_-DR" (String#2076, DoABC#2)
// updateObjectWallItemLocation = "_-26n" (String#1814, DoABC#2)


