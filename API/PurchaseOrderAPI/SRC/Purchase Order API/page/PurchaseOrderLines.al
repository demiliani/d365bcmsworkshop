page 50101 "Purchase Order Lines API"
{
    PageType = ListPart;
    SourceTable = "Purchase Line";
    SourceTableView = where("Document Type" = const(Order));
    DelayedInsert = true;

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                /* field(id; Id)
                {
                } */
                field(doctype; "Document Type")
                {
                    Caption = 'doctype', Locked = true;
                }
                field(docno; "Document No.")
                {
                    Caption = 'docno', Locked = true;
                }
                field(sequence; "Line No.")
                {
                }
                field(linetype; Type)
                {
                }
                field(itemNo; "No.")
                {
                }
                field(quantity; Quantity)
                {
                }
                field(um; "Unit of Measure Code")
                {
                }
                field(unitCost; "Unit Cost")
                {
                }
                field(lineAmount; "Line Amount")
                {
                }
                field(qty_received; "Quantity Received")
                {
                }
                field(qty_invoiced; "Quantity Invoiced")
                {
                }
            }
        }

    }


}