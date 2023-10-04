import {BaseCriteria} from 'src/app/zynerator/criteria/BaseCriteria.model';
import {ClientCriteria} from '../commun/ClientCriteria.model';
import {PurchaseEtatCriteria} from '../commun/PurchaseEtatCriteria.model';
import {PurchaseItemCriteria} from './PurchaseItemCriteria.model';

export class PurchaseCriteria  extends BaseCriteria  {

    public id: number;
    public reference: string;
    public referenceLike: string;
    public purchaseStartDate: Date;
    public purchaseStartDateFrom: Date;
    public purchaseStartDateTo: Date;
    public purchaseEndDate: Date;
    public purchaseEndDateFrom: Date;
    public purchaseEndDateTo: Date;
    public image: string;
    public imageLike: string;
     public total: number;
     public totalMin: number;
     public totalMax: number;
    public description: string;
    public descriptionLike: string;
  public purchaseEtat: PurchaseEtatCriteria ;
  public purchaseEtats: Array<PurchaseEtatCriteria> ;
  public client: ClientCriteria ;
  public clients: Array<ClientCriteria> ;
      public purchaseItems: Array<PurchaseItemCriteria>;

}
