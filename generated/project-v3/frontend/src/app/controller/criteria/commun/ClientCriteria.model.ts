import {BaseCriteria} from 'src/app/zynerator/criteria/BaseCriteria.model';
import {ClientCategoryCriteria} from './ClientCategoryCriteria.model';

export class ClientCriteria  extends BaseCriteria  {

    public id: number;
    public fullName: string;
    public fullNameLike: string;
  public clientCategory: ClientCategoryCriteria ;
  public clientCategorys: Array<ClientCategoryCriteria> ;

}
