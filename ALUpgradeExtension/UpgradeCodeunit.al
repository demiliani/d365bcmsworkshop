codeunit 50106 CustomerClassUpgrade
{
    //IMPORTANT: Remember to increase the version number of the extension in the app.json file
    //Upgrade-NAVApp cmdlet
    
    Subtype = Upgrade;

    // "OnUpgradePerCompany" trigger is used to perform the actual upgrade.
    trigger OnUpgradePerCompany();
    var
        //CustomerClassInstall : Codeunit CustomerClassInstall;
        CustomerClass : Record CustomerClass;

        // "ModuleInfo" is the current executing module. 
        Module : ModuleInfo;
    begin
        // Get information about the current module.
        NavApp.GetCurrentModuleInfo(Module);

        // In the new version, the BAD class is upgraded to WARNING
        if Module.DataVersion.Major = 1 then begin
            CustomerClass.Get('BAD');
            CustomerClass.Rename('WARNING');
            CustomerClass.Description := 'Warning Customer';
            CustomerClass.Modify();
        end;
    end;
}