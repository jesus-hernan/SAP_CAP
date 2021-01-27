using {com.logali as sch} from '../db/schema';

define service catProd {
    entity Products   as projection on sch.Products;
    entity Suppliers  as projection on sch.Suppliers;
    entity Currencies as projection on sch.Currencies;
}


//***** Test Definitions *****//
/* service servTest {
    entity SelProducts as projection on sch.SelProducts;
}  */
