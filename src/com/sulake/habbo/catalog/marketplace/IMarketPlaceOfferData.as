
package com.sulake.habbo.catalog.marketplace
{
    import flash.display.BitmapData;

    public interface IMarketPlaceOfferData 
    {

        function get offerId():int;
        function get furniId():int;
        function get furniType():int;
        function get stuffData():String;
        function get price():int;
        function get averagePrice():int;
        function get image():BitmapData;
        function set image(_arg_1:BitmapData):void;
        function set imageCallback(_arg_1:int):void;
        function get imageCallback():int;
        function get status():int;
        function get timeLeftMinutes():int;
        function set timeLeftMinutes(_arg_1:int):void;
        function set price(_arg_1:int):void;
        function set offerId(_arg_1:int):void;
        function get offerCount():int;
        function set offerCount(_arg_1:int):void;

    }
}//package com.sulake.habbo.catalog.marketplace

// imageCallback = "_-3-K" (String#7292, DoABC#2)
// IMarketPlaceOfferData = "_-1JA" (String#5225, DoABC#2)
// furniId = "_-2KO" (String#6454, DoABC#2)
// stuffData = "_-0vz" (String#1580, DoABC#2)
// offerId = "_-9g" (String#928, DoABC#2)
// furniType = "_-26P" (String#6173, DoABC#2)
// timeLeftMinutes = "_-09A" (String#3743, DoABC#2)
// averagePrice = "_-2h" (String#6892, DoABC#2)
// offerCount = "_-3Bk" (String#7545, DoABC#2)


