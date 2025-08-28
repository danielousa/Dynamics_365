codeunit 54114 "Export Json Helper Equipment"
{
    Access = Internal;
    SingleInstance = true;

    internal procedure ExportEquipmentAdJson()
    var
        Equipment: Record Equipment;
        DataCompression: Codeunit "Data Compression";
        EquipmentJsonObject: JsonObject;
    begin
        Equipment.Reset();
        if not Equipment.FindSet() then begin
            exit;
        end;

        DataCompression.CreateZipArchive();

        repeat
            EquipmentJsonObject := CreateJsonObjectFromEquipment(Equipment);
            AddJsonObjectToZipArchive(EquipmentJsonObject, Equipment."No.", DataCompression);
        until Equipment.Next() = 0;

        CloseAndDownloadZipArchive(DataCompression);

    end;

    local procedure CreateJsonObjectFromEquipment(Equipment: Record Equipment): JsonObject
    var
        EquipmentJsonObject: JsonObject;
    begin
        EquipmentJsonObject.Add('no', Equipment."No.");
        EquipmentJsonObject.Add('serial number', Equipment.SerialNumber);
        EquipmentJsonObject.Add('description', Equipment.Description);
        EquipmentJsonObject.Add('supplier', Equipment.Supplier);
        EquipmentJsonObject.Add('supplier description', Equipment.SupplierDescription);
        EquipmentJsonObject.Add('aquisition date', Equipment.AquisitionDate);
        EquipmentJsonObject.Add('allocation', Equipment.Allocation);
        EquipmentJsonObject.Add('process phase', Equipment.ProcessPhase);
        EquipmentJsonObject.Add('blocked', Equipment.Blocked);

        //AddCowImageToJsonObject(Equipment, EquipmentJsonObject);
        exit(EquipmentJsonObject);

    end;

    // local procedure AddCowImageToJsonObject(Equipment: Record Equipment; var EquipmentJsonObject: JsonObject)
    // var
    //     Base64Convert: Codeunit "Base64 Convert";
    //     TempBlob: Codeunit "Temp Blob";
    //     ImageOutStream: OutStream;
    //     ImageInStream: InStream;
    // begin
    //     if not Equipment.Image.HasValue() then begin
    //         exit;
    //     end;

    //     TempBlob.CreateOutStream(ImageOutStream);
    //     Equipment.Image.ExportStream(ImageOutStream);
    //     TempBlob.CreateInStream(ImageInStream);

    //     EquipmentJsonObject.Add('image', Base64Convert.ToBase64(ImageInStream));

    // end;

    local procedure AddJsonObjectToZipArchive(EquipmentJsonObject: JsonObject; EquipmentNo: Code[20]; var DataCompression: Codeunit "Data Compression")
    var
        TempBlob: Codeunit "Temp Blob";
        JsonOutStream: OutStream;
        JsonInStream: InStream;
        FileNameTok: Label 'Equipment Detail %1.json', Locked = true, Comment = '%1 = Equipment No.';
    begin
        TempBlob.CreateOutStream(JsonOutStream);
        EquipmentJsonObject.WriteTo(JsonOutStream);
        TempBlob.CreateInStream(JsonInStream);

        DataCompression.AddEntry(JsonInStream, StrSubstNo(FileNameTok, EquipmentNo));

    end;

    local procedure CloseAndDownloadZipArchive(var DataCompression: Codeunit "Data Compression")
    var
        TempBlob: Codeunit "Temp Blob";
        ZipInStream: InStream;
        FileName: Text;
        ZipFilterTok: Label 'Zip File|*.zip', Locked = true;
    begin
        DataCompression.SaveZipArchive(TempBlob);
        DataCompression.CloseZipArchive();

        FileName := 'Equipments.zip';

        TempBlob.CreateInStream(ZipInStream);
        DownloadFromStream(ZipInStream, 'Download Equipment Details', '', ZipFilterTok, FileName);
    end;
}