
package com.sulake.core.runtime
{
    import com.sulake.core.runtime.IDisposable;
    import flash.utils.getQualifiedClassName;
    import com.sulake.core.runtime.IID;
    import com.sulake.core.runtime.IUnknown;
    import com.sulake.core.runtime.*;

    final class InterfaceStructList implements IDisposable 
    {

        private var _content:Array;

        public function InterfaceStructList()
        {
            this._content = new Array();
            super();
        }
        public function get length():uint
        {
            return (this._content.length);
        }
        public function get disposed():Boolean
        {
            return ((this._content == null));
        }
        public function dispose():void
        {
            var _local_2:InterfaceStruct;
            var _local_1:uint = this._content.length;
            var _local_3:uint;
            while (_local_3 < _local_1) {
                _local_2 = this._content.pop();
                _local_2.dispose();
                _local_3++;
            };
            this._content = null;
        }
        public function insert(_arg_1:InterfaceStruct):uint
        {
            this._content.push(_arg_1);
            return (this._content.length);
        }
        public function remove(_arg_1:uint):InterfaceStruct
        {
            var _local_2:InterfaceStruct;
            if (_arg_1 < this._content.length){
                _local_2 = this._content[_arg_1];
                this._content.splice(_arg_1, 1);
                return (_local_2);
            };
            throw (new Error("Index out of range!"));
        }
        public function find(_arg_1:IID):IUnknown
        {
            var _local_4:InterfaceStruct;
            var _local_2:String = getQualifiedClassName(_arg_1);
            var _local_3:uint = this._content.length;
            var _local_5:uint;
            while (_local_5 < _local_3) {
                _local_4 = (this._content[_local_5] as InterfaceStruct);
                if (_local_4.iis == _local_2){
                    return (_local_4.unknown);
                };
                _local_5++;
            };
            return (null);
        }
        public function getStructByInterface(_arg_1:IID):InterfaceStruct
        {
            var _local_3:InterfaceStruct;
            var _local_2:String = getQualifiedClassName(_arg_1);
            var _local_4:uint = this._content.length;
            var _local_5:uint;
            while (_local_5 < _local_4) {
                _local_3 = (this._content[_local_5] as InterfaceStruct);
                if (_local_3.iis == _local_2){
                    return (_local_3);
                };
                _local_5++;
            };
            return (null);
        }
        public function getIndexByInterface(_arg_1:IID):int
        {
            var _local_3:InterfaceStruct;
            var _local_2:String = getQualifiedClassName(_arg_1);
            var _local_4:uint = this._content.length;
            var _local_5:int;
            while (_local_5 < _local_4) {
                _local_3 = (this._content[_local_5] as InterfaceStruct);
                if (_local_3.iis == _local_2){
                    return (_local_5);
                };
                _local_5++;
            };
            return (-1);
        }
        public function mapStructsByInterface(_arg_1:IID, _arg_2:Array):uint
        {
            var _local_5:InterfaceStruct;
            var _local_3:String = getQualifiedClassName(_arg_1);
            var _local_4:uint;
            var _local_6:uint = this._content.length;
            var _local_7:uint;
            while (_local_7 < _local_6) {
                _local_5 = (this._content[_local_7] as InterfaceStruct);
                if (_local_5.iis == _local_3){
                    _arg_2.push(_local_5);
                    _local_4++;
                };
                _local_7++;
            };
            return (_local_4);
        }
        public function getStructByImplementor(_arg_1:IUnknown):InterfaceStruct
        {
            var _local_2:InterfaceStruct;
            var _local_3:uint = this._content.length;
            var _local_4:uint;
            while (_local_4 < _local_3) {
                _local_2 = (this._content[_local_4] as InterfaceStruct);
                if (_local_2.unknown == _arg_1){
                    return (_local_2);
                };
                _local_4++;
            };
            return (null);
        }
        public function getIndexByImplementor(_arg_1:IUnknown):int
        {
            var _local_2:InterfaceStruct;
            var _local_3:uint = this._content.length;
            var _local_4:uint;
            while (_local_4 < _local_3) {
                _local_2 = (this._content[_local_4] as InterfaceStruct);
                if (_local_2.unknown == _arg_1){
                    return (_local_4);
                };
                _local_4++;
            };
            return (-1);
        }
        public function mapStructsByImplementor(_arg_1:IUnknown, _arg_2:Array):uint
        {
            var _local_4:InterfaceStruct;
            var _local_3:uint;
            var _local_5:uint = this._content.length;
            var _local_6:uint;
            while (_local_6 < _local_5) {
                _local_4 = (this._content[_local_6] as InterfaceStruct);
                if (_local_4.unknown == _arg_1){
                    _arg_2.push(_local_4);
                    _local_3++;
                };
                _local_6++;
            };
            return (_local_3);
        }
        public function getStructByIndex(_arg_1:uint):InterfaceStruct
        {
            return ((((_arg_1)<this._content.length) ? this._content[_arg_1] : null));
        }
        public function getTotalReferenceCount():uint
        {
            var _local_2:InterfaceStruct;
            var _local_1:uint;
            var _local_3:uint = this._content.length;
            var _local_4:uint;
            while (_local_4 < _local_3) {
                _local_2 = (this._content[_local_4] as InterfaceStruct);
                _local_1 = (_local_1 + _local_2.references);
                _local_4++;
            };
            return (_local_1);
        }

    }
}//package com.sulake.core.runtime

// IID = "_-3KV" (String#7712, DoABC#2)
// IDisposable = "_-0dY" (String#4382, DoABC#2)
// _content = "_-1Q8" (String#74, DoABC#2)
// InterfaceStructList = "_-0ur" (String#16233, DoABC#2)
// InterfaceStruct = "_-2vc" (String#7189, DoABC#2)
// getIndexByImplementor = "_-m6" (String#24113, DoABC#2)
// iis = "_-2RW" (String#20099, DoABC#2)
// references = "_-1yb" (String#18912, DoABC#2)
// getTotalReferenceCount = "_-2A5" (String#19408, DoABC#2)
// getStructByIndex = "_-1BO" (String#16913, DoABC#2)
// getIndexByInterface = "_-t5" (String#24409, DoABC#2)
// mapStructsByInterface = "_-nb" (String#24176, DoABC#2)
// getStructByImplementor = "_-5n" (String#22454, DoABC#2)


