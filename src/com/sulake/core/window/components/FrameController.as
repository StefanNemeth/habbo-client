
package com.sulake.core.window.components
{
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.utils.IMargins;
    import com.sulake.core.window.enum.WindowParam;
    import com.sulake.core.window.WindowContext;
    import flash.geom.Rectangle;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.utils.TextMargins;
    import com.sulake.core.window.utils.Iterator;
    import com.sulake.core.window.utils.IIterator;
    import com.sulake.core.utils.Map;
    import com.sulake.core.window.WindowController;
    import com.sulake.core.window.utils.PropertyStruct;
    import com.sulake.core.window.utils.PropertyDefaults;

    public class FrameController extends ContainerController implements IFrameWindow 
    {

        private static const _TITLE:String = "_TITLE";
        private static const _HEADER:String = "_HEADER";
        private static const _CONTENT:String = "_CONTENT";
        private static const _SCALER:String = "_SCALER";

        private var _title:ILabelWindow;
        private var _header:IHeaderWindow;
        private var _content:IWindowContainer;
        private var _margins:IMargins;
        private var _ready:Boolean = false;

        public function FrameController(_arg_1:String, _arg_2:uint, _arg_3:uint, _arg_4:uint, _arg_5:WindowContext, _arg_6:Rectangle, _arg_7:IWindow, _arg_8:Function=null, _arg_9:Array=null, _arg_10:Array=null, _arg_11:uint=0)
        {
            _arg_4 = (_arg_4 | WindowParam._SafeStr_7434);
            super(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5, _arg_6, _arg_7, _arg_8, _arg_9, _arg_10, _arg_11);
            this._ready = true;
            activate();
            this.FrameController();
        }
        public function get title():ILabelWindow
        {
            if (this._title == null){
                this._title = (findChildByTag(_TITLE) as ILabelWindow);
                if (!this._title){
                    throw (new Error("Frame window's title element not available!"));
                };
            };
            return (this._title);
        }
        public function get header():IHeaderWindow
        {
            if (this._header == null){
                this._header = (findChildByTag(_HEADER) as IHeaderWindow);
                if (!this._header){
                    throw (new Error("Frame window's header element not available!"));
                };
            };
            return (this._header);
        }
        public function get content():IWindowContainer
        {
            if (this._content == null){
                this._content = (findChildByTag(_CONTENT) as IWindowContainer);
                if (!this._content){
                    throw (new Error("Frame window's content element not available!"));
                };
            };
            return (this._content);
        }
        public function get scaler():IScalerWindow
        {
            return ((findChildByTag(_SCALER) as IScalerWindow));
        }
        public function get margins():IMargins
        {
            var _local_1:Rectangle;
            if (!this._margins){
                _local_1 = this.content.rectangle;
                this._margins = new TextMargins(_local_1.left, _local_1.top, _local_1.right, _local_1.bottom, this.FrameController);
            };
            return (this._margins);
        }
        override public function set caption(value:String):void
        {
            super.caption = value;
            try {
                this.title.text = value;
            }
            catch(e:Error) {
            };
        }
        override public function set color(_arg_1:uint):void
        {
            var _local_3:IWindow;
            super.color = _arg_1;
            var _local_2:Array = new Array();
            WindowController(_COLORIZE, _local_2, false);
            for each (_local_3 in _local_2) {
                _local_3.color = _arg_1;
            };
        }
        override public function get iterator():IIterator
        {
            return (((((!((this.content == null))) && (this._ready))) ? this.content.iterator : new Iterator(this)));
        }
        override public function buildFromXML(_arg_1:XML, _arg_2:Map=null):Boolean
        {
            return (!((context.getWindowParser().parseAndConstruct(_arg_1, this.content, _arg_2) == null)));
        }
        override public function setParamFlag(_arg_1:uint, _arg_2:Boolean=true):void
        {
            super.setParamFlag(_arg_1, _arg_2);
            this.FrameController();
        }
        private function FrameController():void
        {
            var _local_1:IWindow = this.scaler;
            var _local_2:Boolean = IWindow(WindowParam._SafeStr_7492);
            var _local_3:Boolean = IWindow(WindowParam._SafeStr_7497);
            var _local_4:Boolean = IWindow(WindowParam._SafeStr_7496);
            if (_local_1){
                if (((_local_3) || (_local_2))){
                    _local_1.setParamFlag(WindowParam._SafeStr_7497, true);
                }
                else {
                    _local_1.setParamFlag(WindowParam._SafeStr_7497, false);
                };
                if (((_local_4) || (_local_2))){
                    _local_1.setParamFlag(WindowParam._SafeStr_7496, true);
                }
                else {
                    _local_1.setParamFlag(WindowParam._SafeStr_7496, false);
                };
                _local_1.visible = ((((_local_3) || (_local_4))) || (_local_2));
            };
        }
        public function IFrameWindow():void
        {
            resizeToAccommodateChildren((this.content as WindowController));
        }
        private function FrameController(_arg_1:IMargins):void
        {
            var _local_2:IWindow = this.content;
            var _local_3:uint = _local_2.param;
            var _local_4:uint = (_local_2.param & (WindowParam._SafeStr_7454 | WindowParam._SafeStr_7464));
            if (_local_4){
                _local_2.setParamFlag((WindowParam._SafeStr_7454 | WindowParam._SafeStr_7464), false);
            };
            var _local_5:uint = (_local_2.param & WindowParam._SafeStr_9362);
            if (_local_5){
                _local_2.setParamFlag(WindowParam._SafeStr_9362, false);
            };
            _local_2.rectangle = new Rectangle(_arg_1.left, _arg_1.top, (_arg_1.right - _arg_1.left), (_arg_1.bottom - _arg_1.top));
            if (((_local_4) || (_local_5))){
                _local_2.setParamFlag(0xFFFFFFFF, false);
                _local_2.setParamFlag(_local_3, true);
            };
        }
        override public function get properties():Array
        {
            var _local_1:Array = super.properties;
            var _local_2 = !((this._margins == null));
            var _local_3:Rectangle = this.content.rectangle;
            _local_1.push(new PropertyStruct(PropertyDefaults._SafeStr_9121, _local_3.left, PropertyStruct._SafeStr_8992, _local_2));
            _local_1.push(new PropertyStruct(PropertyDefaults._SafeStr_9122, _local_3.top, PropertyStruct._SafeStr_8992, _local_2));
            _local_1.push(new PropertyStruct(PropertyDefaults._SafeStr_9123, (_rectangle.width - _local_3.right), PropertyStruct._SafeStr_8992, _local_2));
            _local_1.push(new PropertyStruct(PropertyDefaults._SafeStr_9124, (_rectangle.height - _local_3.bottom), PropertyStruct._SafeStr_8992, _local_2));
            return (_local_1);
        }
        override public function set properties(_arg_1:Array):void
        {
            var _local_2:PropertyStruct;
            for each (_local_2 in _arg_1) {
                switch (_local_2.key){
                    case PropertyDefaults._SafeStr_9121:
                        this.margins.left = (_local_2.value as int);
                        break;
                    case PropertyDefaults._SafeStr_9122:
                        this.margins.top = (_local_2.value as int);
                        break;
                    case PropertyDefaults._SafeStr_9123:
                        this.margins.right = (_rectangle.width - (_local_2.value as int));
                        break;
                    case PropertyDefaults._SafeStr_9124:
                        this.margins.bottom = (_rectangle.height - (_local_2.value as int));
                        break;
                };
            };
            super.properties = _arg_1;
        }

    }
}//package com.sulake.core.window.components

// WindowContext = "_-2K8" (String#6447, DoABC#2)
// IScalerWindow = "_-2bU" (String#1906, DoABC#2)
// IHeaderWindow = "_-1zq" (String#1792, DoABC#2)
// IMargins = "_-1mu" (String#1757, DoABC#2)
// IIterator = "_-6K" (String#7788, DoABC#2)
// ContainerController = "_-1v4" (String#5943, DoABC#2)
// PropertyStruct = "_-t6" (String#24410, DoABC#2)
// PropertyDefaults = "_-3Dd" (String#22019, DoABC#2)
// TextMargins = "_-2Jl" (String#19801, DoABC#2)
// FrameController = "_-Tj" (String#8280, DoABC#2)
// Iterator = "_-G2" (String#7994, DoABC#2)
// _content = "_-o4" (String#96, DoABC#2)
// _ready = "_-2-1" (String#1794, DoABC#2)
// _SafeStr_7434 = "_-2xA" (String#21356, DoABC#2)
// _SafeStr_7454 = "_-sy" (String#24403, DoABC#2)
// _SafeStr_7464 = "_-1u-" (String#18716, DoABC#2)
// _SafeStr_7492 = "_-0tz" (String#16201, DoABC#2)
// _SafeStr_7496 = "_-1Ig" (String#17221, DoABC#2)
// _SafeStr_7497 = "_-0TU" (String#15191, DoABC#2)
// _SafeStr_8992 = "_-5d" (String#22447, DoABC#2)
// _margins = "_-063" (String#1402, DoABC#2)
// _rectangle = "_-0-q" (String#3560, DoABC#2)
// _SafeStr_9121 = "_-Gc" (String#22874, DoABC#2)
// _SafeStr_9122 = "_-3-3" (String#21463, DoABC#2)
// _SafeStr_9123 = "_-Vu" (String#23489, DoABC#2)
// _SafeStr_9124 = "_-tF" (String#24416, DoABC#2)
// IWindow = "_-1ml" (String#5794, DoABC#2)
// _TITLE = "_-zu" (String#8882, DoABC#2)
// WindowController = "_-cU" (String#2141, DoABC#2)
// _COLORIZE = "_-EQ" (String#22789, DoABC#2)
// _HEADER = "_-0Uw" (String#15239, DoABC#2)
// _CONTENT = "_-0gl" (String#15699, DoABC#2)
// _SCALER = "_-1Vd" (String#17727, DoABC#2)
// _header = "_-oJ" (String#24204, DoABC#2)
// FrameController = "_-Ov" (String#23202, DoABC#2)
// FrameController = "_-eR" (String#23819, DoABC#2)
// IFrameWindow = "_-09S" (String#3746, DoABC#2)
// _SafeStr_9362 = "_-199" (String#16823, DoABC#2)


