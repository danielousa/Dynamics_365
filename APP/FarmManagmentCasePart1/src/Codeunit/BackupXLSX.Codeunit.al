codeunit 54107 "Backup XLSX" implements "Data Backup"
{
    internal procedure Backup(var MilkProduction: Record "Milk Production Line"): Boolean
    var
        TempExcelBufer: Record "Excel Buffer" temporary;
        TempBlob: Codeunit "Temp Blob";
        FileName: Text;
        XlsxOutStream: OutStream;
        XlsxInStream: InStream;
        DialogTitleTok: Label 'Download Milk Data Production as XLSX';
        XlsxFilterTok: Label 'XLSX Files (*.xlsx)|*.xlsx';
        FileNameTok: Label 'milkDataProduction-%1.xlsx', Comment = '%1 = Current Date.', Locked = true;
    begin
        CreateHeader(MilkProduction, TempExcelBufer);
        MilkProduction.FindSet();
        repeat
            RetrieveEmployeeInfo(MilkProduction);
            RetrieveEquipmentInfo(MilkProduction);
            CreateLine(MilkProduction, TempExcelBufer);
        until MilkProduction.Next() = 0;

        TempExcelBufer.CreateNewBook(CopyStr(MilkProduction.TableCaption(), 1, 250));
        TempExcelBufer.WriteSheet(MilkProduction.TableCaption(), CompanyName(), UserId());
        TempExcelBufer.CloseBook();

        TempBlob.CreateOutStream(XlsxOutStream, TextEncoding::UTF8);
        TempExcelBufer.SaveToStream(XlsxOutStream, true);
        TempBlob.CreateInStream(XlsxInStream, TextEncoding::UTF8);

        FileName := StrSubstNo(FileNameTok, CurrentDateTime());
        exit(File.DownloadFromStream(XlsxInStream, DialogTitleTok, '', XlsxFilterTok, FileName));

    end;

    local procedure CreateHeader(MilkProduction: Record "Milk Production Line"; var TempExcelBuffer: Record "Excel Buffer")
    begin
        TempExcelBuffer.Reset();
        TempExcelBuffer.NewRow();
        TempExcelBuffer.AddColumn(MilkProduction.FieldCaption("Line No."), false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(MilkProduction.FieldCaption("Cow No."), false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(MilkProduction.FieldCaption(Supervisor), false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(MilkProduction.FieldCaption(SupervisorName), false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(MilkProduction.FieldCaption(MachineID), false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(MilkProduction.FieldCaption(AllocationCow), false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(MilkProduction.FieldCaption(Shift), false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(MilkProduction.FieldCaption(Period), false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(MilkProduction.FieldCaption("Production Date"), false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(MilkProduction.FieldCaption("PLanned Downtime"), false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(MilkProduction.FieldCaption(ProductionTime), false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(MilkProduction.FieldCaption(Quantity), false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(MilkProduction.FieldCaption("Breakdown Description"), false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(MilkProduction.FieldCaption(Breakdowns), false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(MilkProduction.FieldCaption(CleaningTime), false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(MilkProduction.FieldCaption(SetupTime), false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(MilkProduction.FieldCaption(Defects), false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(MilkProduction.FieldCaption(BreedName), false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);

    end;

    local procedure CreateLine(MilkProduction: Record "Milk Production Line"; var TempExcelBuffer: Record "Excel Buffer")
    begin
        TempExcelBuffer.NewRow();
        TempExcelBuffer.AddColumn(MilkProduction."Line No.", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(MilkProduction."Cow No.", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(MilkProduction.Supervisor, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(MilkProduction.SupervisorName, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(MilkProduction.MachineID, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(Format(MilkProduction.AllocationCow), false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(Format(MilkProduction.Shift), false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(Format(MilkProduction.Period), false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(Format(MilkProduction."Production Date"), false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(MilkProduction."Planned Downtime", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(MilkProduction.ProductionTime, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(MilkProduction.Quantity, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(MilkProduction."Breakdown Description", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(MilkProduction.Breakdowns, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(MilkProduction.CleaningTime, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(MilkProduction.SetupTime, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(MilkProduction.Defects, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(MilkProduction.BreedName, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);

    end;

    local procedure RetrieveEmployeeInfo(var MilkProduction: Record "Milk Production Line")
    var
        EmployeeRec: Record Employee;
    begin
        // Retrieve SupervisorName and Shift from the Employee table
        if EmployeeRec.Get(MilkProduction.Supervisor) then
            MilkProduction.SupervisorName := EmployeeRec."First Name";
        MilkProduction.Shift := EmployeeRec.Shift;
    end;

    local procedure RetrieveEquipmentInfo(VAR MilkProduction: Record "Milk Production Line")
    var
        EquipmentRec: Record Equipment;
    begin
        if EquipmentRec.Get(MilkProduction.MachineID) then
            MilkProduction.AllocationCow := EquipmentRec.Allocation;
    end;
}