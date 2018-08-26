
package com.sulake.habbo.avatar.alias
{
    public class AssetAlias 
    {

        private var _name:String;
        private var _link:String;
        private var _flipH:Boolean;
        private var _flipV:Boolean;

        public function AssetAlias(_arg_1:XML)
        {
            this._name = String(_arg_1.@name);
            this._link = String(_arg_1.@link);
            this._flipH = Boolean(parseInt(_arg_1.@fliph));
            this._flipV = Boolean(parseInt(_arg_1.@flipv));
        }
        public function get name():String
        {
            return (this._name);
        }
        public function get link():String
        {
            return (this._link);
        }
        public function get flipH():Boolean
        {
            return (this._flipH);
        }
        public function get flipV():Boolean
        {
            return (this._flipV);
        }

    }
}//package com.sulake.habbo.avatar.alias

// AssetAlias = "_-1G3" (String#5171, DoABC#2)
// _link = "_-z5" (String#8863, DoABC#2)
// _flipH = "_-1nk" (String#863, DoABC#2)
// _flipV = "_-1eo" (String#858, DoABC#2)


