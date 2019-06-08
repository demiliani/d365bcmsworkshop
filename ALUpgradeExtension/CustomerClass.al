table 50105 CustomerClass
{
    DataClassification = CustomerContent;
    Caption = 'Customer Class';
    LookupPageId = CustomerClassList;
    DrillDownPageId = CustomerClassList;

    fields
    {


        field(1; ID; Code[20])
        {
            Caption = 'ID';
            DataClassification = CustomerContent;
        }
        field(2; Description; Text[50])
        {
            NotBlank = true;
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(PK; ID)
        {
            Clustered = true;
        }
    }

}