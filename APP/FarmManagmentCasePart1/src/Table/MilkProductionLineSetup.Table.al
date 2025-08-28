table 54104 "Milk Production Setup"
{
    DataClassification = SystemMetadata;

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
            DataClassification = SystemMetadata;

        }
        field(2; "Backup Type"; Enum "Backup Type")
        {
            Caption = 'Backup Type';
            DataClassification = SystemMetadata;
        }
        field(3; "OEE Data"; Enum "OEE Backup Type")
        {
            Caption = 'OEE Backup Type';
            DataClassification = SystemMetadata;
        }
    }

    keys
    {
        key(Key1; "Primary Key")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        // Add changes to field groups here
    }

    var
        myInt: Integer;

    trigger OnInsert()
    begin

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