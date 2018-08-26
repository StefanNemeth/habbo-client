
package 
{
    import mx.core.SimpleApplication;
    import com.sulake.bootstrap.HabboLocalizationManager;
    import com.sulake.iid.IIDCoreLocalizationManager;
    import com.sulake.iid.IIDHabboLocalizationManager;
    import com.sulake.core.localization.ICoreLocalizationManager;
    import com.sulake.habbo.localization.IHabboLocalizationManager;
    import com.sulake.habbo.localization.HabboLocalizationManager;

    public class HabboLocalizationCom extends SimpleApplication 
    {

        public static var requiredClasses:Array = new Array(HabboLocalizationManager, IIDCoreLocalizationManager, IIDHabboLocalizationManager);
        public static var manifest:Class = HabboLocalizationCom_manifest;
        public static var default_localization:Class = HabboLocalizationCom_default_localization;
        public static var keys_in_use:Class = HabboLocalizationCom_keys_in_use;
        public static var IIDCoreLocalizationManager:Class = IIDCoreLocalizationManager;
        public static var IIDHabboLocalizationManager:Class = IIDHabboLocalizationManager;
        public static var ICoreLocalizationManager:Class = ICoreLocalizationManager;
        public static var IHabboLocalizationManager:Class = IHabboLocalizationManager;
        public static var HabboLocalizationManager:Class = HabboLocalizationManager;

    }
}//package 

// HabboLocalizationCom_keys_in_use = "_-1dH" (String#5619, DoABC#2)
// HabboLocalizationCom_default_localization = "_-0nJ" (String#4577, DoABC#2)
// HabboLocalizationCom_manifest = "_-28p" (String#6219, DoABC#2)


