codeunit 50105 CustomerClassInstall
{
    // Subtype = install codeunit. 
    Subtype = Install;

    trigger OnInstallAppPerDatabase();
    var
        myAppInfo : ModuleInfo;
    begin
        NavApp.GetCurrentModuleInfo(myAppInfo); // Get info about the currently executing module

        // A 'DataVersion' of 0.0.0.0 indicates a 'fresh/new' install
        if myAppInfo.DataVersion = Version.Create(0,0,0,0) then 
            HandleFreshInstall
        else
            // If not a fresh install, then we are Re-installing the same version of the extension
            HandleReinstall; 
    end;
    
    // This trigger includes code for company-related operations. 
    trigger OnInstallAppPerCompany();
    var
        CustomerClass : Record CustomerClass;
    begin        
        if CustomerClass.IsEmpty() then begin
            InsertDefaultCustomerClass();
        end;

        //TODO:
        //SetDefaultCustomerClassForEveryCustomer();
        
    end;

    // Insert the GOLD, SILVER, BRONZE reward levels
    procedure InsertDefaultCustomerClass();
    begin
        InsertCustomerClass('TOP', 'Top Customer');
        InsertCustomerClass('MEDIUM', 'Standard Customer');
        InsertCustomerClass('BAD', 'Bad Customer');
    end;

    // Create and insert a reward level in the "Reward" table.
    procedure InsertCustomerClass(ID : Code[30]; Description : Text[250]);
    var
        CustomerClass : Record CustomerClass;
    begin
        CustomerClass.Init();
        CustomerClass.ID := ID;
        CustomerClass.Description := Description;        
        CustomerClass.Insert();
    end;

    local procedure HandleFreshInstall();
    begin
        // Do work needed the first time this extension is ever installed for this tenant.
        // Some possible usages:
        // - Service callback/telemetry indicating that extension was install
        // - Initial data setup for use
    end;

    local procedure HandleReinstall();
    begin
        // Do work needed when reinstalling the same version of this extension back on this tenant.
        // Some possible usages:
        // - Service callback/telemetry indicating that extension was reinstalled
        // - Data 'patchup' work, for example, detecting if new 'base' records have been changed while you have been working 'offline'.
        // - Setup 'welcome back' messaging for next user access.
    end;

}