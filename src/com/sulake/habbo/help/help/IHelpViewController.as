
package com.sulake.habbo.help.help
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.core.window.IWindowContainer;

    public interface IHelpViewController extends IDisposable 
    {

        function TradingModel():IWindowContainer;
        function render():void;
        function update(_arg_1:*=null):void;
        function set roomSessionActive(_arg_1:Boolean):void;

    }
}//package com.sulake.habbo.help.help

// roomSessionActive = "_-4g" (String#7760, DoABC#2)
// IHelpViewController = "_-0cs" (String#4364, DoABC#2)
// IDisposable = "_-0dY" (String#4382, DoABC#2)
// TradingModel = "_-v8" (String#313, DoABC#2)


