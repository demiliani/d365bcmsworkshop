pageextension 50100 CustomerCardExt_NET extends "Customer Card"
{

    actions
    {
        addlast("F&unctions")
        {
            action(MessageFromDotNet)
            {
                ApplicationArea = All;
                Caption = 'Message from DotNet';
                Image = Alerts;

                trigger OnAction()
                begin
                    Message(DotNetWrapper.CallUnusefulDLL());
                end;
            }
        }
    }

    var
        DotNetWrapper: Codeunit DotNetWrapper;
}