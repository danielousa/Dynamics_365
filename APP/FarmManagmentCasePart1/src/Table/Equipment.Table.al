table 54105 Equipment
{
    DataClassification = CustomerContent;
    Caption = 'Equipment';
    DrillDownPageId = EquipmentCard;
    LookupPageId = EquipmentCard;

    fields
    {
        field(1; "No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'No.';
            Editable = false;

            trigger OnValidate()
            var
                Equipment: Record Equipment;
            begin
                if "No." < xRec."No." then begin
                    if not Equipment.Get("No.") then begin
                        SalesSetup.Get();
                        NoSeries.TestManual(SalesSetup.EquipmentIdNos);
                        "No. Series" := '';

                    end;
                end;
            end;
        }
        field(2; SerialNumber; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Serial Number';
            NotBlank = true;

            trigger OnValidate()
            begin
                if SerialNumber = '' then
                    Error('Serial Number must not be blank.');
                
            end;
        }
        field(3; Description; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Description';
        }
        field(4; Supplier; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Supplier Name';
            NotBlank = true;

            trigger OnValidate()
            begin
                if Supplier = '' then begin
                    Error('Supplier name must not be blank');
                end;
            end;
        }
        field(5; SupplierDescription; Text[500])
        {
            DataClassification = CustomerContent;
            Caption = 'Supplier Description';
        }
        field(6; Allocation; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Allocation';
        }
        field(7; ProcessPhase; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Process Phase';
        }
        field(8; EquipmentPicture; Media)
        {
            DataClassification = CustomerContent;
            Caption = 'Equipment Picture';
        }
        field(9; AquisitionDate; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Aquisition Date';
            NotBlank = true;

            trigger OnValidate()
            begin
                if AquisitionDate = 0D then
                    Error('Aquisition date must not be blank');
            end;
        }
        field(10; Blocked; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Blocked';
        }
        field(11; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
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

    trigger OnInsert()
    begin
        if "No." = '' then begin
            SalesSetup.Get();
            SalesSetup.TestField(EquipmentIdNos);
            "No. Series" := SalesSetup.EquipmentIdNos;
            if NoSeries.AreRelated(SalesSetup.EquipmentIdNos, xRec."No. Series") then
                "No. Series" := xRec."No. Series";
            "No." := NoSeries.GetNextNo("No. Series");

        end;

        Rec.TestField(SerialNumber);
        Rec.TestField(Supplier);
        Rec.TestField(AquisitionDate);

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}