page 54103 CowCard
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = Cow;
    Caption = 'Cow Card page';
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
                    ToolTip = 'Specifies the value of the No. field.', Comment = '%';
                }
                field(BirthDate; Rec.BirthDate)
                {
                    ToolTip = 'Specifies the value of the Birth Date field.', Comment = '%';
                    ShowMandatory = true;
                }
                field(CowAge; Rec.CowAge)
                {
                    ToolTip = 'Specifies the value of the Cow Age field.', Comment = '%';

                    trigger OnValidate()
                    var
                        CowRec: Codeunit CowHandler;
                    begin
                        CowRec.AgeCriteria(Rec);
                        CurrPage.Update();
                        
                    end;
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.', Comment = '%';
                }
                field(EntryDate; Rec.EntryDate)
                {
                    ToolTip = 'Specifies the value of the Entry Date field.', Comment = '%';
                    ShowMandatory = true;
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

    trigger OnNewRecord(BelowxRec: Boolean)
    var
        SalesSetup: Record "Sales & Receivables Setup";
        NoSeries: Codeunit "No. Series";
    begin
        if Rec."No." = '' then begin
            SalesSetup.Get();
            SalesSetup.TestField(CowIdNos);
            if NoSeries.AreRelated(SalesSetup.CowIdNos, xRec."No. Series") then begin
                Rec."No. Series" := SalesSetup.CowIdNos;
            Rec."No.":= NoSeries.GetNextNo(Rec."No. Series", WorkDate())
            end;
        end;
        
    end;

    trigger OnClosePage()
    var
        Cow: Record Cow;
    begin
        Cow.SetRange("No.", Rec."No.");

        if cow.IsEmpty() and Rec.Get(Rec."No.") then begin
            Rec.Delete();
        end;
    end;
   
    var
        myInt: Integer;
}