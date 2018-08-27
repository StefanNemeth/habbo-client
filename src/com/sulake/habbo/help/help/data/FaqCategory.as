
package com.sulake.habbo.help.help.data
{
    import com.sulake.core.utils.Map;

    public class FaqCategory 
    {

        private var _categoryId:int;
        private var _categoryTitle:String;
        private var _description:String;
        private var _SafeStr_11366:Map;
        private var _itemCount:int = 0;
        private var _timeStamp:Date;

        public function FaqCategory(_arg_1:int, _arg_2:String)
        {
            this._SafeStr_11366 = new Map();
            this._categoryId = _arg_1;
            this._categoryTitle = _arg_2;
        }
        public function get categoryId():int
        {
            return (this._categoryId);
        }
        public function get categoryTitle():String
        {
            return (this._categoryTitle);
        }
        public function get description():String
        {
            return (this._description);
        }
        public function get itemCount():int
        {
            if (this._SafeStr_11366.length == 0){
                return (this._itemCount);
            };
            return (this._SafeStr_11366.length);
        }
        public function set description(_arg_1:String):void
        {
            this._description = _arg_1;
        }
        public function set itemCount(_arg_1:int):void
        {
            this._itemCount = _arg_1;
        }
        public function dispose():void
        {
            if (this._SafeStr_11366 != null){
                this._SafeStr_11366.dispose();
                this._SafeStr_11366 = null;
            };
        }
        public function storeItem(_arg_1:int, _arg_2:String, _arg_3:String=null):void
        {
            var _local_4:FaqItem = this.getItem(_arg_1);
            if (_local_4 == null){
                _local_4 = new FaqItem(_arg_1, _arg_2, this._SafeStr_11366.length, this);
                this._SafeStr_11366.add(_arg_1, _local_4);
            };
        }
        public function storeItemAnswer(_arg_1:int, _arg_2:String):void
        {
            var _local_3:FaqItem = this.getItem(_arg_1);
            if (_local_3 != null){
                _local_3.answerText = _arg_2;
            };
        }
        public function reset():void
        {
            if (this._SafeStr_11366 != null){
                this._SafeStr_11366.reset();
            };
        }
        public function getItemByIndex(_arg_1:int):FaqItem
        {
            if (_arg_1 >= this._SafeStr_11366.length){
                return (null);
            };
            return (this._SafeStr_11366.getWithIndex(_arg_1));
        }
        public function getItemIdByIndex(_arg_1:int):int
        {
            var _local_2:FaqItem = this.getItemByIndex(_arg_1);
            if (_local_2 == null){
                return (-1);
            };
            return (_local_2.questionId);
        }
        public function hasItem(_arg_1:int):Boolean
        {
            return (!((this._SafeStr_11366.getValue(_arg_1) == null)));
        }
        public function getItem(_arg_1:int):FaqItem
        {
            return (this._SafeStr_11366.getValue(_arg_1));
        }
        public function getItemIndex(_arg_1:int):int
        {
            var _local_2:FaqItem = this.getItem(_arg_1);
            if (_local_2 == null){
                return (-1);
            };
            return (_local_2.index);
        }
        public function getQuestionTitleArray():Array
        {
            var _local_2:FaqItem;
            var _local_1:Array = new Array();
            var _local_3:int;
            while (_local_3 < this._SafeStr_11366.length) {
                _local_2 = this._SafeStr_11366.getWithIndex(_local_3);
                _local_1.push(_local_2.questionText);
                _local_3++;
            };
            return (_local_1);
        }
        public function hasContent():Boolean
        {
            return ((((this._SafeStr_11366.length > 0)) || (this.hasUpdatedWithinHour())));
        }
        public function setTimeStamp():void
        {
            this._timeStamp = new Date();
        }
        public function getAgeSeconds():Number
        {
            if (this._timeStamp == null){
                return (new Date().valueOf());
            };
            return (((new Date().valueOf() - this._timeStamp.valueOf()) / 1000));
        }
        private function hasUpdatedWithinHour():Boolean
        {
            return ((this.getAgeSeconds() < (60 * 60)));
        }

    }
}//package com.sulake.habbo.help.help.data

// hasItem = "_-0G8" (String#14690, DoABC#2)
// categoryTitle = "_-35k" (String#21720, DoABC#2)
// _categoryTitle = "_-2CK" (String#19497, DoABC#2)
// _SafeStr_11366 = "_-2LG" (String#19859, DoABC#2)
// _itemCount = "_-1aC" (String#17902, DoABC#2)
// storeItem = "_-1Tt" (String#17661, DoABC#2)
// storeItemAnswer = "_-0LV" (String#14894, DoABC#2)
// getItemByIndex = "_-2P9" (String#20007, DoABC#2)
// getItemIdByIndex = "_-Nm" (String#23156, DoABC#2)
// getItemIndex = "_-2EK" (String#19579, DoABC#2)
// getQuestionTitleArray = "_-2HA" (String#19692, DoABC#2)
// questionText = "_-0FL" (String#14658, DoABC#2)
// hasContent = "_-1Qz" (String#17547, DoABC#2)
// hasUpdatedWithinHour = "_-MY" (String#23106, DoABC#2)
// setTimeStamp = "_-2L" (String#19846, DoABC#2)
// getAgeSeconds = "_-1CQ" (String#16963, DoABC#2)
// FaqCategory = "_-0JM" (String#3941, DoABC#2)
// FaqItem = "_-1u6" (String#5923, DoABC#2)
// questionId = "_-3-c" (String#21486, DoABC#2)
// getItem = "_-0un" (String#16229, DoABC#2)
// _description = "_-1a7" (String#164, DoABC#2)
// _categoryId = "_-1If" (String#186, DoABC#2)
// itemCount = "_-1fH" (String#18108, DoABC#2)
// _timeStamp = "_-1IA" (String#845, DoABC#2)
// answerText = "_-3JS" (String#22262, DoABC#2)


