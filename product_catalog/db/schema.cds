namespace com.logali;

using {
    cuid,
    managed
} from '@sap/cds/common';

type Name : String(20);
type Dec : Decimal(16, 2);

type Address {
    Street     : String;
    City       : String;
    State      : String(2);
    PostalCode : String(5);
    Country    : String(3);
}

context mod {
    entity Products : cuid, managed {
        Name             : localized Name;
        Description      : localized String;
        ImageUrl         : String;
        ReleaseDate      : DateTime;
        DiscontinuedDate : DateTime;
        Price            : Dec;
        Height           : type of Price;
        Width            : Decimal(16, 2);
        Depth            : Decimal(16, 2);
        Quantity         : Decimal(16, 2);
        ToUnitOfMeasure  : Association to UnitOfMeasures;
        ToCurrency       : Association to Currencies;
        ToDimensionUnit  : Association to DimensionUnits;
        ToSalesData      : Association to many tda.SalesData
                               on ToSalesData.ToProduct = $self;
        ToCategory       : Association to Categories;
        ToSupplier       : Association to Suppliers;
        ToReviews        : Association to many tda.ProductReviews
                               on ToReviews.ToProduct = $self;
    }

    entity Suppliers : cuid, managed {
        Name      : Products : Name;
        Address   : Address;
        Email     : String;
        Phone     : String;
        Fax       : String;
        ToProduct : Association to Products
                        on ToProduct.ToSupplier = $self;
    }

    entity Categories {
        key ID   : String(1);
            Name : type of Products : Name;
    }

    entity StockAvailability {
        key ID          : Integer;
            Description : localized String;
            ToProduct   : Association to Products
                              on ID = ID;
    }

    entity Currencies {
        key ID          : String(3);
            Description : localized String;
    }

    entity UnitOfMeasures {
        key ID          : String(2);
            Description : localized String;
    }

    entity DimensionUnits {
        key ID          : String(2);
            Description : localized String;
    }

    entity Months {
        key ID               : String(2);
            Description      : localized String;
            ShortDescription : localized String(3);
    }
}

context tda {
    entity ProductReviews : cuid, managed {
        Name      : Name;
        Rating    : Integer;
        Comment   : String;
        ToProduct : Association to mod.Products;
    }

    entity SalesData : cuid {
        DeliveryDate    : DateTime;
        Revenue         : Decimal(16, 2);
        ToProduct       : Association to mod.Products;
        ToCurrency      : Association to mod.Currencies;
        ToDeliveryMonth : Association to mod.Months;
    }
}

context view {
    entity AverageRating as
        select from tda.ProductReviews {
            ToProduct.ID as ProductId,
            avg(
                Rating
            )            as AverageRating : Decimal(16, 2)
        }
        group by
            ToProduct.ID;
}

//***** Test Definitions *****//
/* entity SelProducts                   as select from Products;

entity SelProducts1                  as
    select from Products {
        *
    }; */


/* entity SelProducts(p_name : String)  as
    select
        Name,
        Price,
        Quantity
    from Products
    where
        Name = : p_name;
*/


/* entity ProjProducts(p_name : String) as projection on Products where Name = : p_name;


extend ProjProducts with {
    ColumExtend  : String;
    ColumExtend1 : String;
    ColumExtend2 : String;
}


entity SelProducts3 as
    select from Products
    left join ProductReviews
        on Products.Name = ProductReviews.Name
    {
        Rating,
        Products.Name,
        sum(
            Price
        ) as TotalPrice
    }
    group by
        Rating,
        Products.Name
    order by
        Rating;
 */
/* entity Products4(p_name : String)    as projection on Products where Name = : p_name; */

/* entity Products5    as projection on Products {
    ReleaseDate, Name
}

entity Products6    as projection on Products {
    *
} */
/*
type EmailAddresses : many {
    kind    : String;
    address : String;
}

entity TestBar {
    emails : EmailAddress;
};

type EmailAddress : {
    kind    : String;
    address : String;
}

entity TestCar {
    emails : many EmailAddress;
};

type Gender : String enum {
    male;
    female;
}

entity Order {
    status : Integer enum {
        submitted = 1;
        fulfilled = 2;
        shipped   = 3;
        canceled  = -1;
    };
}

entity Cars {
    virtual colums : String(122);
}

entity Cars1 {
    Name           : Name;
    virtual colums : String(122);
    virtual colum1 : String;
}
*/


/*entity Orders {
    key ID    : Integer;
        Items : Composition of many Orders_Items
                    on Items.parent = $self;
}

entity Orders_Items {
    key OrderPosition : Integer;
    key parent        : Association to Orders;
        product       : Association to Products;
        quantity      : Integer;
} */


/* entity Orders {
    key ID    : Integer;
        Items : Composition of many {
                    key OrderPosition : Integer;
                        product       : Association to Products;
                        quantity      : Integer;
                }
} */
