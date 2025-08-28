namespace FarmManagement.FarmManagement;
permissionset 54100 FarmManagement
{
    Assignable = true;
    Caption = 'FarmManagement', MaxLength = 30;
    Permissions =
        tabledata BreedType = RIMD,
        tabledata Cow = RIMD,
        tabledata "Milk Production Header" = RIMD,
        tabledata "Milk Production Line" = RIMD,
        table BreedType = X,
        table Cow = X,
        table "Milk Production Header" = X,
        table "Milk Production Line" = X,
        codeunit BreedTypeHandler = X,
        codeunit CowHandler = X,
        codeunit Install = X,
        codeunit "Milk Production Helper" = X,
        codeunit Upgrade = X,
        page BreedPicture = X,
        page BreedTypeCard = X,
        page BreedTypeList = X,
        page CowCard = X,
        page CowList = X,
        page "Farm Management RoleCenter" = X,
        page "Milk Production Document" = X,
        page "Milk Production Line List " = X,
        page "Milk Production List" = X,
        page "Milk Production Subpage" = X;
}