page 54115 "Total Milk Production Chart"
{
    PageType = CardPart;
    ApplicationArea = All;
    UsageCategory = Administration;
    Caption = 'Total Milk Production by CowId';

    layout
    {
        area(Content)
        {
            group(General)
            {
                usercontrol(Chart; "Chart Control")
                {
                    ApplicationArea = All;

                    trigger ControlReady()
                    begin
                        DrawChart();
                    end;

                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction()
                begin

                end;
            }
        }
    }

    local procedure DrawChart()
    var
        Cow: Record Cow;
        LabelsJsonArray, DataJosnArray : JsonArray;
        CowJsonValue, DataJsonValue : JsonValue;
    begin
        cow.SetFilter(TotalMilkProduction, '>%1', 0);
        if Cow.FindSet() then
            repeat
                cow.CalcFields(TotalMilkProduction);
                CowJsonValue.SetValue(Cow."No.");
                LabelsJsonArray.Add(CowJsonValue.Clone());
                DataJsonValue.SetValue(Cow.TotalMilkProduction);
                DataJosnArray.Add(DataJsonValue.Clone());

            until Cow.Next() = 0;

        CurrPage.Chart.drawChart(LabelsJsonArray, DataJosnArray);
    end;

    var
        myInt: Integer;
}