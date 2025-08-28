enum 54104 "OEE Backup Type" implements "OEE Backup"
{
    Extensible = true;
    
    value(0; XLSX)
    {
        Caption = 'XLSX', Locked = true;
        Implementation = "OEE Backup" = "OEE Backup XLSX";
    }
}