pageextension 50121 CustomerCategoryListExt_PKN extends "Customer Category List_PKT"
{
    layout
    {
        addlast(Group)
        {
            field("Can Create Orders"; "Can Create Orders")
            {
                ApplicationArea = All;
            }
        }
    }

}