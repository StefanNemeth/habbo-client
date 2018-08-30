
package com.sulake.habbo.avatar
{
    import com.sulake.core.utils.Map;
    import com.sulake.habbo.avatar.alias.AssetAliasCollection;
    import com.sulake.habbo.avatar.cache.AvatarImageCache;
    import flash.display.BitmapData;
    import com.sulake.habbo.avatar.enum.AvatarAction;

    public class PlaceholderAvatarImage extends AvatarImage 
    {

        static var _SafeStr_10132:Map = new Map();

        public function PlaceholderAvatarImage(_arg_1:AvatarStructure, _arg_2:AssetAliasCollection, _arg_3:AvatarFigureContainer, _arg_4:String)
        {
            super(_arg_1, _arg_2, _arg_3, _arg_4);
        }
        override public function dispose():void
        {
            var _local_1:AvatarImageCache;
            if (!_disposed){
                _structure = null;
                _assets = null;
                _cache = null;
                _SafeStr_10078 = null;
                _figure = null;
                _avatarSpriteData = null;
                _SafeStr_5141 = null;
                if (((!(_SafeStr_10133)) && (_image))){
                    _image.dispose();
                };
                _image = null;
                _local_1 = getCache();
                if (_local_1){
                    _local_1.dispose();
                    _local_1 = null;
                };
                _canvasOffsets = null;
                _disposed = true;
            };
        }
        override protected function getFullImage(_arg_1:String):BitmapData
        {
            return (_SafeStr_10132[_arg_1]);
        }
        override protected function cacheFullImage(_arg_1:String, _arg_2:BitmapData):void
        {
            _SafeStr_10132[_arg_1] = _arg_2;
        }
        override public function appendAction(_arg_1:String, ... _args):Boolean
        {
            var _local_3:String;
            if (((!((_args == null))) && ((_args.length > 0)))){
                _local_3 = _args[0];
            };
            switch (_arg_1){
                case AvatarAction._SafeStr_4478:
                    switch (_local_3){
                        case AvatarAction._SafeStr_10003:
                        case AvatarAction._SafeStr_4445:
                        case AvatarAction._SafeStr_10001:
                        case AvatarAction._SafeStr_7967:
                        case AvatarAction._SafeStr_7966:
                        case AvatarAction._SafeStr_10002:
                            super.appendAction.apply(null, [_arg_1].concat(_args));
                            break;
                    };
                    break;
                case AvatarAction._SafeStr_6564:
                case AvatarAction.RSDE_DANCE:
                case AvatarAction._SafeStr_4453:
                case AvatarAction._SafeStr_6561:
                case AvatarAction._SafeStr_6562:
                case AvatarAction._SafeStr_6563:
                    super.addActionData.apply(null, [_arg_1].concat(_args));
                    break;
            };
            return (true);
        }
        override public function isPlaceholder():Boolean
        {
            return (true);
        }

    }
}//package com.sulake.habbo.avatar

// _SafeStr_10001 = "_-Cl" (String#22715, DoABC#2)
// _SafeStr_10002 = "_-16w" (String#16732, DoABC#2)
// _SafeStr_10003 = "_-2r3" (String#21122, DoABC#2)
// _SafeStr_10078 = "_-0hg" (String#4461, DoABC#2)
// _avatarSpriteData = "_-1aN" (String#5566, DoABC#2)
// getCache = "_-CE" (String#7919, DoABC#2)
// addActionData = "_-TE" (String#8272, DoABC#2)
// _SafeStr_10132 = "_-0CY" (String#3801, DoABC#2)
// _SafeStr_10133 = "_-0-3" (String#14013, DoABC#2)
// getFullImage = "_-0Zd" (String#4291, DoABC#2)
// cacheFullImage = "_-04v" (String#3663, DoABC#2)
// AvatarFigureContainer = "_-04P" (String#14219, DoABC#2)
// AvatarImage = "_-as" (String#8437, DoABC#2)
// PlaceholderAvatarImage = "_-0dN" (String#4377, DoABC#2)
// AvatarStructure = "_-2PN" (String#6550, DoABC#2)
// AvatarImageCache = "_-0Nd" (String#4034, DoABC#2)
// _figure = "_-20u" (String#75, DoABC#2)
// _disposed = "_-6m" (String#31, DoABC#2)
// _SafeStr_4445 = "_-bp" (String#23706, DoABC#2)
// _SafeStr_4453 = "_-aY" (String#23655, DoABC#2)
// appendAction = "_-1hS" (String#5696, DoABC#2)
// _SafeStr_4478 = "_-0c6" (String#15518, DoABC#2)
// _image = "_-35u" (String#78, DoABC#2)
// RSDE_DANCE = "_-0-n" (String#14045, DoABC#2)
// _SafeStr_5141 = "_-32J" (String#626, DoABC#2)
// isPlaceholder = "_-128" (String#4919, DoABC#2)
// _SafeStr_6561 = "_-Ne" (String#23151, DoABC#2)
// _SafeStr_6562 = "_-R2" (String#23284, DoABC#2)
// _SafeStr_6563 = "_-07B" (String#14332, DoABC#2)
// _SafeStr_6564 = "_-1eZ" (String#18081, DoABC#2)
// _cache = "_-Fe" (String#636, DoABC#2)
// _SafeStr_7966 = "_-q1" (String#24274, DoABC#2)
// _SafeStr_7967 = "_-2fy" (String#20690, DoABC#2)
// _canvasOffsets = "_-16y" (String#1623, DoABC#2)


