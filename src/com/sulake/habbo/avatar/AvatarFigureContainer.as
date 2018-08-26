
package com.sulake.habbo.avatar
{
    import com.sulake.core.utils.Map;

    public class AvatarFigureContainer implements IAvatarFigureContainer 
    {

        private var _parts:Map;

        public function AvatarFigureContainer(_arg_1:String)
        {
            this._parts = new Map();
            this.parseFigureString(_arg_1);
        }
        public function getPartTypeIds():Array
        {
            return (this.getParts().getKeys());
        }
        public function hasPartType(_arg_1:String):Boolean
        {
            return (!((this.getParts().getValue(_arg_1) == null)));
        }
        public function getPartSetId(_arg_1:String):int
        {
            var _local_2:Map = (this.getParts().getValue(_arg_1) as Map);
            if (_local_2 != null){
                return ((_local_2.getValue("setid") as int));
            };
            return (0);
        }
        public function getPartColorIds(_arg_1:String):Array
        {
            var _local_2:Map = (this.getParts().getValue(_arg_1) as Map);
            if (_local_2 != null){
                return ((_local_2.getValue("colorids") as Array));
            };
            return (null);
        }
        public function updatePart(_arg_1:String, _arg_2:int, _arg_3:Array):void
        {
            var _local_4:Map = new Map();
            _local_4.add("type", _arg_1);
            _local_4.add("setid", _arg_2);
            _local_4.add("colorids", _arg_3);
            var _local_5:Map = this.getParts();
            _local_5.remove(_arg_1);
            _local_5.add(_arg_1, _local_4);
        }
        public function removePart(_arg_1:String):void
        {
            this.getParts().remove(_arg_1);
        }
        public function getFigureString():String
        {
            var _local_2:String;
            var _local_3:Array;
            var _local_1:Array = [];
            for each (_local_2 in this.getParts().getKeys()) {
                _local_3 = [];
                _local_3.push(_local_2);
                _local_3.push(this.getPartSetId(_local_2));
                _local_3 = _local_3.concat(this.getPartColorIds(_local_2));
                _local_1.push(_local_3.join("-"));
            };
            return (_local_1.join("."));
        }
        private function getParts():Map
        {
            if (this._parts == null){
                this._parts = new Map();
            };
            return (this._parts);
        }
        private function parseFigureString(_arg_1:String):void
        {
            var _local_2:String;
            var _local_3:Array;
            var _local_4:String;
            var _local_5:int;
            var _local_6:Array;
            var _local_7:int;
            if (_arg_1 == null){
                _arg_1 = "";
            };
            for each (_local_2 in _arg_1.split(".")) {
                _local_3 = _local_2.split("-");
                if (_local_3.length >= 2){
                    _local_4 = String(_local_3[0]);
                    _local_5 = parseInt(_local_3[1]);
                    _local_6 = new Array();
                    _local_7 = 2;
                    while (_local_7 < _local_3.length) {
                        _local_6.push(parseInt(_local_3[_local_7]));
                        _local_7++;
                    };
                    this.updatePart(_local_4, _local_5, _local_6);
                };
            };
        }

    }
}//package com.sulake.habbo.avatar

// parseFigureString = "_-tr" (String#8765, DoABC#2)
// getPartTypeIds = "_-2ig" (String#6925, DoABC#2)
// hasPartType = "_-064" (String#3687, DoABC#2)
// getPartColorIds = "_-AZ" (String#7879, DoABC#2)
// removePart = "_-123" (String#4917, DoABC#2)
// IAvatarFigureContainer = "_-2-D" (String#6034, DoABC#2)
// AvatarFigureContainer = "_-04P" (String#14219, DoABC#2)
// getParts = "_-3DP" (String#7583, DoABC#2)
// getFigureString = "_-0-z" (String#3563, DoABC#2)
// updatePart = "_-1C9" (String#5112, DoABC#2)


