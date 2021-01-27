using {com.logali as sch} from '../db/schema';

define service catProd {
    entity Products  as projection on sch.Products;
    entity Suppliers as projection on sch.Suppliers;
}


//***** Test Definitions *****//
/* service servTest {
    entity SelProducts as projection on sch.SelProducts;
}  */
