page 50110 "Custom Item API"
{
    Caption = 'items', Locked = true;
    ChangeTrackingAllowed = true;
    InsertAllowed = false;
    DelayedInsert = true;
    EntityName = 'item';
    EntitySetName = 'items';
    ODataKeyFields = Id;
    PageType = API;
    APIGroup = 'customapi';
    APIPublisher = 'sd';
    APIVersion = 'v1.0';
    SourceTable = Item;

    //https://api.businesscentral.dynamics.com/v2.0/production/api/sd/customapi/v1.0/items
    //http://navserver:7048/api/sd/customapi/v1.0/items


    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Id; Id)
                {
                    ApplicationArea = All;
                    Caption = 'Id', Locked = true;
                    Editable = false;
                }
                field(number; "No.")
                {
                    ApplicationArea = All;
                    Caption = 'Number', Locked = true;
                }
                field(displayName; Description)
                {
                    ApplicationArea = All;
                    Caption = 'DisplayName', Locked = true;
                    ToolTip = 'Specifies the Description for the Item.';
                }

                part(picture; "Picture Entity")
                {
                    ApplicationArea = All;
                    Caption = 'picture';
                    EntityName = 'picture';
                    EntitySetName = 'picture';
                    SubPageLink = Id = FIELD(Id);
                }

            }
        }
    }
}