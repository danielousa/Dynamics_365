enum 54103 "Backup Type" implements "Data Backup"
{
    Extensible = true;
    
    value(0; CSV)
    {
        Caption = 'CSV', Locked = true;
        Implementation = "Data Backup" = "Backup CSV";
    }
    value(1; XSLX)
    {
        Caption = 'XLSX', Locked = true;
        Implementation = "Data Backup" = "Backup XLSX";
    }
    value(2; JSON)
    {
        Caption = 'JSON', Locked = true;
        Implementation = "Data Backup" = "Backup JSON";
    }
    value(3; XML)
    {
        Caption = 'XML', Locked = true;
        Implementation = "Data Backup" = "Backup XML";
    }
}