pageextension 50122 CustomerCategoryCardExt_PKN extends "Customer Category Card_PKT"
{
    layout
    {
        addlast(General)
        {
            field("Can Create Orders"; "Can Create Orders")
            {
                ApplicationArea = All;
            }
        }
    }

}