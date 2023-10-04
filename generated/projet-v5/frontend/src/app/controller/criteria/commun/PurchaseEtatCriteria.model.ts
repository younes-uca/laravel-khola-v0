import {BaseCriteria} from 'src/app/zynerator/criteria/BaseCriteria.model';

export class PurchaseEtatCriteria  extends BaseCriteria  {

    public id: number;
    public code: string;
    public codeLike: string;
    public reference: string;
    public referenceLike: string;

}
