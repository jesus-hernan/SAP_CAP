using {com.logali as sch} from '../db/schema';

define service catProd {

    entity Products as
        select from sch.mod.Products {
            ID,
            Name,
            Description,
            ImageUrl,
            ReleaseDate,
            DiscontinuedDate,
            Price,
            Height,
            Width,
            Depth,
            ToUnitOfMeasure,
            ToCurrency,
            ToCategory,
            ToCategory.Name as Category,
            ToDimensionUnit,
            ToSalesData,
            ToSupplier,
            ToReviews
        };

}


//***** Test Definitions *****//
/* service servTest {
    entity SelProducts as projection on sch.SelProducts;
}  */
