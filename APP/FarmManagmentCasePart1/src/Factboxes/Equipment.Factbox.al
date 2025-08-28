page 54121 "Equipment Factbox"
{
    PageType = ListPart;
    //ApplicationArea = All; -- Therefore, the ApplicationArea property on page level is not needed.
    //UsageCategory = Lists; -- because we don't want users to be able to search for this page.
    SourceTable = Equipment;
    Caption = 'Equipment Factbox';
    Editable = false;
    
    layout
    {
        area(Content)
        {
            repeater(General)
            {

                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No. field.', Comment = '%';
                }
                field(SerialNumber; Rec.SerialNumber)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Serial Number field.', Comment = '%';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Description field.', Comment = '%';
                }
                field(Supplier; Rec.Supplier)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Supplier field.', Comment = '%';
                }
                field(Allocation; Rec.Allocation)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Allocation field.', Comment = '%';
                }
                field(ProcessPhase; Rec.ProcessPhase)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Process Phase field.', Comment = '%';
                }
                field(Blocked; Rec.Blocked)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Blocked field.', Comment = '%';
                }
            }
        }
    }
    
    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                
                trigger OnAction()
                begin
                    
                end;
            }
        }
    }
}