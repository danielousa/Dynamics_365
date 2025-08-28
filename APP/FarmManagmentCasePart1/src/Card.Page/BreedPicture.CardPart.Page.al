page 54101 BreedPicture
{
    PageType = CardPart;
    ApplicationArea = All;
    //UsageCategory = Administration;
    SourceTable = BreedType;

    layout
    {
        area(Content)
        {
            group(Group)
            {
                field(BreedPicture; Rec.BreedPicture)
                {
                    ToolTip = 'Upload or view the picture of this breed.', Comment = '%';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(BreedUpload)
            {
                ApplicationArea = All;
                Caption = 'Breed Upload';
                ToolTip = 'Upload a picture of the Breed.';
                Image = Import;
                Promoted = true;
                PromotedCategory = Process;


                trigger OnAction()
                var
                    InStream: InStream;
                    FileName: Text;
                begin
                    if File.UploadIntoStream('Select an image', '', 'Image Files(*.jpg, *.jpeg, *.png, *.webp)|*.jpg;*.jpeg;*.png;*.webp', FileName, InStream) then begin
                        Rec.BreedPicture.ImportStream(InStream, FileName);
                        Rec.Modify();
                        Message('Breed picture uploaded successfully');
                    end else
                        Message('No file was selected');

                end;
            }
        }
    }

    var
        myInt: Integer;
}