page 50100 "Purchase Order API Page"
{
    PageType = API;
    Caption = 'purchaseorder';
    APIPublisher = 'SD';
    APIVersion = 'v1.0';
    APIGroup = 'custom';
    EntityName = 'purchaseorder';
    EntitySetName = 'purchaseorders';
    SourceTable = "Purchase Header";
    SourceTableView = where("Document Type" = const(Order));
    DelayedInsert = true;
    ODataKeyFields = SystemId;
    DeleteAllowed = false;
    ChangeTrackingAllowed = true;

    //URL: https://api.businesscentral.dynamics.com/v1.0/TENANTID/sandbox/api/SD/purchaseorders/beta
    //https://d365bcita0918vm.westeurope.cloudapp.azure.com:7048/NAV/api/sd/custom/v1.0/$metadata
    //companies({id})/purchaseorders

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(id; SystemId)
                {
                    Caption = 'ID', Locked = true;
                }
                field(doctype; "Document Type")
                {
                    Caption = 'doctype', Locked = true;
                }
                field(number; "No.")
                {
                    Caption = 'number', Locked = true;
                }
                field(documentdate; "Document Date")
                {
                    Caption = 'documentdate', Locked = true;
                }
                field(vendorNumber; "Buy-from Vendor No.")
                {
                    Caption = 'vendorNumber', Locked = true;
                }
                field(vendorName; "Buy-from Vendor Name")
                {
                    Caption = 'vendorName', Locked = true;
                }
                field(status; Status)
                {
                    Caption = 'status', Locked = true;
                }
                part(purchaseOrderLines; "Purchase Order Lines API")
                {
                    EntityName = 'purchaseorderline';
                    EntitySetName = 'purchaseorderlines';
                    Caption = 'purchaseorderline', Locked = true;
                    SubPageLink = "Document Type" = FIELD("Document Type"), "Document No." = field("No.");
                    //SubPageLink = "Document Id" = FIELD(Id);
                }
            }
        }
    }

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Insert(true);

        Modify(true);
        exit(false);
    end;

    trigger OnModifyRecord(): Boolean
    var
        PurchaseHeader: Record "Purchase Header";
    begin
        PurchaseHeader.SETRANGE(SystemId, SystemId);
        PurchaseHeader.FINDFIRST;

        IF "No." <> PurchaseHeader."No." THEN BEGIN
            PurchaseHeader.TRANSFERFIELDS(Rec, FALSE);
            PurchaseHeader.RENAME(PurchaseHeader."Document Type"::Order, "No.");
            TRANSFERFIELDS(PurchaseHeader);
        END;
    end;

    trigger OnDeleteRecord(): Boolean
    begin
        Delete(true);
    end;

}