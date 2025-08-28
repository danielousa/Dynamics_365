pageextension 54101 "Employee Page Extension" extends "Employee Card"
{
    layout
    {
        addafter("Job Title")
        {

            field(Shift; Rec.Shift)
            {
                ApplicationArea = All;
                Caption = 'Shift';
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}