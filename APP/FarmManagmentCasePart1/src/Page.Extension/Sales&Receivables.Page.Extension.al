pageextension 54100 "Sales&Receivable Page Ext" extends "Sales & Receivables Setup"
{
    Caption = 'Sales & Receivable Page Ext';
    layout
    {
        addafter("Customer Nos.")
        {
            field(CowIdNos; Rec.CowIdNos)
            {
                ApplicationArea = All;
                Caption = 'Cow Id Nos.';
            }
            field(OEEIdNos; Rec.OEEIdNos)
            {
                ApplicationArea = All;
                Caption = 'OEE Id Nos.';
            }
            field(EquipmentIdNos; Rec.EquipmentIdNos)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Equipment Id Nos. field.', Comment = '%';
            }
            field(DocumentIdNos; Rec.DocumentIdNos)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Document Id Nos. field.', Comment = '%';
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