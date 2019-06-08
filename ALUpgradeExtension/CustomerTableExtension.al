tableextension 50105 CustomerTableExtension extends Customer
{
    fields
    {
        field(50105; "Customer Class"; Code[20])
        {
            TableRelation = CustomerClass.ID;
            ValidateTableRelation = true;            
            DataClassification = ToBeClassified;
            trigger OnValidate()            
            begin
               if (Rec.Id <> xRec.Id) and
                    (Rec.Blocked <> Blocked::" ") then
                begin
                    Error('Cannot update the Customer class of a blocked customer.')
                end; 
            end;
        }
    }
}