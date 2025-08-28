table 54101 BreedType
{
    DataClassification = CustomerContent;
    Caption = 'Breed Type';
    DrillDownPageId = BreedTypeList;
    LookupPageId = BreedTypeList;


    fields
    {
        field(1; "No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'No.';

        }
        field(2; BreedName; Enum "Breed Names")
        {
            DataClassification = CustomerContent;
            Caption = 'Breed Name';
        }
        field(3; BreedPicture; Media)
        {
            DataClassification = CustomerContent;
            Caption = 'Breed Picture';
        }
        field(4; AverageLifeExpetancy; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Average Life Expectancy';
            Editable = false;
        }
        field(5; BreedDescription; Text[500])
        {
            DataClassification = CustomerContent;
            Caption = 'Breed Description';
            Editable = false;
        }
        field(6; MilkProperties; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Milk Properties';
            Editable = false;
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
        BreedTypeHandler: Codeunit "BreedTypeHandler";

    trigger OnInsert()
    begin
        BreedTypeHandler.SetLifeExpectancy(Rec);
        BreedTypeHandler.SetBreedDescription(Rec);
        BreedTypeHandler.SetMilkProperties(Rec);

    end;

    trigger OnModify()
    begin
        BreedTypeHandler.SetLifeExpectancy(Rec);
        BreedTypeHandler.SetBreedDescription(Rec);
        BreedTypeHandler.SetMilkProperties(Rec);

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}