import { Injectable } from '@angular/core';
import {HttpClient} from '@angular/common/http';
import {BehaviorSubject, Observable} from 'rxjs';

import { RoleService } from 'src/app/zynerator/security/Role.service';
import {environment} from 'src/environments/environment';

import {PurchaseItemDto} from 'src/app/controller/model/flos/PurchaseItem.model';
import {PurchaseItemCriteria} from 'src/app/controller/criteria/flos/PurchaseItemCriteria.model';
import {AbstractService} from 'src/app/zynerator/service/AbstractService';


@Injectable({
  providedIn: 'root'
})
export class PurchaseItemAdminService extends AbstractService<PurchaseItemDto, PurchaseItemCriteria> {
     constructor(private http: HttpClient, private roleService: RoleService) {
        super();
        this.setHttp(http);
        this.setApi(environment.apiUrl + 'admin/purchaseItem/');
    }

    public constrcutDto(): PurchaseItemDto {
        return new PurchaseItemDto();
    }

    public constrcutCriteria(): PurchaseItemCriteria {
        return new PurchaseItemCriteria();
    }
}
