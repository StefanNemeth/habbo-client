
package 
{
    import mx.core.SimpleApplication;
    import com.sulake.bootstrap.HabboConfigurationManager;
    import com.sulake.iid.IIDHabboConfigurationManager;
    import com.sulake.habbo.configuration.HabboConfigurationManager;

    public class HabboConfigurationCom extends SimpleApplication 
    {

        public static var requiredClasses:Array = new Array(HabboConfigurationManager, IIDHabboConfigurationManager);
        public static var manifest:Class = HabboConfigurationCom_manifest;
        public static var default_configuration:Class = HabboConfigurationCom_default_configuration;
        public static var IIDHabboConfigurationManager:Class = IIDHabboConfigurationManager;
        public static var HabboConfigurationManager:Class = HabboConfigurationManager;

    }
}//package 

// HabboConfigurationCom_manifest = "_-14e" (String#4972, DoABC#2)
// HabboConfigurationCom_default_configuration = "_-3Id" (String#7682, DoABC#2)


