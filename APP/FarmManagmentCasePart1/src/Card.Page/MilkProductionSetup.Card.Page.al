page 54112 "Milk Production Setup"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Milk Production Setup";
    DeleteAllowed = false;
    InsertAllowed = false;
    Caption = 'Milk Production Setup';

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';

                field("Backup Type"; Rec."Backup Type")
                {
                    ToolTip = 'Specifies the value of the Backup Type field.', Comment = '%';
                }
                field("OEE Data"; Rec."OEE Data")
                {
                    ToolTip = 'Specifies the value of the OEE Backup Type field.', Comment = '%';
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

    trigger OnOpenPage()
    begin
        if not Rec.Get() then begin
            Rec.Init();
            Rec.Insert();
        end;

    end;

    var
        myInt: Integer;
}