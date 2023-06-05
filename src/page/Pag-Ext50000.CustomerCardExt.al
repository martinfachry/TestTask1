pageextension 50000 CustomerCardExt extends "Customer Card"
{
    layout
    {
        addlast(content)
        {
            group(Email)
            {
                field("Body Email"; Rec."Body Email")
                {
                    ApplicationArea = All;
                    MultiLine = true;
                }

                field("Threshold Quantity"; Rec."Threshold Quantity")
                {
                    ApplicationArea = All;
                }
                field("Threshold Sales"; Rec."Threshold Sales")
                {
                    ApplicationArea = All;
                }
                field("Email Receipients(s)"; Rec."Email Receipients(s)")
                {
                    ApplicationArea = All;
                }
                field("Email Notification Sent"; Rec."Email Notification Sent")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    var
        SalesAnalysisMgt: Codeunit "Sales Analysis Function";
}
