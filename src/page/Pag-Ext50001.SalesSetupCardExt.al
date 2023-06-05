pageextension 50001 SalesSetupCardExt extends "Sales & Receivables Setup"
{
    layout
    {
        addlast(content)
        {
            group("Sales Analysis")
            {
                field("Subject Email Sales Analysis"; Rec."Subject Email Sales Analysis")
                {
                    ApplicationArea = All;
                }
                field("Attachment File Name"; Rec."Attachment File Name")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
