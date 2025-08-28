page 54111 "Breed Factbox"
{
    PageType = ListPart;
    //ApplicationArea = All; -- Therefore, the ApplicationArea property on page level is not needed.
    //UsageCategory = Lists; -- because we don't want users to be able to search for this page.
    SourceTable = BreedType;
    Caption = 'Breed Factbox';
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater(General)
            {

                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No. field.', Comment = '%';
                }
                field(BreedName; Rec.BreedName)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Breed Name field.', Comment = '%';
                }
                field(BreedDescription; Rec.BreedDescription)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Breed Description field.', Comment = '%';
                }
                field(AverageLifeExpetancy; Rec.AverageLifeExpetancy)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Average Life Expectancy field.', Comment = '%';
                }
                field(MilkProperties; Rec.MilkProperties)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Milk Properties field.', Comment = '%';
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
}