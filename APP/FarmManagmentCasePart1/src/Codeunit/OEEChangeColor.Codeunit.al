codeunit 54113 OEEChancgeColor
{
    internal procedure OEERankChangeColor(MilkProductionLine: Record "Milk Production Line"): Text[50]
    var
        myInt: Integer;
    begin
        with MilkProductionLine do
            case Rank of
                Rank::WorldClass:
                    exit('Gold');
                Rank::AverageWorldIndustry:
                    exit('favorable');
                Rank::PoorIndustryStandards:
                    exit('Unfavorable');
                
            end;
    end;
}