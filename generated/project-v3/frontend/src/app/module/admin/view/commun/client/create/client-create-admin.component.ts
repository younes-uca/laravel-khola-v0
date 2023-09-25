import {Component, OnInit, Input} from '@angular/core';

import { AbstractCreateController } from 'src/app/zynerator/controller/AbstractCreateController';

import {ClientAdminService} from 'src/app/controller/service/admin/commun/ClientAdmin.service';
import {ClientDto} from 'src/app/controller/model/commun/Client.model';
import {ClientCriteria} from 'src/app/controller/criteria/commun/ClientCriteria.model';
import {ClientCategoryDto} from 'src/app/controller/model/commun/ClientCategory.model';
import {ClientCategoryAdminService} from 'src/app/controller/service/admin/commun/ClientCategoryAdmin.service';
@Component({
  selector: 'app-client-create-admin',
  templateUrl: './client-create-admin.component.html'
})
export class ClientCreateAdminComponent extends AbstractCreateController<ClientDto, ClientCriteria, ClientAdminService>  implements OnInit {



   private _validClientFullName = true;
    private _validClientCategoryReference = true;
    private _validClientCategoryCode = true;

    constructor( private clientService: ClientAdminService , private clientCategoryService: ClientCategoryAdminService) {
        super(clientService);
    }

    ngOnInit(): void {
        this.clientCategory = new ClientCategoryDto();
        this.clientCategoryService.findAll().subscribe((data) => this.clientCategorys = data);
    }





    public setValidation(value: boolean){
        this.validClientFullName = value;
    }



    public validateForm(): void{
        this.errorMessages = new Array<string>();
        this.validateClientFullName();
    }

    public validateClientFullName(){
        if (this.stringUtilService.isEmpty(this.item.fullName)) {
        this.errorMessages.push('Full name non valide');
        this.validClientFullName = false;
        } else {
            this.validClientFullName = true;
        }
    }


    public async openCreateClientCategory(clientCategory: string) {
    const isPermistted = await this.roleService.isPermitted('ClientCategory', 'add');
    if(isPermistted) {
         this.clientCategory = new ClientCategoryDto();
         this.createClientCategoryDialog = true;
    }else{
        this.messageService.add({
        severity: 'error', summary: 'erreur', detail: 'problème de permission'
        });
     }
    }

    get clientCategory(): ClientCategoryDto {
        return this.clientCategoryService.item;
    }
    set clientCategory(value: ClientCategoryDto) {
        this.clientCategoryService.item = value;
    }
    get clientCategorys(): Array<ClientCategoryDto> {
        return this.clientCategoryService.items;
    }
    set clientCategorys(value: Array<ClientCategoryDto>) {
        this.clientCategoryService.items = value;
    }
    get createClientCategoryDialog(): boolean {
       return this.clientCategoryService.createDialog;
    }
    set createClientCategoryDialog(value: boolean) {
        this.clientCategoryService.createDialog= value;
    }



    get validClientFullName(): boolean {
        return this._validClientFullName;
    }

    set validClientFullName(value: boolean) {
         this._validClientFullName = value;
    }

    get validClientCategoryReference(): boolean {
        return this._validClientCategoryReference;
    }
    set validClientCategoryReference(value: boolean) {
        this._validClientCategoryReference = value;
    }
    get validClientCategoryCode(): boolean {
        return this._validClientCategoryCode;
    }
    set validClientCategoryCode(value: boolean) {
        this._validClientCategoryCode = value;
    }


}
