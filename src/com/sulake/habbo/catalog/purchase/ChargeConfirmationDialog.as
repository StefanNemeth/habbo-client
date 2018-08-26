
package com.sulake.habbo.catalog.purchase
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.habbo.catalog.HabboCatalog;
    import com.sulake.core.localization.ICoreLocalizationManager;
    import com.sulake.habbo.communication.messages.incoming.catalog.ChargeInfo;
    import com.sulake.core.window.components.IFrameWindow;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.habbo.communication.messages.outgoing.room.engine.UseFurnitureMessageComposer;
    import com.sulake.core.window.events.WindowEvent;

    public class ChargeConfirmationDialog implements IDisposable 
    {

        private var _catalog:HabboCatalog;
        private var _localization:ICoreLocalizationManager;
        private var _chargeInfo:ChargeInfo;
        private var _window:IFrameWindow;
        private var _disposed:Boolean = false;

        public function ChargeConfirmationDialog(_arg_1:HabboCatalog, _arg_2:ICoreLocalizationManager)
        {
            this._catalog = _arg_1;
            this._localization = _arg_2;
        }
        public function close():void
        {
            if (this._window != null){
                this._window.visible = false;
            };
        }
        public function refresh():void
        {
            if (((!((this._window == null))) && (this._window.visible))){
                this.ChargeConfirmationDialog(this._chargeInfo);
            };
        }
        public function dispose():void
        {
            if (this.disposed){
                return;
            };
            this._disposed = true;
            this._catalog = null;
            this._localization = null;
            this._chargeInfo = null;
            if (this._window != null){
                this._window.dispose();
            };
            this._window = null;
        }
        public function get disposed():Boolean
        {
            return (this._disposed);
        }
        public function ChargeConfirmationDialog(_arg_1:ChargeInfo):void
        {
            var _local_4:IWindow;
            var _local_5:IWindow;
            this._chargeInfo = _arg_1;
            if (this._window == null){
                this._window = (this.createWindow("charge_confirmation") as IFrameWindow);
                _local_4 = this._window.findChildByName("charge_button");
                _local_4.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.ChargeConfirmationDialog);
                _local_5 = this._window.findChildByTag("close");
                _local_5.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onWindowClose);
                this._window.center();
            };
            this._catalog.windowManager.registerLocalizationParameter("catalog.charge.currentamount", "charges", ("" + this._chargeInfo.charges));
            var _local_2:ChargeOffer = new ChargeOffer(this._chargeInfo);
            var _local_3:BalanceAndCost = new BalanceAndCost(this._catalog, this._localization, _local_2);
            this._catalog.windowManager.registerLocalizationParameter("catalog.charge.info", "cost", _local_3.cost);
            this._catalog.windowManager.registerLocalizationParameter("catalog.charge.info", "balance", _local_3.balance);
            this._catalog.windowManager.registerLocalizationParameter("catalog.charge.info", "patch_size", ("" + this._chargeInfo.chargePatchSize));
            this._window.visible = true;
            this._window.activate();
            _local_3.dispose();
            _local_2.dispose();
        }
        private function createWindow(_arg_1:String):IWindow
        {
            var _local_2:XmlAsset = (this._catalog.assets.getAssetByName(_arg_1) as XmlAsset);
            return (this._catalog.windowManager.buildFromXML((_local_2.content as XML)));
        }
        private function ChargeConfirmationDialog(_arg_1:WindowEvent):void
        {
            this._catalog.connection.send(new UseFurnitureMessageComposer(this._chargeInfo.stuffId, 2));
        }
        private function onWindowClose(_arg_1:WindowEvent):void
        {
            Logger.log("Close window");
            if (this._window != null){
                this._window.visible = false;
            };
        }

    }
}//package com.sulake.habbo.catalog.purchase

// WindowEvent = "_-Jh" (String#2085, DoABC#2)
// ChargeConfirmationDialog = "_-4D" (String#7749, DoABC#2)
// ChargeInfo = "_-1bU" (String#5587, DoABC#2)
// BalanceAndCost = "_-sU" (String#8747, DoABC#2)
// ChargeOffer = "_-0nk" (String#4586, DoABC#2)
// UseFurnitureMessageComposer = "_-0I2" (String#14759, DoABC#2)
// IDisposable = "_-0dY" (String#4382, DoABC#2)
// refresh = "_-s9" (String#189, DoABC#2)
// onWindowClose = "_-2tr" (String#136, DoABC#2)
// _chargeInfo = "_-0NE" (String#4023, DoABC#2)
// ChargeConfirmationDialog = "_-re" (String#24346, DoABC#2)
// ChargeConfirmationDialog = "_-2Kl" (String#19834, DoABC#2)
// chargePatchSize = "_-pz" (String#24273, DoABC#2)


