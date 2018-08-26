
package com.sulake.core.window.utils
{
    import flash.utils.Dictionary;
    import com.sulake.core.utils.Map;
    import com.sulake.core.window.IWindowContext;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.utils.XMLVariableParser;
    import com.sulake.core.window.WindowController;
    import flash.geom.Rectangle;
    import com.sulake.core.window.enum.WindowParam;
    import flash.filters.BitmapFilter;
    import flash.filters.DropShadowFilter;
    import flash.utils.*;

    public class WindowParser implements IWindowParser 
    {

        public static const _EXCLUDE:String = "_EXCLUDE";
        public static const _INCLUDE:String = "_INCLUDE";
        public static const _TEMP:String = "_TEMP";
        private static const _SafeStr_9685:String = "layout";
        private static const _SafeStr_9686:String = "window";
        private static const _SafeStr_9687:String = "variables";
        private static const _SafeStr_9688:String = "filters";
        private static const _SafeStr_8785:String = "name";
        private static const _SafeStr_9689:String = "style";
        private static const _SafeStr_9690:String = "params";
        private static const _SafeStr_9691:String = "tags";
        private static const X:String = "x";
        private static const Y:String = "y";
        private static const _SafeStr_9007:String = "width";
        private static const _SafeStr_9008:String = "height";
        private static const _SafeStr_9692:String = "visible";
        private static const _SafeStr_9693:String = "caption";
        private static const ID:String = "id";
        private static const _SafeStr_3421:String = "background";
        private static const _SafeStr_9616:String = "blend";
        private static const _SafeStr_9694:String = "clipping";
        private static const COLOR:String = "color";
        private static const _SafeStr_9695:String = "treshold";
        private static const _SafeStr_9696:String = "children";
        private static const _SafeStr_9697:String = "width_min";
        private static const WIDTH_MAX:String = "width_max";
        private static const _SafeStr_9698:String = "height_min";
        private static const _SafeStr_9699:String = "height_max";
        private static const _SafeStr_9005:String = "true";
        private static const 0:String = "0";
        private static const $1String = "$";
        private static const ,:String = ",";
        private static const :String = "";
        private static const _SafeStr_9701:RegExp = /^(\s|\n|\r|\t|\v)*/m;
        private static const _SafeStr_9702:RegExp = /(\s|\n|\r|\t|\v)*$/;

        protected var _SafeStr_9703:Dictionary;
        protected var _SafeStr_9704:Dictionary;
        protected var _SafeStr_9705:Dictionary;
        protected var _SafeStr_9706:Dictionary;
        protected var _SafeStr_9707:Map;
        protected var _context:IWindowContext;
        private var _disposed:Boolean = false;

        public function WindowParser(_arg_1:IWindowContext)
        {
            this._context = _arg_1;
            this._SafeStr_9703 = new Dictionary();
            this._SafeStr_9704 = new Dictionary();
            TypeCodeTable.fillTables(this._SafeStr_9703, this._SafeStr_9704);
            this._SafeStr_9705 = new Dictionary();
            this._SafeStr_9706 = new Dictionary();
            ParamCodeTable.fillTables(this._SafeStr_9705, this._SafeStr_9706);
            this._SafeStr_9707 = new Map();
        }
        private static function trimWhiteSpace(_arg_1:String):String
        {
            _arg_1 = _arg_1.replace(_SafeStr_9702, );
            return (_arg_1.replace(_SafeStr_9701, ));
        }

        public function get disposed():Boolean
        {
            return (this._disposed);
        }
        public function dispose():void
        {
            var _local_1:Object;
            if (!this._disposed){
                for (_local_1 in this._SafeStr_9703) {
                    delete this._SafeStr_9703[_local_1];
                };
                for (_local_1 in this._SafeStr_9704) {
                    delete this._SafeStr_9704[_local_1];
                };
                for (_local_1 in this._SafeStr_9705) {
                    delete this._SafeStr_9705[_local_1];
                };
                for (_local_1 in this._SafeStr_9706) {
                    delete this._SafeStr_9706[_local_1];
                };
                this._SafeStr_9707.dispose();
                this._SafeStr_9707 = null;
                this._context = null;
                this._disposed = true;
            };
        }
        public function parseAndConstruct(_arg_1:XML, _arg_2:IWindow, _arg_3:Map):IWindow
        {
            var _local_4:XMLList;
            var _local_5:uint;
            var _local_6:IWindow;
            var _local_7:uint;
            var _local_8:XMLList;
            var _local_9:XMLList;
            var _local_10:XML;
            var _local_11:XMLList;
            var _local_12:Array;
            var _local_13:uint;
            if (_arg_1.localName() == _SafeStr_9685){
                _local_8 = _arg_1.child(_SafeStr_9687);
                if (_local_8.length() > 0){
                    _local_10 = _local_8[0];
                    _local_11 = XML(_local_10[0]).children();
                    if (_local_11.length() > 0){
                        if (_arg_3 == null){
                            _arg_3 = new Map();
                        };
                        XMLVariableParser.parseVariableList(_local_11, _arg_3);
                    };
                };
                _local_9 = _arg_1.child(_SafeStr_9688).children();
                if (_local_9.length() > 0){
                    _local_12 = new Array();
                    _local_13 = 0;
                    while (_local_13 < _local_9.length()) {
                        _local_12.push(this.WindowParser(_local_9[_local_13]));
                        _local_13++;
                    };
                    _arg_2.filters = _local_12;
                };
                _local_4 = _arg_1.child(_SafeStr_9686);
                _local_5 = _local_4.length();
                switch (_local_5){
                    case 0:
                        return (null);
                    case 1:
                        _arg_1 = _local_4[0];
                        break;
                    default:
                        _local_7 = 0;
                        while (_local_7 < _local_5) {
                            _local_6 = this.WindowParser(_local_4[_local_7], WindowController(_arg_2), _arg_3);
                            _local_7++;
                        };
                        return (_local_6);
                };
            };
            if (_arg_1.localName() == _SafeStr_9686){
                _local_4 = _arg_1.children();
                _local_5 = _local_4.length();
                if (_local_5 > 1){
                    _local_7 = 0;
                    while (_local_7 < _local_5) {
                        _local_6 = this.WindowParser(_local_4[_local_7], WindowController(_arg_2), _arg_3);
                        _local_7++;
                    };
                    return (_local_6);
                };
                _arg_1 = _arg_1.children()[0];
            };
            return ((((_arg_1)!=null) ? this.WindowParser(_arg_1, WindowController(_arg_2), _arg_3) : null));
        }
        private function WindowParser(xml:XML, parent:WindowController, variables:Map):IWindow
        {
            var window:WindowController;
            var type:uint;
            var name:String;
            var rect:Rectangle;
            var node:XML;
            var list:XMLList;
            var length:uint;
            var i:uint;
            var tags:Array;
            var param:String;
            var filters:Array;
            var iterator:IIterator;
            var caption:String = ;
            var visible:Boolean = true;
            var clipping:Boolean = true;
            var color:String = "0x00ffffff";
            var blend:Number = 1;
            var background:Boolean;
            var treshold:uint = 10;
            var style:uint = (((parent)!=null) ? parent.style : 0);
            var params:uint;
            var tag:String = ;
            var id:int;
            type = this._SafeStr_9703[xml.localName()];
            name = unescape(String(this.WindowParser(xml, _SafeStr_8785, variables, "")));
            style = uint(this.WindowParser(xml, _SafeStr_9689, variables, style));
            params = uint(this.WindowParser(xml, _SafeStr_9690, variables, params));
            tag = unescape(String(this.WindowParser(xml, _SafeStr_9691, variables, tag)));
            rect = new Rectangle();
            rect.x = Number(this.WindowParser(xml, X, variables, 0));
            rect.y = Number(this.WindowParser(xml, Y, variables, 0));
            rect.width = Number(this.WindowParser(xml, _SafeStr_9007, variables, 0));
            rect.height = Number(this.WindowParser(xml, _SafeStr_9008, variables, 0));
            visible = (this.WindowParser(xml, _SafeStr_9692, variables, visible.toString()) == _SafeStr_9005);
            id = int(this.WindowParser(xml, ID, variables, id.toString()));
            if (xml.child(_SafeStr_9690).length() > 0){
                list = xml.child(_SafeStr_9690).children();
                length = list.length();
                i = 0;
                while (i < length) {
                    node = list[i];
                    param = (this.WindowParser(node, _SafeStr_8785, variables, "") as String);
                    if (this._SafeStr_9705[param] != null){
                        params = (params | this._SafeStr_9705[param]);
                    }
                    else {
                        throw (new Error((('Unknown window parameter "' + String(node.attribute(_SafeStr_8785))) + '"!')));
                    };
                    i++;
                };
            };
            caption = (((params & WindowParam._SafeStr_9508)) ? ((parent) ? parent.caption : ) : );
            caption = unescape(String(this.WindowParser(xml, _SafeStr_9693, variables, caption)));
            if (tag != ){
                tags = tag.split(,);
                length = tags.length;
                i = 0;
                while (i < length) {
                    tags[i] = WindowParser.trimWhiteSpace(tags[i]);
                    i++;
                };
            };
            window = (this._context.create(name, null, type, style, params, rect, null, (((parent is IIterable)) ? null : parent), id, this.WindowParser(xml.child(_SafeStr_9687)[0]), tags) as WindowController);
            if (this.WindowParser(xml, _SafeStr_9697)){
                window.limits.minWidth = int(this.WindowParser(xml, _SafeStr_9697, variables, window.limits.minWidth));
            };
            if (this.WindowParser(xml, WIDTH_MAX)){
                window.limits.maxWidth = int(this.WindowParser(xml, WIDTH_MAX, variables, window.limits.maxWidth));
            };
            if (this.WindowParser(xml, _SafeStr_9698)){
                window.limits.minHeight = int(this.WindowParser(xml, _SafeStr_9698, variables, window.limits.minHeight));
            };
            if (this.WindowParser(xml, _SafeStr_9699)){
                window.limits.maxHeight = int(this.WindowParser(xml, _SafeStr_9699, variables, window.limits.maxHeight));
            };
            background = (this.WindowParser(xml, _SafeStr_3421, variables, window.background.toString()) == _SafeStr_9005);
            blend = Number(this.WindowParser(xml, _SafeStr_9616, variables, window.blend.toString()));
            clipping = (this.WindowParser(xml, _SafeStr_9694, variables, window.clipping.toString()) == _SafeStr_9005);
            color = String(this.WindowParser(xml, COLOR, variables, window.color.toString()));
            treshold = uint(this.WindowParser(xml, _SafeStr_9695, variables, window.mouseThreshold.toString()));
            if (window.caption != caption){
                window.caption = caption;
            };
            if (window.blend != blend){
                window.blend = blend;
            };
            if (window.visible != visible){
                window.visible = visible;
            };
            if (window.clipping != clipping){
                window.clipping = clipping;
            };
            if (window.background != background){
                window.background = background;
            };
            if (window.mouseThreshold != treshold){
                window.mouseThreshold = treshold;
            };
            var temp:uint = (((color.charAt(1))==X) ? parseInt(color, 16) : uint(color));
            if (window.color != temp){
                window.color = temp;
            };
            list = xml.child(_SafeStr_9688).children();
            length = list.length();
            if (length > 0){
                filters = new Array();
                i = 0;
                while (i < length) {
                    filters.push(this.WindowParser(list[i]));
                    i++;
                };
                window.filters = filters;
            };
            if (window != null){
                if (parent != null){
                    if ((parent is IIterable)){
                        if (((((((!((window.x == rect.x))) || (!((window.y == rect.y))))) || (!((window.width == rect.width))))) || (!((window.height == rect.height))))){
                            if ((params & WindowParam._SafeStr_7454) == WindowParam._SafeStr_7452){
                                window.x = rect.x;
                            };
                            if ((params & WindowParam._SafeStr_7464) == WindowParam._SafeStr_7462){
                                window.y = rect.y;
                            };
                        };
                        try {
                            iterator = IIterable(parent).iterator;
                        }
                        catch(e:Error) {
                        };
                        if (iterator != null){
                            iterator[iterator.length] = window;
                        }
                        else {
                            parent.addChild(window);
                        };
                    };
                };
            };
            list = xml.child(_SafeStr_9696);
            if (list.length() > 0){
                node = list[0];
                list = node.children();
                length = list.length();
                i = 0;
                while (i < length) {
                    this.parseAndConstruct(list[i], window, variables);
                    i++;
                };
            };
            return (window);
        }
        private function WindowParser(_arg_1:XML, _arg_2:String):Boolean
        {
            return ((_arg_1.attribute(_arg_2).length() > 0));
        }
        private function WindowParser(_arg_1:XML, _arg_2:String, _arg_3:Map, _arg_4:Object):Object
        {
            var _local_5:XMLList = _arg_1.attribute(_arg_2);
            if (_local_5.length() == 0){
                return (_arg_4);
            };
            var _local_6:String = String(_local_5);
            if (_arg_3 != null){
                if (_local_6.charAt(0) == $1{
                    _local_6 = _arg_3[_local_6.slice(1, _local_6.length)];
                    if (_local_6 == null){
                        throw (new Error((('Shared variable not defined: "' + _arg_1.attribute(_arg_2)) + '"!')));
                    };
                };
            };
            return (_local_6);
        }
        private function WindowParser(_arg_1:XML):Array
        {
            return ((((_arg_1)!=null) ? XMLPropertyArrayParser.parse(_arg_1.children()) : new Array()));
        }
        public function windowToXMLString(_arg_1:IWindow):String
        {
            var _local_8:IIterator;
            var _local_10:IWindow;
            var _local_12:uint;
            var _local_14:PropertyStruct;
            var _local_15:BitmapFilter;
            var _local_16:String;
            var _local_17:Boolean;
            var _local_2:String = ;
            var _local_3:String = this._SafeStr_9704[_arg_1.type];
            var _local_4:uint = _arg_1.param;
            var _local_5:uint = _arg_1.style;
            var _local_6:IRectLimiter = _arg_1.limits;
            var _local_7:WindowController = (_arg_1 as WindowController);
            _local_2 = (_local_2 + (((((((((((((((((((((((((((((((((("<" + _local_3) + ' x="') + _arg_1.x) + '"') + ' y="') + _arg_1.y) + '"') + ' width="') + _arg_1.width) + '"') + ' height="') + _arg_1.height) + '"') + ' params="') + _arg_1.param) + '"') + ' style="') + _arg_1.style) + '"') + (((_arg_1.name)!=) ? ((' name="' + escape(_arg_1.name)) + '"') : )) + (((_arg_1.caption)!=) ? ((' caption="' + escape(_arg_1.caption)) + '"') : )) + (((_arg_1.id)!=0) ? ((' id="' + _arg_1.id.toString()) + '"') : )) + (((_arg_1.color)!=0xFFFFFF) ? ((((' color="' + "0x") + _arg_1.alpha.toString(16)) + _arg_1.color.toString(16)) + '"') : )) + (((_arg_1.blend)!=1) ? ((' blend="' + _arg_1.blend.toString()) + '"') : )) + (((_arg_1.visible)!=true) ? ((' visible="' + _arg_1.visible.toString()) + '"') : )) + (((_arg_1.clipping)!=true) ? ((' clipping="' + _arg_1.clipping.toString()) + '"') : )) + (((_arg_1.background)!=false) ? ((' background="' + _arg_1.background.toString()) + '"') : )) + (((_arg_1.mouseThreshold)!=10) ? ((' treshold="' + _arg_1.mouseThreshold.toString()) + '"') : )) + (((_arg_1.tags.length)>0) ? ((' tags="' + escape(_arg_1.tags.toString())) + '"') : )) + (((_local_6.minWidth)>int.MIN_VALUE) ? ((' width_min="' + _local_6.minWidth) + '"') : )) + (((_local_6.maxWidth)<int.MAX_VALUE) ? ((' width_max="' + _local_6.maxWidth) + '"') : )) + (((_local_6.minHeight)>int.MIN_VALUE) ? ((' height_min="' + _local_6.minHeight) + '"') : )) + (((_local_6.maxHeight)<int.MAX_VALUE) ? ((' height_max="' + _local_6.maxHeight) + '"') : )) + ">\r"));
            if (((_arg_1.filters) && ((_arg_1.filters.length > 0)))){
                _local_2 = (_local_2 + "\t<filters>\r");
                for each (_local_15 in _arg_1.filters) {
                    _local_2 = (_local_2 + (("\t\t" + this.WindowParser(_local_15)) + "\r"));
                };
                _local_2 = (_local_2 + "\t</filters>\r");
            };
            var _local_9:uint = _local_7.numChildren;
            var _local_11:String = ;
            if ((_local_7 is IIterable)){
                _local_8 = IIterable(_local_7).iterator;
                _local_9 = _local_8.length;
                if (_local_9 > 0){
                    _local_12 = 0;
                    while (_local_12 < _local_9) {
                        _local_10 = (_local_8[_local_12] as IWindow);
                        if (_local_10.tags.indexOf(WindowParser._EXCLUDE) == -1){
                            _local_11 = (_local_11 + this.windowToXMLString(_local_10));
                        };
                        _local_12++;
                    };
                };
            }
            else {
                _local_9 = _local_7.numChildren;
                if (_local_9 > 0){
                    _local_12 = 0;
                    while (_local_12 < _local_9) {
                        _local_10 = _local_7.getChildAt(_local_12);
                        if (_local_10.tags.indexOf(WindowParser._EXCLUDE) == -1){
                            _local_11 = (_local_11 + this.windowToXMLString(_local_10));
                        };
                        _local_12++;
                    };
                };
            };
            if (_local_11.length > 0){
                _local_2 = (_local_2 + (("\t<children>\r" + _local_11) + "\t</children>\r"));
            };
            var _local_13:Array = _arg_1.properties;
            if (((!((_local_13 == null))) && ((_local_13.length > 0)))){
                _local_16 = "\t<variables>\r";
                _local_17 = false;
                _local_12 = 0;
                while (_local_12 < _local_13.length) {
                    _local_14 = (_local_13[_local_12] as PropertyStruct);
                    if (_local_14.valid){
                        _local_16 = (_local_16 + (("\t\t" + _local_14.toXMLString()) + "\r"));
                        _local_17 = true;
                    };
                    _local_12++;
                };
                _local_16 = (_local_16 + "\t</variables>\r");
                if (_local_17){
                    _local_2 = (_local_2 + _local_16);
                };
            };
            return ((_local_2 + (("</" + _local_3) + ">\r")));
        }
        private function WindowParser(_arg_1:XML):BitmapFilter
        {
            var _local_3:BitmapFilter;
            var _local_2:String = (_arg_1.localName() as String);
            switch (_local_2){
                case "DropShadowFilter":
                    _local_3 = new DropShadowFilter(Number(this.WindowParser(_arg_1, "distance", null, "0")), Number(this.WindowParser(_arg_1, "angle", null, "45")), uint(this.WindowParser(_arg_1, "color", null, "0")), Number(this.WindowParser(_arg_1, "alpha", null, "1")), Number(this.WindowParser(_arg_1, "blurX", null, "0")), Number(this.WindowParser(_arg_1, "blurY", null, "0")), Number(this.WindowParser(_arg_1, "strength", null, "1")), int(this.WindowParser(_arg_1, "quality", null, "1")), Boolean((this.WindowParser(_arg_1, "inner", null, "false") == "true")), Boolean((this.WindowParser(_arg_1, "knockout", null, "false") == "true")), Boolean((this.WindowParser(_arg_1, "hideObject", null, "false") == "true")));
                    break;
            };
            return (_local_3);
        }
        private function WindowParser(_arg_1:BitmapFilter):String
        {
            var _local_2:String;
            if ((_arg_1 is DropShadowFilter)){
                _local_2 = "<DropShadowFilter";
                _local_2 = (_local_2 + (((DropShadowFilter(_arg_1).distance)!=0) ? ((' distance="' + DropShadowFilter(_arg_1).distance) + '"') : ""));
                _local_2 = (_local_2 + (((DropShadowFilter(_arg_1).angle)!=45) ? ((' angle="' + DropShadowFilter(_arg_1).angle) + '"') : ""));
                _local_2 = (_local_2 + (((DropShadowFilter(_arg_1).color)!=0) ? ((' color="' + DropShadowFilter(_arg_1).color) + '"') : ""));
                _local_2 = (_local_2 + (((DropShadowFilter(_arg_1).alpha)!=1) ? ((' alpha="' + DropShadowFilter(_arg_1).alpha) + '"') : ""));
                _local_2 = (_local_2 + (((DropShadowFilter(_arg_1).blurX)!=0) ? ((' blurX="' + DropShadowFilter(_arg_1).blurX) + '"') : ""));
                _local_2 = (_local_2 + (((DropShadowFilter(_arg_1).blurY)!=0) ? ((' blurY="' + DropShadowFilter(_arg_1).blurY) + '"') : ""));
                _local_2 = (_local_2 + (((DropShadowFilter(_arg_1).strength)!=1) ? ((' strength="' + DropShadowFilter(_arg_1).strength) + '"') : ""));
                _local_2 = (_local_2 + (((DropShadowFilter(_arg_1).quality)!=1) ? ((' quality="' + DropShadowFilter(_arg_1).quality) + '"') : ""));
                _local_2 = (_local_2 + (((DropShadowFilter(_arg_1).inner)!=false) ? ((' inner="' + DropShadowFilter(_arg_1).inner) + '"') : ""));
                _local_2 = (_local_2 + (((DropShadowFilter(_arg_1).knockout)!=false) ? ((' knockout="' + DropShadowFilter(_arg_1).knockout) + '"') : ""));
                _local_2 = (_local_2 + (((DropShadowFilter(_arg_1).hideObject)!=false) ? ((' hideObject="' + DropShadowFilter(_arg_1).hideObject) + '"') : ""));
                _local_2 = (_local_2 + " />");
            };
            return (_local_2);
        }

    }
}//package com.sulake.core.window.utils

// XMLVariableParser = "_-pR" (String#24252, DoABC#2)
// IIterable = "_-2BO" (String#6275, DoABC#2)
// IWindowContext = "_-8b" (String#2061, DoABC#2)
// IRectLimiter = "_-1O2" (String#5311, DoABC#2)
// IIterator = "_-6K" (String#7788, DoABC#2)
// IWindowParser = "_-14A" (String#4960, DoABC#2)
// WindowParser = "_-0Rl" (String#4128, DoABC#2)
// TypeCodeTable = "_-0bK" (String#4329, DoABC#2)
// PropertyStruct = "_-t6" (String#24410, DoABC#2)
// XMLPropertyArrayParser = "_-0b" (String#4324, DoABC#2)
// ParamCodeTable = "_-2E5" (String#6322, DoABC#2)
// _SafeStr_3421 = "_-0BR" (String#1420, DoABC#2)
// mouseThreshold = "_-0OA" (String#4051, DoABC#2)
//  = "_-PL" (String#8192, DoABC#2)
// _SafeStr_7452 = "_-2Hm" (String#19717, DoABC#2)
// _SafeStr_7454 = "_-sy" (String#24403, DoABC#2)
// _SafeStr_7462 = "_-15I" (String#16664, DoABC#2)
// _SafeStr_7464 = "_-1u-" (String#18716, DoABC#2)
// 0 = "_-1fe" (String#5657, DoABC#2)
// _SafeStr_8785 = "_-1OX" (String#605, DoABC#2)
// _SafeStr_9005 = "_-2hb" (String#6898, DoABC#2)
// _SafeStr_9007 = "_-iG" (String#2163, DoABC#2)
// _SafeStr_9008 = "_-hz" (String#2162, DoABC#2)
// , = "_-1gk" (String#5678, DoABC#2)
// valid = "_-H2" (String#22891, DoABC#2)
// limits = "_-2BM" (String#6274, DoABC#2)
// _SafeStr_9508 = "_-36f" (String#21753, DoABC#2)
// fillTables = "_-15n" (String#16687, DoABC#2)
// _SafeStr_9616 = "_-1DN" (String#5132, DoABC#2)
// windowToXMLString = "_-1D-" (String#841, DoABC#2)
// _EXCLUDE = "_-1Lh" (String#17344, DoABC#2)
// _INCLUDE = "_-01M" (String#14106, DoABC#2)
// _TEMP = "_-w8" (String#24535, DoABC#2)
// _SafeStr_9685 = "_-Fd" (String#22836, DoABC#2)
// _SafeStr_9686 = "_-2XJ" (String#6707, DoABC#2)
// _SafeStr_9687 = "_-02M" (String#14137, DoABC#2)
// _SafeStr_9688 = "_-AG" (String#22627, DoABC#2)
// _SafeStr_9689 = "_-0t5" (String#16163, DoABC#2)
// _SafeStr_9690 = "_-1fE" (String#18105, DoABC#2)
// _SafeStr_9691 = "_-1r7" (String#18586, DoABC#2)
// _SafeStr_9692 = "_-3Jy" (String#22283, DoABC#2)
// _SafeStr_9693 = "_-Dk" (String#22759, DoABC#2)
// _SafeStr_9694 = "_-LL" (String#23060, DoABC#2)
// _SafeStr_9695 = "_-2F4" (String#19607, DoABC#2)
// _SafeStr_9696 = "_-1Hh" (String#17178, DoABC#2)
// _SafeStr_9697 = "_-4h" (String#22404, DoABC#2)
// _SafeStr_9698 = "_-09v" (String#14443, DoABC#2)
// _SafeStr_9699 = "_-2zL" (String#21434, DoABC#2)
// $1= "_-05X" (String#14264, DoABC#2)
// _SafeStr_9701 = "_-2yU" (String#21410, DoABC#2)
// _SafeStr_9702 = "_-3Gg" (String#22149, DoABC#2)
// _SafeStr_9703 = "_-074" (String#14327, DoABC#2)
// _SafeStr_9704 = "_-12U" (String#16558, DoABC#2)
// _SafeStr_9705 = "_-0EJ" (String#14621, DoABC#2)
// _SafeStr_9706 = "_-0zu" (String#16422, DoABC#2)
// _SafeStr_9707 = "_-15X" (String#16677, DoABC#2)
// WindowParser = "_-25a" (String#19242, DoABC#2)
// WindowParser = "_-2YL" (String#20370, DoABC#2)
// WindowParser = "_-1my" (String#18419, DoABC#2)
// WindowParser = "_-6Y" (String#22483, DoABC#2)
// WindowParser = "_-KN" (String#23021, DoABC#2)
// WindowParser = "_-2b7" (String#20493, DoABC#2)


