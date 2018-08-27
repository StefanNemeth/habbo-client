
package com.sulake.habbo.help.help.data
{
    import com.sulake.core.utils.Map;

    public class FaqIndex 
    {

        private var _SafeStr_11347:FaqCategory;
        private var _SafeStr_11348:FaqCategory;
        private var _SafeStr_11349:FaqCategory;
        private var _SafeStr_11350:Map;
        private var _lastUpdatedQuestionId:int;
        private var _lastUpdatedCategoryId:int;

        public function FaqIndex()
        {
            this._SafeStr_11347 = new FaqCategory(-999, "${help.faq.title.urgent}");
            this._SafeStr_11348 = new FaqCategory(-9999, "${help.faq.title.normal}");
            this._SafeStr_11349 = new FaqCategory(-99999, "${help.faq.title.searchresults}");
            this._SafeStr_11350 = new Map();
        }
        public function get lastUpdatedQuestionId():int
        {
            return (this._lastUpdatedQuestionId);
        }
        public function get lastUpdatedCategoryId():int
        {
            return (this._lastUpdatedCategoryId);
        }
        public function dispose():void
        {
            var _local_1:int;
            var _local_2:FaqCategory;
            if (this._SafeStr_11350 != null){
                _local_1 = 0;
                while (_local_1 < this._SafeStr_11350.length) {
                    _local_2 = this._SafeStr_11350.getWithIndex(_local_1);
                    _local_2.dispose();
                    _local_1++;
                };
                this._SafeStr_11350.dispose();
                this._SafeStr_11350 = null;
            };
            this._SafeStr_11347.dispose();
            this._SafeStr_11348.dispose();
            this._SafeStr_11349.dispose();
        }
        public function getCategory(_arg_1:int, _arg_2:String=null, _arg_3:Boolean=false):FaqCategory
        {
            var _local_4:FaqCategory = this._SafeStr_11350.getValue(_arg_1);
            if (((!((_local_4 == null))) || (!(_arg_3)))){
                return (_local_4);
            };
            _local_4 = new FaqCategory(_arg_1, _arg_2);
            this._SafeStr_11350.add(_arg_1, _local_4);
            return (_local_4);
        }
        public function getItem(_arg_1:int, _arg_2:int=-1):FaqItem
        {
            if (_arg_2 < 0){
                return (this.findItem(_arg_1));
            };
            var _local_3:FaqCategory = this.getCategory(_arg_2);
            if (_local_3 == null){
                return (null);
            };
            return (_local_3.getItem(_arg_1));
        }
        public function storeAnswerText(_arg_1:int, _arg_2:String):void
        {
            var _local_4:FaqCategory;
            if (this._SafeStr_11347.hasItem(_arg_1)){
                this._SafeStr_11347.getItem(_arg_1).answerText = _arg_2;
            };
            if (this._SafeStr_11348.hasItem(_arg_1)){
                this._SafeStr_11348.getItem(_arg_1).answerText = _arg_2;
            };
            if (this._SafeStr_11349.hasItem(_arg_1)){
                this._SafeStr_11349.getItem(_arg_1).answerText = _arg_2;
            };
            var _local_3:int;
            while (_local_3 < this._SafeStr_11350.length) {
                _local_4 = this._SafeStr_11350.getWithIndex(_local_3);
                if (_local_4.hasItem(_arg_1)){
                    _local_4.getItem(_arg_1).answerText = _arg_2;
                };
                _local_3++;
            };
        }
        public function getFrontPageUrgentCategory():FaqCategory
        {
            return (this._SafeStr_11347);
        }
        public function getFrontPageNormalCategory():FaqCategory
        {
            return (this._SafeStr_11348);
        }
        public function getSearchResultCategory():FaqCategory
        {
            return (this._SafeStr_11349);
        }
        public function getCategoryCount():int
        {
            return (this._SafeStr_11350.length);
        }
        public function getCategoryByIndex(_arg_1:int):FaqCategory
        {
            if (_arg_1 >= this._SafeStr_11350.length){
                return (null);
            };
            return (this._SafeStr_11350.getWithIndex(_arg_1));
        }
        public function getCategoryTitleArray():Array
        {
            var _local_2:FaqCategory;
            var _local_1:Array = new Array();
            var _local_3:int;
            while (_local_3 < this._SafeStr_11350.length) {
                _local_2 = this._SafeStr_11350.getWithIndex(_local_3);
                if (_local_2 != null){
                    _local_1.push(_local_2.categoryTitle);
                };
                _local_3++;
            };
            return (_local_1);
        }
        private function findItem(_arg_1:int):FaqItem
        {
            var _local_3:FaqCategory;
            if (this._SafeStr_11347.hasItem(_arg_1)){
                return (this._SafeStr_11347.getItem(_arg_1));
            };
            if (this._SafeStr_11348.hasItem(_arg_1)){
                return (this._SafeStr_11348.getItem(_arg_1));
            };
            if (this._SafeStr_11349.hasItem(_arg_1)){
                return (this._SafeStr_11349.getItem(_arg_1));
            };
            var _local_2:int;
            while (_local_2 < this._SafeStr_11350.length) {
                _local_3 = this._SafeStr_11350.getWithIndex(_local_2);
                if (_local_3.hasItem(_arg_1)){
                    return (_local_3.getItem(_arg_1));
                };
                _local_2++;
            };
            return (null);
        }

    }
}//package com.sulake.habbo.help.help.data

// _SafeStr_11347 = "_-1zb" (String#18952, DoABC#2)
// _SafeStr_11348 = "_-2rV" (String#21137, DoABC#2)
// _SafeStr_11349 = "_-1PP" (String#17484, DoABC#2)
// _SafeStr_11350 = "_-2dK" (String#6818, DoABC#2)
// _lastUpdatedCategoryId = "_-2ui" (String#21266, DoABC#2)
// lastUpdatedQuestionId = "_-3IF" (String#22212, DoABC#2)
// lastUpdatedCategoryId = "_-1f1" (String#18099, DoABC#2)
// getCategory = "_-Ir" (String#22962, DoABC#2)
// findItem = "_-28j" (String#19359, DoABC#2)
// storeAnswerText = "_-21O" (String#19067, DoABC#2)
// hasItem = "_-0G8" (String#14690, DoABC#2)
// getFrontPageUrgentCategory = "_-zh" (String#24676, DoABC#2)
// getFrontPageNormalCategory = "_-Ij" (String#22955, DoABC#2)
// getSearchResultCategory = "_-2O6" (String#19969, DoABC#2)
// getCategoryCount = "_-0sg" (String#16149, DoABC#2)
// getCategoryByIndex = "_-11L" (String#16511, DoABC#2)
// getCategoryTitleArray = "_-0nT" (String#15955, DoABC#2)
// categoryTitle = "_-35k" (String#21720, DoABC#2)
// FaqIndex = "_-3I0" (String#7667, DoABC#2)
// FaqCategory = "_-0JM" (String#3941, DoABC#2)
// FaqItem = "_-1u6" (String#5923, DoABC#2)
// getItem = "_-0un" (String#16229, DoABC#2)
// answerText = "_-3JS" (String#22262, DoABC#2)


