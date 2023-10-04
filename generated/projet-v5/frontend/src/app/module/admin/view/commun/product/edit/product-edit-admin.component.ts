import {Component, OnInit, Input} from '@angular/core';


import {AbstractEditController} from 'src/app/zynerator/controller/AbstractEditController';

import {ProductAdminService} from 'src/app/controller/service/admin/commun/ProductAdmin.service';
import {ProductDto} from 'src/app/controller/model/commun/Product.model';
import {ProductCriteria} from 'src/app/controller/criteria/commun/ProductCriteria.model';



@Component({
  selector: 'app-product-edit-admin',
  templateUrl: './product-edit-admin.component.html'
})
export class ProductEditAdminComponent extends AbstractEditController<ProductDto, ProductCriteria, ProductAdminService>   implements OnInit {


    private _validProductCode = true;
    private _validProductReference = true;




    constructor( private productService: ProductAdminService ) {
        super(productService);
    }

    ngOnInit(): void {
    }


    public setValidation(value: boolean){
        this.validProductCode = value;
        this.validProductReference = value;
        }
    public validateForm(): void{
        this.errorMessages = new Array<string>();
        this.validateProductCode();
        this.validateProductReference();
    }
    public validateProductCode(){
        if (this.stringUtilService.isEmpty(this.item.code)) {
            this.errorMessages.push('Code non valide');
            this.validProductCode = false;
        } else {
            this.validProductCode = true;
        }
    }
    public validateProductReference(){
        if (this.stringUtilService.isEmpty(this.item.reference)) {
            this.errorMessages.push('Reference non valide');
            this.validProductReference = false;
        } else {
            this.validProductReference = true;
        }
    }






    get validProductCode(): boolean {
        return this._validProductCode;
    }
    set validProductCode(value: boolean) {
        this._validProductCode = value;
    }
    get validProductReference(): boolean {
        return this._validProductReference;
    }
    set validProductReference(value: boolean) {
        this._validProductReference = value;
    }

}
