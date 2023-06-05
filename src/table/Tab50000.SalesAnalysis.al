table 50000 "Sales Analysis"
{
    Caption = 'Sales Analysis';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Customer No."; Text[20])
        {
            Caption = 'Customer No.';
            DataClassification = CustomerContent;
            TableRelation = Customer;
        }
        field(2; "Item No."; Text[20])
        {
            Caption = 'Item No.';
            DataClassification = CustomerContent;
            TableRelation = Item;
        }
        field(3; Date; Date)
        {
            Caption = 'Date';
            DataClassification = CustomerContent;
        }
        field(4; Quantity; Decimal)
        {
            Caption = 'Quantity';
            DataClassification = CustomerContent;
        }
        field(5; Amount; Decimal)
        {
            Caption = 'Amount ';
            DataClassification = CustomerContent;
        }
        field(6; "Currency Code"; Text[10])
        {
            Caption = 'Currency Code';
            DataClassification = CustomerContent;
            TableRelation = Currency;
        }
    }
    keys
    {
        key(PK; "Customer No.", "Item No.", "Date", "Currency Code")
        {
            Clustered = true;
        }
        key(key2; "Customer No.", "Date")
        {
        }
        key(key3; "Item No.")
        {
        }
        key(key4; "Customer No.", "Item No.", "Date")
        {
        }
    }
}
