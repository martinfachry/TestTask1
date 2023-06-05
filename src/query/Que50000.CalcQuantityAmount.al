query 50000 "Calc. Quantity Amount"
{
    QueryType = Normal;
    /*APIGroup = 'sales';
    APIPublisher = 'fachri';
    APIVersion = 'beta';
    Caption = 'salesAnalysis';
    EntityName = 'salesAnalysis';
    EntitySetName = 'salesAnalysis'*/
    ;
    elements
    {
        dataitem(salesAnalysis; "Sales Analysis")
        {
            column(customerNo; "Customer No.")
            {
            }
            column(itemNo; "Item No.")
            {
            }
            column(currencyCode; "Currency Code")
            {
            }
            filter(dateSales; Date)
            {
                //Method = Min;
            }
            column(quantity; Quantity)
            {
                Method = Sum;
            }
            column(amount; Amount)
            {
                Method = Sum;
            }
        }
    }
}
