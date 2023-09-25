import {Component, OnInit} from '@angular/core';


import {AbstractViewController} from 'src/app/zynerator/controller/AbstractViewController';
import { environment } from 'src/environments/environment';

import {ProductAdminService} from 'src/app/controller/service/admin/commun/ProductAdmin.service';
import {ProductDto} from 'src/app/controller/model/commun/Product.model';
import {ProductCriteria} from 'src/app/controller/criteria/commun/ProductCriteria.model';

@Component({
  selector: 'app-product-view-admin',
  templateUrl: './product-view-admin.component.html'
})
export class ProductViewAdminComponent extends AbstractViewController<ProductDto, ProductCriteria, ProductAdminService> implements OnInit {


    constructor(private productService: ProductAdminService){
        super(productService);
    }

    ngOnInit(): void {
    }




}
