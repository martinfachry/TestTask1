report 50000 "Sales Analysis Report"
{
    ApplicationArea = All;
    Caption = 'Sales Analysis Report';
    UsageCategory = ReportsAndAnalysis;
    RDLCLayout = './src/report/Report50000.rdlc';
    dataset
    {
        dataitem(SalesAnalysis; "Sales Analysis")
        {
            RequestFilterFields = Date;
            column(CustomerNo; "Customer No.")
            {
            }
            column(ItemNo; "Item No.")
            {
            }
            column(CurrencyCode; "Currency Code")
            {
            }
            column(Quantity; Quantity)
            {
            }
            column(Amount; Amount)
            {
            }
            column(DateFilter; DateFilter)
            {
            }
        }

    }
    trigger OnPreReport()
    begin
        DateFilter := SalesAnalysis.GetFilter(Date);
    end;

    var
        DateFilter: Text;
        TitleLbl: Label 'Sales Analysis';
        CustNoLbl: Label 'Customer No.';
        ItemNoLbl: Label 'Item No.';
        CurrCodeLbl: Label 'Currency Code';
        TotalQtyLbl: Label 'Total Quantity';
        TotalSales: Label 'Total Sales';
        DateFilterLbl: Label 'Date Filter';

}
