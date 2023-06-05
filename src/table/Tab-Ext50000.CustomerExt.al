tableextension 50000 CustomerExt extends Customer
{
    fields
    {
        field(50000; "Body Email"; Text[2048])
        {
            Caption = 'Body Email';
            DataClassification = CustomerContent;
        }

        field(50001; "Threshold Quantity"; Decimal)
        {
            Caption = 'Threshold Quantity';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                if "Threshold Quantity" <> xRec."Threshold Quantity" then
                    "Email Notification Sent" := false;
            end;
        }
        field(50002; "Threshold Sales"; Decimal)
        {
            Caption = 'Threshold Sales';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                if "Threshold Sales" <> xRec."Threshold Sales" then
                    "Email Notification Sent" := false;
            end;
        }
        field(50003; "Email Receipients(s)"; Text[2048])
        {
            Caption = 'Email Receipients(s)';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                _SalesSetup.Get();
                _SalesSetup.TestField("Subject Email Sales Analysis");
                _SalesSetup.TestField("Attachment File Name");
            end;
        }
        field(50004; "Email Notification Sent"; Boolean)
        {
            Caption = 'Email Notification Sent';
            DataClassification = CustomerContent;
        }

    }
    var
        _SalesSetup: Record "Sales & Receivables Setup";
}
