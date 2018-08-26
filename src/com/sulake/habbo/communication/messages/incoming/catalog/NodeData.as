
package com.sulake.habbo.communication.messages.incoming.catalog
{
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class NodeData 
    {

        private var _navigateable:Boolean;
        private var _color:int;
        private var _icon:int;
        private var _pageId:int;
        private var _localization:String;
        private var _nodes:Array;

        public function NodeData(_arg_1:IMessageDataWrapper)
        {
            this._navigateable = Boolean(_arg_1.readInteger());
            this._color = _arg_1.readInteger();
            this._icon = _arg_1.readInteger();
            this._pageId = _arg_1.readInteger();
            this._localization = _arg_1.readString();
            this._nodes = new Array();
            var _local_2:int = _arg_1.readInteger();
            var _local_3:int;
            while (_local_3 < _local_2) {
                this._nodes.push(new NodeData(_arg_1));
                _local_3++;
            };
        }
        public function get navigateable():Boolean
        {
            return (this._navigateable);
        }
        public function get color():int
        {
            return (this._color);
        }
        public function get icon():int
        {
            return (this._icon);
        }
        public function get pageId():int
        {
            return (this._pageId);
        }
        public function get localization():String
        {
            return (this._localization);
        }
        public function get nodes():Array
        {
            return (this._nodes);
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.catalog

// NodeData = "_-02P" (String#3615, DoABC#2)
// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// readString = "_-2y7" (String#1973, DoABC#2)
// _pageId = "_-251" (String#366, DoABC#2)
// _navigateable = "_-AS" (String#22634, DoABC#2)
// _nodes = "_-JB" (String#8065, DoABC#2)
// navigateable = "_-0EP" (String#14623, DoABC#2)
// nodes = "_-7H" (String#22513, DoABC#2)


