pageextension 50105 CustomerCardExt extends "Customer Card"
{
    actions
    {
        addlast("F&unctions")
        {
            action(RevertName)
            {
                ApplicationArea = All;
                Caption = 'Revert Customer Name';
                Image = Change;

                trigger OnAction()
                var
                    RevertManagement: Codeunit "Revert Management";
                begin
                    Rec.Name := RevertManagement.RevertText(Rec.Name);
                end;
            }
        }
    }

}