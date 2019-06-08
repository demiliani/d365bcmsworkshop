report 50103 "MyCustomerReport"
{
    //DefaultLayout = Word;
    RDLCLayout = 'Layout\MyCustomerReportRDLC.rdl';
    WordLayout = 'Layout\MyCustomerReportWord.docx';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    CaptionML = ITA = 'My Customer Report', ENU = 'My Customer Report';

    dataset
    {
        dataitem(Customer; Customer)
        {
            column("No"; "No.")
            {
                
            }
            column(Name; "Name")
            {
                
            }
            column(Address; Address)
            {
                
            }
            column(City; City)
            {
                
            }
            
        }
    }
    
    /* requestpage
    {
        layout
        {
            area(content)
            {
                group(GroupName)
                {
                    field(Name; SourceExpression)
                    {
                        
                    }
                }
            }
        }
    
        actions
        {
            area(processing)
            {
                action(ActionName)
                {
                    
                }
            }
        }
    }
    */
    
    var
    [InDataSet]
        myInt: Integer;
}