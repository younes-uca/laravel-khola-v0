import {BaseDto} from 'src/app/zynerator/dto/BaseDto.model';

import {ClientDto} from '../commun/Client.model';
import {PurchaseEtatDto} from '../commun/PurchaseEtat.model';
import {PurchaseItemDto} from './PurchaseItem.model';

export class PurchaseDto extends BaseDto{

    public reference: string;

   public purchaseStartDate: Date;

   public purchaseEndDate: Date;

    public image: string;

    public total: null | number;

    public description: string;

    public purchaseEtat: PurchaseEtatDto ;
    public client: ClientDto ;
     public purchaseItems: Array<PurchaseItemDto>;
    

    constructor() {
        super();

        this.reference = '';
        this.purchaseStartDate = null;
        this.purchaseEndDate = null;
        this.image = '';
        this.total = null;
        this.description = '';
        this.purchaseEtat = new PurchaseEtatDto() ;
        this.client = new ClientDto() ;
        this.purchaseItems = new Array<PurchaseItemDto>();

        }

}
