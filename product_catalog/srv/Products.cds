using {com.logali as sch} from '../db/schema';

define service catProd {

    entity Products          as
        select from sch.view.Products {
            ID,
            Name                        @mandatory,
            Description                 @mandatory,
            ImageUrl,
            ReleaseDate,
            DiscontinuedDate,
            Rating, 
            Price                       @mandatory,
            Height,
            Width,
            Depth,
            Quantity                    @(
                mandatory,
                assert.range : [
                0.00,
                20.00
                ]
            ),
            ToUnitOfMeasure             @mandatory,
            ToCurrency                  @mandatory,
            ToCategory                  @mandatory,
            ToCategory.Name as Category @readonly,
            ToDimensionUnit,
            ToSalesData,
            ToStockAvailability,
            StockAvailability,
            ToSupplier,
            ToReviews
        };

    @readonly
    entity Suppliers         as
        select from sch.mod.Suppliers {
            ID,
            Name,
            Email,
            Phone,
            Fax,
            ToProduct
        };

    @readonly
    entity Reviews           as
        select from sch.tda.ProductReviews {
            ID,
            Name,
            Rating,
            Comment,
            createdAt,
            ToProduct
        };

    @readonly
    entity SalesData         as
        select from sch.tda.SalesData {
            ID,
            DeliveryDate,
            Revenue,
            ToCurrency.ID               as CurrencyKey,
            ToDeliveryMonth.ID          as DeliveryMonthId,
            ToDeliveryMonth.Description as DeliveryMonth,
            ToProduct
        };

    @readonly
    entity StockAvailability as
        select from sch.mod.StockAvailability {
            ID,
            Description,
            ToProduct
        };

    @readonly
    entity VH_Categories     as
        select from sch.mod.Categories {
            ID   as Code,
            Name as Text
        };

    @readonly
    entity VH_Currencies     as
        select from sch.mod.Currencies {
            ID          as Code,
            Description as Text
        };

    @readonly
    entity VH_UnitOfMeasures as
        select from sch.mod.UnitOfMeasures {
            ID          as Code,
            Description as Text
        };

    @readonly
    entity VH_DimensionUnits as
        select from sch.mod.DimensionUnits {
            ID          as Code,
            Description as Text
        };
}


//***** Test Definitions *****//
/* service servTest {

    entity infix         as
        select ToSupplier[Name = 'Tokyo Traders'].Phone from sch.mod.Products
        where
            Products.Name = 'DVD Player';

    entity entityJoin    as
        select
            Phone,
            cast(
                Price as Integer
            ) as Price
        from sch.mod.Products
        inner join sch.mod.Suppliers supp
            on(
                supp.ID = Products.ID
            )
            and (
                supp.Name = 'Tokyo Traders'
            )
        where
            Products.Name = 'DVD Player';

    entity NavEntities   as
        select
            ToSupplier.Email,
            ToCategory.Name,
            ToSalesData.ToCurrency.Description
        from sch.mod.Products;

    entity SuppProducts1 as
        select from sch.mod.Products[Name = 'DVD Player'
    ]{
        *,
        Name,
        Price as Price : Integer,
        Description,
        ToSupplier.Address
    }
    where
        ToSupplier.Address.PostalCode = 1500;

    entity SuppProducts  as
        select
            Name,
            ToSupplier.Address
        from sch.mod.Products;
 */

/*    entity SelProducts as projection on sch.SelProducts;
}  */

/* service servTest {
    view VH_DimensionUnits( p_id : String) as
        select
            ID          as Code,
            Description as Text
        from sch.mod.DimensionUnits

        where
            ID = : p_id;
}*/
