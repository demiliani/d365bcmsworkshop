dotnet
{

    assembly(mscorlib)
    {
        type(System.DateTime; MyDateTime) { }
    }
    /* assembly(System)
    {
        type(System.Diagnostics.Process; Process) { }
        type(System.Diagnostics.ProcessStartInfo; ProcessStartInfo) { }
        type(System.Diagnostics.ProcessWindowStyle; ProcessWindowStyle) { }
    } */
    assembly(UnusefulDLL)
    {
        type(UnusefulDLL.UnusefulClass; UnusefulClass) { }
    }

}

codeunit 50100 DotNetWrapper
{
    procedure CallUnusefulDLL(): Text
    var
        UnusefulClass: DotNet UnusefulClass;
    begin
        UnusefulClass := UnusefulClass.UnusefulClass();
        exit(UnusefulClass.GiveMeMessage());
    end;



    /* procedure PrintExternalDocument(Path: Text[100])
    begin
        if NOT CallDotNet(Path) then
            Error('Error on printing document %1. \\ERROR: %2', Path, GetLastErrorText());
    end; */

    /* [TryFunction]
    local procedure CallDotNet(Path: Text[100])
    var
        [RunOnClient]
        Process: DotNet Process;
        [RunOnClient]
        ProcessStartInfo: DotNet ProcessStartInfo;
        [RunOnClient]
        ProcessWindowStyle: DotNet ProcessWindowStyle;
    begin
        ProcessStartInfo := ProcessStartInfo.ProcessStartInfo(Path);
        ProcessStartInfo.Verb := 'Print';
        ProcessStartInfo.CreateNoWindow := true;
        ProcessStartInfo.WindowStyle := ProcessWindowStyle.Hidden;
        Process.Start(ProcessStartInfo);
    end; */

    /* procedure CreateQRCode()
    var
        EIDQRGenerator: DotNet EIDQRGenerator;
    begin
        //Calling my custom DLL
        EIDQRGenerator.CreateQRCode('Prova', 300, 300, 'C:\TEMP', 'testQR.jpg');
    end; */




}