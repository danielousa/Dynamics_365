page 54104 CowList
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = Cow;
    CardPageId = CowCard;
    Editable = false;
    Caption = 'Cow List page';

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
                field(BirthDate; Rec.BirthDate)
                {
                    ToolTip = 'Specifies the value of the Birth Date field.', Comment = '%';
                }
                field(CowAge; Rec.CowAge)
                {
                    ToolTip = 'Specifies the value of the Cow Age field.', Comment = '%';
                }

                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.', Comment = '%';
                }
                field(EntryDate; Rec.EntryDate)
                {
                    ToolTip = 'Specifies the value of the Entry Date field.', Comment = '%';
                }
                field(ExitDate; Rec.ExitDate)
                {
                    ToolTip = 'Specifies the value of the Exit Date field.', Comment = '%';
                }
                field("BreedType Code"; Rec."BreedType Code")
                {
                    ToolTip = 'Specifies the value of the Breed Type Code field.', Comment = '%';
                }
                field(BreedName; Rec.BreedName)
                {
                    ToolTip = 'Specifies the value of the Breed Names field.', Comment = '%';
                }
                field(TotalMilkProduction; Rec.TotalMilkProduction)
                {
                    ToolTip = 'Specifies the value of the Total Milk Production field.', Comment = '%';
                }
                field(Blocked; Rec.Blocked)
                {
                    ToolTip = 'Specifies the value of the Blocked field.', Comment = '%';
                }
                field(CowStatus; Rec.CowStatus)
                {
                    ToolTip = 'Specifies the value of the Cow Status field.', Comment = '%';
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
            action(ExportCowasJSON)
            {
                ApplicationArea = All;
                Caption = 'Export Cow as JSON';
                Image = Compress;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                ToolTip = 'Export All cows as Json Files in a ZIP Archive';

                trigger OnAction()
                var
                    ExportJsonHelper: Codeunit "Export Json Helper";
                begin
                    ExportJsonHelper.ExportCowASJson();

                end;
            }
        }
    }
}