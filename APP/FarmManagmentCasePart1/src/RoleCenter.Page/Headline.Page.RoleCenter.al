page 54116 "Headline RoleCenter"
{
    PageType = HeadlinePart;
    ApplicationArea = All;
    Caption = 'Headline RoleCenter';

    layout
    {
        area(Content)
        {
            field(HeadlineTxt; HeadlineTxt)
            {
                ApplicationArea = All;
            }
            field(TopProducerTxt; TopProducerTxt)
            {
                ApplicationArea = all;

                trigger OnDrillDown()
                var
                    Cow: Record Cow;
                begin
                    Page.Run(Page::CowListByMilkProduction, Cow);

                end;
            }

        }
    }

    trigger OnOpenPage()
    var
        Cow: Record Cow;
        TopCowName: Text;
        TopTotalMilkProduction: Decimal;
        Notifications: Codeunit GetBlocked;
    begin
        HeadlineTxt := 'Welcome <emphasize>Local Farm Trade Milk</emphasize>';

        if Cow.FindSet() then begin
            Cow.SetCurrentKey(TotalMilkProduction);
            Cow.FindLast();

            TopProducerCowNo := Cow."No.";
            TopCowName := Format(Cow.BreedName);
            TopTotalMilkProduction := Cow.TotalMilkProduction;
        end else begin
            TopCowName := 'Unknown';
        end;

        TopProducerTxt := StrSubstNo('Top cow: <emphasize>%1</emphasize> with <emphasize>%2</emphasize> liters of milk', TopCowName, TopTotalMilkProduction);

        Notifications.GetBlockedRecords();
    end;

    var
        HeadlineTxt: Text;
        TopProducerTxt: Text;
        TopProducerCowNo: Code[20];
}