import {Component, OnInit} from '@angular/core';


import {AbstractViewController} from 'src/app/zynerator/controller/AbstractViewController';
import { environment } from 'src/environments/environment';

import {PurchaseEtatAdminService} from 'src/app/controller/service/admin/commun/PurchaseEtatAdmin.service';
import {PurchaseEtatDto} from 'src/app/controller/model/commun/PurchaseEtat.model';
import {PurchaseEtatCriteria} from 'src/app/controller/criteria/commun/PurchaseEtatCriteria.model';

@Component({
  selector: 'app-purchase-etat-view-admin',
  templateUrl: './purchase-etat-view-admin.component.html'
})
export class PurchaseEtatViewAdminComponent extends AbstractViewController<PurchaseEtatDto, PurchaseEtatCriteria, PurchaseEtatAdminService> implements OnInit {


    constructor(private purchaseEtatService: PurchaseEtatAdminService){
        super(purchaseEtatService);
    }

    ngOnInit(): void {
    }




}
