
package com.sulake.habbo.inventory
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.core.window.IWindowContainer;

    public interface IInventoryModel extends IDisposable 
    {

        function TradingModel():IWindowContainer;
        function TradingModel(_arg_1:int=0):void;
        function categorySwitch(_arg_1:String):void;
        function TradingModel(_arg_1:String):void;
        function TradingModel():void;

    }
}//package com.sulake.habbo.inventory

// IInventoryModel = "_-Fh" (String#7987, DoABC#2)
// IDisposable = "_-0dY" (String#4382, DoABC#2)
// TradingModel = "_-v8" (String#313, DoABC#2)
// TradingModel = "_-0Lx" (String#4000, DoABC#2)
// TradingModel = "_-2eX" (String#6842, DoABC#2)
// categorySwitch = "_-3Ad" (String#7526, DoABC#2)
// TradingModel = "_-1Gu" (String#5187, DoABC#2)


