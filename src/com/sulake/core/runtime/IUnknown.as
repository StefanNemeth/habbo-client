
package com.sulake.core.runtime
{
    public interface IUnknown extends IDisposable 
    {

        function queueInterface(_arg_1:IID, _arg_2:Function=null):IUnknown;
        function release(_arg_1:IID):uint;

    }
}//package com.sulake.core.runtime

// IID = "_-3KV" (String#7712, DoABC#2)
// IDisposable = "_-0dY" (String#4382, DoABC#2)


