page 54108 "Milk Production Subpage"
{
    PageType = ListPart;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Milk Production Line";
    AutoSplitKey = true;
    DelayedInsert = true;
    Editable = true;

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
                    Editable = false;
                }
                field("Cow No."; Rec."Cow No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Cow No. field.', Comment = '%';
                }
                field(Supervisor; Rec.Supervisor)
                {
                    ApplicationArea = All;
                    ToolTip = 'Write the nome of the Supervisor.', Comment = '%';
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
                    Editable = false;
                }
                field("PLanned Downtime"; Rec."PLanned Downtime")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Planned Downtime (min) field.', Comment = '%';

                    trigger OnValidate()
                    var
                        MilkProductionHelper: Codeunit "Milk Production Helper";
                    begin
                        MilkProductionHelper.ValidateShiftTime(Rec);
                    end;
                }
                field(ProductionTime; Rec.ProductionTime)
                {
                    ApplicationArea = All;
                    ToolTip = 'Insert the net Production Time (min). Cannot be longer than 480 min', Comment = '%';

                    trigger OnValidate()
                    var
                        MilkProductionHelper: Codeunit "Milk Production Helper";
                    begin
                        MilkProductionHelper.ValidateShiftTime(Rec);
                    end;
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                    ToolTip = 'Insert the total Quantity Produced during the shift time. Must be in liters.', Comment = '%';
                }
                field("Breakdown Description"; Rec."Breakdown Description")
                {
                    ApplicationArea = All;
                    ToolTip = 'Describe the various breakdowns that occur during the shift.', Comment = '%';
                    MultiLine = true;

                }
                field(Breakdowns; Rec.Breakdowns)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the total value of breakdowns in min that occur during the shift.', Comment = '%';

                    trigger OnValidate()
                    var
                        MilkProductionHelper: Codeunit "Milk Production Helper";
                    begin
                        MilkProductionHelper.ValidateShiftTime(Rec);
                    end;
                }
                field(CleaningTime; Rec.CleaningTime)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the the total value the Cleaning Time (min) spended in the shift.', Comment = '%';

                    trigger OnValidate()
                    var
                        MilkProductionHelper: Codeunit "Milk Production Helper";
                    begin
                        MilkProductionHelper.ValidateShiftTime(Rec);
                    end;
                }
                field(SetupTime; Rec.SetupTime)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the total time spended during the Setup (min).', Comment = '%';

                    trigger OnValidate()
                    var
                        MilkProductionHelper: Codeunit "Milk Production Helper";
                    begin
                        MilkProductionHelper.ValidateShiftTime(Rec);
                    end;
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
                    Editable = false;
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