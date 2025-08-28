page 54102 BreedTypeList
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = BreedType;
    CardPageId = BreedTypeCard;
    Editable = true;

    layout
    {
        area(Content)
        {
            repeater(Group)
            {

                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field.', Comment = '%';
                }
                field(BreedName; Rec.BreedName)
                {
                    ToolTip = 'Specifies the value of the Breed Name field.', Comment = '%';
                }
                field(BreedDescription; Rec.BreedDescription)
                {
                    ToolTip = 'Specifies the value of the Breed Description field.', Comment = '%';
                }
                field(AverageLifeExpetancy; Rec.AverageLifeExpetancy)
                {
                    ToolTip = 'Specifies the value of the Average Life Expectancy field.', Comment = '%';
                }
                field(BreedPicture; Rec.BreedPicture)
                {
                    ToolTip = 'Upload or view the picture of this breed.', Comment = '%';
                }
                field(MilkProperties; Rec.MilkProperties)
                {
                    ToolTip = 'Specifies the value of the Milk Properties field.', Comment = '%';
                }
            }
        }
        area(Factboxes)
        {

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