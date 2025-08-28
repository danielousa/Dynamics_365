codeunit 54103 Install
{
    Subtype = Install;

    trigger OnInstallAppPerCompany()
    var
        BreedType: Record BreedType;
    begin
        if BreedType.IsEmpty() then begin
            InsertDefaultBreedTypes();

        end;
    end;

    local procedure InsertBreedType(BreedTypeNo: Code[20]; BreedName: Enum "Breed Names")
    var
        BreedType: Record BreedType;
    begin
        Clear(BreedType);
        BreedType."No." := BreedTypeNo;
        BreedType.BreedName := BreedName;
        BreedType.Insert();
    end;

    local procedure InsertDefaultBreedTypes()
    var
        // Holstein: Enum "Breed Names";
        // Jersey: Enum "Breed Names";
        // Guernsey: Enum "Breed Names";
        // BrownSwiss: Enum "Breed Names";
        // Ayrshire: Enum "Breed Names";
    begin
        InsertBreedType('001', 0);
        InsertBreedType('002', 1);
        InsertBreedType('003', 2);
        InsertBreedType('004', 3);
        InsertBreedType('005', 4);
        
        // Holstein := Enum::HolsteinFriesian;
        // Jersey := Enum::Jersey;
        // Guernsey := Enum::Guernsey;
        // BrownSwiss := Enum::BrownSwiss;
        // Ayrshire := Enum::Ayrshire;

        // InsertBreedType('001', Holstein);
        // InsertBreedType('002', Jersey);
        // InsertBreedType('003', Guernsey);
        // InsertBreedType('004', BrownSwiss);
        // InsertBreedType('005', Ayrshire);

    end;
}