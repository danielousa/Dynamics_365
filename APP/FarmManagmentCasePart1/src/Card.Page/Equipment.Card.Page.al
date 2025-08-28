page 54119 EquipmentCard
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = Equipment;
    Caption = 'Equipment Card page';
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
                field(SerialNumber; Rec.SerialNumber)
                {
                    ToolTip = 'Specifies the value of the Serial Number field.', Comment = '%';
                    ShowMandatory = true;
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.', Comment = '%';
                    MultiLine = true;
                }
                field(Supplier; Rec.Supplier)
                {
                    ToolTip = 'Specifies the value of the Supplier field.', Comment = '%';
                    ShowMandatory = true;
                }
                field(SupplierDescription; Rec.SupplierDescription)
                {
                    ToolTip = 'Specifies the value of the Supplier Description field.', Comment = '%';
                    MultiLine = true;
                }
                field(AquisitionDate; Rec.AquisitionDate)
                {
                    ToolTip = 'Specifies the value of the Aquisition Date field.', Comment = '%';
                    ShowMandatory = true;
                }
                field(Allocation; Rec.Allocation)
                {
                    ToolTip = 'Specifies the value of the Allocation field.', Comment = '%';
                }
                field(ProcessPhase; Rec.ProcessPhase)
                {
                    ToolTip = 'Specifies the value of the Process Phase field.', Comment = '%';
                }
                field(EquipmentPicture; Rec.EquipmentPicture)
                {
                    ToolTip = 'Specifies the value of the Equipment Picture field.', Comment = '%';
                }
                field(Blocked; Rec.Blocked)
                {
                    ToolTip = 'Specifies the value of the Blocked field.', Comment = '%';
                }
            }
        }

        area(Factboxes)
        {
            part(Equipment; EquipmentPicture)
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

    trigger OnNewRecord(BelowRec: Boolean)
    var
        SalesSetup: Record "Sales & Receivables Setup";
        NoSeries: Codeunit "No. Series";
    begin
        if Rec."No." = '' then begin
            SalesSetup.Get();
            SalesSetup.TestField(EquipmentIdNos);
            if NoSeries.AreRelated(SalesSetup.EquipmentIdNos, xRec."No. Series") then begin
                Rec."No. Series" := SalesSetup.EquipmentIdNos;
            Rec."No." := NoSeries.GetNextNo(Rec."No. Series", WorkDate())
            end;
        end;
        
    end;

    trigger OnClosePage()
    var
        Equipment: Record Equipment;
    begin
        Equipment.SetRange("No.", Rec."No.");

        if Equipment.IsEmpty() and Rec.Get(Rec."No.") then begin
            Rec.Delete();
        end;
    end;

    var
        myInt: Integer;
}