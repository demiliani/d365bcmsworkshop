codeunit 50100 "Customer Category Mgt_PKT"
{
    procedure CreateDefaultCategory()
    var
        CustomerCategory: Record "Customer Category_PKT";
        DefaultCode: Label 'DEFAULT';
        DefaultDescription: Label 'Default Customer Category';
    begin
        CustomerCategory.Code := DefaultCode;
        CustomerCategory.Description := DefaultDescription;
        CustomerCategory.Default := true;
        if CustomerCategory.Insert then;
    end;


    procedure AssignDefaultCategory(CustomerCode: Code[20])

    var
        Customer: Record Customer;
        CustomerCategory: Record "Customer Category_PKT";
    begin
        //Set default category for a Customer        
        Customer.Get(CustomerCode);
        CustomerCategory.SetRange(Default, true);
        if CustomerCategory.FindFirst() then begin
            Customer.Validate("Customer Category Code_PKT", CustomerCategory.Code);
            Customer.Modify();
        end;
    end;

    procedure AssignDefaultCategory()
    var
        Customer: Record Customer;
        CustomerCategory: Record "Customer Category_PKT";
    begin
        //Set default category for ALL Customer       
        CustomerCategory.SetRange(Default, true);
        if CustomerCategory.FindFirst() then begin
            Customer.SetFilter("Customer Category Code_PKT", '%1', '');
            Customer.ModifyAll("Customer Category Code_PKT", CustomerCategory.Code, true);
        end;
    end;

    //Returns the number of Customers without an assigned Customer Category
    procedure GetTotalCustomersWithoutCategory(): Integer
    var
        Customer: record Customer;
    begin
        Customer.SetRange("Customer Category Code_PKT", '');
        exit(customer.Count());
    end;

    procedure GetSalesAmount(CustomerCategoryCode: Code[20]): Decimal
    var
        SalesLine: Record "Sales Line";
        Customer: record Customer;
        TotalAmount: Decimal;
    begin
        Customer.SetCurrentKey("Customer Category Code_PKT");
        Customer.SetRange("Customer Category Code_PKT", CustomerCategoryCode);
        if Customer.FindSet() then
            repeat
                SalesLine.SetRange("Document Type", SalesLine."Document Type"::Order);
                SalesLine.SetRange("Sell-to Customer No.", Customer."No.");
                if SalesLine.FindSet() then
                    repeat
                        TotalAmount += SalesLine."Line Amount";
                    until SalesLine.Next() = 0;
            until Customer.Next() = 0;

        exit(TotalAmount);
    end;


    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnAfterValidateEvent', 'No.', false, false)]
    local procedure CheckQualityEnabled(var Rec: Record "Sales Line")
    begin
        if (Rec."Document Type" = Rec."Document Type"::Order) and (Rec.Type = Rec.Type::Item) then begin
            VerifyQualityEnabled(Rec);
        end;
    end;

    local procedure VerifyQualityEnabled(var SalesLine: Record "Sales Line")
    var
        handled: Boolean;
    begin
        OnBeforeVerifyQuality(SalesLine, handled);
        VerifyQuality(SalesLine, handled);
        OnAfterVerifyQuality(SalesLine);
    end;

    [IntegrationEvent(true, false)]
    local procedure OnBeforeVerifyQuality(var SalesLine: Record "Sales Line"; var handled: Boolean)
    begin
    end;

    [IntegrationEvent(true, false)]
    local procedure OnAfterVerifyQuality(var SalesLine: Record "Sales Line")
    begin
    end;

    local procedure VerifyQuality(var SalesLine: Record "Sales Line"; var handled: Boolean)
    var
        Customer: Record Customer;
        CustomerCategory: Record "Customer Category_PKT";
        QualityCheckErr: Label 'Customer %1 is not quality enabled.';
        CheckNotification: Notification;
    begin
        if Customer.Get(SalesLine."Sell-to Customer No.") then begin
            if CustomerCategory.Get(Customer."Customer Category Code_PKT") and
            not CustomerCategory."Quality Control Enabled" then
            begin
                
                CheckNotification.Message(StrSubstNo(QualityCheckErr,Customer."No."));
                CheckNotification.Send();
                Error(StrSubstNo(QualityCheckErr,Customer."No."));
            end;
        end;
    end;

}