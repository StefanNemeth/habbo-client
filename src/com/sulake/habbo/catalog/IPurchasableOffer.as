
package com.sulake.habbo.catalog
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.habbo.catalog.viewer.ICatalogPage;
    import com.sulake.habbo.catalog.viewer.IProductContainer;

    public interface IPurchasableOffer extends IDisposable 
    {

        function get offerId():int;
        function get priceInActivityPoints():int;
        function get activityPointType():int;
        function get priceInCredits():int;
        function get page():ICatalogPage;
        function get priceType():String;
        function get productContainer():IProductContainer;
        function get localizationId():String;

    }
}//package com.sulake.habbo.catalog

// IPurchasableOffer = "_-2RV" (String#6596, DoABC#2)
// ICatalogPage = "_-0mL" (String#4556, DoABC#2)
// IProductContainer = "_-7f" (String#7816, DoABC#2)
// IDisposable = "_-0dY" (String#4382, DoABC#2)
// offerId = "_-9g" (String#928, DoABC#2)
// localizationId = "_-0nF" (String#4575, DoABC#2)
// priceInCredits = "_-0Is" (String#3931, DoABC#2)
// priceInActivityPoints = "_-0HW" (String#3908, DoABC#2)
// activityPointType = "_-1gh" (String#5677, DoABC#2)
// priceType = "_-2ty" (String#7160, DoABC#2)


