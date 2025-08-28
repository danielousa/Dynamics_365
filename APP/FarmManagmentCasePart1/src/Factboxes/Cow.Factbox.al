page 54110 "Cow Factbox"
{
    PageType = ListPart;
    //ApplicationArea = All; -- Therefore, the ApplicationArea property on page level is not needed.
    //UsageCategory = Lists; -- because we don't want users to be able to search for this page.
    SourceTable = Cow;
    Caption = 'Cow Factbox';
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
                field(BirthDate; Rec.BirthDate)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Birth Date field.', Comment = '%';
                }
                field(CowAge; Rec.CowAge)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Cow Age field.', Comment = '%';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Description field.', Comment = '%';
                }
                field(EntryDate; Rec.EntryDate)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Entry Date field.', Comment = '%';
                }
                field(ExitDate; Rec.ExitDate)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Exit Date field.', Comment = '%';
                }
                field("BreedType Code"; Rec."BreedType Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Breed Type Code field.', Comment = '%';
                }
                field(BreedName; Rec.BreedName)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Breed Names field.', Comment = '%';
                }
                field(TotalMilkProduction; Rec.TotalMilkProduction)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Total Milk Production field.', Comment = '%';
                }
                field(Blocked; Rec.Blocked)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Blocked field.', Comment = '%';
                }
                field(CowStatus; Rec.CowStatus)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Cow Status field.', Comment = '%';
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