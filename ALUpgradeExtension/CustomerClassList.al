page 50111 CustomerClassList
{
    PageType = List;
    SourceTable = CustomerClass;
    CardPageId = CustomerClassCard;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(ID; ID)
                {
                    ApplicationArea = All;
                }
                field(Description; Description)
                {
                    ApplicationArea = All;
                }
            }
        }

    }

}