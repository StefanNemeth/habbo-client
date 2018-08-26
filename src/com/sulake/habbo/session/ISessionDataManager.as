
package com.sulake.habbo.session
{
    import com.sulake.core.runtime.IUnknown;
    import flash.events.IEventDispatcher;
    import flash.display.BitmapData;
    import com.sulake.habbo.session.product.IProductData;
    import com.sulake.habbo.session.furniture.IFurnitureData;
    import com.sulake.habbo.session.product.IProductDataListener;
    import com.sulake.habbo.session.furniture.IFurniDataListener;

    public interface ISessionDataManager extends IUnknown 
    {

        function get events():IEventDispatcher;
        function get systemOpen():Boolean;
        function get systemShutDown():Boolean;
        function hasSecurity(_arg_1:int):Boolean;
        function hasUserRight(_arg_1:String, _arg_2:int):Boolean;
        function get clubLevel():int;
        function get userId():int;
        function get userName():String;
        function get realName():String;
        function get figure():String;
        function get gender():String;
        function get isAnyRoomController():Boolean;
        function SessionDataManager(_arg_1:int):Array;
        function SessionDataManager(_arg_1:String):BitmapData;
        function requestBadgeImage(_arg_1:String):BitmapData;
        function SessionDataManager(_arg_1:String):BadgeInfo;
        function SessionDataManager(_arg_1:int):String;
        function SessionDataManager(_arg_1:String):BitmapData;
        function isIgnored(_arg_1:String):Boolean;
        function SessionDataManager(_arg_1:String):void;
        function SessionDataManager(_arg_1:String):void;
        function get respectLeft():int;
        function get petRespectLeft():int;
        function giveRespect(_arg_1:int):void;
        function givePetRespect(_arg_1:int):void;
        function getProductData(_arg_1:String):IProductData;
        function SessionDataManager(_arg_1:int):IFurnitureData;
        function SessionDataManager(_arg_1:int):IFurnitureData;
        function SessionDataManager(_arg_1:String, _arg_2:int=0):IFurnitureData;
        function SessionDataManager(_arg_1:String, _arg_2:int=0):IFurnitureData;
        function SessionDataManager(_arg_1:int):void;
        function InfoStandUserView(_arg_1:int):void;
        function SessionDataManager(_arg_1:int, _arg_2:int):void;
        function SessionDataManager(_arg_1:IProductDataListener=null):Boolean;
        function getFurniData(_arg_1:IFurniDataListener):Array;

    }
}//package com.sulake.habbo.session

// SessionDataManager = "_-0cU" (String#4353, DoABC#2)
// ISessionDataManager = "_-Bk" (String#7907, DoABC#2)
// SessionDataManager = "_-0SD" (String#4143, DoABC#2)
// IFurnitureData = "_-pe" (String#8701, DoABC#2)
// IProductData = "_-0jc" (String#4494, DoABC#2)
// getFurniData = "_-07h" (String#3715, DoABC#2)
// systemOpen = "_-10P" (String#4880, DoABC#2)
// SessionDataManager = "_-0y8" (String#4814, DoABC#2)
// SessionDataManager = "_-2ne" (String#7033, DoABC#2)
// IProductDataListener = "_-0H" (String#3894, DoABC#2)
// IFurniDataListener = "_-02J" (String#3612, DoABC#2)
// BadgeInfo = "_-3V" (String#7736, DoABC#2)
// realName = "_-3HH" (String#922, DoABC#2)
// respectLeft = "_-2Yo" (String#6743, DoABC#2)
// petRespectLeft = "_-0wV" (String#4782, DoABC#2)
// isAnyRoomController = "_-2IH" (String#6407, DoABC#2)
// isIgnored = "_-0NV" (String#4031, DoABC#2)
// hasSecurity = "_-0x9" (String#4794, DoABC#2)
// SessionDataManager = "_-1Q1" (String#5353, DoABC#2)
// SessionDataManager = "_-08L" (String#3728, DoABC#2)
// SessionDataManager = "_-Hc" (String#8029, DoABC#2)
// givePetRespect = "_-0Gq" (String#3891, DoABC#2)
// SessionDataManager = "_-2nM" (String#7029, DoABC#2)
// SessionDataManager = "_-2jq" (String#6950, DoABC#2)
// SessionDataManager = "_-25Y" (String#6152, DoABC#2)
// InfoStandUserView = "_-1Qo" (String#1680, DoABC#2)
// SessionDataManager = "_-3DK" (String#7581, DoABC#2)
// systemShutDown = "_-0D0" (String#3809, DoABC#2)
// SessionDataManager = "_-cs" (String#8469, DoABC#2)
// SessionDataManager = "_-3Cg" (String#2022, DoABC#2)
// SessionDataManager = "_-KC" (String#2087, DoABC#2)


