
package com.sulake.habbo.roomevents.userdefinedroomevents
{
    import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
    import com.sulake.core.window.components.IFrameWindow;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.roomevents.userdefinedroomevents.triggerconfs.TriggerConfs;
    import com.sulake.habbo.roomevents.userdefinedroomevents.actiontypes.ActionTypes;
    import com.sulake.habbo.roomevents.userdefinedroomevents.conditions.ConditionTypes;
    import flash.utils.Dictionary;
    import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.Triggerable;
    import com.sulake.habbo.roomevents.userdefinedroomevents.help.UserDefinedRoomEventsHelp;
    import com.sulake.habbo.roomevents.userdefinedroomevents.common.SliderWindowController;
    import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.TriggerDefinition;
    import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.ActionDefinition;
    import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.ConditionDefinition;
    import com.sulake.habbo.roomevents.Util;
    import flash.events.Event;
    import com.sulake.core.window.IWindow;
    import com.sulake.habbo.roomevents.userdefinedroomevents.triggerconfs.TriggerOnce;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.habbo.communication.messages.outgoing.userdefinedroomevents.UpdateTriggerMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.userdefinedroomevents.UpdateActionMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.userdefinedroomevents.UpdateConditionMessageComposer;
    import com.sulake.habbo.roomevents.userdefinedroomevents.actiontypes.ActionType;
    import com.sulake.habbo.communication.messages.outgoing.userdefinedroomevents.ApplySnapshotMessageComposer;
    import com.sulake.habbo.session.furniture.IFurnitureData;
    import com.sulake.core.window.components.ITextWindow;
    import com.sulake.core.window.components.ICheckBoxWindow;
    import com.sulake.core.window.events.*;

    public class UserDefinedRoomEventsCtrl 
    {

        public static var STUFF_SELECTION_OPTION_NONE:int = 0;
        public static var STUFF_SELECTION_OPTION_BY_ID:int = 1;
        public static var STUFF_SELECTION_OPTION_BY_ID_OR_BY_TYPE:int = 2;
        public static var _SafeStr_5209:int = 3;
        private static var _SafeStr_13553:int = 2;

        private var _SafeStr_5221:HabboUserDefinedRoomEvents;
        private var _window:IFrameWindow;
        private var _SafeStr_13554:IWindowContainer;
        private var _SafeStr_13555:TriggerConfs;
        private var _SafeStr_13556:ActionTypes;
        private var _SafeStr_13557:ConditionTypes;
        private var _SafeStr_13558:Dictionary;
        private var _SafeStr_13559:Triggerable;
        private var _SafeStr_13560:RoomObjectHightLighter;
        private var _SafeStr_11411:UserDefinedRoomEventsHelp;
        private var _SafeStr_13561:SliderWindowController;

        public function UserDefinedRoomEventsCtrl(_arg_1:HabboUserDefinedRoomEvents)
        {
            this._SafeStr_13555 = new TriggerConfs();
            this._SafeStr_13556 = new ActionTypes();
            this._SafeStr_13557 = new ConditionTypes();
            this._SafeStr_13558 = new Dictionary();
            super();
            this._SafeStr_5221 = _arg_1;
            this._SafeStr_13560 = new RoomObjectHightLighter(_arg_1);
            this._SafeStr_11411 = new UserDefinedRoomEventsHelp(_arg_1);
        }
        public function stuffSelected(_arg_1:int, _arg_2:String):void
        {
            if ((((this._window == null)) || (!(this._window.visible)))){
                return;
            };
            if (!this.isStuffSelectionMode()){
                return;
            };
            if (this._SafeStr_13558[_arg_1]){
                delete this._SafeStr_13558[_arg_1];
                this._SafeStr_13560.hide(_arg_1);
            }
            else {
                if (this.getStuffIds().length < this._SafeStr_13559.furniLimit){
                    this._SafeStr_13558[_arg_1] = _arg_2;
                    this._SafeStr_13560.show(_arg_1);
                };
            };
            this.refresh();
        }
        private function isStuffSelectionMode():Boolean
        {
            var _local_1:Element = this.resolveType();
            return (!((_local_1.requiresFurni == STUFF_SELECTION_OPTION_NONE)));
        }
        private function resolveType():Element
        {
            return (this.resolveHolder().getElementByCode(this._SafeStr_13559.code));
        }
        private function resolveHolder():ElementTypeHolder
        {
            if ((this._SafeStr_13559 as TriggerDefinition) != null){
                return (this._SafeStr_13555);
            };
            if ((this._SafeStr_13559 as ActionDefinition) != null){
                return (this._SafeStr_13556);
            };
            if ((this._SafeStr_13559 as ConditionDefinition) != null){
                return (this._SafeStr_13557);
            };
            return (null);
        }
        private function prepareWindow():void
        {
            if (this._window != null){
                return;
            };
            this._window = IFrameWindow(this._SafeStr_5221.getXmlWindow("ude_main"));
            this._SafeStr_13554 = IWindowContainer(this.find(this._window, "configure_container"));
            Util.setProcDirectly(this.find(this._SafeStr_13554, "save_button"), this.onSave);
            Util.setProcDirectly(this.find(this._SafeStr_13554, "cancel_save_button"), this.onWindowClose);
            Util.setProcDirectly(this.find(this._SafeStr_13554, "helplink"), this.onHelp);
            Util.setProcDirectly(this.find(this._SafeStr_13554, "apply_snapshot_txt"), this.onApplySnapshot);
            Util.setProcDirectly(this.find(this._SafeStr_13554, "dec_stuff_sel_txt"), this.onDecStuffSelectionType);
            Util.setProcDirectly(this.find(this._SafeStr_13554, "inc_stuff_sel_txt"), this.onIncStuffSelectionType);
            this.find(this._SafeStr_13554, "dec_stuff_sel_txt").mouseThreshold = 0;
            this.find(this._SafeStr_13554, "inc_stuff_sel_txt").mouseThreshold = 0;
            this.find(this._SafeStr_13554, "helplink").mouseThreshold = 0;
            this.find(this._SafeStr_13554, "apply_snapshot_txt").mouseThreshold = 0;
            this._SafeStr_13561 = new SliderWindowController(this._SafeStr_5221, IWindowContainer(this.find(this._SafeStr_13554, "delay_slider_container")), this._SafeStr_5221.assets, 0, 20, 1);
            this._SafeStr_13561.addEventListener(Event.CHANGE, this.onDelaySliderChange);
            this._SafeStr_13561.setValue(0);
            this.setIcon("configure_container", "icon_trigger", "trigger_icon_bitmap");
            this.setIcon("configure_container", "icon_action", "action_icon_bitmap");
            this.setIcon("configure_container", "icon_condition", "condition_icon_bitmap");
            var _local_1:IWindow = this._window.findChildByTag("close");
            _local_1.procedure = this.onWindowClose;
            this._window.center();
        }
        private function onDelaySliderChange(_arg_1:Event):void
        {
            var _local_2:SliderWindowController;
            var _local_3:Number;
            var _local_4:int;
            var _local_5:String;
            if (_arg_1.type == Event.CHANGE){
                _local_2 = (_arg_1.target as SliderWindowController);
                if (_local_2){
                    _local_3 = _local_2.getValue();
                    _local_4 = int(_local_3);
                    _local_5 = TriggerOnce.TriggerOnce(_local_4);
                    this._SafeStr_5221.localization.registerParameter("wiredfurni.params.delay", "seconds", _local_5);
                };
            };
        }
        private function setIcon(_arg_1:String, _arg_2:String, _arg_3:String="icon_bitmap"):void
        {
            var _local_4:IWindowContainer = IWindowContainer(this.find(this._window, _arg_1));
            this._SafeStr_5221.refreshButton(_local_4, _arg_3, true, null, 0, _arg_2);
        }
        private function onWindowClose(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type == WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK){
                this.close();
            };
        }
        public function close():void
        {
            if (this._window){
                this._window.visible = false;
                this._SafeStr_13560.hideAll(this._SafeStr_13558);
            };
        }
        private function find(_arg_1:IWindowContainer, _arg_2:String):IWindow
        {
            var _local_3:IWindow = _arg_1.findChildByName(_arg_2);
            if (_local_3 == null){
                throw (new Error((("Window element with name: " + _arg_2) + " cannot be found!")));
            };
            return (_local_3);
        }
        public function prepareForUpdate(_arg_1:Triggerable):void
        {
            var _local_3:int;
            var _local_4:IWindowContainer;
            var _local_5:ActionDefinition;
            var _local_6:int;
            this.prepareWindow();
            this._SafeStr_13559 = _arg_1;
            Logger.log(((("Received: " + this._SafeStr_13559) + ", ") + _arg_1.code));
            var _local_2:Element = this.resolveType();
            this._SafeStr_13560.hideAll(this._SafeStr_13558);
            this._SafeStr_13558 = new Dictionary();
            for each (_local_3 in this._SafeStr_13559.stuffIds) {
                this._SafeStr_13558[_local_3] = "yes";
            };
            _local_4 = ((_local_2.hasSpecialInputs) ? this.prepareCustomInput() : null);
            _local_2.Element(_local_4, this._SafeStr_13559);
            this._SafeStr_13560.showAll(this._SafeStr_13558);
            if ((this._SafeStr_13559 as ActionDefinition) != null){
                _local_5 = ActionDefinition(this._SafeStr_13559);
                _local_6 = _local_5.delayInPulses;
                this._SafeStr_13561.setValue(_local_6);
            };
            this.prepareStuffSelectionForUpdate();
            this.refresh();
        }
        private function prepareStuffSelectionForUpdate():void
        {
            var _local_2:Element;
            this.getFurniTypeMatchesCheckBox().visible = false;
            this.getFurniTypeMatchesText().visible = false;
            this.getIncStuffSelTxt().visible = false;
            this.getDecStuffSelTxt().visible = false;
            if (this._SafeStr_13559.stuffTypeSelectionEnabled){
                _local_2 = this.resolveType();
                if (_local_2.requiresFurni == STUFF_SELECTION_OPTION_BY_ID_OR_BY_TYPE){
                    if (this._SafeStr_13559.stuffTypeSelectionCode == 1){
                        this.getFurniTypeMatchesCheckBox().select();
                    }
                    else {
                        this.getFurniTypeMatchesCheckBox().ISelectableWindow();
                    };
                    this.getFurniTypeMatchesText().caption = this._SafeStr_5221.localization.getKey("wiredfurni.pickfurnis.furnitypematches");
                    this.getFurniTypeMatchesCheckBox().visible = true;
                    this.getFurniTypeMatchesText().visible = true;
                }
                else {
                    if (_local_2.requiresFurni == _SafeStr_5209){
                        this.getIncStuffSelTxt().visible = true;
                        this.getDecStuffSelTxt().visible = true;
                        this.getFurniTypeMatchesText().visible = true;
                        this.refreshStuffTypeSelectionToggler();
                    };
                };
            };
            var _local_1:IWindowContainer = IWindowContainer(this._SafeStr_13554.findChildByName("select_furni_container"));
            _local_1.height = Util.getLowestPoint(_local_1);
        }
        private function refreshStuffTypeSelectionToggler():void
        {
            this.getFurniTypeMatchesText().caption = this._SafeStr_5221.localization.getKey(("wiredfurni.pickfurnis.stuffselectiontype." + this._SafeStr_13559.stuffTypeSelectionCode));
        }
        public function stuffRemoved(_arg_1:int):void
        {
            if (this._window == null){
                return;
            };
            if (!this._window.visible){
                return;
            };
            if (this._SafeStr_13559.id == _arg_1){
                this._window.visible = false;
                return;
            };
            if (this._SafeStr_13558[_arg_1]){
                delete this._SafeStr_13558[_arg_1];
                this.refresh();
            };
        }
        private function onSave(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK){
                return;
            };
            if (this.isStuffSelectionMode()){
                this._SafeStr_13560.hideAll(this._SafeStr_13558);
            };
            if ((this._SafeStr_13559 as TriggerDefinition) != null){
                this._SafeStr_5221.send(new UpdateTriggerMessageComposer(this._SafeStr_13559.id, this.resolveIntParams(), this.resolveStringParam(), this.getStuffIds(), this.resolveStuffSelectionType()));
            }
            else {
                if ((this._SafeStr_13559 as ActionDefinition) != null){
                    this._SafeStr_5221.send(new UpdateActionMessageComposer(this._SafeStr_13559.id, this.resolveIntParams(), this.resolveStringParam(), this.getStuffIds(), this.getActionDelay(), this.resolveStuffSelectionType()));
                }
                else {
                    if ((this._SafeStr_13559 as ConditionDefinition) != null){
                        this._SafeStr_5221.send(new UpdateConditionMessageComposer(this._SafeStr_13559.id, this.resolveIntParams(), this.resolveStringParam(), this.getStuffIds(), this.resolveStuffSelectionType()));
                    };
                };
            };
            this.close();
        }
        public function getActionDelay():int
        {
            var _local_1:ActionType = ActionType(this.resolveType());
            return (((_local_1.allowDelaying) ? this._SafeStr_13561.getValue() : 0));
        }
        private function onHelp(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK){
                return;
            };
            this._SafeStr_11411.open(((this._window.x + this._window.width) + 5), this._window.y);
        }
        private function onDecStuffSelectionType(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK){
                return;
            };
            this._SafeStr_13559.stuffTypeSelectionCode = (((this._SafeStr_13559.stuffTypeSelectionCode < 1)) ? _SafeStr_13553 : (this._SafeStr_13559.stuffTypeSelectionCode - 1));
            this.refreshStuffTypeSelectionToggler();
        }
        private function onIncStuffSelectionType(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK){
                return;
            };
            this._SafeStr_13559.stuffTypeSelectionCode = ((this._SafeStr_13559.stuffTypeSelectionCode + 1) % (_SafeStr_13553 + 1));
            this.refreshStuffTypeSelectionToggler();
        }
        private function onApplySnapshot(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK){
                return;
            };
            this._SafeStr_5221.send(new ApplySnapshotMessageComposer(this._SafeStr_13559.id));
        }
        private function resolveIntParams():Array
        {
            var _local_1:Element = this.resolveType();
            var _local_2:IWindowContainer = ((_local_1.hasSpecialInputs) ? this.prepareCustomInput() : null);
            return (_local_1.Element(_local_2));
        }
        private function resolveStringParam():String
        {
            var _local_1:Element = this.resolveType();
            var _local_2:IWindowContainer = ((_local_1.hasSpecialInputs) ? this.prepareCustomInput() : null);
            return (_local_1.Element(_local_2));
        }
        private function resolveStuffSelectionType():int
        {
            if (!this._SafeStr_13559.stuffTypeSelectionEnabled){
                return (0);
            };
            var _local_1:Element = this.resolveType();
            if (_local_1.requiresFurni == STUFF_SELECTION_OPTION_BY_ID_OR_BY_TYPE){
                return (((this.getFurniTypeMatchesCheckBox().isSelected) ? 1 : 0));
            };
            if (_local_1.requiresFurni == _SafeStr_5209){
                return (this._SafeStr_13559.stuffTypeSelectionCode);
            };
            return (0);
        }
        public function getStuffIds():Array
        {
            var _local_2:String;
            var _local_1:Array = new Array();
            for (_local_2 in this._SafeStr_13558) {
                _local_1.push(int(_local_2));
            };
            return (_local_1);
        }
        private function refresh():void
        {
            this._SafeStr_13554.visible = false;
            this.refreshConfigureElement(this._SafeStr_13555);
            this.refreshConfigureElement(this._SafeStr_13556);
            this.refreshConfigureElement(this._SafeStr_13557);
            this._window.content.height = Util.getLowestPoint(this._window.content);
            this._window.visible = true;
        }
        private function refreshConfigureElement(_arg_1:ElementTypeHolder):void
        {
            if (!_arg_1.acceptTriggerable(this._SafeStr_13559)){
                this.find(this._SafeStr_13554, (_arg_1.getKey() + "_icon_bitmap")).visible = false;
                return;
            };
            this._SafeStr_13554.visible = true;
            var _local_2:Element = this.resolveType();
            this.refreshHeader(_local_2, _arg_1.getKey());
            this.refreshCustomInputs();
            this.refreshSelectFurni();
            this.find(this._SafeStr_13554, "warning_container").visible = false;
            this.refreshConflictingTriggers();
            this.refreshConflictingActions();
            this.refreshActionInputs();
            Util.moveAllChildrenToColumn(this._SafeStr_13554, 3, 5);
            this._SafeStr_13554.height = (Util.getLowestPoint(this._SafeStr_13554) + 1);
        }
        private function getElementName(_arg_1:int):String
        {
            var _local_2:IFurnitureData = this._SafeStr_5221.sessionDataManager.SessionDataManager(_arg_1);
            if (_local_2 == null){
                Logger.log(("COULD NOT FIND FURNIDATA FOR " + _arg_1));
                return (("NAME: " + _arg_1));
            };
            return (_local_2.title);
        }
        private function getElementDesc(_arg_1:int):String
        {
            var _local_2:IFurnitureData = this._SafeStr_5221.sessionDataManager.SessionDataManager(_arg_1);
            if (_local_2 == null){
                Logger.log(("COULD NOT FIND FURNIDATA FOR " + _arg_1));
                return (("NAME: " + _arg_1));
            };
            return (_local_2.description);
        }
        private function CurrencyIndicatorBase(_arg_1:IWindowContainer, _arg_2:String, _arg_3:String):void
        {
            var _local_4:ITextWindow = ITextWindow(this.find(_arg_1, _arg_2));
            _local_4.caption = _arg_3;
            _local_4.height = (_local_4.textHeight + 6);
        }
        private function refreshHeader(_arg_1:Element, _arg_2:String):void
        {
            var _local_3:IWindowContainer = IWindowContainer(this.find(this._SafeStr_13554, "header_container"));
            this.find(_local_3, (_arg_2 + "_icon_bitmap")).visible = true;
            this.CurrencyIndicatorBase(_local_3, "conf_name_txt", this.getElementName(this._SafeStr_13559.stuffTypeId));
            this.CurrencyIndicatorBase(_local_3, "conf_desc_txt", this.getElementDesc(this._SafeStr_13559.stuffTypeId));
            var _local_4:IWindow = this.find(_local_3, "conf_name_txt");
            var _local_5:IWindow = this.find(_local_3, "conf_desc_txt");
            _local_5.y = (_local_4.y + _local_4.height);
            var _local_6:Element = this.resolveType();
            var _local_7:IWindow = this.find(_local_3, "apply_snapshot_txt");
            if (_local_6.hasStateSnapshot){
                _local_7.visible = true;
                _local_7.y = (_local_5.y + _local_5.height);
            }
            else {
                _local_7.visible = false;
            };
            _local_3.height = (Util.getLowestPoint(_local_3) + 4);
        }
        private function refreshActionInputs():void
        {
            var _local_1:IWindowContainer = IWindowContainer(this.find(this._SafeStr_13554, "action_inputs_container"));
            if ((this._SafeStr_13559 as ActionDefinition) == null){
                _local_1.visible = false;
                return;
            };
            var _local_2:ActionType = ActionType(this.resolveType());
            if (!_local_2.allowDelaying){
                _local_1.visible = false;
                return;
            };
            _local_1.visible = true;
        }
        private function refreshConflictingTriggers():void
        {
            var _local_4:int;
            if ((this._SafeStr_13559 as ActionDefinition) == null){
                return;
            };
            var _local_1:ActionDefinition = ActionDefinition(this._SafeStr_13559);
            if (_local_1.conflictingTriggers.length < 1){
                return;
            };
            var _local_2:String = "";
            var _local_3:Boolean = true;
            for each (_local_4 in _local_1.conflictingTriggers) {
                _local_2 = (_local_2 + (((((_local_3) ? "" : ", ") + "'") + this.getElementName(_local_4)) + "'"));
                _local_3 = false;
            };
            this._SafeStr_5221.localization.registerParameter("wiredfurni.conflictingtriggers.text", "triggers", _local_2);
            this.refreshWarning(this._SafeStr_5221.localization.getKey("wiredfurni.conflictingtriggers.caption"), this._SafeStr_5221.localization.getKey("wiredfurni.conflictingtriggers.text"));
        }
        private function refreshConflictingActions():void
        {
            var _local_4:int;
            if ((this._SafeStr_13559 as TriggerDefinition) == null){
                return;
            };
            var _local_1:TriggerDefinition = TriggerDefinition(this._SafeStr_13559);
            if (_local_1.conflictingActions.length < 1){
                return;
            };
            var _local_2:String = "";
            var _local_3:Boolean = true;
            for each (_local_4 in _local_1.conflictingActions) {
                _local_2 = (_local_2 + (((((_local_3) ? "" : ", ") + "'") + this.getElementName(_local_4)) + "'"));
                _local_3 = false;
            };
            this._SafeStr_5221.localization.registerParameter("wiredfurni.conflictingactions.text", "actions", _local_2);
            this.refreshWarning(this._SafeStr_5221.localization.getKey("wiredfurni.conflictingactions.caption"), this._SafeStr_5221.localization.getKey("wiredfurni.conflictingactions.text"));
        }
        private function refreshWarning(_arg_1:String, _arg_2:String):void
        {
            var _local_3:IWindowContainer = IWindowContainer(this.find(this._SafeStr_13554, "warning_container"));
            this.CurrencyIndicatorBase(_local_3, "caption_txt", _arg_1);
            this.CurrencyIndicatorBase(_local_3, "desc_txt", _arg_2);
            var _local_4:IWindow = this.find(_local_3, "caption_txt");
            this.find(_local_3, "desc_txt").y = (_local_4.y + _local_4.height);
            _local_3.height = (Util.getLowestPoint(_local_3) + 4);
            this.find(this._SafeStr_13554, "warning_container").visible = true;
        }
        private function refreshCustomInputs():void
        {
            var _local_2:IWindowContainer;
            var _local_1:IWindowContainer = IWindowContainer(this._SafeStr_13554.findChildByName("custom_inputs_container"));
            Util.InfostandWidget(_local_1);
            if (this.resolveType().hasSpecialInputs){
                _local_2 = this.prepareCustomInput();
                _local_2.visible = true;
            };
            _local_1.height = Util.getLowestPoint(_local_1);
        }
        private function prepareCustomInput():IWindowContainer
        {
            var _local_1:ElementTypeHolder = this.resolveHolder();
            var _local_2:Element = this.resolveType();
            var _local_3:IWindowContainer = IWindowContainer(this._SafeStr_13554.findChildByName("custom_inputs_container"));
            var _local_4:String = (_local_1.getKey() + _local_2.code);
            var _local_5:IWindowContainer = IWindowContainer(_local_3.getChildByName(_local_4));
            if (_local_5 == null){
                _local_5 = IWindowContainer(this._SafeStr_5221.getXmlWindow(((("ude_" + _local_1.getKey()) + "_inputs_") + _local_2.code)));
                _local_5.name = _local_4;
                _local_3.addChild(_local_5);
                _local_2.Element(_local_5, this._SafeStr_5221);
            };
            return (_local_5);
        }
        private function refreshSelectFurni():void
        {
            var _local_1:IWindowContainer = IWindowContainer(this._SafeStr_13554.findChildByName("select_furni_container"));
            if (!this.isStuffSelectionMode()){
                _local_1.visible = false;
                return;
            };
            _local_1.visible = true;
            var _local_2:IWindow = _local_1.findChildByName("furni_name_txt");
            var _local_3:int = this.getStuffIds().length;
            var _local_4:int = this._SafeStr_13559.furniLimit;
            this._SafeStr_5221.localization.registerParameter("wiredfurni.pickfurnis.caption", "count", ("" + _local_3));
            this._SafeStr_5221.localization.registerParameter("wiredfurni.pickfurnis.caption", "limit", ("" + _local_4));
        }
        private function getFurniTypeMatchesCheckBox():ICheckBoxWindow
        {
            return (ICheckBoxWindow(this._SafeStr_13554.findChildByName("furni_type_matches_checkbox")));
        }
        private function getDecStuffSelTxt():IWindow
        {
            return (this._SafeStr_13554.findChildByName("dec_stuff_sel_txt"));
        }
        private function getIncStuffSelTxt():IWindow
        {
            return (this._SafeStr_13554.findChildByName("inc_stuff_sel_txt"));
        }
        private function getFurniTypeMatchesText():IWindow
        {
            return (this._SafeStr_13554.findChildByName("furni_type_matches_txt"));
        }

    }
}//package com.sulake.habbo.roomevents.userdefinedroomevents

// setIcon = "_-0dP" (String#4379, DoABC#2)
// _SafeStr_11411 = "_-0kl" (String#822, DoABC#2)
// moveAllChildrenToColumn = "_-07-" (String#14323, DoABC#2)
// IFurnitureData = "_-pe" (String#8701, DoABC#2)
// WindowEvent = "_-Jh" (String#2085, DoABC#2)
// hideAll = "_-0ei" (String#15614, DoABC#2)
// showAll = "_-al" (String#23662, DoABC#2)
// _SafeStr_13553 = "_-1ju" (String#18280, DoABC#2)
// _SafeStr_13554 = "_-0Wp" (String#15310, DoABC#2)
// _SafeStr_13555 = "_-Eg" (String#22801, DoABC#2)
// _SafeStr_13556 = "_-3-5" (String#21465, DoABC#2)
// _SafeStr_13557 = "_-0MV" (String#14933, DoABC#2)
// _SafeStr_13558 = "_-33j" (String#21649, DoABC#2)
// _SafeStr_13559 = "_-2w7" (String#21314, DoABC#2)
// _SafeStr_13560 = "_-1Vq" (String#17735, DoABC#2)
// _SafeStr_13561 = "_-383" (String#21804, DoABC#2)
// isStuffSelectionMode = "_-01U" (String#14109, DoABC#2)
// getStuffIds = "_-06V" (String#14306, DoABC#2)
// resolveType = "_-32u" (String#21616, DoABC#2)
// resolveHolder = "_-0EK" (String#14622, DoABC#2)
// onSave = "_-3-Z" (String#21485, DoABC#2)
// onHelp = "_-0BP" (String#14502, DoABC#2)
// onApplySnapshot = "_-TX" (String#23387, DoABC#2)
// onDecStuffSelectionType = "_-08k" (String#14395, DoABC#2)
// onIncStuffSelectionType = "_-2BV" (String#19465, DoABC#2)
// onDelaySliderChange = "_-2ib" (String#20792, DoABC#2)
// prepareForUpdate = "_-1zL" (String#18941, DoABC#2)
// prepareCustomInput = "_-0oy" (String#16010, DoABC#2)
// prepareStuffSelectionForUpdate = "_-1T-" (String#17625, DoABC#2)
// getFurniTypeMatchesCheckBox = "_-04o" (String#14232, DoABC#2)
// getFurniTypeMatchesText = "_-bL" (String#23685, DoABC#2)
// getIncStuffSelTxt = "_-qO" (String#24288, DoABC#2)
// getDecStuffSelTxt = "_-fr" (String#23883, DoABC#2)
// refreshStuffTypeSelectionToggler = "_-2iH" (String#20781, DoABC#2)
// stuffRemoved = "_-09l" (String#14437, DoABC#2)
// resolveIntParams = "_-1mg" (String#18408, DoABC#2)
// resolveStringParam = "_-1lQ" (String#18349, DoABC#2)
// resolveStuffSelectionType = "_-057" (String#14248, DoABC#2)
// getActionDelay = "_-0X0" (String#15315, DoABC#2)
// refreshConfigureElement = "_-24Q" (String#19196, DoABC#2)
// refreshCustomInputs = "_-22V" (String#19110, DoABC#2)
// refreshSelectFurni = "_-1a3" (String#17896, DoABC#2)
// refreshConflictingTriggers = "_-366" (String#21733, DoABC#2)
// refreshConflictingActions = "_-1XA" (String#17783, DoABC#2)
// refreshActionInputs = "_-1M6" (String#17363, DoABC#2)
// getElementName = "_-22L" (String#19105, DoABC#2)
// getElementDesc = "_-w" (String#24529, DoABC#2)
// refreshWarning = "_-0Uf" (String#15231, DoABC#2)
// ICheckBoxWindow = "_-1zu" (String#1793, DoABC#2)
// Util = "_-1ve" (String#445, DoABC#2)
// Triggerable = "_-2oD" (String#7043, DoABC#2)
// TriggerDefinition = "_-2ov" (String#7057, DoABC#2)
// UpdateActionMessageComposer = "_-Dh" (String#22758, DoABC#2)
// UpdateTriggerMessageComposer = "_-Dg" (String#22757, DoABC#2)
// UserDefinedRoomEventsHelp = "_-2tb" (String#7150, DoABC#2)
// Element = "_-zj" (String#8875, DoABC#2)
// ActionType = "_-0Jp" (String#813, DoABC#2)
// RoomObjectHightLighter = "_-1Nm" (String#5306, DoABC#2)
// ElementTypeHolder = "_-0P4" (String#4071, DoABC#2)
// UpdateConditionMessageComposer = "_-0Et" (String#14639, DoABC#2)
// ConditionDefinition = "_-Lz" (String#8123, DoABC#2)
// SliderWindowController = "_-GO" (String#8002, DoABC#2)
// TriggerConfs = "_-0Qs" (String#4108, DoABC#2)
// ActionTypes = "_-0vr" (String#4765, DoABC#2)
// ApplySnapshotMessageComposer = "_-2OL" (String#19980, DoABC#2)
// ActionDefinition = "_-1nw" (String#864, DoABC#2)
// ConditionTypes = "_-246" (String#6125, DoABC#2)
// TriggerOnce = "_-31n" (String#7342, DoABC#2)
// InfostandWidget = "_-14q" (String#1615, DoABC#2)
// refresh = "_-s9" (String#189, DoABC#2)
// getLowestPoint = "_-0t0" (String#16161, DoABC#2)
// onWindowClose = "_-2tr" (String#136, DoABC#2)
// sessionDataManager = "_-0pX" (String#4623, DoABC#2)
// allowDelaying = "_-4e" (String#7759, DoABC#2)
// code = "_-12Y" (String#4926, DoABC#2)
// getElementByCode = "_-2v7" (String#7181, DoABC#2)
// acceptTriggerable = "_-29f" (String#6243, DoABC#2)
// requiresFurni = "_-1i4" (String#5711, DoABC#2)
// _SafeStr_5209 = "_-1vi" (String#18785, DoABC#2)
// hasStateSnapshot = "_-2bG" (String#6777, DoABC#2)
// Element = "_-10U" (String#4881, DoABC#2)
// Element = "_-2Cw" (String#6305, DoABC#2)
// Element = "_-0uD" (String#4727, DoABC#2)
// Element = "_-gW" (String#8522, DoABC#2)
// hasSpecialInputs = "_-pV" (String#8699, DoABC#2)
// _SafeStr_5221 = "_-0D2" (String#124, DoABC#2)
// ISelectableWindow = "_-2aK" (String#6764, DoABC#2)
// stuffTypeSelectionEnabled = "_-0rL" (String#16098, DoABC#2)
// stuffTypeSelectionCode = "_-1BV" (String#16918, DoABC#2)
// furniLimit = "_-22s" (String#19128, DoABC#2)
// stuffIds = "_-0b1" (String#15475, DoABC#2)
// stuffTypeId = "_-0zV" (String#16407, DoABC#2)
// conflictingActions = "_-0T5" (String#15174, DoABC#2)
// delayInPulses = "_-1IB" (String#17200, DoABC#2)
// conflictingTriggers = "_-2EX" (String#19587, DoABC#2)
// CurrencyIndicatorBase = "_-1vu" (String#243, DoABC#2)
// prepareWindow = "_-RN" (String#219, DoABC#2)
// setProcDirectly = "_-24s" (String#19218, DoABC#2)
// refreshHeader = "_-18C" (String#834, DoABC#2)
// mouseThreshold = "_-0OA" (String#4051, DoABC#2)
// TriggerOnce = "_-2SO" (String#20133, DoABC#2)
// SessionDataManager = "_-08L" (String#3728, DoABC#2)
// stuffSelected = "_-0oj" (String#4608, DoABC#2)


