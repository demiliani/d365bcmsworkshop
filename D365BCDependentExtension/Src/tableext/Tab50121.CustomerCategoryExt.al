tableextension 50121 CustomerCategoryExt_PKN extends "Customer Category_PKT"
{
    fields
    {
        field(50121; "Can Create Orders"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Can Create Sales Orders';
        }
    }
}