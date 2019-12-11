codeunit 50121 CustomCategoryLogic_PKN
{


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Customer Category Mgt_PKT", 'OnBeforeVerifyQuality', '', false, false)]
    local procedure CustomQualityCheckEvent(var SalesLine: Record "Sales Line"; var handled: Boolean)
    begin
        handled := true;
        CustomQualityCheck(SalesLine);
    end;

    local procedure CustomQualityCheck(var SalesLine: Record "Sales Line")
    var
        Customer: Record Customer;
        CustomerCategory: Record "Customer Category_PKT";
        //ErrQualityEnabled: Label 'Customer %1 is not Quality Enabled';
        ErrSalesEnabled: Label 'Customer %1 is not enabled for sales orders';
    begin
        if Customer.Get(SalesLine."Sell-to Customer No.") then begin
            if CustomerCategory.Get(Customer."No.") then begin
                /* if not CustomerCategory."Quality Control Enabled" then
                    Error(ErrQualityEnabled, Customer."No."); */
                if not CustomerCategory."Can Create Orders" then
                    Error(ErrSalesEnabled, Customer."No.");
            end;
        end;
    end;
}