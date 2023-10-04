import {BaseCriteria} from 'src/app/zynerator/criteria/BaseCriteria.model';
import {ProductCriteria} from '../commun/ProductCriteria.model';
import {PurchaseCriteria} from './PurchaseCriteria.model';

export class PurchaseItemCriteria  extends BaseCriteria  {

    public id: number;
     public price: number;
     public priceMin: number;
     public priceMax: number;
     public quantity: number;
     public quantityMin: number;
     public quantityMax: number;
  public product: ProductCriteria ;
  public products: Array<ProductCriteria> ;
  public purchase: PurchaseCriteria ;
  public purchases: Array<PurchaseCriteria> ;

}
