import {Component, OnInit} from '@angular/core';


import {AbstractViewController} from 'src/app/zynerator/controller/AbstractViewController';
import { environment } from 'src/environments/environment';

import {PurchaseAdminService} from 'src/app/controller/service/admin/flos/PurchaseAdmin.service';
import {PurchaseDto} from 'src/app/controller/model/flos/Purchase.model';
import {PurchaseCriteria} from 'src/app/controller/criteria/flos/PurchaseCriteria.model';

import {ProductDto} from 'src/app/controller/model/commun/Product.model';
import {ProductAdminService} from 'src/app/controller/service/admin/commun/ProductAdmin.service';
import {ClientDto} from 'src/app/controller/model/commun/Client.model';
import {ClientAdminService} from 'src/app/controller/service/admin/commun/ClientAdmin.service';
import {PurchaseEtatDto} from 'src/app/controller/model/commun/PurchaseEtat.model';
import {PurchaseEtatAdminService} from 'src/app/controller/service/admin/commun/PurchaseEtatAdmin.service';
import {PurchaseItemDto} from 'src/app/controller/model/flos/PurchaseItem.model';
import {PurchaseItemAdminService} from 'src/app/controller/service/admin/flos/PurchaseItemAdmin.service';
@Component({
  selector: 'app-purchase-view-admin',
  templateUrl: './purchase-view-admin.component.html'
})
export class PurchaseViewAdminComponent extends AbstractViewController<PurchaseDto, PurchaseCriteria, PurchaseAdminService> implements OnInit {

    purchaseItems = new PurchaseItemDto();
    purchaseItemss: Array<PurchaseItemDto> = [];

    constructor(private purchaseService: PurchaseAdminService, private productService: ProductAdminService, private clientService: ClientAdminService, private purchaseEtatService: PurchaseEtatAdminService, private purchaseItemService: PurchaseItemAdminService){
        super(purchaseService);
    }

    ngOnInit(): void {
    }


    get purchaseEtat(): PurchaseEtatDto {
       return this.purchaseEtatService.item;
    }
    set purchaseEtat(value: PurchaseEtatDto) {
        this.purchaseEtatService.item = value;
    }
    get purchaseEtats(): Array<PurchaseEtatDto> {
       return this.purchaseEtatService.items;
    }
    set purchaseEtats(value: Array<PurchaseEtatDto>) {
        this.purchaseEtatService.items = value;
    }
    get product(): ProductDto {
       return this.productService.item;
    }
    set product(value: ProductDto) {
        this.productService.item = value;
    }
    get products(): Array<ProductDto> {
       return this.productService.items;
    }
    set products(value: Array<ProductDto>) {
        this.productService.items = value;
    }
    get client(): ClientDto {
       return this.clientService.item;
    }
    set client(value: ClientDto) {
        this.clientService.item = value;
    }
    get clients(): Array<ClientDto> {
       return this.clientService.items;
    }
    set clients(value: Array<ClientDto>) {
        this.clientService.items = value;
    }


}
