table 54100 Cow
{
    DataClassification = CustomerContent;
    Caption = 'Cow';
    DrillDownPageId = CowCard;
    LookupPageId = CowCard;

    fields
    {
        field(1; "No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'No.';
            Editable = false;

            trigger OnValidate()
            var
                Cow: Record Cow;
            begin
                if "No." < xRec."No." then begin
                    if not Cow.Get("No.") then begin
                        SalesSetup.Get();
                        NoSeries.TestManual(SalesSetup.CowIdNos);
                        "No. Series" := '';
                    end;

                end;

            end;

        }
        field(2; Description; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Description';
            Editable = false;
        }
        field(3; BirthDate; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Cow Birth Date';
            NotBlank = true;

            trigger OnValidate()
            var
                CowHandler: Codeunit CowHandler;
            begin

                if (BirthDate = 0D) or (BirthDate > Today()) then begin
                    Error('Birth Date must not be blank or above today.');
                end else begin
                    CowAge := CowHandler.CalculateAge(BirthDate);
                    CowHandler.AgeCriteria(Rec);

                end;
            end;

        }
        field(8; "BreedType Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Breed Type Code';
            TableRelation = BreedType."No.";

            trigger OnValidate()
            begin
                CalcFields(BreedName);

            end;

        }
        field(4; BreedName; Enum "Breed Names")
        {
            Caption = 'Breed Name';
            FieldClass = FlowField;
            Editable = false;
            CalcFormula = lookup(BreedType.BreedName
                                                where("No." = field("BreedType Code")));

        }
        field(5; EntryDate; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Entry Date';
            NotBlank = true;

            trigger OnValidate()
            begin
                if EntryDate = 0D then
                    Error('Entry Date must not be blank.');
            end;
        }
        field(6; ExitDate; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Exit Date';

            trigger OnValidate()
            begin
                if ExitDate < EntryDate then begin
                    Error('The Exit Date cannot be earlier than the Entry Date.');

                end;

            end;
        }
        field(7; Blocked; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Blocked';

            trigger OnValidate()
            begin
                if not Blocked then begin
                    CowStatus := CowStatus::Active;
                end;

            end;
        }
        field(9; CowAge; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Cow Age (Years)';
            Editable = false;
        }
        field(10; TotalMilkProduction; Decimal)
        {
            //DataClassification = CustomerContent;
            FieldClass = FlowField;
            Caption = 'Total Milk Production (liters)';
            Editable = false;
            CalcFormula = sum("Milk Production Line".Quantity where("Cow No." = field("No."), "Production Date" = field(MilkDateFilter)));

        }
        field(11; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
        }
        field(12; MilkDateFilter; Date)
        {
            Caption = 'Date Filter';
            FieldClass = FlowFilter;
        }
        field(13; CowStatus; Enum "Cow Status")
        {
            DataClassification = CustomerContent;
            Caption = 'Cow Status';
        }


    }

    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        // Add changes to field groups here
    }

    var
        SalesSetup: Record "Sales & Receivables Setup";
        NoSeries: Codeunit "No. Series";
        CowRec: Codeunit CowHandler;

    trigger OnInsert()
    begin
        if "No." = '' then begin
            SalesSetup.Get();
            SalesSetup.TestField(CowIdNos);
            "No. Series" := SalesSetup.CowIdNos;
            if NoSeries.AreRelated(SalesSetup.CowIdNos, xRec."No. Series") then
                "No. Series" := xRec."No. Series";
            "No." := NoSeries.GetNextNo("No. Series");

        end;

        if not Blocked then begin
            CowStatus := CowStatus::Active;
        end;

        Rec.TestField(BirthDate);
        Rec.TestField(EntryDate);

        CowAge := CowRec.CalculateAge(BirthDate);
        CowRec.AgeCriteria(Rec);
    end;

    trigger OnModify()
    begin
        if not Blocked then begin
            CowStatus := CowStatus::Active;
        end;
        
        CowAge := CowRec.CalculateAge(BirthDate);
        CowRec.AgeCriteria(Rec);

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}