tableextension 50001 SalesSetupExt extends "Sales & Receivables Setup"
{
    fields
    {
        field(50000; "Subject Email Sales Analysis"; Text[50])
        {
            Caption = 'Subject Email Sales Analysis';
            DataClassification = CustomerContent;
        }
        field(50001; "Attachment File Name"; Text[100])
        {
            Caption = 'Attachment File Name';
            DataClassification = CustomerContent;
        }
    }
}
