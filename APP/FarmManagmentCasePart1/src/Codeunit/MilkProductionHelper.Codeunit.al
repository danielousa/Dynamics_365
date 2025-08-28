codeunit 54102 "Milk Production Helper"
{
    Subtype = Normal;

    internal procedure ValidateTotalTimeByPeriod(NewLine: Record "Milk Production Line"): Decimal
    var
        ExistingLines: Record "Milk Production Line";
        TotalTime: Decimal;
    begin
        // Filter records by the same Production Date and Period
        ExistingLines.SetRange("Production Date", NewLine."Production Date");
        ExistingLines.SetRange(Period, NewLine.Period);

        if ExistingLines.FindSet then begin
            repeat
                if ExistingLines."Line No." <> NewLine."Line No." then begin
                    // Sum up time fields for existing lines
                    TotalTime += ExistingLines."PLanned Downtime" +
                                 ExistingLines.ProductionTime +
                                 ExistingLines.Breakdowns +
                                 ExistingLines.CleaningTime +
                                 ExistingLines.SetupTime;
                end;
            until ExistingLines.Next() = 0;
        end;

        // Add the current record's time fields
        TotalTime += NewLine."PLanned Downtime" +
                     NewLine.ProductionTime +
                     NewLine.Breakdowns +
                     NewLine.CleaningTime +
                     NewLine.SetupTime;

        exit(TotalTime);

        // var
        //     ExistingLines: Record "Milk Production Line";
        //     TotalTime: Decimal;
        //     PlannedDowntime: Decimal;
        //     ProductionTime: Decimal;
        //     Breakdowns: Decimal;
        //     CleaningTime: Decimal;
        //     SetupTime: Decimal;
        // begin
        //     // Filter records by the same Production Date and Period
        //     ExistingLines.SetRange("Production Date", NewLine."Production Date");
        //     ExistingLines.SetRange(Period, NewLine.Period);

        //     if ExistingLines.FindSet then begin
        //         repeat
        //             // Accumulate time fields for existing lines
        //             PlannedDowntime += ExistingLines."PLanned Downtime";
        //             ProductionTime += ExistingLines.ProductionTime;
        //             Breakdowns += ExistingLines.Breakdowns;
        //             CleaningTime += ExistingLines.CleaningTime;
        //             SetupTime += ExistingLines.SetupTime;
        //         until ExistingLines.Next() = 0;
        //     end;

        //     // Add the current record's time fields
        //     PlannedDowntime += NewLine."PLanned Downtime";
        //     ProductionTime += NewLine.ProductionTime;
        //     Breakdowns += NewLine.Breakdowns;
        //     CleaningTime += NewLine.CleaningTime;
        //     SetupTime += NewLine.SetupTime;

        //     // Sum total time
        //     TotalTime := PlannedDowntime + ProductionTime + Breakdowns + CleaningTime + SetupTime;

        //     // Optional: Log the individual times for debugging
        //     Message('Planned Downtime: %1, Production Time: %2, Breakdowns: %3, Cleaning Time: %4, Setup Time: %5, Total Time: %6',
        //             PlannedDowntime, ProductionTime, Breakdowns, CleaningTime, SetupTime, TotalTime);

        //     exit(TotalTime);
    end;

    internal procedure ValidateShiftTime(MilkProductionLine: Record "Milk Production Line")
    var
        TotalShiftTime: Decimal;
    begin
        TotalShiftTime := ValidateTotalTimeByPeriod(MilkProductionLine);

        if TotalShiftTime > 480 then begin
            Error('The total time for the %1 period exceeds 480 minutes. Please adjust the values.', MilkProductionLine.Period);
        end;
    end;
}