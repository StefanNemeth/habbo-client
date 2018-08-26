
package com.sulake.core.window.graphics.renderer
{
    import com.sulake.core.window.utils.IChildEntityArray;
    import com.sulake.core.window.utils.IChildEntity;
    import com.sulake.core.assets.IAsset;

    public interface ISkinTemplate extends IChildEntityArray, IChildEntity 
    {

        function get asset():IAsset;
        function dispose():void;

    }
}//package com.sulake.core.window.graphics.renderer

// IChildEntityArray = "_-2oU" (String#7047, DoABC#2)
// IChildEntity = "_-1NX" (String#5302, DoABC#2)
// ISkinTemplate = "_-31I" (String#1988, DoABC#2)


