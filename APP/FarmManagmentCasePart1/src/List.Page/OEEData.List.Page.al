page 54114 "OEE Data List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Milk Production Line";
    Editable = false;
    Caption = 'OEE Data List';
    // To use on future improvements on the Metric OEE
    //SourceTableTemporary = true; 

    layout
    {
        area(Content)
        {
            repeater(General)
            {

                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field.', Comment = '%';
                }
                field(Supervisor; Rec.Supervisor)
                {
                    ToolTip = 'Show the name of the Supervisor.', Comment = '%';
                }
                field(SupervisorName; Rec.SupervisorName)
                {
                    ToolTip = 'Write the name of the Supervisor.', Comment = '%';
                }

                field(Shift; Rec.Shift)
                {
                    ToolTip = 'Specifies the value of the Shift field.', Comment = '%';
                }
                field(Period; Rec.Period)
                {
                    ToolTip = 'Specifies the value of the Period of the day.', Comment = '%';
                }
                // field("Theoretical CT"; Rec."Theoretical CT")
                // {
                //     ToolTip = 'Specifies the value of the Theoretical Cycle Time.', Comment = '%';
                // }
                field("Production Date"; Rec."Production Date")
                {
                    ToolTip = 'Specifies the value of the Production Date field.', Comment = '%';
                }
                field("Availability Index"; gAvailabilityIndex)
                {
                    Caption = 'Availability Index %';
                    ToolTip = 'Specifies the value of the Availability Index field.', Comment = '%';
                }
                field("Performance rate"; gPerformanceRate)
                {
                    Caption = 'Performance rate %';
                    ToolTip = 'Specifies the value of the Performance rate field.', Comment = '%';
                }
                field("Quality rate"; gQualityRate)
                {
                    Caption = 'Quality rate %';
                    ToolTip = 'Specifies the value of the Quality rate field.', Comment = '%';
                }
                field(OEE; gOEE)
                {
                    Caption = 'OEE %';
                    ToolTip = 'Specifies the value of the OEE field.', Comment = '%';
                }
                field(Rank; Rec.Rank)
                {
                    ToolTip = 'Specifies the rank according with the result of OEE.', Comment = '%';
                    Caption = 'OEE Rank';
                    StyleExpr = gStyleExprTxt;
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
            action("Backup OEE Data")
            {
                ApplicationArea = All;
                Caption = 'OEE Data';
                Image = ExportDatabase;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                ToolTip = 'Create a backup of OEE Data in your database.';
                trigger OnAction()
                begin
                    RunBackupOEE();

                end;
            }

        }
    }
    var
        gAvailabilityIndex: Decimal;
        gPerformanceRate: Decimal;
        gQualityRate: Decimal;
        gOEE: Decimal;
        gStyleExprTxt: Text[50];
        gOEEChangeColor: Codeunit OEEChancgeColor;

    // To use on future improvements on the Metric OEE

    // trigger OnOpenPage()
    // var
    //     lVarCode: Code[20];
    // begin

    //     UploadTEMPMilkProductionLine();

    // end;

    trigger OnAfterGetRecord()
    var
        //CUMediaTest: Codeunit "OEE Calculator";
        CUAvailabilityIndex: Codeunit "OEE Calculator";
        CUPerformanceRate: Codeunit "OEE Calculator";
        CUQualityRate: Codeunit "OEE Calculator";
        CUOEE: Codeunit "OEE Calculator";
    begin
        Clear(gAvailabilityIndex);
        Clear(gPerformanceRate);
        Clear(gQualityRate);
        Clear(gOEE);
        gAvailabilityIndex := CUAvailabilityIndex.AvailabilityIndex(Rec);
        gPerformanceRate := CUPerformanceRate.PerformanceRate(Rec);
        gQualityRate := CUQualityRate.QualityRate(Rec);
        gOEE := CUOEE.OEE(Rec);

        //Calculate OEE Rank
        if gOEE >= 85 then
            Rec.Rank := Rec.Rank::WorldClass
        else if (gOEE >= 60) and (gOEE < 85) then
            Rec.Rank := Rec.Rank::AverageWorldIndustry
        else
            Rec.Rank := Rec.Rank::PoorIndustryStandards;

        gStyleExprTxt := gOEEChangeColor.OEERankChangeColor(Rec);
    end;

    local procedure RunBackupOEE()
    var
        MilkProduction: Record "Milk Production Line";
        MilkProductionSetup: Record "Milk Production Setup";
        OEEBackup: Interface "OEE Backup";
    begin
        if not MilkProductionSetup.Get() then begin
            exit;
        end;

        if MilkProduction.IsEmpty() then begin
            exit;
        end;

        OEEBackup := MilkProductionSetup."OEE Data";
        OEEBackup.BackupOEE(MilkProduction);

    end;

    // To use on future improvments on the Metric OEE

    // local procedure UploadTEMPMilkProductionLine()
    // var
    //     MilkProductionLine: Record "Milk Production Line";
    //     lVarCode: Code[20];
    //     CUOEECalculator: Codeunit "OEE Calculator";

    // begin
    //     MilkProductionLine.SetRange(Period, Period::Morning); //test
    //     MilkProductionLine.SetRange(Supervisor, 'E0010'); //test
    //     MilkProductionLine.SetCurrentKey(Supervisor, Period, "Production Date", "No.", "Line No.");
    //     IF MilkProductionLine.FindSet() THEN begin
    //         Rec.Supervisor := MilkProductionLine.Supervisor;
    //         repeat
    //             IF (MilkProductionLine.Period = Rec.Period) and (MilkProductionLine."Production Date" = Rec."Production Date") THEN begin
    //                 IF MilkProductionLine.Supervisor = Rec.Supervisor THEN BEGIN


    //                     rec."Availability Index" := CUOEECalculator.AvailabilityIndex(Rec);
    //                     rec."Performance rate" := CUOEECalculator.PerformanceRate(Rec);
    //                     rec."Quality rate" := CUOEECalculator.QualityRate(Rec);
    //                     rec.OEE := CUOEECalculator.OEE(Rec);
    //                     //Calculate OEE Rank
    //                     if rec.OEE >= 85 then
    //                         Rec.Rank := Rec.Rank::WorldClass
    //                     else if (Rec.OEE >= 60) and (Rec.OEE < 85) then
    //                         Rec.Rank := Rec.Rank::AverageWorldIndustry
    //                     else
    //                         Rec.Rank := Rec.Rank::PoorIndustryStandards;
    //                     gStyleExprTxt := gOEEChangeColor.OEERankChangeColor(Rec);

    //                     Rec.Modify();
    //                 END else begin
    //                     Rec.Init();
    //                     Rec.TransferFields(MilkProductionLine);
    //                     //Função.s
    //                     rec."Availability Index" := CUOEECalculator.AvailabilityIndex(Rec);
    //                     rec."Performance rate" := CUOEECalculator.PerformanceRate(Rec);
    //                     rec."Quality rate" := CUOEECalculator.QualityRate(Rec);
    //                     rec.OEE := CUOEECalculator.OEE(Rec);
    //                     //Calculate OEE Rank
    //                     if rec.OEE >= 85 then
    //                         Rec.Rank := Rec.Rank::WorldClass
    //                     else if (Rec.OEE >= 60) and (Rec.OEE < 85) then
    //                         Rec.Rank := Rec.Rank::AverageWorldIndustry
    //                     else
    //                         Rec.Rank := Rec.Rank::PoorIndustryStandards;
    //                     //Função.e
    //                     Rec.Insert();
    //                 end;

    //             end else begin
    //                 Rec.Init();
    //                 Rec.TransferFields(MilkProductionLine);
    //                 //Função.s
    //                 rec."Availability Index" := CUOEECalculator.AvailabilityIndex(Rec);
    //                 rec."Performance rate" := CUOEECalculator.PerformanceRate(Rec);
    //                 rec."Quality rate" := CUOEECalculator.QualityRate(Rec);
    //                 rec.OEE := CUOEECalculator.OEE(Rec);
    //                 //Calculate OEE Rank
    //                 if rec.OEE >= 85 then
    //                     Rec.Rank := Rec.Rank::WorldClass
    //                 else if (Rec.OEE >= 60) and (Rec.OEE < 85) then
    //                     Rec.Rank := Rec.Rank::AverageWorldIndustry
    //                 else
    //                     Rec.Rank := Rec.Rank::PoorIndustryStandards;
    //                 //Função.e
    //                 Rec.Insert();
    //             end;


    //         //Rec."No." := MilkProductionLine."No.";

    //         until MilkProductionLine.Next() = 0;
    //     end;

    // end;

}