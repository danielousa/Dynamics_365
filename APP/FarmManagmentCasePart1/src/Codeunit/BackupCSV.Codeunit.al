codeunit 54105 "Backup CSV" implements "Data Backup"
{
    internal procedure Backup(var MilkProduction: Record "Milk Production Line"): Boolean
    var
        TempBlob: Codeunit "Temp Blob";
        CsvTextBuilder: TextBuilder;
        FileName: Text;
        CsvOutStream: OutStream;
        CsvInStream: InStream;
        DialogTitleTok: Label 'Download Milk Data Producion as CSV';
        CsvFilterTok: Label 'CSV Files (*.csv)|*.csv';
        FileNameTok: Label 'milkDataProduction-%1.csv', Comment = '%1 = Current Date', Locked = true;
    begin
        CreateHeader(MilkProduction, CsvTextBuilder);
        MilkProduction.FindSet();
        repeat
            CreateLine(MilkProduction, CsvTextBuilder);
        until MilkProduction.Next() = 0;

        TempBlob.CreateOutStream(CsvOutStream, TextEncoding::UTF8);
        CsvOutStream.WriteText(CsvTextBuilder.ToText());
        TempBlob.CreateInStream(CsvInStream, TextEncoding::UTF8);

        FileName := StrSubstNo(FileNameTok, CurrentDateTime());
        exit(File.DownloadFromStream(CsvInStream, DialogTitleTok, '', CsvFilterTok, FileName));

    end;

    local procedure CreateHeader(MilkPoduction: Record "Milk Production Line"; var CsvTextBuilder: TextBuilder)
    begin

        AppendWithComma(MilkPoduction.FieldCaption("Line No."), CsvTextBuilder);
        AppendWithComma(MilkPoduction.FieldCaption("Cow No."), CsvTextBuilder);
        AppendWithComma(MilkPoduction.FieldCaption(Supervisor), CsvTextBuilder);
        //AppendWithComma(MilkPoduction.FieldCaption(SupervisorName), CsvTextBuilder);
        AppendWithComma('Supervisor Name', CsvTextBuilder);
        AppendWithComma(MilkPoduction.FieldCaption(MachineID), CsvTextBuilder);
        AppendWithComma('Allocation', CsvTextBuilder);
        //AppendWithComma(MilkPoduction.FieldCaption(Shift), CsvTextBuilder);
        AppendWithComma('Shift', CsvTextBuilder);
        AppendWithComma(MilkPoduction.FieldCaption(Period), CsvTextBuilder);
        AppendWithComma(MilkPoduction.FieldCaption("Production Date"), CsvTextBuilder);
        AppendWithComma(MilkPoduction.FieldCaption("PLanned Downtime"), CsvTextBuilder);
        AppendWithComma(MilkPoduction.FieldCaption(ProductionTime), CsvTextBuilder);
        AppendWithComma(MilkPoduction.FieldCaption(Quantity), CsvTextBuilder);
        AppendWithComma(MilkPoduction.FieldCaption("Breakdown Description"), CsvTextBuilder);
        AppendWithComma(MilkPoduction.FieldCaption(Breakdowns), CsvTextBuilder);
        AppendWithComma(MilkPoduction.FieldCaption(CleaningTime), CsvTextBuilder);
        AppendWithComma(MilkPoduction.FieldCaption(SetupTime), CsvTextBuilder);
        AppendWithComma(MilkPoduction.FieldCaption(Defects), CsvTextBuilder);
        CsvTextBuilder.AppendLine(MilkPoduction.FieldCaption(BreedName));


    end;

    local procedure CreateLine(MilkProduction: Record "Milk Production Line"; var CsvTextBuilder: TextBuilder)
    var
        MilkPoduction: Record "Milk Production Line";
        EmployeeRec: Record Employee;
        EquipmentRec: Record Equipment;
    begin

        AppendWithComma(Format(MilkProduction."Line No."), CsvTextBuilder);
        AppendWithComma(MilkProduction."Cow No.", CsvTextBuilder);
        AppendWithComma(MilkProduction.Supervisor, CsvTextBuilder);
        //AppendWithComma(Format(MilkProduction.SupervisorName), CsvTextBuilder);
        if EmployeeRec.Get(MilkProduction.Supervisor) then
            AppendWithComma(Format(EmployeeRec."First Name"), CsvTextBuilder)
        else
            AppendWithComma('', CsvTextBuilder);

        AppendWithComma(MilkProduction.MachineID, CsvTextBuilder);

        if EquipmentRec.Get(MilkProduction.MachineID) then 
            AppendWithComma(Format(EquipmentRec.Allocation), CsvTextBuilder)
        else
            AppendWithComma('', CsvTextBuilder);

        //AppendWithComma(Format(MilkProduction.Shift), CsvTextBuilder);
        if EmployeeRec.Get(MilkProduction.Supervisor) then
            AppendWithComma(Format(EmployeeRec.Shift), CsvTextBuilder)
        else
            AppendWithComma('', CsvTextBuilder);

        AppendWithComma(Format(MilkProduction.Period), CsvTextBuilder);
        AppendWithComma(Format(MilkProduction."Production Date"), CsvTextBuilder);
        AppendWithComma(Format(MilkProduction."PLanned Downtime"), CsvTextBuilder);
        AppendWithComma(Format(MilkProduction.ProductionTime), CsvTextBuilder);
        AppendWithComma(Format(MilkProduction.Quantity), CsvTextBuilder);
        AppendWithComma(MilkProduction."Breakdown Description", CsvTextBuilder);
        AppendWithComma(Format(MilkProduction.Breakdowns), CsvTextBuilder);
        AppendWithComma(Format(MilkProduction.CleaningTime), CsvTextBuilder);
        AppendWithComma(Format(MilkProduction.SetupTime), CsvTextBuilder);
        AppendWithComma(Format(MilkProduction.Defects), CsvTextBuilder);
        CsvTextBuilder.AppendLine(Format(MilkProduction.BreedName));


    end;

    local procedure AppendWithComma(TextValue: Text; var CsvTextBuilder: TextBuilder)
    begin
        CsvTextBuilder.Append(TextValue);
        CsvTextBuilder.Append(';');
    end;
}