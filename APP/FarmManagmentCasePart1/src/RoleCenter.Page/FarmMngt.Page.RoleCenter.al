page 54109 "Farm Management RoleCenter"
{
    PageType = RoleCenter;
    ApplicationArea = All;
    UsageCategory = Administration;
    Caption = 'Farm Management';

    layout
    {
        area(RoleCenter)
        {
            // part(HeadLineOrderProcessor; "Headline RC Order Processor")
            // {
            //     ApplicationArea = All;
            // }
            // part(OverdueCustomers; "Overdue Customers")
            // {
            //     ApplicationArea = All;
            // }
            // part(O365Activities; "O365 Activities")
            // {
            //     ApplicationArea = All;
            // }
            part(Headline; "Headline RoleCenter")
            {
                ApplicationArea = All;

            }
            part(CardsRoleCenter; "Cards RoleCenter")
            {

            }
            part(Breed; "Breed Factbox")
            {
                ApplicationArea = All;

            }
            part(Logo; Logo)
            {
                ApplicationArea = All;

            }
            part(Cow; "Cow Factbox")
            {
                ApplicationArea = All;

            }
            part(MilkProd; "Milk Production Subpage")
            {
                ApplicationArea = All;

            }
            part(OEE; "OEE Data List")
            {
                ApplicationArea = All;
            }
            part(Equipment; "Equipment Factbox")
            {
                ApplicationArea = All;
            }
            part(TotalMilkProduction; "Total Milk Production Chart")
            {
                ApplicationArea = All;

            }

        }
    }

    actions
    {
        area(Creation)
        {
            // action(ActionBarAction)
            // {
            //     RunObject = Page ObjectName;
            // }
        }
        area(Sections)
        {
            group(MasterData)
            {
                Caption = 'Master Data';
                Image = RegisteredDocs;
                action(CowList)
                {
                    ApplicationArea = All;
                    Caption = 'Cow List';
                    RunObject = Page CowList;
                }
                action(BreedType)
                {
                    ApplicationArea = All;
                    Caption = 'Breed Type';
                    RunObject = page BreedTypeList;
                }
                action(EquipmentList)
                {
                    ApplicationArea = All;
                    Caption = 'Equipment';
                    RunObject = page EquipmentList;
                }
            }

            group(Documents)
            {
                action(MilkProduction)
                {
                    ApplicationArea = All;
                    Caption = 'Milk Production List';
                    RunObject = page "Milk Production List";
                }
                action(OEEData)
                {
                    ApplicationArea = All;
                    Caption = 'OEE';
                    RunObject = page "OEE Data List";
                }
            }
        }
        area(Processing) //I changed Embedding to Processing
        {
            action(eCowList)
            {
                ApplicationArea = All;
                Caption = 'Cow List';
                RunObject = Page CowList;
            }
            action(eBreedType)
            {
                ApplicationArea = All;
                Caption = 'Breed Type';
                RunObject = page BreedTypeList;
            }
            action(eEquipmentList)
            {
                ApplicationArea = All;
                Caption = 'Equipment';
                RunObject = page EquipmentList;
            }
            action(eMilkProduction)
            {
                ApplicationArea = All;
                Caption = 'Milk Production List';
                RunObject = page "Milk Production List";
            }
            action(eOEEData)
            {
                ApplicationArea = All;
                Caption = 'OEE';
                RunObject = page "OEE Data List";
            }
        }
    }
}