page 54106 "Milk Production Document"
{
    PageType = Document;
    ApplicationArea = All;
    UsageCategory = Documents;
    SourceTable = "Milk Production Header";

    layout
    {
        area(Content)
        {
            group(General)
            {

                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field.', Comment = '%';
                }
                field("Document Date"; Rec."Document Date")
                {
                    ToolTip = 'Specifies the value of the Date field.', Comment = '%';
                }
            }
            part(Lines; "Milk Production Subpage")
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

    trigger OnNewRecord(BelowxRec: Boolean)
    var
        SalesSetup: Record "Sales & Receivables Setup";
        NoSeries: Codeunit "No. Series";
    begin
        if Rec."No." = '' then begin
            SalesSetup.Get();
            SalesSetup.TestField(DocumentIdNos);
            if NoSeries.AreRelated(SalesSetup.DocumentIdNos, xRec."No. Series") then begin
                Rec."No. Series" := SalesSetup.DocumentIdNos;
                Rec."No." := NoSeries.GetNextNo(Rec."No. Series", WorkDate())
            end;
        end;

    end;

    trigger OnClosePage()
    var
        MilkProductionLine: Record "Milk Production Line";
    begin
        if (Rec."Document Date" = 0D) then begin
            MilkProductionLine.SetRange("No.", Rec."No.");
            if MilkProductionLine."Cow No." = '' then begin
                Rec.Delete();
            end;
        end;
    end;

    var
        myInt: Integer;
}