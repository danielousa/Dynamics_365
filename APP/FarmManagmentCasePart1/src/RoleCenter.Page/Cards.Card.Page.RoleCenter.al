page 54122 "Cards RoleCenter"
{
    PageType = CardPart;
    ApplicationArea = All;
    UsageCategory = Lists;
    Caption = 'Cards RoleCenter';
    RefreshOnActivate = true;

    layout
    {
        area(Content)
        {
            cuegroup(CowsGroup)
            {
                Caption = 'Cows';
                // field(NumberOfCows; NumberOfCows)
                // {
                //     Caption = 'Total of Cows';

                //     trigger OnDrillDown()
                //     begin
                //         PAGE.Run(PAGE::CowList);
                //     end;
                // }
                field(NoOfAvailableCows; NoOfAvailableCows)
                {
                    Caption = 'Available Cows';

                    trigger OnDrillDown()
                    begin
                        PAGE.Run(PAGE::CowList);
                    end;
                }
                field(NoOfSickCows; NoOfSickCows)
                {
                    Caption = 'Sick Cows';
                    StyleExpr = RedStyle;

                    trigger OnDrillDown()
                    begin
                        PAGE.Run(PAGE::CowList);
                    end;
                }
                field(NoOfQuarentineCows; NoOfQuarentineCows)
                {
                    Caption = 'Quarentine Cows';
                    StyleExpr = RedStyle;

                    trigger OnDrillDown()
                    begin
                        PAGE.Run(PAGE::CowList);
                    end;
                }
                field(NoOfGestationCows; NoOfGestationCows)
                {
                    Caption = 'Gestation Cows';
                    StyleExpr = RedStyle;

                    trigger OnDrillDown()
                    begin
                        PAGE.Run(PAGE::CowList);
                    end;
                }
                field(TotalLiters; TotalLitersProduced)
                {
                    Caption = 'Total Liters Produced';

                    trigger OnDrillDown()
                    begin
                        PAGE.Run(PAGE::"Milk Production Line List ");
                    end;
                }
            }

            cuegroup(EquipmentGroup)
            {
                Caption = 'Blocked Equipments by Process Phase';
                field(MilkingParlorPens; MilkingParlorPens)
                {
                    Caption = 'Milking Parlor Pens';

                    trigger OnDrillDown()
                    begin
                        Page.Run(Page::EquipmentList);

                    end;
                }
                field(MilkReceptiion; MilkReceptiion)
                {
                    Caption = 'Milk Reception';

                    trigger OnDrillDown()
                    begin
                        Page.Run(Page::EquipmentList);

                    end;
                }
                field(MilkStorage; MilkStorage)
                {
                    Caption = 'Milk Storage';

                    trigger OnDrillDown()
                    begin
                        Page.Run(Page::EquipmentList);

                    end;
                }
                field(MixingAndBlending; MixingAndBlending)
                {
                    Caption = 'Mixing and Blending';

                    trigger OnDrillDown()
                    begin
                        Page.Run(Page::EquipmentList);

                    end;
                }
                field(Pasteurization; Pasteurization)
                {
                    Caption = 'Pasteurization';

                    trigger OnDrillDown()
                    begin
                        Page.Run(Page::EquipmentList);

                    end;
                }
                field(Fermentation; Fermentation)
                {
                    Caption = 'Fermentation';

                    trigger OnDrillDown()
                    begin
                        Page.Run(Page::EquipmentList);

                    end;
                }
                field(BufferStorage; BufferStorage)
                {
                    Caption = 'Buffer Storage';

                    trigger OnDrillDown()
                    begin
                        Page.Run(Page::EquipmentList);

                    end;
                }
                field(Separation; Separation)
                {
                    Caption = 'Separation';

                    trigger OnDrillDown()
                    begin
                        Page.Run(Page::EquipmentList);

                    end;
                }
                field(Concentration; Concentration)
                {
                    Caption = 'Concentration';

                    trigger OnDrillDown()
                    begin
                        Page.Run(Page::EquipmentList);

                    end;
                }
                field(CleaningInPlace; CleaningInPlace)
                {
                    Caption = 'Cleaning-In-Place';

                    trigger OnDrillDown()
                    begin
                        Page.Run(Page::EquipmentList);

                    end;
                }
                // field(BestShift; BestShift)
                // {
                //     Caption = 'Best Team Supervisor';

                //     trigger OnDrillDown()
                //     begin
                //         Page.Run(Page::"OEE Data List");
                //     end;
                // }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(RefreshAction)
            {
                ApplicationArea = All;
                Caption = 'Refresh';

                trigger OnAction()
                begin
                    CurrPage.Update();
                end;
            }
        }
    }
    trigger OnOpenPage()
    begin
        //GetTotalCows();
        GetTotalAvailableCows();
        CalculateTotalLiters();
        //GetBestSupervisor();
        GetTotalSickCows();
        GetTotalQuarentineCows();
        GetTotalGestationCows();
        GetMilkingParlorPens();
        GetMilkReception();
        GetMilkStorage();
        GetMixingAndBlending();
        GetPasteurization();
        GetFermentation();
        GetBufferStorage();
        GetSeparation();
        GetConcentration();
        GetCleaningInPlace();

    end;

    var
        //NumberOfCows: Integer;
        NoOfAvailableCows: Integer;
        TotalLitersProduced: Decimal;
        BestShift: Text;
        BestOEE: Decimal;
        NoOfSickCows: Integer;
        NoOfQuarentineCows: Integer;
        NoOfGestationCows: Integer;
        MilkingParlorPens: Integer;
        MilkReceptiion: Integer;
        MilkStorage: Integer;
        MixingAndBlending: Integer;
        Pasteurization: Integer;
        Fermentation: Integer;
        BufferStorage: Integer;
        Separation: Integer;
        Concentration: Integer;
        CleaningInPlace: Integer;
        RedStyle: Text;

    // local procedure GetTotalCows();
    // var
    //     Cow: Record Cow;

    // begin
    //     Clear(NumberOfCows);
    //     if Cow.FindSet() then
    //         repeat
    //             NumberOfCows += 1;
    //         until Cow.Next() = 0;
    // end;

    Local procedure GetTotalAvailableCows()
    var
        Cow: Record Cow;
    begin
        Clear(NoOfAvailableCows);

        Cow.SETRANGE(Cow.CowStatus, Cow.CowStatus::Active);

        if Cow.FindSet() then
            repeat
                NoOfAvailableCows += 1;
            until Cow.Next() = 0;
    end;

    local procedure CalculateTotalLiters()
    var
        MilkProductionLine: Record "Milk Production Line";

    begin
        Clear(TotalLitersProduced);
        TotalLitersProduced := 0;
        if MilkProductionLine.FindSet() then begin
            repeat
                TotalLitersProduced += MilkProductionLine.Quantity;
            until MilkProductionLine.Next() = 0;
        end;
    end;

    Local procedure GetTotalSickCows()
    var
        Cow: Record Cow;
    begin
        Clear(NoOfSickCows);

        Cow.SETRANGE(Cow.CowStatus, Cow.CowStatus::Sick);

        if Cow.FindSet() then
            repeat
                NoOfSickCows += 1;
            until Cow.Next() = 0;
    end;

    Local procedure GetTotalQuarentineCows()
    var
        Cow: Record Cow;
    begin
        Clear(NoOfQuarentineCows);

        Cow.SETRANGE(Cow.CowStatus, Cow.CowStatus::Quarentine);

        if Cow.FindSet() then
            repeat
                NoOfQuarentineCows += 1;
            until Cow.Next() = 0;
    end;

    Local procedure GetTotalGestationCows()
    var
        Cow: Record Cow;
    begin
        Clear(NoOfGestationCows);

        Cow.SETRANGE(Cow.CowStatus, Cow.CowStatus::Gestation);

        if Cow.FindSet() then
            repeat
                NoOfGestationCows += 1;
            until Cow.Next() = 0;
    end;

    local procedure GetMilkingParlorPens()
    var
        EquipmentRec: Record Equipment;
        ProcessPhaseFilter: Text[100];
    begin
        Clear(MilkingParlorPens);

        ProcessPhaseFilter := 'Milking Parlor Pens';

        EquipmentRec.SetRange(Blocked, true);
        EquipmentRec.SetRange(ProcessPhase, ProcessPhaseFilter);

        if EquipmentRec.FindSet() then begin
            repeat
                MilkingParlorPens += 1;
            until EquipmentRec.Next() = 0;
        end;
    end;

    local procedure GetMilkReception()
    var
        EquipmentRec: Record Equipment;
        ProcessPhaseFilter: Text[100];
    begin
        Clear(MilkReceptiion);

        ProcessPhaseFilter := 'Milk Reception';

        EquipmentRec.SetRange(Blocked, true);
        EquipmentRec.SetRange(ProcessPhase, ProcessPhaseFilter);

        if EquipmentRec.FindSet() then begin
            repeat
                MilkReceptiion += 1;
            until EquipmentRec.Next() = 0;
        end;
    end;

    local procedure GetMilkStorage()
    var
        EquipmentRec: Record Equipment;
        ProcessPhaseFilter: Text[100];
    begin
        Clear(MilkStorage);

        ProcessPhaseFilter := 'Milk Storage';

        EquipmentRec.SetRange(Blocked, true);
        EquipmentRec.SetRange(ProcessPhase, ProcessPhaseFilter);

        if EquipmentRec.FindSet() then begin
            repeat
                MilkStorage += 1;
            until EquipmentRec.Next() = 0;
        end;
    end;

    local procedure GetMixingAndBlending()
    var
        EquipmentRec: Record Equipment;
        ProcessPhaseFilter: Text[100];
    begin
        Clear(MixingAndBlending);

        ProcessPhaseFilter := 'Mixing and Blending';

        EquipmentRec.SetRange(Blocked, true);
        EquipmentRec.SetRange(ProcessPhase, ProcessPhaseFilter);

        if EquipmentRec.FindSet() then begin
            repeat
                MixingAndBlending += 1;
            until EquipmentRec.Next() = 0;
        end;
    end;

    local procedure GetPasteurization()
    var
        EquipmentRec: Record Equipment;
        ProcessPhaseFilter: Text[100];
    begin
        Clear(Pasteurization);

        ProcessPhaseFilter := 'Pasteurization';

        EquipmentRec.SetRange(Blocked, true);
        EquipmentRec.SetRange(ProcessPhase, ProcessPhaseFilter);

        if EquipmentRec.FindSet() then begin
            repeat
                Pasteurization += 1;
            until EquipmentRec.Next() = 0;
        end;
    end;

    local procedure GetFermentation()
    var
        EquipmentRec: Record Equipment;
        ProcessPhaseFilter: Text[100];
    begin
        Clear(Fermentation);

        ProcessPhaseFilter := 'Fermentation';

        EquipmentRec.SetRange(Blocked, true);
        EquipmentRec.SetRange(ProcessPhase, ProcessPhaseFilter);

        if EquipmentRec.FindSet() then begin
            repeat
                Fermentation += 1;
            until EquipmentRec.Next() = 0;
        end;
    end;

    local procedure GetBufferStorage()
    var
        EquipmentRec: Record Equipment;
        ProcessPhaseFilter: Text[100];
    begin
        Clear(BufferStorage);

        ProcessPhaseFilter := 'Buffer Storage';

        EquipmentRec.SetRange(Blocked, true);
        EquipmentRec.SetRange(ProcessPhase, ProcessPhaseFilter);

        if EquipmentRec.FindSet() then begin
            repeat
                BufferStorage += 1;
            until EquipmentRec.Next() = 0;
        end;
    end;

    local procedure GetSeparation()
    var
        EquipmentRec: Record Equipment;
        ProcessPhaseFilter: Text[100];
    begin
        Clear(Separation);

        ProcessPhaseFilter := 'Separation';

        EquipmentRec.SetRange(Blocked, true);
        EquipmentRec.SetRange(ProcessPhase, ProcessPhaseFilter);

        if EquipmentRec.FindSet() then begin
            repeat
                Separation += 1;
            until EquipmentRec.Next() = 0;
        end;
    end;

    local procedure GetConcentration()
    var
        EquipmentRec: Record Equipment;
        ProcessPhaseFilter: Text[100];
    begin
        Clear(Concentration);

        ProcessPhaseFilter := 'Concentration';

        EquipmentRec.SetRange(Blocked, true);
        EquipmentRec.SetRange(ProcessPhase, ProcessPhaseFilter);

        if EquipmentRec.FindSet() then begin
            repeat
                Concentration += 1;
            until EquipmentRec.Next() = 0;
        end;
    end;

    local procedure GetCleaningInPlace()
    var
        EquipmentRec: Record Equipment;
        ProcessPhaseFilter: Text[100];
    begin
        Clear(CleaningInPlace);

        ProcessPhaseFilter := 'Cleaning-in-Place';

        EquipmentRec.SetRange(Blocked, true);
        EquipmentRec.SetRange(ProcessPhase, ProcessPhaseFilter);

        if EquipmentRec.FindSet() then begin
            repeat
                CleaningInPlace += 1;
            until EquipmentRec.Next() = 0;
        end;
    end;

    trigger OnAfterGetRecord()
    begin
        RedStyle := 'Unfaborable';
    end;

    // local procedure GetBestSupervisor()
    // var
    //     OEEDataRec: Record "Milk Production Line";
    //     BestOEERec: Record "Milk Production Line";
    //     SupervisorName: Text[100];
    // begin
    //     BestOEE := 0;

    //     // Loop through OEE data to find the best supervisor
    //     if OEEDataRec.FindSet() then begin
    //         repeat
    //             if OEEDataRec.OEE > BestOEE then begin
    //                 BestOEE := OEEDataRec.OEE;
    //                 //BestOEERec := OEEDataRec; // Store the record with the best OEE
    //             end;
    //         until OEEDataRec.Next() = 0;

    //     end;

    //     SupervisorName := BestOEERec.SupervisorName;
    //     BestShift := SupervisorName + ' (' + Format(BestOEE) + '%)';
    // end;





}