import {Component, OnInit} from '@angular/core';
import {PurchaseEtatAdminService} from 'src/app/controller/service/admin/commun/PurchaseEtatAdmin.service';
import {PurchaseEtatDto} from 'src/app/controller/model/commun/PurchaseEtat.model';
import {PurchaseEtatCriteria} from 'src/app/controller/criteria/commun/PurchaseEtatCriteria.model';
import {AbstractListController} from 'src/app/zynerator/controller/AbstractListController';
import { environment } from 'src/environments/environment';



@Component({
  selector: 'app-purchase-etat-list-admin',
  templateUrl: './purchase-etat-list-admin.component.html'
})
export class PurchaseEtatListAdminComponent extends AbstractListController<PurchaseEtatDto, PurchaseEtatCriteria, PurchaseEtatAdminService>  implements OnInit {

    fileName = 'PurchaseEtat';



    constructor( private purchaseEtatService: PurchaseEtatAdminService  ) {
        super(purchaseEtatService);
    }

    ngOnInit(): void {
        this.findPaginatedByCriteria();
        this.initExport();
        this.initCol();
    }


    public initCol() {
        this.cols = [
            {field: 'code', header: 'Code'},
            {field: 'reference', header: 'Reference'},
        ];
    }





   public prepareColumnExport(): void {
        this.exportData = this.items.map(e => {
            return {
                 'Code': e.code ,
                 'Reference': e.reference ,
            }
        });

        this.criteriaData = [{
            'Code': this.criteria.code ? this.criteria.code : environment.emptyForExport ,
            'Reference': this.criteria.reference ? this.criteria.reference : environment.emptyForExport ,
        }];
      }
}
