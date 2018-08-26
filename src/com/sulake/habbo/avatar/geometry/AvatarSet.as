
package com.sulake.habbo.avatar.geometry
{
    import flash.utils.Dictionary;

    public class AvatarSet 
    {

        private var _id:String;
        private var _SafeStr_7012:Dictionary;
        private var _SafeStr_7013:Array;
        private var _SafeStr_7014:Array;
        private var _isMain:Boolean;

        public function AvatarSet(_arg_1:XML)
        {
            var _local_3:AvatarSet;
            var _local_4:XML;
            var _local_5:XML;
            var _local_6:Array;
            super();
            this._id = String(_arg_1.@id);
            var _local_2:String = String(_arg_1.@main);
            this._isMain = (((_local_2)==null) ? false : Boolean(parseInt(_local_2)));
            this._SafeStr_7012 = new Dictionary();
            this._SafeStr_7013 = new Array();
            for each (_local_4 in _arg_1.avatarset) {
                _local_3 = new AvatarSet(_local_4);
                this._SafeStr_7012[String(_local_4.@id)] = _local_3;
            };
            for each (_local_5 in _arg_1.bodypart) {
                this._SafeStr_7013.push(String(_local_5.@id));
            };
            _local_6 = this._SafeStr_7013.concat();
            for each (_local_3 in this._SafeStr_7012) {
                _local_6 = _local_6.concat(_local_3.getBodyParts());
            };
            this._SafeStr_7014 = _local_6;
        }
        public function findAvatarSet(_arg_1:String):AvatarSet
        {
            var _local_2:AvatarSet;
            if (_arg_1 == this._id){
                return (this);
            };
            for each (_local_2 in this._SafeStr_7012) {
                if (_local_2.findAvatarSet(_arg_1) != null){
                    return (_local_2);
                };
            };
            return (null);
        }
        public function getBodyParts():Array
        {
            return (this._SafeStr_7014.concat());
        }
        public function get id():String
        {
            return (this._id);
        }
        public function get isMain():Boolean
        {
            var _local_1:AvatarSet;
            if (this._isMain){
                return (true);
            };
            for each (_local_1 in this._SafeStr_7012) {
                if (_local_1.isMain){
                    return (true);
                };
            };
            return (false);
        }

    }
}//package com.sulake.habbo.avatar.geometry

// AvatarSet = "_-2qw" (String#7095, DoABC#2)
// findAvatarSet = "_-Jm" (String#22997, DoABC#2)
// isMain = "_-00N" (String#3570, DoABC#2)
// _SafeStr_7012 = "_-2DE" (String#19534, DoABC#2)
// _SafeStr_7013 = "_-1N1" (String#17401, DoABC#2)
// _SafeStr_7014 = "_-1aU" (String#17913, DoABC#2)
// _isMain = "_-37V" (String#7459, DoABC#2)


