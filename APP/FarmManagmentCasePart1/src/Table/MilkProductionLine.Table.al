table 54103 "Milk Production Line"
{
    DataClassification = CustomerContent;
    Caption = 'Milk Production Line';
    DrillDownPageId = "Milk Production Line List ";


    fields
    {
        field(1; "No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'No.';
        }
        field(2; "Line No."; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Line No.';
        }
        field(3; "Cow No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cow No.';
            TableRelation = Cow;

            trigger OnValidate()
            var
                Cow: Record Cow;
                BreedType: Record BreedType;
            begin
                if Rec."Cow No." <> '' then begin
                    if Cow.Get("Cow No.") then begin

                        // Check if the cow is blocked
                        if Cow.Blocked then
                            Error('The cow %1 is blocked and cannot be used for milk production.', "Cow No.");

                        // Get the BreedType No. from the Cow table
                        Rec."BreedType No." := Cow."BreedType Code";

                        // Retrieve the Breed Name from the BreedType table
                        if BreedType.Get(Rec."BreedType No.") then
                            Rec.BreedName := BreedType.BreedName;
                    end else
                        Error('The cow %1 does not exist.', "Cow No.");
                end;

            end;
        }
        field(4; Period; Enum Period)
        {
            DataClassification = CustomerContent;
            Caption = 'Period';
        }
        field(5; Shift; Enum Shift)
        {
            //DataClassification = CustomerContent;
            Caption = 'Shift';
            FieldClass = FlowField;
            Editable = false;

            CalcFormula = lookup(Employee.Shift where("No." = field(Supervisor)));
        }
        field(6; Supervisor; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Supervisor No.';
            TableRelation = Employee."No." where("Job Title" = CONST('Supervisor'));

            trigger OnValidate()

            begin
                CalcFields(SupervisorName);
            end;
        }

        field(7; MachineID; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Machine ID';
            TableRelation = Equipment."No." where(ProcessPhase = const('Milking Parlor Pens'));

            trigger OnValidate()
            var
                Equipment: Record Equipment;
            begin
                CalcFields(AllocationCow);

                if Rec.MachineID <> '' then begin
                    if Equipment.Get(MachineID) then begin

                        //Check if the equipment is blocked
                        if Equipment.Blocked then
                            Error('The equipment %1 is blocked and cannot be used for milk production.', MachineID);

                    end else
                        Error('The equipment %1 does not exist.', MachineID);
                end;
            end;


        }
        field(8; "Production Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Production Date';
        }
        field(9; Quantity; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Quantity Produced (liters)';
        }
        field(10; ProductionTime; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Production Time (min)';
        }
        field(11; CleaningTime; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Cleaning Time (min)';
        }
        field(12; SetupTime; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Setup Time (min)';
        }
        field(13; "Breakdown Description"; Text[500])
        {
            DataClassification = CustomerContent;
            Caption = 'Breakdown Description';
        }
        field(14; "Breakdowns"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Breakdown (min)';
        }
        field(15; "PLanned Downtime"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Planned Downtime (min)';
        }
        field(16; Defects; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Milk scrap (liters)';
        }
        field(17; BreedName; Enum "Breed Names")
        {
            DataClassification = CustomerContent;
            Caption = 'Breed Name';
        }
        field(18; "BreedType No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Breed Type No.';
            TableRelation = BreedType."No.";
        }
        field(19; "Theoretical CT"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Theoretical CT';

        }
        field(20; "Availability Index"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Availability Index %';
        }
        field(21; "Performance rate"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Performance rate %';
        }
        field(22; "Quality rate"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Quality rate %';
        }
        field(23; OEE; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'OEE %';
        }
        // field(24; "Total Quantity Produced"; Decimal)
        // {
        //     //DataClassification = CustomerContent;
        //     FieldClass = FlowField;
        //     Caption = 'Total Quantity Produced';
        //     CalcFormula = sum("Milk Production Line".Quantity where("Production Date" = field("Production Date")));
        //     Editable = false;
        // }
        // field(25; "Total Milk Scrap"; Decimal)
        // {
        //     //DataClassification = CustomerContent;
        //     FieldClass = FlowField;
        //     Caption = 'Total Milk Scrap';
        //     CalcFormula = sum("Milk Production Line".Defects where("Production Date" = field("Production Date")));
        //     Editable = false;
        // }
        field(26; Rank; Enum "OEE Rank")
        {
            Caption = 'OEE Rank';
            DataClassification = CustomerContent;
        }
        field(27; SupervisorName; Text[100])
        {
            Caption = 'Supervisor';
            FieldClass = FlowField;
            Editable = false;

            CalcFormula = Lookup(Employee."First Name" WHERE("No." = FIELD(Supervisor)));
        }
        field(28; AllocationCow; Text[100])
        {
            Caption = 'Allocation';
            FieldClass = FlowField;
            Editable = false;

            CalcFormula = lookup(Equipment.Allocation where("No." = field(MachineID)));
        }
    }

    keys
    {
        key(PK; "No.", "Line No.")
        {
            Clustered = true;

        }
        // To use on futures improvements of the metric OEE

        // key(Secundary; Supervisor, Period , "Production Date", "No.", "Line No.")
        // {

        // }
    }

    fieldgroups
    {
        // Add changes to field groups here
    }

    var
        myInt: Integer;

    trigger OnInsert()
    var
        MilkProductionHeader: Record "Milk Production Header";
        MilkProductionHelper: Codeunit "Milk Production Helper";
    begin
        if MilkProductionHeader.Get("No.") then begin
            if ("Production Date" = 0D) then begin
                "Production Date" := MilkProductionHeader."Document Date";
            end;
        end;

        MilkProductionHelper.ValidateShiftTime(Rec);

    end;

    trigger OnModify()
    var
        MilkProductionHelper: Codeunit "Milk Production Helper";
    begin
        MilkProductionHelper.ValidateShiftTime(Rec);
    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;





}