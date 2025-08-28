codeunit 54111 "Export Json Helper"
{
    Access = Internal;
    SingleInstance = true;

    internal procedure ExportCowASJson()
    var
        Cow: Record Cow;
        DataCompression: Codeunit "Data Compression";
        CowJsonObject: JsonObject;
    begin
        Cow.Reset();
        if not Cow.FindSet() then begin
            exit;
        end;

        DataCompression.CreateZipArchive();

        repeat
            CowJsonObject := CreateJsonObjectFromCow(Cow);
            AddJsonObjectToZipArchive(CowJsonObject, Cow."No.", DataCompression);
        until Cow.Next() = 0;

        CloseAndDownloadZipArchive(DataCompression);
    end;


    local procedure CreateJsonObjectFromCow(Cow: Record Cow): JsonObject
    var
        CowJsonObject: JsonObject;
    begin
        CowJsonObject.Add('no', Cow."No.");
        CowJsonObject.Add('cow birth date', Cow.BirthDate);
        CowJsonObject.Add('cow age (years)', cow.CowAge);
        CowJsonObject.Add('description', Cow.Description);
        CowJsonObject.Add('entry date', Cow.EntryDate);
        CowJsonObject.Add('exit date', Cow.ExitDate);
        CowJsonObject.Add('breed type code', Cow."BreedType Code");
        CowJsonObject.Add('breed name', Format(Cow.BreedName));
        CowJsonObject.Add('total milk production (liters)', Cow.TotalMilkProduction);
        CowJsonObject.Add('blocked', Cow.Blocked);
        CowJsonObject.Add('cow status', Format(Cow.CowStatus));

        // AddCowImageToJsonObject(Cow, CowJsonObject);
        exit(CowJsonObject);

    end;

    // local procedure AddCowImageToJsonObject(Cow: Record Cow; var CowJsonObject: JsonObject)
    // var
    //     Base64Convert: Codeunit "Base64 Convert";
    //     TempBlob: Codeunit "Temp Blob";
    //     ImageOutStream: OutStream;
    //     ImageInStream: InStream;
    // begin
    //     if not Cow.Image.HasValue() then begin
    //         exit;
    //     end;

    //     TempBlob.CreateOutStream(ImageOutStream);
    //     Cow.Image.ExportStream(ImageOutStream);
    //     TempBlob.CreateInStream(ImageInStream);

    //     CowJsonObject.Add('image', Base64Convert.ToBase64(ImageInStream));

    // end;

    local procedure AddJsonObjectToZipArchive(CowJsonObject: JsonObject; CowNo: Code[20]; var DataCompression: Codeunit "Data Compression")
    var
        TempBlob: Codeunit "Temp Blob";
        JsonOutStream: OutStream;
        JsonInStream: InStream;
        FileNameTok: Label 'Cow Detail %1.json', Locked = true, Comment = '%1 = Cow No.';
    begin
        TempBlob.CreateOutStream(JsonOutStream);
        CowJsonObject.WriteTo(JsonOutStream);
        TempBlob.CreateInStream(JsonInStream);

        DataCompression.AddEntry(JsonInStream, StrSubstNo(FileNameTok, CowNo));
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

        FileName := 'Cows.zip';

        TempBlob.CreateInStream(ZipInStream);
        DownloadFromStream(ZipInStream, 'Download Cow Details', '', ZipFilterTok, FileName);

    end;

    var
        myInt: Integer;
}