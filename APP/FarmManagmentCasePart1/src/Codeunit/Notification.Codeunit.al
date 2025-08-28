codeunit 54116 Notification
{
    internal procedure OpenBlockedCows(BlocekdNotification: Notification)
    var
        CowRec: Record Cow;
        BlockedStatus: Boolean;
        Blocked: Page CowList;
    begin
        Blocked.Run();
    end;

    internal procedure OpenBlockedEquipments(BlocekdNotification: Notification)
    var
        EquipmentRec: Record Equipment;
        BlockedStatus: Boolean;
        Blocked: Page EquipmentList;
    begin
        Blocked.Run();
    end;

    var
        myInt: Integer;
}