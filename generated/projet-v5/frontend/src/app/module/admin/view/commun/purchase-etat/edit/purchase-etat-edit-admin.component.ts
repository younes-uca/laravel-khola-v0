import {Component, OnInit, Input} from '@angular/core';


import {AbstractEditController} from 'src/app/zynerator/controller/AbstractEditController';

import {PurchaseEtatAdminService} from 'src/app/controller/service/admin/commun/PurchaseEtatAdmin.service';
import {PurchaseEtatDto} from 'src/app/controller/model/commun/PurchaseEtat.model';
import {PurchaseEtatCriteria} from 'src/app/controller/criteria/commun/PurchaseEtatCriteria.model';



@Component({
  selector: 'app-purchase-etat-edit-admin',
  templateUrl: './purchase-etat-edit-admin.component.html'
})
export class PurchaseEtatEditAdminComponent extends AbstractEditController<PurchaseEtatDto, PurchaseEtatCriteria, PurchaseEtatAdminService>   implements OnInit {


    private _validPurchaseEtatCode = true;
    private _validPurchaseEtatReference = true;




    constructor( private purchaseEtatService: PurchaseEtatAdminService ) {
        super(purchaseEtatService);
    }

    ngOnInit(): void {
    }


    public setValidation(value: boolean){
        this.validPurchaseEtatCode = value;
        this.validPurchaseEtatReference = value;
        }
    public validateForm(): void{
        this.errorMessages = new Array<string>();
        this.validatePurchaseEtatCode();
        this.validatePurchaseEtatReference();
    }
    public validatePurchaseEtatCode(){
        if (this.stringUtilService.isEmpty(this.item.code)) {
            this.errorMessages.push('Code non valide');
            this.validPurchaseEtatCode = false;
        } else {
            this.validPurchaseEtatCode = true;
        }
    }
    public validatePurchaseEtatReference(){
        if (this.stringUtilService.isEmpty(this.item.reference)) {
            this.errorMessages.push('Reference non valide');
            this.validPurchaseEtatReference = false;
        } else {
            this.validPurchaseEtatReference = true;
        }
    }






    get validPurchaseEtatCode(): boolean {
        return this._validPurchaseEtatCode;
    }
    set validPurchaseEtatCode(value: boolean) {
        this._validPurchaseEtatCode = value;
    }
    get validPurchaseEtatReference(): boolean {
        return this._validPurchaseEtatReference;
    }
    set validPurchaseEtatReference(value: boolean) {
        this._validPurchaseEtatReference = value;
    }

}
