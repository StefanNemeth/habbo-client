
package com.sulake.core.window.graphics
{
    import com.sulake.core.utils.Map;
    import com.sulake.core.utils.XMLVariableParser;
    import flash.utils.Dictionary;
    import com.sulake.core.window.graphics.renderer.ISkinRenderer;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.core.window.utils.ChildEntityArray;
    import com.sulake.core.window.utils.IChildEntityArray;
    import com.sulake.core.window.graphics.renderer.SkinLayout;
    import com.sulake.core.window.graphics.renderer.SkinLayoutEntity;
    import flash.geom.Rectangle;
    import com.sulake.core.window.graphics.renderer.BitmapSkinTemplate;
    import com.sulake.core.window.graphics.renderer.BitmapSkinTemplateEntity;
    import com.sulake.core.window.graphics.renderer.ISkinLayout;
    import com.sulake.core.window.enum.WindowState;
    import com.sulake.core.window.graphics.renderer.*;

    public class BitmapSkinParser 
    {

        public static const _SafeStr_4075:String = "default";
        public static const _SafeStr_4586:String = "active";
        public static const _SafeStr_9170:String = "focused";
        public static const _SafeStr_5004:String = "hovering";
        public static const _SafeStr_9258:String = "selected";
        public static const _SafeStr_6248:String = "pressed";
        public static const _SafeStr_9399:String = "disabled";
        public static const _SafeStr_9479:String = "locked";

        public static function parseSkinDescription(_arg_1:XML, _arg_2:XMLList, _arg_3:ISkinRenderer, _arg_4:String, _arg_5:IAssetLibrary):void
        {
            var _local_12:XML;
            var _local_13:XMLList;
            var _local_14:XMLList;
            var _local_15:uint;
            var _local_16:uint;
            var _local_17:XML;
            var _local_18:XMLList;
            var _local_19:uint;
            var _local_20:uint;
            var _local_21:uint;
            var _local_22:XML;
            var _local_6:Map = new Map();
            var _local_7:XMLList = _arg_1.child("variables");
            if (_local_7.length() > 0){
                _local_12 = _local_7[0];
                _local_13 = _local_12.child("variable");
                if (_local_13.length()){
                    XMLVariableParser.parseVariableList(_local_13, _local_6);
                };
            };
            var _local_8:Dictionary = new Dictionary();
            var _local_9:XMLList = _arg_1.child("templates");
            if (_local_9[0]){
                parseTemplateList(_arg_3, _local_9[0], _local_8, _local_6, _arg_5);
            };
            var _local_10:Dictionary = new Dictionary();
            var _local_11:XMLList = _arg_1.child("layouts");
            if (_local_11[0]){
                if (_arg_4 == null){
                    parseLayoutList(_arg_3, _local_11[0], _local_10, _local_6);
                }
                else {
                    _local_14 = _local_11[0].child("layout");
                    _local_15 = _local_14.length();
                    _local_16 = 0;
                    while (_local_16 < _local_15) {
                        _local_17 = _local_14[_local_16];
                        if (_local_17.attribute("name") == _arg_4){
                            parseLayout(_arg_3, _local_17, _local_10, _local_6);
                            break;
                        };
                        _local_16++;
                    };
                };
            };
            if (_arg_2.length() == 0){
                _arg_2 = _arg_1.child("states");
            };
            if (_arg_2.length() > 0){
                if (_arg_4 == null){
                    parseRenderStateList(_arg_3, _arg_2[0], _local_10, _local_6);
                }
                else {
                    _local_18 = _arg_2[0].child("state");
                    _local_19 = _local_18.length();
                    _local_20 = 0;
                    _local_21 = 0;
                    while (_local_21 < _local_19) {
                        _local_22 = _local_18[_local_21];
                        if (_local_22.attribute("layout") == _arg_4){
                            parseState(_arg_3, _local_22, _local_10, _local_6);
                            _local_20++;
                        };
                        _local_21++;
                    };
                };
            };
        }
        protected static function parseLayout(_arg_1:ISkinRenderer, _arg_2:XML, _arg_3:Dictionary, _arg_4:Map):void
        {
            var _local_11:XML;
            var _local_12:XMLList;
            var _local_5:String = _arg_2.attribute("name");
            var _local_6 = (_arg_2.attribute("transparent") == "true");
            var _local_7:IChildEntityArray = new ChildEntityArray();
            var _local_8:String = _arg_2.attribute("blendMode");
            var _local_9:SkinLayout = new SkinLayout(_local_5, _local_6, _local_8, _local_7);
            var _local_10:XMLList = _arg_2.child("entities");
            if (_local_10.length() > 0){
                _local_11 = _local_10[0];
                _local_12 = _local_11.child("entity");
                if (_local_12.length()){
                    parseLayoutEntityList(_arg_1, _local_9, _local_12, _arg_4);
                };
            };
            _arg_3[_local_5] = _local_9;
            _arg_1.addLayout(_local_9);
        }
        protected static function parseLayoutList(_arg_1:ISkinRenderer, _arg_2:XML, _arg_3:Dictionary, _arg_4:Map):void
        {
            var _local_8:XML;
            var _local_5:XMLList = _arg_2.child("layout");
            var _local_6:uint = _local_5.length();
            var _local_7:uint;
            while (_local_7 < _local_6) {
                _local_8 = _local_5[_local_7];
                parseLayout(_arg_1, _local_8, _arg_3, _arg_4);
                _local_7++;
            };
        }
        protected static function static(_arg_1:XML, _arg_2:Map):SkinLayoutEntity
        {
            var _local_3:uint;
            var _local_4:String;
            var _local_5:SkinLayoutEntity;
            var _local_6:String;
            var _local_7:XML;
            var _local_8:XMLList;
            _local_6 = _arg_1.attribute("id");
            _local_3 = (((_local_6 == null)) ? 0 : uint(_local_6));
            _local_6 = _arg_1.attribute("name");
            _local_4 = (((_local_6 == null)) ? "" : _local_6);
            _local_5 = new SkinLayoutEntity(_local_3, _local_4);
            _local_6 = _arg_1.attribute("colorize");
            _local_5.colorize = (((_local_6 == "")) ? true : (_local_6 == "true"));
            _local_6 = null;
            _local_8 = _arg_1.child("color");
            if (_local_8.length() > 0){
                _local_7 = _local_8[0];
                _local_6 = String(_local_7);
                if (_local_6 != null){
                    if (_local_6.charAt(0) == "$"){
                        _local_6 = _arg_2[_local_6.slice(1, _local_6.length)];
                    };
                };
            };
            _local_5.color = (((_local_6 == null)) ? 0 : uint(_local_6));
            _local_6 = null;
            _local_8 = _arg_1.child("blend");
            if (_local_8.length() > 0){
                _local_7 = _local_8[0];
                _local_6 = String(_local_7);
                if (_local_6 != null){
                    if (_local_6.charAt(0) == "$"){
                        _local_6 = _arg_2[_local_6.slice(1, _local_6.length)];
                    };
                };
            };
            _local_5.blend = (((_local_6 == null)) ? 0xFFFFFFFF : uint(_local_6));
            _local_8 = _arg_1.child("scale");
            if (_local_8.length() > 0){
                _local_7 = _local_8[0];
                _local_6 = _local_7.attribute("horizontal");
                if (_local_6 != null){
                    if (_local_6.charAt(0) == "$"){
                        _local_6 = _arg_2[_local_6.slice(1, _local_6.length)];
                    };
                };
                switch (_local_6.toLowerCase()){
                    case "fixed":
                        _local_5._SafeStr_4078 = SkinLayoutEntity._SafeStr_4086;
                        break;
                    case "move":
                        _local_5._SafeStr_4078 = SkinLayoutEntity._SafeStr_4079;
                        break;
                    case "strech":
                        _local_5._SafeStr_4078 = SkinLayoutEntity._SafeStr_4080;
                        break;
                    case "tiled":
                        _local_5._SafeStr_4078 = SkinLayoutEntity._SafeStr_4081;
                        break;
                    case "center":
                        _local_5._SafeStr_4078 = SkinLayoutEntity._SafeStr_4082;
                        break;
                };
                _local_6 = _local_7.attribute("vertical");
                if (_local_6 != null){
                    if (_local_6.charAt(0) == "$"){
                        _local_6 = _arg_2[_local_6.slice(1, _local_6.length)];
                    };
                };
                switch (_local_6.toLowerCase()){
                    case "fixed":
                        _local_5._SafeStr_4083 = SkinLayoutEntity._SafeStr_4086;
                        break;
                    case "move":
                        _local_5._SafeStr_4083 = SkinLayoutEntity._SafeStr_4079;
                        break;
                    case "strech":
                        _local_5._SafeStr_4083 = SkinLayoutEntity._SafeStr_4080;
                        break;
                    case "tiled":
                        _local_5._SafeStr_4083 = SkinLayoutEntity._SafeStr_4081;
                        break;
                    case "center":
                        _local_5._SafeStr_4083 = SkinLayoutEntity._SafeStr_4082;
                        break;
                };
            };
            _local_8 = _arg_1.child("region");
            if (_local_8.length() > 0){
                _local_7 = _local_8[0];
                _local_8 = _local_7.child("Rectangle");
                _local_7 = _local_8[0];
                _local_5.region = new Rectangle();
                _local_6 = _local_7.attribute("x");
                _local_5.region.x = Number((((_local_6.charAt(0))=="$") ? _arg_2[_local_6.slice(1, _local_6.length)] : _local_6));
                _local_6 = _local_7.attribute("y");
                _local_5.region.y = Number((((_local_6.charAt(0))=="$") ? _arg_2[_local_6.slice(1, _local_6.length)] : _local_6));
                _local_6 = _local_7.attribute("width");
                _local_5.region.width = Number((((_local_6.charAt(0))=="$") ? _arg_2[_local_6.slice(1, _local_6.length)] : _local_6));
                _local_6 = _local_7.attribute("height");
                _local_5.region.height = Number((((_local_6.charAt(0))=="$") ? _arg_2[_local_6.slice(1, _local_6.length)] : _local_6));
            };
            return (_local_5);
        }
        protected static function parseLayoutEntityList(_arg_1:ISkinRenderer, _arg_2:SkinLayout, _arg_3:XMLList, _arg_4:Map):void
        {
            var _local_5:SkinLayoutEntity;
            var _local_6:uint;
            var _local_7:uint = _arg_3.length();
            _local_6 = 0;
            while (_local_6 < _local_7) {
                _local_5 = static(_arg_3[_local_6], _arg_4);
                if (_local_5 != null){
                    _arg_2.addChild(_local_5);
                };
                _local_6++;
            };
        }
        protected static function parseTemplateList(_arg_1:ISkinRenderer, _arg_2:XML, _arg_3:Dictionary, _arg_4:Map, _arg_5:IAssetLibrary):void
        {
            var _local_9:XML;
            var _local_10:String;
            var _local_11:String;
            var _local_12:BitmapSkinTemplate;
            var _local_13:XMLList;
            var _local_14:XML;
            var _local_15:XMLList;
            var _local_6:XMLList = _arg_2.child("template");
            var _local_7:uint = _local_6.length();
            var _local_8:uint;
            while (_local_8 < _local_7) {
                _local_9 = _local_6[_local_8];
                _local_10 = _local_9.attribute("name");
                if (_local_10 != null){
                    if (_local_10.charAt(0) == "$"){
                        _local_10 = _arg_4[_local_10.slice(1, _local_10.length)];
                    };
                };
                _local_11 = _local_9.attribute("asset");
                if (_local_11 != null){
                    if (_local_11.charAt(0) == "$"){
                        _local_11 = _arg_4[_local_11.slice(1, _local_11.length)];
                    };
                };
                _local_12 = new BitmapSkinTemplate(_local_10, _arg_5.getAssetByName(_local_11));
                _local_13 = _local_9.child("entities");
                if (_local_13.length() > 0){
                    _local_14 = _local_13[0];
                    _local_15 = _local_14.child("entity");
                    if (_local_15.length()){
                        parseTemplateEntityList(_arg_1, _local_12, _local_15, _arg_4);
                    };
                };
                _arg_3[_local_10] = _local_12;
                _arg_1.addTemplate(_local_12);
                _local_8++;
            };
        }
        protected static function parseTemplateEntityList(_arg_1:ISkinRenderer, _arg_2:BitmapSkinTemplate, _arg_3:XMLList, _arg_4:Map):void
        {
            var _local_5:XML;
            var _local_6:XMLList;
            var _local_7:XML;
            var _local_8:XMLList;
            var _local_9:XML;
            var _local_10:String;
            var _local_11:String;
            var _local_12:String;
            var _local_13:uint;
            var _local_14:Rectangle;
            var _local_16:int;
            var _local_15:int = _arg_3.length();
            _local_16 = 0;
            while (_local_16 < _local_15) {
                _local_5 = _arg_3[_local_16];
                _local_10 = _local_5.attribute("name");
                _local_11 = (((_local_10.charAt(0))=="$") ? _arg_4[_local_10.slice(1, _local_10.length)] : _local_10);
                _local_10 = _local_5.attribute("type");
                _local_12 = (((_local_10.charAt(0))=="$") ? _arg_4[_local_10.slice(1, _local_10.length)] : _local_10);
                _local_10 = _local_5.attribute("id");
                _local_13 = uint((((_local_10.charAt(0))=="$") ? _arg_4[_local_10.slice(1, _local_10.length)] : _local_10));
                _local_6 = _local_5.child("region");
                if (_local_6.length() > 0){
                    _local_7 = _local_6[0];
                    _local_6 = _local_7.child("Rectangle");
                    _local_7 = _local_6[0];
                    _local_14 = new Rectangle();
                    _local_10 = _local_7.attribute("x");
                    _local_14.x = Number((((_local_10.charAt(0))=="$") ? _arg_4[_local_10.slice(1, _local_10.length)] : _local_10));
                    _local_10 = _local_7.attribute("y");
                    _local_14.y = Number((((_local_10.charAt(0))=="$") ? _arg_4[_local_10.slice(1, _local_10.length)] : _local_10));
                    _local_10 = _local_7.attribute("width");
                    _local_14.width = Number((((_local_10.charAt(0))=="$") ? _arg_4[_local_10.slice(1, _local_10.length)] : _local_10));
                    _local_10 = _local_7.attribute("height");
                    _local_14.height = Number((((_local_10.charAt(0))=="$") ? _arg_4[_local_10.slice(1, _local_10.length)] : _local_10));
                };
                _local_8 = _local_5.child("variables");
                if (_local_8.length() > 0){
                    _local_9 = _local_8[0];
                    _local_8 = _local_9.child("variable");
                    _arg_4 = new Map();
                    XMLVariableParser.parseVariableList(_local_8, _arg_4);
                };
                _arg_2.addChild(new BitmapSkinTemplateEntity(_local_11, _local_12, _local_13, _local_14, _arg_4));
                _local_16++;
            };
        }
        protected static function parseState(_arg_1:ISkinRenderer, _arg_2:XML, _arg_3:Dictionary, _arg_4:Map):void
        {
            var _local_11:XML;
            var _local_12:XMLList;
            var _local_13:Map;
            var _local_14:String;
            var _local_15:Object;
            var _local_5:String = _arg_2.attribute("name");
            if (_local_5.charAt(0) == "$"){
                _local_5 = _arg_4[_local_5.slice(1, _local_5.length)];
            };
            var _local_6:String = _arg_2.attribute("layout");
            if (_local_6.charAt(0) == "$"){
                _local_6 = _arg_4[_local_6.slice(1, _local_6.length)];
            };
            var _local_7:String = _arg_2.attribute("template");
            if (_local_7.charAt(0) == "$"){
                _local_7 = _arg_4[_local_7.slice(1, _local_7.length)];
            };
            var _local_8:ISkinLayout = _arg_3[_local_6];
            if (_local_8 == null){
                throw (new Error((((("State " + _local_5) + " has invalid layout reference ") + _local_6) + "!")));
            };
            var _local_9:XMLList = _arg_2.child("variables");
            if (_local_9.length() > 0){
                _local_11 = _local_9[0];
                _local_12 = _local_11.child("variable");
                if (_local_12.length()){
                    _local_13 = new Map();
                    XMLVariableParser.parseVariableList(_local_12, _local_13);
                    for (_local_14 in _local_13) {
                        _local_15 = _local_13[_local_14];
                        if ((_local_15 is String)){
                            if (String(_local_15).charAt(0) == "$"){
                                _local_15 = _arg_4[_local_15.slice(1, _local_15.length)];
                                _local_13[_local_14] = _local_15;
                            };
                        };
                    };
                };
            };
            var _local_10:uint = WindowState._SafeStr_4075;
            switch (_local_5){
                case BitmapSkinParser._SafeStr_4586:
                    _local_10 = WindowState._SafeStr_4586;
                    break;
                case BitmapSkinParser._SafeStr_4075:
                    _local_10 = WindowState._SafeStr_4075;
                    break;
                case BitmapSkinParser._SafeStr_9170:
                    _local_10 = WindowState._SafeStr_9170;
                    break;
                case BitmapSkinParser._SafeStr_9399:
                    _local_10 = WindowState._SafeStr_9399;
                    break;
                case BitmapSkinParser._SafeStr_5004:
                    _local_10 = WindowState._SafeStr_5004;
                    break;
                case BitmapSkinParser._SafeStr_6248:
                    _local_10 = WindowState._SafeStr_6248;
                    break;
                case BitmapSkinParser._SafeStr_9258:
                    _local_10 = WindowState._SafeStr_9258;
                    break;
                case BitmapSkinParser._SafeStr_9479:
                    _local_10 = WindowState._SafeStr_9479;
                    break;
                default:
                    throw (new Error((('Unknown window state: "' + _local_5) + '"!')));
            };
            _arg_1.registerLayoutForRenderState(_local_10, _local_6);
            _arg_1.registerTemplateForRenderState(_local_10, _local_7);
        }
        protected static function parseRenderStateList(_arg_1:ISkinRenderer, _arg_2:XML, _arg_3:Dictionary, _arg_4:Map):void
        {
            var _local_5:XMLList = _arg_2.child("state");
            var _local_6:uint = _local_5.length();
            var _local_7:uint;
            while (_local_7 < _local_6) {
                parseState(_arg_1, _local_5[_local_7], _arg_3, _arg_4);
                _local_7++;
            };
        }

    }
}//package com.sulake.core.window.graphics

// XMLVariableParser = "_-pR" (String#24252, DoABC#2)
// IChildEntityArray = "_-2oU" (String#7047, DoABC#2)
// ISkinLayout = "_-m8" (String#2182, DoABC#2)
// ISkinRenderer = "_-1uJ" (String#1780, DoABC#2)
// WindowState = "_-1Kt" (String#5262, DoABC#2)
// BitmapSkinParser = "_-0dO" (String#4378, DoABC#2)
// SkinLayoutEntity = "_-27j" (String#6196, DoABC#2)
// ChildEntityArray = "_-w1" (String#8805, DoABC#2)
// SkinLayout = "_-2Ti" (String#6640, DoABC#2)
// BitmapSkinTemplate = "_-8c" (String#7834, DoABC#2)
// BitmapSkinTemplateEntity = "_-33m" (String#7382, DoABC#2)
// addLayout = "_-2RX" (String#6597, DoABC#2)
// registerLayoutForRenderState = "_-ZK" (String#8402, DoABC#2)
// addTemplate = "_-1FX" (String#5163, DoABC#2)
// registerTemplateForRenderState = "_-U7" (String#8289, DoABC#2)
// parseSkinDescription = "_-tq" (String#24441, DoABC#2)
// _SafeStr_4075 = "_-0DX" (String#14589, DoABC#2)
// _SafeStr_4078 = "_-30D" (String#21509, DoABC#2)
// _SafeStr_4079 = "_-0Lq" (String#14907, DoABC#2)
// _SafeStr_4080 = "_-2Gj" (String#19670, DoABC#2)
// _SafeStr_4081 = "_-0AU" (String#14466, DoABC#2)
// _SafeStr_4082 = "_-0dp" (String#15577, DoABC#2)
// _SafeStr_4083 = "_-2vf" (String#21301, DoABC#2)
// _SafeStr_4086 = "_-0SW" (String#15154, DoABC#2)
// _SafeStr_4586 = "_-22X" (String#19111, DoABC#2)
// _SafeStr_5004 = "_-0Yv" (String#15399, DoABC#2)
// _SafeStr_6248 = "_-3J9" (String#22246, DoABC#2)
// _SafeStr_9170 = "_-2FR" (String#19621, DoABC#2)
// _SafeStr_9258 = "const" (String#44694, DoABC#2)
// _SafeStr_9399 = "_-1WJ" (String#17754, DoABC#2)
// _SafeStr_9479 = "_-H4" (String#22893, DoABC#2)
// parseTemplateList = "_-22G" (String#19102, DoABC#2)
// parseLayoutList = "_-1MO" (String#17375, DoABC#2)
// parseLayout = "_-TL" (String#23379, DoABC#2)
// parseRenderStateList = "_-102" (String#16468, DoABC#2)
// parseState = "_-pM" (String#24248, DoABC#2)
// parseLayoutEntityList = "_-3GE" (String#22129, DoABC#2)
// parseTemplateEntityList = "_-0kW" (String#15849, DoABC#2)


