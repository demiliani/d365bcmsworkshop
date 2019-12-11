codeunit 50110 TaskCodeunit
{
    trigger OnRun()
    var
        Result: Dictionary of [Text, Text];
        CustomerNo: Code[20];
        CustomerSalesValue: Text;
        NoOfSalesValue: Text;
        NoOfItemsShippedValue: Text;
    begin
        CustomerNo := Page.GetBackgroundParameters().Get('CustomerNo');
        if CustomerNo = '' then
            Error('Invalid parameter CustomerNo');
        if CustomerNo <> '' then begin
            CustomerSalesValue := Format(GetCustomerSalesAmount(CustomerNo));
            NoOfSalesValue := Format(GetNoOfItemsSales(CustomerNo));
            NoOfItemsShippedValue := Format(GetNoOfItemsShipped(CustomerNo));
            //sleep for demo purposes
            Sleep((Random(5)) * 1000);
        end;
        Result.Add('TotalSales', CustomerSalesValue);
        Result.Add('NoOfSales', NoOfSalesValue);
        Result.Add('NoOfItemsShipped', NoOfItemsShippedValue);
        Page.SetBackgroundTaskResult(Result);
    end;

    /// <summary>
    /// Gets the total amount of sales for a given customer.
    /// </summary>
    /// <param name="CustomerNo">The No. of the Customer.</param>
    /// <returns>The decimal value of the sales amount for the customer.</returns>
    local procedure GetCustomerSalesAmount(CustomerNo: Code[20]): Decimal
    var
        SalesLine: Record "Sales Line";
        amount: Decimal;
    begin
        SalesLine.SetRange("Document Type", SalesLine."Document Type"::Order);
        SalesLine.SetRange("Sell-to Customer No.", CustomerNo);
        if SalesLine.FindSet() then
            repeat
                amount += SalesLine."Line Amount";
            until SalesLine.Next() = 0;
        exit(amount);
    end;

    local procedure GetNoOfItemsSales(CustomerNo: Code[20]): Decimal
    var
        SalesLine: Record "Sales Line";
        total: Decimal;
    begin
        SalesLine.SetRange("Document Type", SalesLine."Document Type"::Order);
        SalesLine.SetRange("Sell-to Customer No.", CustomerNo);
        SalesLine.SetRange(Type, SalesLine.Type::Item);
        if SalesLine.FindSet() then
            repeat
                total += SalesLine.Quantity;
            until SalesLine.Next() = 0;
        exit(total);
    end;

    local procedure GetNoOfItemsShipped(CustomerNo: Code[20]): Decimal
    var
        SalesShiptmentLine: Record "Sales Shipment Line";
        total: Decimal;
    begin
        SalesShiptmentLine.SetRange("Sell-to Customer No.", CustomerNo);
        SalesShiptmentLine.SetRange(Type, SalesShiptmentLine.Type::Item);
        if SalesShiptmentLine.FindSet() then
            repeat
                total += SalesShiptmentLine.Quantity
            until SalesShiptmentLine.Next() = 0;
        exit(total);
    end;
}