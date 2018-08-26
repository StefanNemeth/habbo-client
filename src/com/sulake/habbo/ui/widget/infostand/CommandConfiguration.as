
package com.sulake.habbo.ui.widget.infostand
{
    import flash.utils.Dictionary;

    public class CommandConfiguration 
    {

        private var _allCommandIds:Array;
        private var _enabledCommands:Dictionary;

        public function CommandConfiguration(_arg_1:Array, _arg_2:Array)
        {
            var _local_3:int;
            var _local_4:int;
            this._enabledCommands = new Dictionary();
            super();
            this._allCommandIds = _arg_1;
            while (_local_3 < _arg_2.length) {
                _local_4 = _arg_2[_local_3];
                this._enabledCommands[_local_4] = true;
                _local_3++;
            };
        }
        public function get allCommandIds():Array
        {
            return (this._allCommandIds);
        }
        public function isEnabled(_arg_1:int):Boolean
        {
            return (!((this._enabledCommands[_arg_1] == null)));
        }

    }
}//package com.sulake.habbo.ui.widget.infostand

// allCommandIds = "_-2Df" (String#19552, DoABC#2)
// CommandConfiguration = "_-2sa" (String#21184, DoABC#2)
// _allCommandIds = "_-37L" (String#7453, DoABC#2)
// isEnabled = "_-2ri" (String#21145, DoABC#2)
// _enabledCommands = "_-1GF" (String#843, DoABC#2)


