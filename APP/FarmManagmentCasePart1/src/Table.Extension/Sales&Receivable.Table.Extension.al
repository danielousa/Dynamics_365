tableextension 54100 "Sales&Receivable TableExt" extends "Sales & Receivables Setup"
{
    Caption = 'Sales&Receivable TableExt';

    fields
    {
        field(54101; CowIdNos; Code[20])
        {
            Caption = 'Cow Id Nos.';
            DataClassification = CustomerContent;
            TableRelation = "No. Series";
        }
        field(54102; OEEIdNos; Code[20])
        {
            Caption = 'OEE Id Nos.';
            DataClassification = CustomerContent;
            TableRelation = "No. Series";
        }
        field(54103; EquipmentIdNos; Code[20])
        {
            Caption = 'Equipment Id Nos.';
            DataClassification = CustomerContent;
            TableRelation = "No. Series";
        }
        field(54104; DocumentIdNos; Code[20])
        {
            Caption = 'Document Id Nos.';
            DataClassification = CustomerContent;
            TableRelation = "No. Series";
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