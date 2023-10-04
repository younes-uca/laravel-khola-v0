import {Component, OnInit, Input} from '@angular/core';

import { AbstractCreateController } from 'src/app/zynerator/controller/AbstractCreateController';

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
  selector: 'app-purchase-create-admin',
  templateUrl: './purchase-create-admin.component.html'
})
export class PurchaseCreateAdminComponent extends AbstractCreateController<PurchaseDto, PurchaseCriteria, PurchaseAdminService>  implements OnInit {

    private _purchaseItemsElement = new PurchaseItemDto();


   private _validPurchaseReference = true;
    private _validPurchaseEtatCode = true;
    private _validPurchaseEtatReference = true;
    private _validClientFullName = true;
    private _validPurchaseItemsProduct = true;
    private _validPurchaseItemsPrice = true;
    private _validPurchaseItemsQuantity = true;

    constructor( private purchaseService: PurchaseAdminService , private productService: ProductAdminService, private clientService: ClientAdminService, private purchaseEtatService: PurchaseEtatAdminService, private purchaseItemService: PurchaseItemAdminService) {
        super(purchaseService);
    }

    ngOnInit(): void {
        this.purchaseItemsElement.product = new ProductDto();
        this.productService.findAll().subscribe((data) => this.products = data);
        this.purchaseEtat = new PurchaseEtatDto();
        this.purchaseEtatService.findAll().subscribe((data) => this.purchaseEtats = data);
        this.client = new ClientDto();
        this.clientService.findAll().subscribe((data) => this.clients = data);
    }



    validatePurchaseItems(){
        this.errorMessages = new Array();
        this.validatePurchaseItemsProduct();
        this.validatePurchaseItemsPrice();
        this.validatePurchaseItemsQuantity();
    }


    public setValidation(value: boolean){
        this.validPurchaseReference = value;
        this.validPurchaseItemsProduct = value;
        this.validPurchaseItemsPrice = value;
        this.validPurchaseItemsQuantity = value;
    }

    public addPurchaseItems() {
        if( this.item.purchaseItems == null )
            this.item.purchaseItems = new Array<PurchaseItemDto>();
       this.validatePurchaseItems();
       if (this.errorMessages.length === 0) {
              this.item.purchaseItems.push({... this.purchaseItemsElement});
              this.purchaseItemsElement = new PurchaseItemDto();
       }else{
            this.messageService.add({severity: 'error',summary: 'Erreurs',detail: 'Merci de corrigé les erreurs suivant : ' + this.errorMessages});
       }
    }


    public deletepurchaseItems(p: PurchaseItemDto) {
        this.item.purchaseItems.forEach((element, index) => {
            if (element === p) { this.item.purchaseItems.splice(index, 1); }
        });
    }

    public editpurchaseItems(p: PurchaseItemDto) {
        this.purchaseItemsElement = {... p};
        this.activeTab = 0;
    }


    public validateForm(): void{
        this.errorMessages = new Array<string>();
        this.validatePurchaseReference();
    }

    public validatePurchaseReference(){
        if (this.stringUtilService.isEmpty(this.item.reference)) {
        this.errorMessages.push('Reference non valide');
        this.validPurchaseReference = false;
        } else {
            this.validPurchaseReference = true;
        }
    }

    public validatePurchaseItemsProduct(){
        if (this.purchaseItemsElement.product == null) {
            this.errorMessages.push('Product de la purchaseItem est  invalide');
            this.validPurchaseItemsProduct = false;
        } else {
            this.validPurchaseItemsProduct = true;
        }
    }
    public validatePurchaseItemsPrice(){
        if (this.purchaseItemsElement.price == null) {
            this.errorMessages.push('Price de la purchaseItem est  invalide');
            this.validPurchaseItemsPrice = false;
        } else {
            this.validPurchaseItemsPrice = true;
        }
    }
    public validatePurchaseItemsQuantity(){
        if (this.purchaseItemsElement.quantity == null) {
            this.errorMessages.push('Quantity de la purchaseItem est  invalide');
            this.validPurchaseItemsQuantity = false;
        } else {
            this.validPurchaseItemsQuantity = true;
        }
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
    get createPurchaseEtatDialog(): boolean {
       return this.purchaseEtatService.createDialog;
    }
    set createPurchaseEtatDialog(value: boolean) {
        this.purchaseEtatService.createDialog= value;
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
    get createProductDialog(): boolean {
       return this.productService.createDialog;
    }
    set createProductDialog(value: boolean) {
        this.productService.createDialog= value;
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
    get createClientDialog(): boolean {
       return this.clientService.createDialog;
    }
    set createClientDialog(value: boolean) {
        this.clientService.createDialog= value;
    }



    get validPurchaseReference(): boolean {
        return this._validPurchaseReference;
    }

    set validPurchaseReference(value: boolean) {
         this._validPurchaseReference = value;
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
    get validClientFullName(): boolean {
        return this._validClientFullName;
    }
    set validClientFullName(value: boolean) {
        this._validClientFullName = value;
    }
    get validPurchaseItemsProduct(): boolean {
        return this._validPurchaseItemsProduct;
    }
    set validPurchaseItemsProduct(value: boolean) {
        this._validPurchaseItemsProduct = value;
    }
    get validPurchaseItemsPrice(): boolean {
        return this._validPurchaseItemsPrice;
    }
    set validPurchaseItemsPrice(value: boolean) {
        this._validPurchaseItemsPrice = value;
    }
    get validPurchaseItemsQuantity(): boolean {
        return this._validPurchaseItemsQuantity;
    }
    set validPurchaseItemsQuantity(value: boolean) {
        this._validPurchaseItemsQuantity = value;
    }

    get purchaseItemsElement(): PurchaseItemDto {
        if( this._purchaseItemsElement == null )
            this._purchaseItemsElement = new PurchaseItemDto();
        return this._purchaseItemsElement;
    }

    set purchaseItemsElement(value: PurchaseItemDto) {
        this._purchaseItemsElement = value;
    }

}
