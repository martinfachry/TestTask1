page 50001 "Sales Analysis API"
{
    APIGroup = 'sales';
    APIPublisher = 'fachri';
    APIVersion = 'beta';
    Caption = 'salesAnalysis';
    DelayedInsert = true;
    EntityName = 'salesAnalysis';
    EntitySetName = 'salesAnalysis';
    PageType = API;
    SourceTable = "Sales Analysis";
    SourceTableTemporary = true;
    ODataKeyFields = "Customer No.", "Currency Code";
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(customerNo; Rec."Customer No.")
                {
                    Caption = 'Item No.';
                }
                field(itemNo; Rec."Item No.")
                {
                    Caption = 'Item No.';
                }
                field(currencyCode; Rec."Currency Code")
                {
                    Caption = 'Currency Code';
                }
                field(quantity; Rec.Quantity)
                {
                    Caption = 'Quantity';
                }
                field(amount; Rec.Amount)
                {
                    Caption = 'Amount ';
                }
                field(date; Rec.Date)
                {
                    Visible = false;
                }
            }
        }
    }


    trigger OnOpenPage()
    begin
        Clear(_QuerySales);
        if Rec.GetFilter(Date) <> '' then
            _QuerySales.Setfilter(dateSales, Rec.GetFilter(Date));
        if Rec.GetFilter("Item No.") <> '' then
            _QuerySales.SetFilter(itemNo, Rec.GetFilter("Item No."));
        _QuerySales.Open();
        Clear(Rec);
        while _QuerySales.Read() do begin
            Rec."Customer No." := _QuerySales.customerNo;
            Rec."Item No." := _QuerySales.itemNo;
            Rec."Currency Code" := _QuerySales.currencyCode;
            Rec.Date := Today;
            Rec.Quantity := _QuerySales.quantity;
            Rec.Amount := _QuerySales.amount;
            if Rec.Insert() then;
        end;
        _QuerySales.Close();
    end;

    var
        SalesAnalysisMgt: Codeunit "Sales Analysis Function";
        _QuerySales: Query "Calc. Quantity Amount";
        StartDate: Date;
        EndDate: Date;
        _SalesAnalysis: Record "Sales Analysis" temporary;
}