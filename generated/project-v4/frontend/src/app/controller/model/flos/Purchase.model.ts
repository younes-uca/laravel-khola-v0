import {BaseDto} from 'src/app/zynerator/dto/BaseDto.model';

import {PurchaseItemDto} from './PurchaseItem.model';
import {ClientDto} from '../commun/Client.model';

export class PurchaseDto extends BaseDto{

    public reference: string;

   public purchaseStartDate: Date;

   public purchaseEndDate: Date;

    public image: string;

   public etat: null | boolean;

    public total: null | number;

    public description: string;

    public client: ClientDto ;
     public purchaseItems: Array<PurchaseItemDto>;
    

    constructor() {
        super();

        this.reference = '';
        this.purchaseStartDate = null;
        this.purchaseEndDate = null;
        this.image = '';
        this.etat = null;
        this.total = null;
        this.description = '';
        this.client = new ClientDto() ;
        this.purchaseItems = new Array<PurchaseItemDto>();

        }

}
