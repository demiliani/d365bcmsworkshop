page 50110 CustomerClassCard
{
    PageType = Card;
    SourceTable = CustomerClass;

    layout
    {
        area(content)
        {
            group(General)
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