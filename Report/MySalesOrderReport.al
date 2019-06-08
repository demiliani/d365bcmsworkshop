report 50104 MySalesOrder
{
    //DefaultLayout = Word;
    RDLCLayout = 'Layout\MySalesOrderReportRDLC.rdl';
    WordLayout = 'Layout\MySalesOrderReportWord.docx';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    CaptionML = ITA = 'My Sales Order Report', ENU = 'My Sales Order Report';

    dataset
    {
        dataitem("Sales Header"; "Sales Header")
        {
            column("No"; "No.")
            {

            }



            dataitem("Sales Line"; "Sales Line")
            {
                DataItemLink = "Document Type" = FIELD ("Document Type"), "Document No." = FIELD ("No.");

                column(Type; Type)
                {

                }
                column(No_; "No.")
                {

                }
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
    
    var
        myInt: Integer; */
}