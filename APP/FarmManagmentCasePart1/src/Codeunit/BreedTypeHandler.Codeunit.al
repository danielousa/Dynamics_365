codeunit 54100 BreedTypeHandler
{

    internal procedure SetLifeExpectancy(var BreedTypeRec: Record "BreedType")
    begin
        case BreedTypeRec.BreedName of
            BreedTypeRec.BreedName::HolsteinFriesian:
                BreedTypeRec.AverageLifeExpetancy := '2.5 - 4 years';
            BreedTypeRec.BreedName::Jersey:
                BreedTypeRec.AverageLifeExpetancy := '3 -5 years';
            BreedTypeRec.BreedName::Guernsey:
                BreedTypeRec.AverageLifeExpetancy := '2.5 - 4.5 years';
            BreedTypeRec.BreedName::BrownSwiss:
                BreedTypeRec.AverageLifeExpetancy := '3 - 6 years';
            BreedTypeRec.BreedName::Ayrshire:
                BreedTypeRec.AverageLifeExpetancy := '4 - 7 years';
            else
                BreedTypeRec.AverageLifeExpetancy := '';
        end;
    end;

    internal procedure SetBreedDescription(var BreedTypeRec: Record "BreedType")
    begin
        case BreedTypeRec.BreedName of
            BreedTypeRec.BreedName::HolsteinFriesian:
                BreedTypeRec.BreedDescription := 'The Holstein-Friesian is a dairy cattle breed from the Netherlands and northern Germany, renowned for its large size, distinctive coat, and exceptional milk production, though prone to some health issues.';
            BreedTypeRec.BreedName::Jersey:
                BreedTypeRec.BreedDescription := 'Originating from Jersey in the English Channel, the Jersey breed is smaller than Holsteins, with a coat ranging from light to dark brown, and is known for its expressive eyes, black snout, and high-quality milk rich in fat, protein, and calcium, making it ideal for premium dairy products like cheese and butter, while also being adaptable, docile, and useful for both dairy and meat production.';
            BreedTypeRec.BreedName::Guernsey:
                BreedTypeRec.BreedDescription := 'The Guernsey breed, originating from the island of Guernsey in the English Channel, is known for its high-quality, golden-colored milk rich in beta-carotene and protein, as well as its adaptability, longevity, and distinctive red-and-white or brown coat.';
            BreedTypeRec.BreedName::BrownSwiss:
                BreedTypeRec.BreedDescription := 'Originating in Switzerland, the Brown Swiss breed is valued for its adaptability, robustness, and longevity, producing milk with a balanced fat and protein content ideal for cheese, and is known for its feed efficiency and consistent production in diverse conditions.';
            BreedTypeRec.BreedName::Ayrshire:
                BreedTypeRec.BreedDescription := 'Originating from Scotland, the Ayrshire breed is a robust, red-and-white dairy cow known for its efficient milk production, low somatic cell count, easy calving, good longevity, and genetic disease resistance, making it highly valued for its balanced milk quality and adaptability.';
            else
                BreedTypeRec.BreedDescription := '';
        end;
    end;

    internal procedure SetMilkProperties(var BreedTypeRec: Record "BreedType")
    begin
        case BreedTypeRec.BreedName of
            BreedTypeRec.BreedName::HolsteinFriesian:
                BreedTypeRec.MilkProperties := '4.08% fat and 3.32% protein';
            BreedTypeRec.BreedName::Jersey:
                BreedTypeRec.MilkProperties := '5.16% fat and 3.90% protein';
            BreedTypeRec.BreedName::Guernsey:
                BreedTypeRec.MilkProperties := '4.69% fat and 3.51% protein';
            BreedTypeRec.BreedName::BrownSwiss:
                BreedTypeRec.MilkProperties := '4.24% fat and 3.57% protein';
            BreedTypeRec.BreedName::Ayrshire:
                BreedTypeRec.MilkProperties := '4.16% fat and 3.42% protein';
            else
                BreedTypeRec.MilkProperties := '';
        end;
    end;
}