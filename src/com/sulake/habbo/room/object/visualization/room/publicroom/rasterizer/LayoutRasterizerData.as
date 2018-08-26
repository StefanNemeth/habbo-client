
package com.sulake.habbo.room.object.visualization.room.publicroom.rasterizer
{
    public class LayoutRasterizerData 
    {

        private var _elementList:XMLList;

        public function LayoutRasterizerData(_arg_1:XML)
        {
            this._elementList = _arg_1.elements.element;
        }
        public function get elementList():XMLList
        {
            return (this._elementList);
        }
        public function dispose():void
        {
            this._elementList = null;
        }

    }
}//package com.sulake.habbo.room.object.visualization.room.publicroom.rasterizer

// LayoutRasterizerData = "_-jp" (String#8597, DoABC#2)
// _elementList = "_-3ES" (String#7602, DoABC#2)
// elementList = "_-30K" (String#21514, DoABC#2)


