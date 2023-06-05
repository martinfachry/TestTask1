report 50001 "Send Email Notification"
{
    ApplicationArea = All;
    Caption = 'Send Email Notification';
    UsageCategory = Tasks;
    ProcessingOnly = true;
    dataset
    {
        dataitem(Customer; Customer)
        {
            RequestFilterFields = "No.";
            DataItemTableView = where("Email Notification Sent" = filter(false), "Email Receipients(s)" = filter(<> ''));
            trigger OnAfterGetRecord()
            begin
                if (Customer."Threshold Quantity" = 0) and (Customer."Threshold Sales" = 0) then
                    CurrReport.Skip();
                IsExceed := false;
                Clear(QuerySA);
                QuerySA.SetRange(customerNo, Customer."No.");
                QuerySA.SetFilter(dateSales, DateFilterTxt);
                if Customer."Threshold Quantity" > 0 then begin
                    QuerySA.SetFilter(quantity, '>%1', Customer."Threshold Quantity");
                    QuerySA.Open();
                    if QuerySA.Read() then
                        IsExceed := true;
                    QuerySA.SetRange(quantity);
                end;
                if (Customer."Threshold Sales" > 0) and (not IsExceed) then begin
                    QuerySA.SetFilter(amount, '>%1', Customer."Threshold Sales");
                    QuerySA.Open();
                    if QuerySA.Read() then
                        IsExceed := true;
                end;
                if IsExceed then begin
                    Clear(SalesAnalysis);
                    SalesAnalysis.Reset();
                    SalesAnalysis.SetRange("Customer No.", Customer."No.");
                    SalesAnalysis.SetFilter(Date, DateFilterTxt);
                    if SalesAnalysis.FindSet() then begin
                        Clear(SAMgt);
                        SAMgt.SendEmailNotifSalesExceedThreshold(Customer, SalesAnalysis);
                        Customer."Email Notification Sent" := true;
                        Customer.Modify();
                    end;
                end;
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                group(Filter)
                {
                    field("Date Filter"; DateFilterTxt)
                    {
                        ApplicationArea = All;
                        trigger OnValidate()
                        begin
                            Clear(GLAcc);
                            GLAcc.SetFilter("Date Filter", DateFilterTxt);
                            DateFilterTxt := GLAcc.GetFilter("Date Filter");
                        end;
                    }

                }
            }
        }
    }
    var
        SalesAnalysis: Record "Sales Analysis";
        SAMgt: Codeunit "Sales Analysis Function";
        QuerySA: Query "Calc. Quantity Amount";
        DateFilterTxt: Text;
        GLAcc: Record "G/L Account";
        IsExceed: Boolean;
}
