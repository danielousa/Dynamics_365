codeunit 54106 "Backup JSON" implements "Data Backup"
{
    internal procedure Backup(var MilkProduction: Record "Milk Production Line"): Boolean
    var
        TempBlob: Codeunit "Temp Blob";
        MilkProductionJsonArray: JsonArray;
        FileName: Text;
        JsonOutStream: OutStream;
        JsonInStream: InStream;
        DialogTitlek: Label 'Download Milk Data Production as JSON';
        JsonFilterTok: Label 'JSON Files (*.json)|*.json';
        FileNameTok: Label 'milkDataProduction-%1.json', Comment = '%1 = current Date.', Locked = true;
    begin

        MilkProduction.FindSet();
        repeat
            MilkProductionJsonArray.Add(GetMilkProductionJsonObject(MilkProduction));
        until MilkProduction.Next() = 0;

        TempBlob.CreateOutStream(JsonOutStream, TextEncoding::UTF8);
        MilkProductionJsonArray.WriteTo(JsonOutStream);
        TempBlob.CreateInStream(JsonInStream, TextEncoding::UTF8);

        FileName := StrSubstNo(FileNameTok, CurrentDateTime());
        exit(File.DownloadFromStream(JsonInStream, DialogTitlek, '', JsonFilterTok, FileName));

    end;

    local procedure GetMilkProductionJsonObject(MilkProduction: Record "Milk Production Line"): JsonObject
    var
        MilkProdutionJsonObject: JsonObject;
        EmployeeRec: Record Employee;
        EquipmentRec: Record Equipment;
    begin
        if EmployeeRec.Get(MilkProduction.Supervisor) then
            MilkProduction.SupervisorName := EmployeeRec."First Name";
        MilkProduction.Shift := EmployeeRec.Shift;

        if EquipmentRec.Get(MilkProduction.MachineID) then
            MilkProduction.AllocationCow := EquipmentRec.Allocation;

        MilkProdutionJsonObject.Add('line nº', MilkProduction."Line No.");
        MilkProdutionJsonObject.Add('cow nº', MilkProduction."Cow No.");
        MilkProdutionJsonObject.Add('supervisor', MilkProduction.Supervisor);
        MilkProdutionJsonObject.Add('supervisor name', MilkProduction.SupervisorName);
        MilkProdutionJsonObject.Add('machine ID', MilkProduction.MachineID);
        MilkProdutionJsonObject.Add('allocation', Format(MilkProduction.AllocationCow));
        MilkProdutionJsonObject.Add('shift', Format(MilkProduction.Shift));
        MilkProdutionJsonObject.Add('period', Format(MilkProduction.Period));
        MilkProdutionJsonObject.Add('production date', MilkProduction."Production Date");
        MilkProdutionJsonObject.Add('planned downtime', MilkProduction."PLanned Downtime");
        MilkProdutionJsonObject.Add('production time', MilkProduction.ProductionTime);
        MilkProdutionJsonObject.Add('quantity produced', MilkProduction.Quantity);
        MilkProdutionJsonObject.Add('breakdown description', MilkProduction."Breakdown Description");
        MilkProdutionJsonObject.Add('breakdown', MilkProduction.Breakdowns);
        MilkProdutionJsonObject.Add('cleanningtime', MilkProduction.CleaningTime);
        MilkProdutionJsonObject.Add('setup time', MilkProduction.SetupTime);
        MilkProdutionJsonObject.Add('defects', MilkProduction.Defects);
        MilkProdutionJsonObject.Add('breed name', Format(MilkProduction.BreedName));

        exit(MilkProdutionJsonObject);

    end;
}