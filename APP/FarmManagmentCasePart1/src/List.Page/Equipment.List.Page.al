page 54118 EquipmentList
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = Equipment;
    CardPageId = EquipmentCard;
    Editable = false;
    Caption = 'Equipment List page';
    
    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field.', Comment = '%';
                }
                field(SerialNumber; Rec.SerialNumber)
                {
                    ToolTip = 'Specifies the value of the Serial Number field.', Comment = '%';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.', Comment = '%';
                }
                field(Supplier; Rec.Supplier)
                {
                    ToolTip = 'Specifies the value of the Supplier field.', Comment = '%';
                }
                field(SupplierDescription; Rec.SupplierDescription)
                {
                    ToolTip = 'Specifies the value of the Supplier Description field.', Comment = '%';
                }
                field(AquisitionDate; Rec.AquisitionDate)
                {
                    ToolTip = 'Specifies the value of the Aquisition Date field.', Comment = '%';
                }
                field(Allocation; Rec.Allocation)
                {
                    ToolTip = 'Specifies the value of the Allocation field.', Comment = '%';
                }
                field(ProcessPhase; Rec.ProcessPhase)
                {
                    ToolTip = 'Specifies the value of the Process Phase field.', Comment = '%';
                }
                field(EquipmentPicture; Rec.EquipmentPicture)
                {
                    ToolTip = 'Specifies the value of the Equipment Picture field.', Comment = '%';
                }
                field(Blocked; Rec.Blocked)
                {
                    ToolTip = 'Specifies the value of the Blocked field.', Comment = '%';
                }
                
            }
        }
        area(Factboxes)
        {
            
        }
    }
    
    actions
    {
        area(Processing)
        {
            action(ExportEquipmentasJSON)
            {
                ApplicationArea = All;
                Caption = 'Export Equipment as JSON';
                Image = Compress;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                ToolTip = 'Export All Equipments as Json Files in a ZIP Archive';
                
                trigger OnAction()
                var
                    ExportJsonHelper: Codeunit "Export Json Helper Equipment";
                begin
                    ExportJsonHelper.ExportEquipmentAdJson();
                    
                end;
            }
        }
    }
}