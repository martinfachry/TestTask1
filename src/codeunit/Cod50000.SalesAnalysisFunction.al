codeunit 50000 "Sales Analysis Function"
{
    procedure CheckItemSalesAnalysis(pSalesHeader: Record "Sales Header"; pSalesLine: Record "Sales Line")
    var
        _SalesAnalysis: Record "Sales Analysis";
    begin
        if (pSalesHeader."Document Type" <> pSalesHeader."Document Type"::Order) then
            exit;
        if (pSalesLine.Type <> pSalesLine.Type::Item) then
            exit;

        Clear(_SalesAnalysis);
        _SalesAnalysis.Reset();
        _SalesAnalysis.SetRange("Customer No.", pSalesHeader."Sell-to Customer No.");
        _SalesAnalysis.SetRange("Item No.", pSalesLine."No.");
        _SalesAnalysis.SetRange(Date, pSalesHeader."Posting Date");
        _SalesAnalysis.SetRange("Currency Code", pSalesHeader."Currency Code");
        if _SalesAnalysis.FindFirst() then begin
            _SalesAnalysis.Quantity += pSalesLine.Quantity;
            _SalesAnalysis.Amount += pSalesLine.Amount;
            _SalesAnalysis.Modify();
        end else begin
            _SalesAnalysis.SetRange("Customer No.");
            _SalesAnalysis.SetRange(Date);
            _SalesAnalysis.SetRange("Currency Code");
            if _SalesAnalysis.FindSet() then begin
                _SalesAnalysis.Reset();
                _SalesAnalysis."Customer No." := pSalesHeader."Sell-to Customer No.";
                _SalesAnalysis."Item No." := pSalesLine."No.";
                _SalesAnalysis.Date := pSalesHeader."Posting Date";
                _SalesAnalysis.Quantity := pSalesLine.Quantity;
                _SalesAnalysis.Amount := pSalesLine.Amount;
                _SalesAnalysis.Insert();
            end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnPostSalesLineOnAfterTestUpdatedSalesLine', '', false, false)]
    local procedure OnPostSalesLineOnAfterTestUpdatedSalesLine(var SalesLine: Record "Sales Line"; var EverythingInvoiced: Boolean; SalesHeader: Record "Sales Header")
    begin
        CheckItemSalesAnalysis(SalesHeader, SalesLine);
    end;

    [EventSubscriber(ObjectType::Page, Page::"Report Selection - Sales", 'OnSetUsageFilterOnAfterSetFiltersByReportUsage', '', false, false)]
    local procedure MOnSetUsageFilterOnAfterSetFiltersByReportUsage(var Rec: Record "Report Selections"; ReportUsage2: Option)
    begin
        case ReportUsage2 of
            50000:
                Rec.SetRange(Usage, "Report Selection Usage"::"Sales Analysis");
        end;
    end;

    procedure SendEmailNotifSalesExceedThreshold(pCustomer: Record Customer; var pSalesAnalysis: Record "Sales Analysis")
    var
        //_Customer: Record Customer;
        Email: Codeunit Email;
        EmailMessage: Codeunit "Email Message";
        BodyEmail: Text;
        OutS: OutStream;
        InS: InStream;
        TempBlob: Codeunit "Temp Blob";
        RecRef: RecordRef;
        SalesSetup: Record "Sales & Receivables Setup";
    begin
        BodyEmail := '';
        SalesSetup.Get();
        TempBlob.CreateOutStream(OutS);
        RecRef.GetTable(pSalesAnalysis);
        Report.SaveAs(Report::"Sales Analysis Report", '', ReportFormat::Pdf, OutS, RecRef);
        TempBlob.CreateInStream(ins);
        BodyEmail := StrSubstNo(pCustomer."Body Email", pCustomer.Name);
        EmailMessage.Create(pCustomer."Email Receipients(s)", SalesSetup."Subject Email Sales Analysis", BodyEmail);
        EmailMessage.AddAttachment(SalesSetup."Attachment File Name", 'PDF', InS);
        Email.Send(EmailMessage);
    end;
}
