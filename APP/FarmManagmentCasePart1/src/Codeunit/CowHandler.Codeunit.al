codeunit 54101 CowHandler
{
  internal procedure CalculateAge(BirthDate: Date): Integer
    var
        Currentdate: Date;
    begin
        Currentdate := Today();
        if BirthDate <> 0D then begin
            exit(YearsBetween(BirthDate, Currentdate));
            exit(0);

        end;

    end;


    internal procedure YearsBetween(StartDate: Date; EndDate: Date): Integer
    var
        StartYear: Integer;
        EndYear: Integer;
        StartMonth: Integer;
        EndMonth: Integer;
        StartDay: Integer;
        EndDay: Integer;
    begin
        if (StartDate = 0D) or (EndDate = 0D) then
            exit(0);

        StartYear := Date2DMY(StartDate, 3); // Extract year from StartDate
        EndYear := Date2DMY(EndDate, 3); // Extract year from EndDate
        StartMonth := Date2DMY(StartDate, 2); // Extract month from StartDate
        EndMonth := Date2DMY(EndDate, 2); // Extract month from EndDate
        StartDay := Date2DMY(StartDate, 1); // Extract day from StartDate
        EndDay := Date2DMY(EndDate, 1); // Extract day from EndDate

        if (EndMonth < StartMonth) or ((EndMonth = StartMonth) and (EndDay < StartDay)) then
            exit(EndYear - StartYear - 1) // Subtract one year if the end date is before the start date within the same year
        else
            exit(EndYear - StartYear); // Otherwise, just subtract the years
    end;

    internal procedure AgeCriteria(var CowRec: Record cow)
    begin
        if CowRec.CowAge <= 1 then
            CowRec.Description := 'Calf';
        if (CowRec.CowAge > 1) and (CowRec.CowAge <= 2) then
            CowRec.Description := 'Young Bull'; 
        if (CowRec.CowAge > 2) and (CowRec.CowAge <= 7) then
            CowRec.Description := 'Adult';
        if CowRec.CowAge > 7 then
            CowRec.Description := 'Old';
    end;
}