
package com.sulake.habbo.session.product
{
    public class ProductData implements IProductData 
    {

        private var _type:String;
        private var _name:String;
        private var _description:String;

        public function ProductData(_arg_1:String, _arg_2:String, _arg_3:String)
        {
            this._type = _arg_1;
            this._name = _arg_2;
            this._description = _arg_3;
        }
        public function get type():String
        {
            return (this._type);
        }
        public function get name():String
        {
            return (this._name);
        }
        public function get description():String
        {
            return (this._description);
        }

    }
}//package com.sulake.habbo.session.product

// IProductData = "_-0jc" (String#4494, DoABC#2)
// ProductData = "_-2XG" (String#6705, DoABC#2)
// _description = "_-1a7" (String#164, DoABC#2)


