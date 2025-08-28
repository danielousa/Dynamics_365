page 54105 "Milk Production Line List "
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Milk Production Line";
    Editable = false;
    Caption = 'Milk Production Line List';

    layout
    {
        area(Content)
        {
            repeater(General)
            {

                field("Line No."; Rec."Line No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Line No. field.', Comment = '%';
                }
                field("Cow No."; Rec."Cow No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Cow No. field.', Comment = '%';
                }
                field(SupervisorNo; Rec.Supervisor)
                {
                    ApplicationArea = All;
                    ToolTip = 'Write the name of the Supervisor.', Comment = '%';
                    Caption = 'Supervisor Code.';
                }
                field(SupervisorName; Rec.SupervisorName)
                {
                    ApplicationArea = All;
                    ToolTip = 'Write the name of the Supervisor.', Comment = '%';
                    Caption = 'Supervisor Name';
                }
                field(MachineID; Rec.MachineID)
                {
                    ApplicationArea = All;
                    ToolTip = 'Write the Machine ID.', Comment = '%';
                }
                field(AllocationCow; Rec.AllocationCow)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Allocation field.', Comment = '%';
                    Caption = 'Allocation';
                }
                field(Shift; Rec.Shift)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Shift field.', Comment = '%';
                }
                field(Period; Rec.Period)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Period of the day.', Comment = '%';
                }
                field("Production Date"; Rec."Production Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Production Date field.', Comment = '%';
                }
                field("PLanned Downtime"; Rec."PLanned Downtime")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Planned Downtime (min) field.', Comment = '%';
                }
                field(ProductionTime; Rec.ProductionTime)
                {
                    ApplicationArea = All;
                    ToolTip = 'Insert the net Production Time (min). Cannot be longer than 480 min', Comment = '%';
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                    ToolTip = 'Insert the total Quantity Produced during the shift time. Must be in liters.', Comment = '%';
                }
                field("Breakdown Description"; Rec."Breakdown Description")
                {
                    ApplicationArea = All;
                    MultiLine = true;
                    ToolTip = 'Describe the various breakdowns that occur during the shift.', Comment = '%';
                }
                field(Breakdowns; Rec.Breakdowns)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the total value of breakdowns in min that occur during the shift.', Comment = '%';
                }
                field(CleaningTime; Rec.CleaningTime)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the the total value the Cleaning Time (min) spended in the shift.', Comment = '%';
                }
                field(SetupTime; Rec.SetupTime)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the total time spended during the Setup (min).', Comment = '%';
                }
                field(Defects; Rec.Defects)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the tolal value of Milk scraped during the shift in liters.', Comment = '%';
                }
                field(BreedName; Rec.BreedName)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Breed Name field.', Comment = '%';
                    DrillDown = true;

                    trigger OnDrillDown()
                    var
                        BreedType: Record BreedType;
                        LabelText: Label 'The related cattle type record eas not found.';
                    begin
                        if BreedType.Get(Rec."BreedType No.") then begin
                            Page.Run(Page::BreedTypeCard, BreedType);
                        end else
                            Error(LabelText);
                    end;
                }
            }
        }
        area(Factboxes)
        {
            part(CowFactbox; "Cow Factbox")
            {
                ApplicationArea = All;
                SubPageLink = "No." = field("Cow No.");

            }
            part(BreedFactbox; "Breed Factbox")
            {
                ApplicationArea = All;
                SubPageLink = BreedName = field(BreedName);

            }
            part(EquipmentFactbox; "Equipment Factbox")
            {
                ApplicationArea = All;
                SubPageLink = "No." = field(MachineID);
                
            }

        }
    }

    actions
    {
        area(Processing)
        {
            action("Backup Milk Data Production")
            {
                ApplicationArea = All;
                Caption = 'Milk Data Production';
                Image = ExportDatabase;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                ToolTip = 'Create a backup of Milk Data Production in your database.';

                trigger OnAction()
                begin
                    RunBackup();

                end;
            }
        }
    }

    local procedure RunBackup()
    var
        MilkProduction: Record "Milk Production Line";
        MilkProductionSetup: Record "Milk Production Setup";
        MilkProductionBackup: Interface "Data Backup";
    begin
        if not MilkProductionSetup.Get() then begin
            exit;

        end;

        if MilkProduction.IsEmpty() then begin
            exit
        end;

        MilkProductionBackup := MilkProductionSetup."Backup Type";
        MilkProductionBackup.Backup(MilkProduction);
    end;
}