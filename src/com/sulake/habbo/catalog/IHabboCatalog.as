
package com.sulake.habbo.catalog
{
    import com.sulake.core.runtime.IUnknown;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.habbo.configuration.IHabboConfigurationManager;
    import flash.events.IEventDispatcher;
    import com.sulake.core.localization.ICoreLocalizationManager;
    import com.sulake.core.communication.connection.IConnection;
    import com.sulake.habbo.session.product.IProductData;
    import com.sulake.habbo.session.furniture.IFurnitureData;
    import flash.display.BitmapData;
    import com.sulake.habbo.catalog.purse.IPurse;
    import com.sulake.habbo.catalog.recycler.IRecycler;
    import com.sulake.habbo.catalog.marketplace.IMarketPlace;

    public interface IHabboCatalog extends IUnknown 
    {

        function redeemVoucher(_arg_1:String):void;
        function loadCatalogPage(_arg_1:int, _arg_2:int):void;
        function getRecyclerStatus():void;
        function getRecyclerPrizes():void;
        function sendRecycleItems(_arg_1:Array):void;
        function get assets():IAssetLibrary;
        function get windowManager():IHabboWindowManager;
        function get configuration():IHabboConfigurationManager;
        function get events():IEventDispatcher;
        function get localization():ICoreLocalizationManager;
        function get connection():IConnection;
        function openCatalog():void;
        function openCatalogPage(_arg_1:String, _arg_2:Boolean=false):void;
        function openCatalogPageById(_arg_1:int, _arg_2:int):void;
        function openInventoryCategory(_arg_1:String):void;
        function openCreditsHabblet():void;
        function setupInventoryForRecycler(_arg_1:Boolean):void;
        function HabboCatalog():int;
        function HabboInventory(_arg_1:int):Boolean;
        function get privateRoomSessionActive():Boolean;
        function get tradingActive():Boolean;
        function getProductData(_arg_1:String):IProductData;
        function getFurnitureData(_arg_1:int, _arg_2:String):IFurnitureData;
        function getPixelEffectIcon(_arg_1:int):BitmapData;
        function getSubscriptionProductIcon(_arg_1:int):BitmapData;
        function getPurse():IPurse;
        function getRecycler():IRecycler;
        function getMarketPlace():IMarketPlace;
        function getPublicMarketPlaceOffers(_arg_1:int, _arg_2:int, _arg_3:String, _arg_4:int):void;
        function getOwnMarketPlaceOffers():void;
        function buyMarketPlaceOffer(_arg_1:int):void;
        function redeemSoldMarketPlaceOffers():void;
        function redeemExpiredMarketPlaceOffer(_arg_1:int):void;
        function getMarketplaceItemStats(_arg_1:int, _arg_2:int):void;
        function showNotEnoughCreditsAlert():void;
        function getHabboClubOffers():void;

    }
}//package com.sulake.habbo.catalog

// getPublicMarketPlaceOffers = "_-1kA" (String#5754, DoABC#2)
// getOwnMarketPlaceOffers = "_-2ye" (String#7252, DoABC#2)
// getMarketplaceItemStats = "_-0Ya" (String#4274, DoABC#2)
// showNotEnoughCreditsAlert = "_-20s" (String#6062, DoABC#2)
// redeemExpiredMarketPlaceOffer = "_-29g" (String#6244, DoABC#2)
// redeemSoldMarketPlaceOffers = "_-2lU" (String#6992, DoABC#2)
// buyMarketPlaceOffer = "_-2t" (String#7137, DoABC#2)
// loadCatalogPage = "_-2Go" (String#6383, DoABC#2)
// getRecyclerStatus = "_-2YN" (String#6734, DoABC#2)
// setupInventoryForRecycler = "_-0uu" (String#4742, DoABC#2)
// HabboCatalog = "_-0Vk" (String#4222, DoABC#2)
// HabboInventory = "_-81" (String#2057, DoABC#2)
// sendRecycleItems = "_-3GL" (String#7633, DoABC#2)
// privateRoomSessionActive = "_-2CC" (String#6289, DoABC#2)
// tradingActive = "_-1-4" (String#1595, DoABC#2)
// getRecyclerPrizes = "_-iN" (String#8565, DoABC#2)
// openCatalogPageById = "_-1I6" (String#5209, DoABC#2)
// openInventoryCategory = "_-10J" (String#4878, DoABC#2)
// IFurnitureData = "_-pe" (String#8701, DoABC#2)
// IProductData = "_-0jc" (String#4494, DoABC#2)
// IMarketPlace = "_-1xE" (String#5977, DoABC#2)
// IPurse = "_-0GN" (String#3880, DoABC#2)
// IRecycler = "_-0fo" (String#4421, DoABC#2)
// IHabboCatalog = "_-1fJ" (String#5651, DoABC#2)
// getFurnitureData = "_-40" (String#7745, DoABC#2)
// getPixelEffectIcon = "_-1HA" (String#5192, DoABC#2)
// getSubscriptionProductIcon = "_-dz" (String#8484, DoABC#2)
// openCreditsHabblet = "_-0D5" (String#3811, DoABC#2)
// getHabboClubOffers = "_-16e" (String#5009, DoABC#2)
// openCatalog = "_-RM" (String#8233, DoABC#2)


