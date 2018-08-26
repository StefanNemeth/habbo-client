
package com.sulake.habbo.avatar.structure.figure
{
    import flash.utils.Dictionary;

    public class Palette implements IPalette 
    {

        private var _id:int;
        private var _colors:Dictionary;

        public function Palette(_arg_1:XML)
        {
            this._id = parseInt(_arg_1.@id);
            this._colors = new Dictionary();
            this.append(_arg_1);
        }
        public function append(_arg_1:XML):void
        {
            var _local_2:XML;
            for each (_local_2 in _arg_1.color) {
                this._colors[String(_local_2.@id)] = new PartColor(_local_2);
            };
        }
        public function get id():int
        {
            return (this._id);
        }
        public function getColor(_arg_1:int):IPartColor
        {
            return (this._colors[String(_arg_1)]);
        }
        public function get colors():Dictionary
        {
            return (this._colors);
        }

    }
}//package com.sulake.habbo.avatar.structure.figure

// IPartColor = "_-1dO" (String#5620, DoABC#2)
// IPalette = "_-UT" (String#8293, DoABC#2)
// Palette = "_-LG" (String#8107, DoABC#2)
// PartColor = "_-1py" (String#5856, DoABC#2)
// getColor = "_-07L" (String#1406, DoABC#2)
// append = "_-0Hu" (String#14753, DoABC#2)


