codeunit 54108 "Backup XML" implements "Data Backup"
{
    internal procedure Backup(var MilkProduction: Record "Milk Production Line"): Boolean
    var
        TempBlob: Codeunit "Temp Blob";
        MilkProductionXlmDocument: XmlDocument;
        MilkProductionXmlElement: XmlElement;
        FileName: Text;
        XmlOutStream: OutStream;
        XmlInStream: InStream;
        DialogTitleTok: Label 'Download Milk Data Production as Xml';
        XmlFilterTok: Label 'XML Files (*.xml)|*.xml';
        FileNameTok: Label 'milkDataProduction-%1.xml', Comment = '%1 = Current Date.', Locked = true;
    begin
        MilkProductionXlmDocument := XmlDocument.Create();
        MilkProductionXmlElement := XmlElement.Create('MilkProduction');

        MilkProduction.FindSet();
        repeat
            MilkProductionXmlElement.Add(GetMilkProductionXmlElement(MilkProduction));
        until MilkProduction.Next() = 0;

        MilkProductionXlmDocument.Add(MilkProductionXmlElement);

        TempBlob.CreateOutStream(XmlOutStream, TextEncoding::UTF8);
        MilkProductionXlmDocument.WriteTo(XmlOutStream);
        TempBlob.CreateInStream(XmlInStream, TextEncoding::UTF8);

        FileName := StrSubstNo(FileNameTok, CurrentDateTime());
        exit(File.DownloadFromStream(XmlInStream, DialogTitleTok, '', XmlFilterTok, FileName));

    end;

    local procedure GetMilkProductionXmlElement(MilkProduction: Record "Milk Production Line"): XmlElement
    var
        MilkProductionXmlElement: XmlElement;
        TempBlob: Codeunit "Temp Blob";
        Base64Convert: Codeunit "Base64 Convert";
        OutStream: OutStream;
        InStream: InStream;
        Base64Image: Text;
        EmployeeRec: Record Employee;
        SupervisorName: Text;
        Shift: Text;
        EquipmentRec: Record Equipment;
    begin
        if EmployeeRec.Get(MilkProduction.Supervisor) then
            MilkProduction.SupervisorName := EmployeeRec."First Name"; // Assuming Name is the field for the Supervisor's full name
        MilkProduction.Shift := EmployeeRec.Shift; // Assuming Shift is the field you added

        if EquipmentRec.Get(MilkProduction.MachineID) then begin
            MilkProduction.AllocationCow := EquipmentRec.Allocation;
        end;

        MilkProductionXmlElement := XmlElement.Create('MilkProduction');
        MilkProductionXmlElement.Add(XmlElement.Create('LineNo', '', MilkProduction."Line No."));
        MilkProductionXmlElement.Add(XmlElement.Create('CowNo', '', MilkProduction."Cow No."));
        MilkProductionXmlElement.Add(XmlElement.Create('Supervisor', '', MilkProduction.Supervisor));
        MilkProductionXmlElement.Add(XmlElement.Create('SupervisorName', '', MilkProduction.SupervisorName));
        MilkProductionXmlElement.Add(XmlElement.Create('MachineID', '', MilkProduction.MachineID));
        MilkProductionXmlElement.Add(XmlElement.Create('Allocation', '', MilkProduction.AllocationCow));
        MilkProductionXmlElement.Add(XmlElement.Create('Shift', '', Format(MilkProduction.Shift)));
        MilkProductionXmlElement.Add(XmlElement.Create('Period', '', Format(MilkProduction.Period)));
        MilkProductionXmlElement.Add(XmlElement.Create('ProductionDate', '', MilkProduction."Production Date"));
        MilkProductionXmlElement.Add(XmlElement.Create('PlannedDowntime', '', MilkProduction."PLanned Downtime"));
        MilkProductionXmlElement.Add(XmlElement.Create('ProductionTime', '', MilkProduction.ProductionTime));
        MilkProductionXmlElement.Add(XmlElement.Create('QuantityProduced', '', MilkProduction.Quantity));
        MilkProductionXmlElement.Add(XmlElement.Create('BreakdownDescription', '', MilkProduction."Breakdown Description"));
        MilkProductionXmlElement.Add(XmlElement.Create('Breakdowns', '', MilkProduction.Breakdowns));
        MilkProductionXmlElement.Add(XmlElement.Create('CleaningTime', '', MilkProduction.CleaningTime));
        MilkProductionXmlElement.Add(XmlElement.Create('SetupTime', '', MilkProduction.SetupTime));
        MilkProductionXmlElement.Add(XmlElement.Create('Defects', '', MilkProduction.Defects));
        MilkProductionXmlElement.Add(XmlElement.Create('BreedName', '', Format(MilkProduction.BreedName)));

        exit(MilkProductionXmlElement);


    end;
}