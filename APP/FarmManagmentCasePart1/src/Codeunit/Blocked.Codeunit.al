codeunit 54115 GetBlocked
{
    internal procedure GetBlockedRecords()
    var
        CowRec: Record Cow;
        NoOfRecords: Integer;
        EquipmentRec: Record Equipment;
        NoOfRecordsEquipment: Integer;
    begin
        CowRec.Init();
        CowRec.SetRange(CowRec.Blocked, true);
        EquipmentRec.SetRange(EquipmentRec.Blocked, true);

        NoOfRecords := CowRec.Count;
        NoOfRecordsEquipment := EquipmentRec.Count;

        SendNoofBlockedCowsNotification(NoOfRecords, CowRec);
        SendNoofBlockedEquipmentsNotification(NoOfRecordsEquipment, EquipmentRec);

    end;

    local procedure SendNoofBlockedCowsNotification(NoOfBlocked: Integer; CowRec: Record Cow)
    var
        BlockedNotification: Notification;
        BlockedCowsMsgLbl: Label 'There are %1 cow(s) currently blocked.', Comment = '%1 = No of cows blocked';
        ShowNoOfBlockedCowsLbl: Label 'Show blocked cow(s)', Comment = '%1 = No of cows blocked';
        NotiticationMgmt: Codeunit Notification;
    begin
        BlockedNotification.Message := StrSubstNo(BlockedCowsMsgLbl, NoOfBlocked);
        BlockedNotification.AddAction(StrSubstNo(ShowNoOfBlockedCowsLbl), Codeunit::Notification, 'OpenBlockedCows');
        BlockedNotification.Send();

    end;

    local procedure SendNoofBlockedEquipmentsNotification(NoOfBlocked: Integer; EquipmentRec: Record Equipment)
    var
        BlockedNotification: Notification;
        BlockedEquipmentsMsgLbl: Label 'There are %1 equipments(s) currently blocked.', Comment = '%1 = No of equipments blocked';
        ShowNoOfBlockedEquipmentsLbl: Label 'Show blocked equipments(s)', Comment = '%1 = No of equipments blocked';
        NotiticationMgmt: Codeunit Notification;
    begin
        BlockedNotification.Message := StrSubstNo(BlockedEquipmentsMsgLbl, NoOfBlocked);
        BlockedNotification.AddAction(StrSubstNo(ShowNoOfBlockedEquipmentsLbl), Codeunit::Notification, 'OpenBlockedEquipments');
        BlockedNotification.Send();

    end;

    var
        myInt: Integer;
}