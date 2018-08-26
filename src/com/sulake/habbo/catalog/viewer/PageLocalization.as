
package com.sulake.habbo.catalog.viewer
{
    import flash.utils.Dictionary;

    public class PageLocalization implements IPageLocalization 
    {

        private static const _SafeStr_4879:Array = ["ctlg_header_text", "ctlg_description", "ctlg_special_txt", "ctlg_text_1", "ctlg_text_2"];
        private static const _SafeStr_4880:Array = ["ctlg_header_img", "ctlg_teaserimg_1", "ctlg_special_img", "ctlg_teaserimg_2", "ctlg_teaserimg_3"];
        private static const LAYOUTS_IMAGE_FIELDS:Object = {"frontpage3":["ctlg_header_img", "ctlg_special_img", "frontpage_promotion"]};
        private static const LAYOUTS_TEXT_FIELDS:Object = {
            "camera1":["ctlg_header_text", "ctlg_text_1"],
            "club1":["ctlg_text_1", "ctlg_text_2", "ctlg_text_3", "ctlg_text_4", "ctlg_text_5"],
            "club2":["ctlg_text_1", "ctlg_text_2", "ctlg_text_3", "ctlg_text_4"],
            "presents":["ctlg_header_text", "ctlg_text1"],
            "collectibles":["ctlg_header_text", "ctlg_collectibles_link"],
            "purse":["ctlg_header_text", "ctlg_special_txt"],
            "pets":["ctlg_header_text", "ctlg_text_1", "ctlg_text_2", "ctlg_text_3"],
            "pets2":["ctlg_header_text", "ctlg_text_1", "ctlg_text_2", "ctlg_text_3"],
            "info_credits":["ctlg_text_1", "ctlg_text_2", "ctlg_text_3", "ctlg_text_4", "ctlg_text_5", "ctlg_text_6", "ctlg_text_7", "ctlg_text_8"],
            "info_pixels":["ctlg_text_1", "ctlg_text_2", "ctlg_text_3", "ctlg_text_4", "ctlg_text_5", "ctlg_text_6", "ctlg_text_7", "ctlg_text_8"],
            "frontpage3":["ctlg_txt1", "ctlg_txt2", "ctlg_txt3", "ctlg_txt4", "ctlg_txt5", "ctlg_txt6", "", "", "", "ctlg_txt7"]
        };
        private static const _SafeStr_4881:Dictionary = new Dictionary();
        private static const _SafeStr_4882:Object = {"frontpage3":[7, 8]};
        private static const _SafeStr_4883:Object = {"frontpage3":[["ctlg_txt1", "ctlg_txt2"], ["ctlg_txt3"]]};

        private var _images:Array;
        private var _texts:Array;

        {
            _SafeStr_4881["frontpage3"] = ["ctlg_txt3", "ctlg_txt7"];
            _SafeStr_4881["info_pixels"] = ["ctlg_text_5", "ctlg_text_7"];
            _SafeStr_4881["info_credits"] = ["ctlg_text_5", "ctlg_text_7"];
            _SafeStr_4881["collectibles"] = ["ctlg_collectibles_link"];
            _SafeStr_4881["club1"] = ["ctlg_text_5"];
            _SafeStr_4881["club_buy"] = ["club_link"];
            _SafeStr_4881["mad_money"] = ["ctlg_madmoney_button"];
            _SafeStr_4881["monkey"] = ["ctlg_teaserimg_1_region", "ctlg_special_img_region"];
        }
        public function PageLocalization(_arg_1:Array, _arg_2:Array)
        {
            this._images = _arg_1;
            this._texts = _arg_2;
        }
        public function get imageCount():int
        {
            return (this._images.length);
        }
        public function get textCount():int
        {
            return (this._texts.length);
        }
        public function dispose():void
        {
            this._images = null;
            this._texts = null;
        }
        public function hasLinks(_arg_1:String):Boolean
        {
            return (!((_SafeStr_4881[_arg_1] == null)));
        }
        public function PageLocalization(_arg_1:String):Array
        {
            return (_SafeStr_4881[_arg_1]);
        }
        public function hasColors(_arg_1:String):Boolean
        {
            return (((!((_SafeStr_4883[_arg_1] == null))) && (!((_SafeStr_4882[_arg_1] == null)))));
        }
        public function getColorTargets(_arg_1:String):Array
        {
            return (_SafeStr_4883[_arg_1]);
        }
        public function getColorSources(_arg_1:String):Array
        {
            return (_SafeStr_4882[_arg_1]);
        }
        public function getTextElementName(_arg_1:int, _arg_2:String):String
        {
            var _local_3:Array = LAYOUTS_TEXT_FIELDS[_arg_2];
            if (_local_3 == null){
                _local_3 = _SafeStr_4879;
            };
            if (_arg_1 < _local_3.length){
                return (_local_3[_arg_1]);
            };
            return ("");
        }
        public function getImageElementName(_arg_1:int, _arg_2:String):String
        {
            var _local_3:Array = LAYOUTS_IMAGE_FIELDS[_arg_2];
            if (_local_3 == null){
                _local_3 = _SafeStr_4880;
            };
            if (_arg_1 < _local_3.length){
                return (_local_3[_arg_1]);
            };
            return ("");
        }
        public function getTextElementContent(_arg_1:int):String
        {
            if (_arg_1 < this._texts.length){
                return (this._texts[_arg_1]);
            };
            return ("");
        }
        public function getImageElementContent(_arg_1:int):String
        {
            if (_arg_1 < this._images.length){
                return (this._images[_arg_1]);
            };
            return ("");
        }
        public function getColorUintFromText(_arg_1:int):uint
        {
            var _local_2:String;
            if (_arg_1 < this._texts.length){
                _local_2 = String(this._texts[_arg_1]).replace("#", "0x");
                return (uint(Number(_local_2)));
            };
            return (0);
        }

    }
}//package com.sulake.habbo.catalog.viewer

// IPageLocalization = "_-0gS" (String#4433, DoABC#2)
// PageLocalization = "_-37h" (String#21794, DoABC#2)
// PageLocalization = "_-Eu" (String#7970, DoABC#2)
// _SafeStr_4879 = "_-Q0" (String#23251, DoABC#2)
// _SafeStr_4880 = "_-0s8" (String#16128, DoABC#2)
// _SafeStr_4881 = "_-1lu" (String#18370, DoABC#2)
// _SafeStr_4882 = "_-0ln" (String#15891, DoABC#2)
// _SafeStr_4883 = "_-2i6" (String#20776, DoABC#2)
// _texts = "_-O9" (String#8166, DoABC#2)


