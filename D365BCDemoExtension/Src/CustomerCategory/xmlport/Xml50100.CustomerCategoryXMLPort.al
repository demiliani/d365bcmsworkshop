xmlport 50100 CustomerCategoryXMLPort_PKT
{
    Caption = 'Customer Category XMLPort';
    Direction = Both;
    Format = Xml;

    schema
    {
        textelement(Categories)
        {
            tableelement(Category; "Customer Category_PKT")
            {
                fieldattribute(CategoryCode; Category.Code)
                {
                }
                fieldattribute(Description; Category.Description)
                {
                }
            }
        }
    }

}