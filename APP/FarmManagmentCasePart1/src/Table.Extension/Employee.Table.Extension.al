tableextension 54101 "Employee Table Extension" extends Employee
{
    fields
    {
        field(54103; Shift; Enum Shift)
        {
            DataClassification = CustomerContent;
            Caption = 'Shift';
        }
    }
    
    keys
    {
        // Add changes to keys here
    }
    
    fieldgroups
    {
        // Add changes to field groups here
    }
    
    var
        myInt: Integer;
}