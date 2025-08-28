codeunit 54110 "OEE Calculator"
{
    internal procedure AvailabilityIndex(MilkProductionLine: Record "Milk Production Line") rAvailabilityIndex: Decimal
    var
        TotalAvailableTime: Decimal;       // Constant total available time per shift (480 min)
        PlannedProductionTime: Decimal;    // Calculated Planned Production Time (after planned downtime)
        OperationTime: Decimal;            // Operation Time after subtracting breakdown, cleaning, and setup
        //lRecMilkProductionLines: Record "Milk Production Line"; // To use on future improvements of the metric OEE
    begin

        // To use on future improvements of the metric OEE

        // lRecMilkProductionLines.SetRange(Period, MilkProductionLine.Period);
        // lRecMilkProductionLines.SetRange("Production Date", MilkProductionLine."Production Date");
        // lRecMilkProductionLines.SetRange(Supervisor, MilkProductionLine.Supervisor);
        // lRecMilkProductionLines.SetCurrentKey(Supervisor, Period, "Production Date", "No.", "Line No.");
        // If lRecMilkProductionLines.FindSet() then begin
        //     repeat

                Clear(rAvailabilityIndex);

                // Total Available Time: 480 minutes (shift time)
                TotalAvailableTime := 480;

                // Calculate Planned Production lRecMilkProductionLines
                PlannedProductionTime := TotalAvailableTime - MilkProductionLine."PLanned Downtime";

                // Calculate Operation Time
                OperationTime := PlannedProductionTime - MilkProductionLine.Breakdowns - MilkProductionLine.CleaningTime - MilkProductionLine.SetupTime;

                // Calculate Availability Index
                if PlannedProductionTime > 0 then
                    rAvailabilityIndex := OperationTime / PlannedProductionTime * 100 // expressed as a percentage
                else
                    rAvailabilityIndex := 0;

            // until lRecMilkProductionLines.Next() = 0;
        //end;


    end;

    internal procedure PerformanceRate(MilkProductionLine: Record "Milk Production Line") rPerformanceRate: Decimal
    var
        TheoreticalCT: Decimal;            // For now i will use as constant
        Factor1: Decimal;                  // Factor 1 used in Performance Rate calculation
        TotalAvailableTime: Decimal;       // Constant total available time per shift (480 min)
        PlannedProductionTime: Decimal;    // Calculated Planned Production Time (after planned downtime)
        OperationTime: Decimal;            // Operation Time after subtracting breakdown, cleaning, and setup
    begin
        Clear(rPerformanceRate);

        // Total Available Time: 480 minutes (shift time)
        TotalAvailableTime := 480;

        // CT= min/liters
        //Consider which cow in maximum produce 15 liters per shift
        TheoreticalCT := 0.32;

        // Calculate Planned Production Time
        PlannedProductionTime := TotalAvailableTime - MilkProductionLine."PLanned Downtime";

        // Calculate Operation Time
        OperationTime := PlannedProductionTime - MilkProductionLine.Breakdowns - MilkProductionLine.CleaningTime - MilkProductionLine.SetupTime;

        if TheoreticalCT > 0 then begin
            Factor1 := OperationTime / TheoreticalCT;
            if Factor1 > 0 then
                rPerformanceRate := MilkProductionLine.Quantity / Factor1 * 100
            else
                rPerformanceRate := 0;
        end else
            rPerformanceRate := 0;

    end;

    internal procedure QualityRate(MilkProductionLine: Record "Milk Production Line") rQualityRate: Decimal
    var
        Factor3: Decimal;  // Factor 3 used in Quality Rate calculation
    begin
        Clear(rQualityRate);

        if MilkProductionLine.Defects > 0 then begin
            Factor3 := MilkProductionLine.Defects / MilkProductionLine.Quantity;
            rQualityRate := (1 - Factor3) * 100;
        end else
            rQualityRate := 100;

    end;

    internal procedure OEE(MilkProductionLine: Record "Milk Production Line") rOEE: Decimal
    var
        CUAvailabilityIndex: Codeunit "OEE Calculator";
        CUPerformanceRate: Codeunit "OEE Calculator";
        CUQualityRate: Codeunit "OEE Calculator";
        AvailabilityIndex: Decimal;
        PerformanceRate: Decimal;
        QualityRate: Decimal;
    begin
        Clear(rOEE);

        AvailabilityIndex := CUAvailabilityIndex.AvailabilityIndex(MilkProductionLine);
        PerformanceRate := CUPerformanceRate.PerformanceRate(MilkProductionLine);
        QualityRate := CUQualityRate.QualityRate(MilkProductionLine);

        if (AvailabilityIndex > 0) and (PerformanceRate > 0) and (QualityRate > 0) then
            rOEE := AvailabilityIndex * PerformanceRate * QualityRate / 10000
        else
            rOEE := 0;

    end;


}