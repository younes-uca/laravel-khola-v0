import { Injectable } from '@angular/core';
import {HttpClient} from '@angular/common/http';
import {BehaviorSubject, Observable} from 'rxjs';

import { RoleService } from 'src/app/zynerator/security/Role.service';
import {environment} from 'src/environments/environment';

import {PurchaseEtatDto} from 'src/app/controller/model/commun/PurchaseEtat.model';
import {PurchaseEtatCriteria} from 'src/app/controller/criteria/commun/PurchaseEtatCriteria.model';
import {AbstractService} from 'src/app/zynerator/service/AbstractService';


@Injectable({
  providedIn: 'root'
})
export class PurchaseEtatAdminService extends AbstractService<PurchaseEtatDto, PurchaseEtatCriteria> {
     constructor(private http: HttpClient, private roleService: RoleService) {
        super();
        this.setHttp(http);
        this.setApi(environment.apiUrl + 'admin/purchaseEtat/');
    }

    public constrcutDto(): PurchaseEtatDto {
        return new PurchaseEtatDto();
    }

    public constrcutCriteria(): PurchaseEtatCriteria {
        return new PurchaseEtatCriteria();
    }
}
