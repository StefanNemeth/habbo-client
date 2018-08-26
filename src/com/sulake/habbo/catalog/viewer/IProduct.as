
package com.sulake.habbo.catalog.viewer
{
    import com.sulake.habbo.room.IGetImageListener;
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.habbo.session.product.IProductData;
    import com.sulake.habbo.session.furniture.IFurnitureData;
    import com.sulake.habbo.catalog.IPurchasableOffer;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import flash.display.BitmapData;
    import com.sulake.core.window.IWindowContainer;

    public interface IProduct extends IGetImageListener, IDisposable 
    {

        function get productType():String;
        function get productClassId():int;
        function set extraParam(_arg_1:String):void;
        function get extraParam():String;
        function get productCount():int;
        function get expiration():int;
        function get productData():IProductData;
        function get furnitureData():IFurnitureData;
        function initIcon(_arg_1:IProductContainer, _arg_2:IGetImageListener=null, _arg_3:IPurchasableOffer=null, _arg_4:IBitmapWrapperWindow=null, _arg_5:Function=null):BitmapData;
        function set view(_arg_1:IWindowContainer):void;
        function set grid(_arg_1:IItemGrid):void;

    }
}//package com.sulake.habbo.catalog.viewer

// IFurnitureData = "_-pe" (String#8701, DoABC#2)
// IProductData = "_-0jc" (String#4494, DoABC#2)
// IPurchasableOffer = "_-2RV" (String#6596, DoABC#2)
// IProductContainer = "_-7f" (String#7816, DoABC#2)
// IItemGrid = "_-0i3" (String#4468, DoABC#2)
// IGetImageListener = "_-2i7" (String#6909, DoABC#2)
// IDisposable = "_-0dY" (String#4382, DoABC#2)
// productClassId = "_-02F" (String#3609, DoABC#2)
// productType = "_-Sd" (String#8259, DoABC#2)
// extraParam = "_-AM" (String#7874, DoABC#2)
// expiration = "_-1G1" (String#1648, DoABC#2)
// furnitureData = "_-2GE" (String#6370, DoABC#2)
// initIcon = "_-0Fm" (String#1437, DoABC#2)


