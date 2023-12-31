
// const root = environment.rootAppUrl;

import { NgModule } from '@angular/core';
import { RouterModule } from '@angular/router';
import { AuthGuard } from 'src/app/controller/guards/auth.guard';



import { PurchaseEtatListAdminComponent } from './purchase-etat/list/purchase-etat-list-admin.component';
import { ProductListAdminComponent } from './product/list/product-list-admin.component';
import { ClientCategoryListAdminComponent } from './client-category/list/client-category-list-admin.component';
import { ClientListAdminComponent } from './client/list/client-list-admin.component';
@NgModule({
    imports: [
        RouterModule.forChild(
            [
                {
                    path: '',
                    children: [


                        {

                            path: 'purchase-etat',
                            children: [
                                {
                                    path: 'list',
                                    component: PurchaseEtatListAdminComponent ,
                                    canActivate: [AuthGuard]
                                }
                            ]
                        },

                        {

                            path: 'product',
                            children: [
                                {
                                    path: 'list',
                                    component: ProductListAdminComponent ,
                                    canActivate: [AuthGuard]
                                }
                            ]
                        },

                        {

                            path: 'client-category',
                            children: [
                                {
                                    path: 'list',
                                    component: ClientCategoryListAdminComponent ,
                                    canActivate: [AuthGuard]
                                }
                            ]
                        },

                        {

                            path: 'client',
                            children: [
                                {
                                    path: 'list',
                                    component: ClientListAdminComponent ,
                                    canActivate: [AuthGuard]
                                }
                            ]
                        },

                    ]
                },
            ]
        ),
    ],
    exports: [RouterModule],
})
export class CommunAdminRoutingModule { }
