
package com.sulake.habbo.catalog.navigation
{
    import com.sulake.habbo.communication.messages.incoming.catalog.NodeData;
    import flash.display.BitmapData;

    public class CatalogNode implements ICatalogNode 
    {

        private static const _SafeStr_10316:Array = [4293190884, 4293914607, 0xFFFFDB54, 4289454682, 4289431551, 4285716709, 4294016606, 4293326172, 4293694138, 4285383659, 4293082689, 4288782753];
        private static const ICON_PREFIX:String = "icon_";

        private var _depth:int = 0;
        private var _isNavigateable:Boolean = false;
        private var _localization:String = "";
        private var _pageId:int = -1;
        private var _color:uint = 0;
        private var _iconId:int = 0;
        private var _children:Array;
        private var _navigator:ICatalogNavigator;
        private var _parent:ICatalogNode;

        public function CatalogNode(_arg_1:ICatalogNavigator, _arg_2:NodeData, _arg_3:int)
        {
            this._children = [];
            super();
            this._depth = _arg_3;
            this._navigator = _arg_1;
            this._isNavigateable = _arg_2.navigateable;
            this._localization = _arg_2.localization;
            this._pageId = _arg_2.pageId;
            this._color = _SafeStr_10316[_arg_2.color];
            this._iconId = _arg_2.icon;
            this._children = [];
        }
        public function get IssueBrowser():Boolean
        {
            return (false);
        }
        public function get depth():int
        {
            return (this._depth);
        }
        public function get isBranch():Boolean
        {
            return ((this._children.length > 0));
        }
        public function get isLeaf():Boolean
        {
            return ((this._children.length == 0));
        }
        public function get isNavigateable():Boolean
        {
            return (this._isNavigateable);
        }
        public function get localization():String
        {
            return (this._localization);
        }
        public function get pageId():int
        {
            return (this._pageId);
        }
        public function get color():uint
        {
            return (this._color);
        }
        public function get icon():BitmapData
        {
            return (null);
        }
        public function get children():Array
        {
            return (this._children);
        }
        public function get navigator():ICatalogNavigator
        {
            return (this._navigator);
        }
        public function get parent():ICatalogNode
        {
            return (this._parent);
        }
        public function set parent(_arg_1:ICatalogNode):void
        {
            this._parent = _arg_1;
        }
        public function dispose():void
        {
            var _local_1:ICatalogNode;
            for each (_local_1 in this._children) {
                _local_1.dispose();
            };
            this._children = null;
            this._navigator = null;
            this._parent = null;
        }
        public function hasChild(_arg_1:ICatalogNode):Boolean
        {
            var _local_2:ICatalogNode;
            for each (_local_2 in this._children) {
                if (_local_2 == _arg_1){
                    return (true);
                };
            };
            return (false);
        }
        public function addChild(_arg_1:ICatalogNode):void
        {
            if (_arg_1 == null){
                return;
            };
            this._children.push(_arg_1);
            _arg_1.parent = this;
        }
        public function activate():void
        {
        }
        public function deActivate():void
        {
        }
        public function open():void
        {
        }
        public function close():void
        {
        }
        protected function get iconName():String
        {
            if (this._iconId < 1){
                return ("");
            };
            return ((ICON_PREFIX + this._iconId.toString()));
        }

    }
}//package com.sulake.habbo.catalog.navigation

// isNavigateable = "_-1Ts" (String#5429, DoABC#2)
// isBranch = "_-0o2" (String#4593, DoABC#2)
// isLeaf = "_-2Tk" (String#6641, DoABC#2)
// hasChild = "_-1eH" (String#5633, DoABC#2)
// _SafeStr_10316 = "_-YJ" (String#23574, DoABC#2)
// _isNavigateable = "_-uE" (String#24460, DoABC#2)
// ICatalogNavigator = "_-24D" (String#6126, DoABC#2)
// NodeData = "_-02P" (String#3615, DoABC#2)
// ICatalogNode = "_-0Td" (String#4172, DoABC#2)
// CatalogNode = "_-148" (String#4959, DoABC#2)
// IssueBrowser = "_-2i4" (String#897, DoABC#2)
// _pageId = "_-251" (String#366, DoABC#2)
// _depth = "_-XX" (String#935, DoABC#2)
// navigateable = "_-0EP" (String#14623, DoABC#2)
// _iconId = "_-32l" (String#7362, DoABC#2)
// iconName = "_-1Xn" (String#5513, DoABC#2)


