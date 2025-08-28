page 54100 BreedTypeCard
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = BreedType;
    Caption = 'Breed Type Card';
    InsertAllowed = true;
    ModifyAllowed = true;
    DeleteAllowed = true;


    layout
    {
        area(Content)
        {
            group(Group)
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

                    trigger OnValidate()
                    var
                        BreedTypeHandler: Codeunit "BreedTypeHandler";
                    begin
                        BreedTypeHandler.SetLifeExpectancy(Rec);
                        BreedTypeHandler.SetBreedDescription(Rec);
                        BreedTypeHandler.SetMilkProperties(Rec);
                        CurrPage.Update();

                    end;
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
                field(BreedDescription; Rec.BreedDescription)
                {
                    ApplicationArea = All;
                    MultiLine = true;
                    ToolTip = 'Specifies the value of the Breed Description field.', Comment = '%';
                }
                field(BreedPicture; Rec.BreedPicture)
                {
                    ApplicationArea = All;
                    ToolTip = 'Upload or view the picture of this breed.', Comment = '%';
                }

            }
            // part(BreedType; BreedPicture)
            // {
            //     ApplicationArea = All;
            //     SubPageLink = "No." = field("No.");

            // }
        }

        area(FactBoxes)
        {
            part(BreedType; BreedPicture)
            {
                ApplicationArea = All;
                SubPageLink = "No." = field("No.");

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

    var
        myInt: Integer;
}