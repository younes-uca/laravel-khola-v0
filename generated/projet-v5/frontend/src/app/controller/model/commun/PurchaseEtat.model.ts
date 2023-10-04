import {BaseDto} from 'src/app/zynerator/dto/BaseDto.model';


export class PurchaseEtatDto extends BaseDto{

    public code: string;

    public reference: string;

    

    constructor() {
        super();

        this.code = '';
        this.reference = '';

        }

}
