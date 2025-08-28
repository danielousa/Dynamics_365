report 54100 WeeklyProductionReport
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    //DefaultRenderingLayout = LayoutName;
    Caption = 'Weekly Production Report';
    RDLCLayout = './src/Reports/WeeklyProductionReport.rdl';
    
    dataset
    {
        dataitem(MilkProduction; "Milk Production Line")
        {
            column(Cow_No_; "Cow No.")
            {
                IncludeCaption = true;
            }
            column(Supervisor; Supervisor)
            {
                IncludeCaption = true;
            }
            column(MachineID; MachineID)
            {
                IncludeCaption = true;
            }
            column(Shift; Shift)
            {
                IncludeCaption = true;
            }
            column(Period; Period)
            {
                IncludeCaption = true;
            }
            column(Production_Date; "Production Date")
            {
                IncludeCaption = true;
            }
            column(Quantity_Produced; Quantity)
            {
                IncludeCaption = true;
            }
            column(Breakdown_Description; "Breakdown Description")
            {
                IncludeCaption = true;
            }
            column(Breakdowns; Breakdowns)
            {
                IncludeCaption = true;
            }
            column(CleaningTime; CleaningTime)
            {
                IncludeCaption = true;
            }
            column(SetupTime; SetupTime)
            {
                IncludeCaption = true;
            }
            column(Milk_scrap; Defects)
            {
                IncludeCaption = true;
            }
        }
    }
    
    // requestpage
    // {
    //     AboutTitle = 'Teaching tip title';
    //     AboutText = 'Teaching tip content';
    //     layout
    //     {
    //         area(Content)
    //         {
    //             group(GroupName)
    //             {
    //                 field(Name; SourceExpression)
    //                 {
    //                     ApplicationArea = All;
                        
    //                 }
    //             }
    //         }
    //     }
    
    //     actions
    //     {
    //         area(processing)
    //         {
    //             action(LayoutName)
    //             {
    //                 ApplicationArea = All;
                    
    //             }
    //         }
    //     }
    // }
    
    // rendering
    // {
    //     layout(LayoutName)
    //     {
    //         Type = Excel;
    //         LayoutFile = 'mySpreadsheet.xlsx';
    //     }
    // }
    
    var
        myInt: Integer;
}