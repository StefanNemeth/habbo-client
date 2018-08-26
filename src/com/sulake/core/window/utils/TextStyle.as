
package com.sulake.core.window.utils
{
    public class TextStyle 
    {

        public static const NORMAL:String = "normal";
        public static const ITALIC:String = "italic";
        public static const BOLD:String = "bold";
        public static const _SafeStr_9113:String = "underline";
        public static const NONE:String = "none";
        public static const ADVANCED:String = "advanced";

        public var name:String;
        public var color:Object;
        public var fontFamily:String;
        public var fontSize:Object = null;
        public var fontStyle:String = null;
        public var fontWeight:String = null;
        public var kerning:Object = null;
        public var leading:Object = null;
        public var letterSpacing:Object = null;
        public var textDecoration:String = null;
        public var textIndent:Object = null;
        public var antiAliasType:String = null;
        public var sharpness:Object = null;
        public var thickness:Object = null;

        public function toString():String
        {
            var _local_1:String = "";
            _local_1 = (_local_1 + (this.name + " {\n"));
            if (this.color){
                _local_1 = (_local_1 + (("\tcolor: #" + this.color.toString(16)) + ";\n"));
            };
            if (this.fontFamily){
                _local_1 = (_local_1 + (("\tfont-family: " + this.fontFamily) + ";\n"));
            };
            if (this.fontSize){
                _local_1 = (_local_1 + (("\tfont-size: " + this.fontSize) + ";\n"));
            };
            if (this.fontStyle){
                _local_1 = (_local_1 + (("\tfont-style: " + this.fontStyle) + ";\n"));
            };
            if (this.fontWeight){
                _local_1 = (_local_1 + (("\tfont-weight: " + this.fontWeight) + ";\n"));
            };
            if (this.kerning){
                _local_1 = (_local_1 + (("\tkerning: " + this.kerning) + ";\n"));
            };
            if (this.leading){
                _local_1 = (_local_1 + (("\tleading: " + this.leading) + ";\n"));
            };
            if (this.letterSpacing){
                _local_1 = (_local_1 + (("\tletter-spacing: " + this.letterSpacing) + ";\n"));
            };
            if (this.textDecoration){
                _local_1 = (_local_1 + (("\ttext-decoration: " + this.textDecoration) + ";\n"));
            };
            if (this.textIndent){
                _local_1 = (_local_1 + (("\ttext-indent: " + this.textIndent) + ";\n"));
            };
            if (this.antiAliasType){
                _local_1 = (_local_1 + (("\tanti-alias-type: " + this.antiAliasType) + ";\n"));
            };
            if (this.sharpness){
                _local_1 = (_local_1 + (("\tsharpness: " + this.sharpness) + ";\n"));
            };
            if (this.thickness){
                _local_1 = (_local_1 + (("\tthickness: " + this.thickness) + ";\n"));
            };
            return ((_local_1 + "}"));
        }
        public function equals(_arg_1:TextStyle):Boolean
        {
            return ((((((((((((((((((((((((((this.color == _arg_1.color)) && ((this.fontFamily == _arg_1.fontFamily)))) && ((this.fontSize == _arg_1.fontSize)))) && ((this.fontStyle == _arg_1.fontStyle)))) && ((this.fontWeight == _arg_1.fontWeight)))) && ((this.kerning == _arg_1.kerning)))) && ((this.leading == _arg_1.leading)))) && ((this.letterSpacing == _arg_1.letterSpacing)))) && ((this.textDecoration == _arg_1.textDecoration)))) && ((this.textIndent == _arg_1.textIndent)))) && ((this.antiAliasType == _arg_1.antiAliasType)))) && ((this.sharpness == _arg_1.sharpness)))) && ((this.thickness == _arg_1.thickness))));
        }
        public function clone():TextStyle
        {
            var _local_1:TextStyle = new TextStyle();
            _local_1.name = this.name;
            _local_1.color = this.color;
            _local_1.fontFamily = this.fontFamily;
            _local_1.fontSize = this.fontSize;
            _local_1.fontStyle = this.fontStyle;
            _local_1.fontWeight = this.fontWeight;
            _local_1.kerning = this.kerning;
            _local_1.leading = this.leading;
            _local_1.letterSpacing = this.letterSpacing;
            _local_1.textDecoration = this.textDecoration;
            _local_1.textIndent = this.textIndent;
            _local_1.antiAliasType = this.antiAliasType;
            _local_1.sharpness = this.sharpness;
            _local_1.thickness = this.thickness;
            return (_local_1);
        }

    }
}//package com.sulake.core.window.utils

// TextStyle = "_-0qh" (String#16074, DoABC#2)
// equals = "_-1fP" (String#18113, DoABC#2)
// _SafeStr_9113 = "_-059" (String#14249, DoABC#2)


