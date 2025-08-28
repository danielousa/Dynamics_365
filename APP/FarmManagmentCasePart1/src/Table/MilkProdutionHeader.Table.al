table 54102 "Milk Production Header"
{
    DataClassification = CustomerContent;
    Caption = 'Milk Production Header';
    DataCaptionFields = "No.", "Document Date";

    fields
    {
        field(1; "No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'No.';
            Editable = false;

            trigger OnValidate()
            var
                MilkProductionHeader: Record "Milk Production Header";
            begin
                if "No." < xRec."No." then begin
                    if not MilkProductionHeader.Get("No.") then begin
                        SalesSetup.Get();
                        NoSeries.TestManual(SalesSetup.DocumentIdNos);
                        "No. Series" := '';
                    end;
                end;
            end;

        }
        field(2; "Document Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Date';
        }
        field(3; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
        }
    }

    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        // Add changes to field groups here
    }

    var
        SalesSetup: Record "Sales & Receivables Setup";
        NoSeries: Codeunit "No. Series";

    trigger OnInsert()
    begin
        if "No." = '' then begin
            SalesSetup.Get();
            SalesSetup.TestField(DocumentIdNos);
            "No. Series" := SalesSetup.DocumentIdNos;
            if NoSeries.AreRelated(SalesSetup.DocumentIdNos, xRec."No. Series") then
                "No. Series" := xRec."No. Series";
            "No." := NoSeries.GetNextNo("No. Series");

        end;

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}