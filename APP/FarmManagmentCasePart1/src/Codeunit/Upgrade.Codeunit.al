codeunit 54104 Upgrade
{
    Subtype = Upgrade;
    trigger OnCheckPreconditionsPerCompany()
    var
        Module: ModuleInfo;
    begin
        NavApp.GetCurrentModuleInfo(Module);
        if Module.DataVersion().Major() = 1 then begin
            UpdateBreedTypes();
        end;
    end;

    local procedure UpdateBreedTypes()
    begin
        UpdateBreedType('001', 'BREED0001', 'Holstein-Friesian');
        UpdateBreedType('002', 'BREED0002', 'Jersey');
        UpdateBreedType('003', 'BREED0003', 'Guernsey');
        UpdateBreedType('004', 'BREED0004', 'Brown Swiss');
        UpdateBreedType('005', 'BREED0005', 'Ayrshire');
    end;

    local procedure UpdateBreedType(OldBreedTypeNo: Code[20]; NewBreedTypeNo: Code[20]; NewBreedDescription: Text[100])
    var
        BreedType: Record BreedType;
    begin
        if BreedType.Get(OldBreedTypeNo) then begin
            BreedType.Rename(NewBreedTypeNo);
            BreedType.BreedDescription := NewBreedDescription;
            BreedType.Modify();

        end;
    end;
}