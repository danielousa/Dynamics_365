page 54120 EquipmentPicture
{
    PageType = CardPart;
    ApplicationArea = All;
    //UsageCategory = Administration;
    SourceTable = Equipment;

    layout
    {
        area(Content)
        {
            group(Group)
            {

                field(EquipmentPicture; Rec.EquipmentPicture)
                {
                    ToolTip = 'Specifies the value of the Equipment Picture field.', Comment = '%';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(EquipmentUpload)
            {
                ApplicationArea = All;
                Caption = 'Equipment Upload';
                ToolTip = 'Upload a picture of the Equipment';
                Image = Import;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    InStream: InStream;
                    FileName: Text;
                begin
                    if File.UploadIntoStream('Select an image', '', 'Image Files(*.jpg, *.jpeg, *.png, *.webp)|*.jpg;*.jpeg;*.png;*.webp', FileName, InStream) then begin
                        Rec.EquipmentPicture.ImportStream(InStream, FileName);
                        Rec.Modify();
                        Message('Equipment picture uploaded successfully');
                    end else
                        Message('No file was selected');

                end;
            }
        }
    }

    var
        myInt: Integer;
}