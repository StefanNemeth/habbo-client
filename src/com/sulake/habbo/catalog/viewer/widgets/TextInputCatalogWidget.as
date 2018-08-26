
package com.sulake.habbo.catalog.viewer.widgets
{
    import com.sulake.core.window.components.ITextFieldWindow;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.events.WindowKeyboardEvent;
    import com.sulake.habbo.catalog.viewer.widgets.events.TextInputEvent;

    public class TextInputCatalogWidget extends CatalogWidget implements ICatalogWidget 
    {

        private var _inputText:ITextFieldWindow;

        public function TextInputCatalogWidget(_arg_1:IWindowContainer)
        {
            super(_arg_1);
        }
        override public function init():Boolean
        {
            if (!super.init()){
                return (false);
            };
            this._inputText = (_window.findChildByName("input_text") as ITextFieldWindow);
            if (this._inputText != null){
                this._inputText.addEventListener(WindowKeyboardEvent.WKE_KEY_UP, this.onKey);
            };
            return (true);
        }
        private function onKey(_arg_1:WindowKeyboardEvent):void
        {
            if (this._inputText == null){
                return;
            };
            events.dispatchEvent(new TextInputEvent(this._inputText.text));
        }

    }
}//package com.sulake.habbo.catalog.viewer.widgets

// onKey = "_-0v9" (String#16243, DoABC#2)
// ITextFieldWindow = "_-3EL" (String#2027, DoABC#2)
// WindowKeyboardEvent = "_-0Di" (String#1433, DoABC#2)
// CatalogWidget = "_-1pJ" (String#5844, DoABC#2)
// ICatalogWidget = "_-016" (String#3585, DoABC#2)
// TextInputCatalogWidget = "_-3LC" (String#22333, DoABC#2)
// TextInputEvent = "_-2kd" (String#6969, DoABC#2)
// WKE_KEY_UP = "_-0aL" (String#15451, DoABC#2)


