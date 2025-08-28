codeunit 54112 "OEE Backup XLSX" implements "OEE Backup"
{
    internal procedure BackupOEE(var MilkProduction: Record "Milk Production Line"): Boolean
    var
        TempExcelBufer: Record "Excel Buffer" temporary;
        TempBlob: Codeunit "Temp Blob";
        FileName: Text;
        XlsxOutStream: OutStream;
        XlsxInStream: InStream;
        DialogTitleTok: Label 'Download OEE Data as XLSX';
        XlsxFilterTok: Label 'XLSX Files (*.xlsx)|*.xlsx';
        FileNameTok: Label 'OEEData-%1.xlsx', Comment = '%1 = Current Date.', Locked = true;
    begin
        CreateHeader(MilkProduction, TempExcelBufer);
        MilkProduction.FindSet();
        repeat
            RetrieveEmployeeInfo(MilkProduction);
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
        TempExcelBuffer.AddColumn(MilkProduction.FieldCaption("No."), false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(MilkProduction.FieldCaption(Supervisor), false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(MilkProduction.FieldCaption(SupervisorName), false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(MilkProduction.FieldCaption(Shift), false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(MilkProduction.FieldCaption(Period), false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(MilkProduction.FieldCaption("Production Date"), false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Date);
        TempExcelBuffer.AddColumn(MilkProduction.FieldCaption("Availability Index"), false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(MilkProduction.FieldCaption("Performance rate"), false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(MilkProduction.FieldCaption("Quality rate"), false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(MilkProduction.FieldCaption(OEE), false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);

    end;

    local procedure CreateLine(MilkProduction: Record "Milk Production Line"; var TempExcelBuffer: Record "Excel Buffer")
    var
        OEEcalculator: Codeunit "OEE Calculator";
        AvailabilityIndex: Decimal;
        PerformanceRate: Decimal;
        QualityRate: Decimal;
        OEE: Decimal;
    begin
        AvailabilityIndex := OEEcalculator.AvailabilityIndex(MilkProduction);
        PerformanceRate := OEEcalculator.PerformanceRate(MilkProduction);
        QualityRate := OEEcalculator.QualityRate(MilkProduction);
        OEE := OEEcalculator.OEE(MilkProduction);

        TempExcelBuffer.NewRow();
        TempExcelBuffer.AddColumn(MilkProduction."No.", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(MilkProduction.Supervisor, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(MilkProduction.SupervisorName, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(MilkProduction.Shift, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(MilkProduction.Period, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(MilkProduction."Production Date", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Date);
        TempExcelBuffer.AddColumn(AvailabilityIndex, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(Performancerate, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(Qualityrate, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(OEE, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);

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
}