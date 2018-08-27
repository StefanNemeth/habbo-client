
package com.sulake.habbo.help.help
{
    import com.sulake.habbo.help.help.data.FaqItem;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.enum.WindowParam;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.window.components.ITextWindow;
    import com.sulake.habbo.help.help.data.FaqIndex;
    import default.GetFaqTextMessageComposer;
    import com.sulake.habbo.help.help.data.FaqCategory;
    import com.sulake.core.window.components.ILabelWindow;
    import com.sulake.habbo.help.enum.HabboHelpViewEnum;

    public class FaqBrowseEntry extends HelpViewController 
    {

        private var _SafeStr_3764:FaqItem;

        public function FaqBrowseEntry(_arg_1:HelpUI, _arg_2:IHabboWindowManager, _arg_3:IAssetLibrary)
        {
            super(_arg_1, _arg_2, _arg_3);
        }
        override public function render():void
        {
            if (container != null){
                container.dispose();
            };
            container = (buildXmlWindow("help_faq_entry") as IWindowContainer);
            if (container == null){
                return;
            };
            var _local_1:IWindow = container.findChildByTag("help_faq_back_link");
            if (_local_1 != null){
                _local_1.setParamFlag(WindowParam._SafeStr_7434);
                _local_1.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onBack);
            };
            var _local_2:IWindow = container.findChildByTag("help_faq_next_entry");
            if (_local_2 != null){
                _local_2.setParamFlag(WindowParam._SafeStr_7434);
                _local_2.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onNextEntry);
            };
            super.render();
            if (this._SafeStr_3764 != null){
                this.update();
            };
        }
        override public function update(_arg_1:*=null):void
        {
            var _local_4:ITextWindow;
            var _local_5:FaqItem;
            var _local_2:FaqIndex = main.getFaq();
            if (_local_2 == null){
                return;
            };
            if (_arg_1 != null){
                this._SafeStr_3764 = FaqItem(_arg_1);
            };
            if (this._SafeStr_3764 == null){
                return;
            };
            if (!this._SafeStr_3764.hasAnswer){
                main.sendMessage(new GetFaqTextMessageComposer(this._SafeStr_3764.questionId));
                return;
            };
            var _local_3:FaqCategory = this._SafeStr_3764.category;
            if (_local_3 == null){
                return;
            };
            _local_4 = (container.findChildByTag("faq_category_title") as ITextWindow);
            if (_local_4 != null){
                _local_4.text = _local_3.categoryTitle;
            };
            _local_4 = (container.findChildByTag("faq_question_text") as ITextWindow);
            if (_local_4 != null){
                _local_4.text = this._SafeStr_3764.questionText;
            };
            _local_4 = (container.findChildByTag("faq_answer_text") as ITextWindow);
            if (_local_4 != null){
                _local_4.htmlText = this.hackHTML(this._SafeStr_3764.answerText);
            };
            if (_local_3 != null){
                _local_5 = _local_3.getItemByIndex((this._SafeStr_3764.index + 1));
            };
            var _local_6:ILabelWindow = (container.findChildByTag("help_faq_next_entry_title") as ILabelWindow);
            if (_local_6 != null){
                if (_local_5 != null){
                    _local_6.text = _local_5.questionText;
                    _local_6.setParamFlag(WindowParam._SafeStr_7434);
                    _local_6.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onNextEntry);
                    _local_6.mouseThreshold = 0;
                }
                else {
                    _local_6.text = "";
                };
            };
            _local_4 = (container.findChildByTag("help_faq_next_entry") as ITextWindow);
            if (_local_4 != null){
                if (_local_5 != null){
                    _local_4.text = "${help.button.faq.next.entry}";
                }
                else {
                    _local_4.text = "";
                };
            };
            super.update(_arg_1);
        }
        private function hackHTML(_arg_1:String):String
        {
            var _local_4:String;
            var _local_2:String = _arg_1;
            var _local_3:int;
            while (_local_3 < (_local_2.length - 4)) {
                _local_4 = _local_2.slice(_local_3, (_local_3 + 4));
                if (_local_4 == "<img"){
                    _local_2 = ((_local_2.slice(0, _local_3) + '<img checkPolicyFile="true"') + _local_2.slice((_local_3 + 4), _local_2.length));
                };
                _local_3++;
            };
            return (_local_2);
        }
        private function onBack(_arg_1:WindowMouseEvent):void
        {
            var _local_2:FaqCategory;
            if (this._SafeStr_3764 != null){
                _local_2 = this._SafeStr_3764.category;
                main.showUI(HabboHelpViewEnum.HHVE_FAQ_CATEGORY);
                main.tellUI(HabboHelpViewEnum.HHVE_FAQ_CATEGORY, _local_2);
            };
        }
        private function onNextEntry(_arg_1:WindowMouseEvent):void
        {
            if (this.getNextItem() != null){
                main.tellUI(HabboHelpViewEnum.HHVE_FAQ_TOPICS, this.getNextItem());
            };
        }
        private function getNextItem():FaqItem
        {
            var _local_1:FaqIndex = main.getFaq();
            if ((((_local_1 == null)) || ((this._SafeStr_3764 == null)))){
                return (null);
            };
            var _local_2:FaqCategory = this._SafeStr_3764.category;
            if (_local_2 == null){
                return (null);
            };
            return (_local_2.getItemByIndex((this._SafeStr_3764.index + 1)));
        }

    }
}//package com.sulake.habbo.help.help

// categoryTitle = "_-35k" (String#21720, DoABC#2)
// getItemByIndex = "_-2P9" (String#20007, DoABC#2)
// questionText = "_-0FL" (String#14658, DoABC#2)
// hasAnswer = "_-1ET" (String#17047, DoABC#2)
// onBack = "_-2yv" (String#905, DoABC#2)
// onNextEntry = "_-1ov" (String#18496, DoABC#2)
// hackHTML = "_-0Ao" (String#14480, DoABC#2)
// getNextItem = "_-M-" (String#23082, DoABC#2)
// FaqIndex = "_-3I0" (String#7667, DoABC#2)
// HabboHelpViewEnum = "_-1e7" (String#18062, DoABC#2)
// HelpViewController = "_-IY" (String#8052, DoABC#2)
// FaqBrowseEntry = "_-1BI" (String#5100, DoABC#2)
// FaqCategory = "_-0JM" (String#3941, DoABC#2)
// FaqItem = "_-1u6" (String#5923, DoABC#2)
// GetFaqTextMessageComposer = "_-nR" (String#24169, DoABC#2)
// questionId = "_-3-c" (String#21486, DoABC#2)
// _SafeStr_3764 = "_-1eS" (String#609, DoABC#2)
// mouseThreshold = "_-0OA" (String#4051, DoABC#2)
// _SafeStr_7434 = "_-2xA" (String#21356, DoABC#2)
// HHVE_FAQ_CATEGORY = "_-1AU" (String#16879, DoABC#2)
// HHVE_FAQ_TOPICS = "_-ed" (String#23829, DoABC#2)
// answerText = "_-3JS" (String#22262, DoABC#2)


