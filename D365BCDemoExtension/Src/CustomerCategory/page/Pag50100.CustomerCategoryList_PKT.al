page 50100 "Customer Category List_PKT"
{
    PageType = List;
    SourceTable = "Customer Category_PKT";
    UsageCategory = Lists;
    ApplicationArea = All;
    CardPageId = "Customer Category Card_PKT";
    Caption = 'Customer Category List';
    AdditionalSearchTerms = 'ranking, categorization';

    layout
    {
        area(content)
        {
            repeater(Group)
            {               
                field(Code; Code)
                {
                    ApplicationArea = All;
                }
                field(Description; Description)
                {
                    ApplicationArea = All;
                }
                field(Default; Default)
                {
                    ApplicationArea = All;
                }
                field("Quality Control Enabled"; "Quality Control Enabled")
                {
                    ApplicationArea = All;
                }

                field(TotalCustomersForCategory; TotalCustomersForCategory)
                {
                    ApplicationArea = All;
                    ToolTip = 'Total Customers for Category';
                }


            }
        }

    }

    actions
    {
        area(processing)
        {
            action("Create Default Category")
            {
                Image = CreateForm;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = All;
                ToolTip = 'Create default category';
                Caption = 'Create default category';

                trigger OnAction();
                var
                    CustManagement: Codeunit "Customer Category Mgt_PKT";
                begin
                    CustManagement.CreateDefaultCategory();
                end;
            }

            action("Export Categories XML")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Export Customer Category';
                Caption = 'Export Customer Category';
                Image = Export;

                trigger OnAction()
                var
                    TempBlob: Codeunit "Temp Blob";
                    FileOutStream: OutStream;
                    FileInStream: InStream;
                    outputFile: Text;
                begin
                    TempBlob.CreateOutStream(FileOutStream);
                    Xmlport.Export(Xmlport::CustomerCategoryXMLPort_PKT, FileOutStream);
                    TempBlob.CreateInStream(FileInStream);
                    outputFile := 'Categories.xml';
                    DownloadFromStream(FileInStream, 'Export', '', '', outputFile);
                end;
            }
            action("Import Categories XML")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Import Customer Category';
                Caption = 'Import Customer Category';
                Image = Import;

                trigger OnAction()
                var
                    FileInStream: InStream;
                    fileName: Text;
                    ImportSuccessMsg: Label 'Import done sucessfully.';
                begin
                    UploadIntoStream('Import Category XML', '', '', fileName, FileInStream);
                    Xmlport.Import(Xmlport::CustomerCategoryXMLPort_PKT, FileInStream);
                    Message(ImportSuccessMsg);
                end;
            }
        }
    }
}