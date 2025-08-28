page 54117 "CowListByMilkProduction"
{
    PageType = List;
    ApplicationArea = All;
    //UsageCategory = Lists;
    SourceTable = Cow;
    CardPageId = CowCard;
    SourceTableView = sorting(TotalMilkProduction) order(descending);
    Caption = 'Milk production by cow list';
    
    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field.', Comment = '%';
                }
                field(BreedName; Rec.BreedName)
                {
                    ToolTip = 'Specifies the value of the Breed Names field.', Comment = '%';
                }
                field(TotalMilkProduction; Rec.TotalMilkProduction)
                {
                    ToolTip = 'Specifies the value of the Total Milk Production field.', Comment = '%';
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
            action(ActionName)
            {
                ApplicationArea = All;
                
                trigger OnAction()
                begin
                    
                end;
            }
        }
    }
}