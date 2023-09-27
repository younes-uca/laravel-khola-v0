import {BaseDto} from 'src/app/zynerator/dto/BaseDto.model';


export class ClientCategoryDto extends BaseDto{

    public reference: string;

    public code: string;

    

    constructor() {
        super();

        this.reference = '';
        this.code = '';

        }

}
