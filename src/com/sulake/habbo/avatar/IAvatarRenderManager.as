
package com.sulake.habbo.avatar
{
    import com.sulake.core.runtime.IUnknown;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.habbo.avatar.structure.IFigureData;
    import com.sulake.core.assets.IAsset;
    import com.sulake.habbo.avatar.pets.IPetDataManager;
    import com.sulake.habbo.avatar.animation.IAnimationManager;
    import flash.events.IEventDispatcher;

    public interface IAvatarRenderManager extends IUnknown 
    {

        function createAvatarImage(_arg_1:String, _arg_2:String, _arg_3:String=null, _arg_4:IAvatarImageListener=null):IAvatarImage;
        function createPetImageFromFigure(_arg_1:String, _arg_2:String, _arg_3:IPetImageListener=null):IAvatarImage;
        function createPetImage(_arg_1:int, _arg_2:int, _arg_3:uint, _arg_4:String, _arg_5:IPetImageListener=null):IAvatarImage;
        function getPetFigureString(_arg_1:String):String;
        function get assets():IAssetLibrary;
        function getFigureData(_arg_1:String):IFigureData;
        function getMandatoryAvatarPartSetIds(_arg_1:String, _arg_2:int):Array;
        function getAssetByName(_arg_1:String):IAsset;
        function get petDataManager():IPetDataManager;
        function get mode():String;
        function set mode(_arg_1:String):void;
        function injectFigureData(_arg_1:String, _arg_2:XML):void;
        function createFigureContainer(_arg_1:String):IAvatarFigureContainer;
        function isFigureReady(_arg_1:IAvatarFigureContainer):Boolean;
        function downloadFigure(_arg_1:IAvatarFigureContainer, _arg_2:IAvatarImageListener):void;
        function getAnimationManager(_arg_1:String):IAnimationManager;
        function get events():IEventDispatcher;
        function resetAssetManager():void;
        function removePetImageListener(_arg_1:IPetImageListener):void;

    }
}//package com.sulake.habbo.avatar

// injectFigureData = "_-2vT" (String#7186, DoABC#2)
// getFigureData = "_-2tG" (String#7143, DoABC#2)
// getMandatoryAvatarPartSetIds = "_-1un" (String#5934, DoABC#2)
// getAnimationManager = "_-1Rm" (String#5394, DoABC#2)
// resetAssetManager = "_-2X6" (String#6702, DoABC#2)
// removePetImageListener = "_-1Uw" (String#5453, DoABC#2)
// IAvatarFigureContainer = "_-2-D" (String#6034, DoABC#2)
// IPetDataManager = "_-03y" (String#3647, DoABC#2)
// IAnimationManager = "_-271" (String#6183, DoABC#2)
// IFigureData = "_-Ip" (String#8057, DoABC#2)
// createPetImageFromFigure = "_-0Sk" (String#4153, DoABC#2)
// IAvatarRenderManager = "_-C9" (String#7915, DoABC#2)
// mode = "_-3Cz" (String#2023, DoABC#2)
// petDataManager = "_-0y0" (String#4809, DoABC#2)
// createPetImage = "_-0Qk" (String#4105, DoABC#2)
// IAvatarImageListener = "_-06N" (String#3688, DoABC#2)
// getPetFigureString = "_-0DP" (String#1431, DoABC#2)
// createFigureContainer = "_-vG" (String#8789, DoABC#2)
// isFigureReady = "_-1Ey" (String#5157, DoABC#2)
// downloadFigure = "_-20I" (String#6051, DoABC#2)


