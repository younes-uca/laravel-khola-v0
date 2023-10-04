import {Component, OnInit, ChangeDetectorRef, ViewChild} from '@angular/core';
import {PurchaseAdminService} from 'src/app/controller/service/admin/flos/PurchaseAdmin.service';
import {PurchaseDto} from 'src/app/controller/model/flos/Purchase.model';
import {PurchaseCriteria} from 'src/app/controller/criteria/flos/PurchaseCriteria.model';
import {AbstractListController} from 'src/app/zynerator/controller/AbstractListController';
import { environment } from 'src/environments/environment';

import {ProductDto} from 'src/app/controller/model/commun/Product.model';
import {ProductAdminService} from 'src/app/controller/service/admin/commun/ProductAdmin.service';
import {ClientDto} from 'src/app/controller/model/commun/Client.model';
import {ClientAdminService} from 'src/app/controller/service/admin/commun/ClientAdmin.service';
import {PurchaseEtatDto} from 'src/app/controller/model/commun/PurchaseEtat.model';
import {PurchaseEtatAdminService} from 'src/app/controller/service/admin/commun/PurchaseEtatAdmin.service';
import {PurchaseItemDto} from 'src/app/controller/model/flos/PurchaseItem.model';
import {PurchaseItemAdminService} from 'src/app/controller/service/admin/flos/PurchaseItemAdmin.service';

import {CalendarOptions, EventClickArg} from '@fullcalendar/core';
import dayGridPlugin from '@fullcalendar/daygrid';
import timeGridPlugin from '@fullcalendar/timegrid';
import interactionPlugin from '@fullcalendar/interaction';
import {FullCalendarComponent} from '@fullcalendar/angular';
import {ScheduleDto} from 'src/app/zynerator/dto/ScheduleDto.model';

@Component({
  selector: 'app-purchase-list-admin',
  templateUrl: './purchase-list-admin.component.html'
})
export class PurchaseListAdminComponent extends AbstractListController<PurchaseDto, PurchaseCriteria, PurchaseAdminService>  implements OnInit {

    fileName = 'Purchase';

    purchaseEtats: Array<PurchaseEtatDto>;
    clients: Array<ClientDto>;
    schedules: ScheduleDto[];
    schedule = new ScheduleDto();

    public events: Array<any> = new Array<any>();

    @ViewChild('calendar') calendarComponent: FullCalendarComponent;
    showEditDialogContent = false ;
    createDialogVisible = false;
    calendarOptions: CalendarOptions = {
        plugins: [timeGridPlugin, dayGridPlugin, interactionPlugin],
        headerToolbar: {
            left: 'prev,today,next',
            center: 'title',
            right: 'dayGridMonth,timeGridWeek,timeGridDay,listWeek'
        },
        slotLabelFormat: {
            hour: '2-digit',
            minute: '2-digit',
            omitZeroMinute: false,
            hour12: false,
        },
        initialView: 'timeGridWeek',
        weekends: true,
        editable: true, // Enable event dragging
        eventResizableFromStart: true, // Enable resizing from the start
        selectable: true,
        selectMirror: true,
        dayMaxEvents: true,
        datesSet: (info) => {
            const start = info.start;
            const end = info.end;
            this.handleDateSet(start, end);
        },
        eventClick: this.handleEventClick.bind(this),
        dateClick: this.handleDateClick.bind(this),
    };



    constructor( private purchaseService: PurchaseAdminService  , private changeDetectorRef: ChangeDetectorRef  , private productService: ProductAdminService, private clientService: ClientAdminService, private purchaseEtatService: PurchaseEtatAdminService, private purchaseItemService: PurchaseItemAdminService) {
        super(purchaseService);
        this.pdfName = 'Purchase.pdf';
    }

    ngOnInit(): void {
        this.findPaginatedByCriteria();
        this.initExport();
        this.initCol();
        this.loadPurchaseEtat();
        this.loadClient();
    }


  update() {
        this.service.edit().subscribe(data => {
            const myIndex = this.items.findIndex(e => e.id === this.item.id);
            this.items[myIndex] = data;
            this.editDialog = false;
            this.item = this.service.constrcutDto();
            const event = {
            };
            this.calendarComponent.getApi().addEvent(event);
            this.calendarComponent.getApi().refetchEvents(); // Refresh the calendar
            this.changeDetectorRef.markForCheck();
        } , error => {
            console.log(error);
        });
  }

    public save() {
        this.service.save().subscribe(item => {
            if (item != null) {
                this.items.push({...item});
                this.createDialog = false;
                this.item = this.service.constrcutDto();
                const event = {
                };
                this.calendarComponent.getApi().addEvent(event);
                this.calendarComponent.getApi().refetchEvents(); // Refresh the calendar
                this.changeDetectorRef.markForCheck();
            } else {
                this.messageService.add({severity: 'error', summary: 'Erreurs', detail: 'Element existant'});
            }
        }, error => {
            console.log(error);
        });
    }

// add

  private handleDateSet(start: Date, end: Date) {
        const startDate = new Date(start).toISOString().replace('Z', '');
        const endDate = new Date(end).toISOString().replace('Z', '');
        this.service.findSchedule(startDate, endDate)
            .subscribe(response => {
                this.schedules = response;
                this.updateFullCalendarEvents();
            });
        console.log('schedules', this.schedules);
    }
    updateFullCalendarEvents(viewType: string = 'timeGridWeek'): void {
        this.calendarOptions.initialView = viewType;
        this.events = this.schedules.map((item) => ({
            id: item.id,
            title: item.subject,
            start: new Date(item.startTime),
            end: new Date(item.endTime),
        }));
        this.calendarOptions.events = this.events;
        this.calendarComponent.getApi().refetchEvents();
    }

    handleDateClick(info: any) {
        const clickedDate = info.date;
        this.createDialog = true;
        this.createDialogVisible = true;
        this.calendarComponent.getApi().refetchEvents();
        this.changeDetectorRef.markForCheck();
    }

    handleEventClick(clickInfo: EventClickArg) {
        const eventTitle = clickInfo.event.title;
        const clickedDate = clickInfo.event.start;
        const itemIndex = this.schedules.findIndex(item => item.subject === eventTitle);
        if (itemIndex !== -1) {
            this.item.id = Number(clickInfo.event.id);

            this.showEditDialogContent = true;
            this.editDialog = true;
        }
        this.calendarComponent.getApi().refetchEvents();
        this.changeDetectorRef.markForCheck();
    }






    public initCol() {
        this.cols = [
            {field: 'reference', header: 'Reference'},
            {field: 'purchaseStartDate', header: 'Purchase start date'},
            {field: 'purchaseEndDate', header: 'Purchase end date'},
            {field: 'image', header: 'Image'},
            {field: 'purchaseEtat?.reference', header: 'Purchase etat'},
            {field: 'total', header: 'Total'},
            {field: 'client?.fullName', header: 'Client'},
        ];
    }


    public async loadPurchaseEtat(){
       this.purchaseEtatService.findAllOptimized().subscribe(purchaseEtats => this.purchaseEtats = purchaseEtats, error => console.log(error))
    }
    public async loadClient(){
       this.clientService.findAllOptimized().subscribe(clients => this.clients = clients, error => console.log(error))
    }

	public initDuplicate(res: PurchaseDto) {
        if (res.purchaseItems != null) {
             res.purchaseItems.forEach(d => { d.purchase = null; d.id = null; });
        }
	}


   public prepareColumnExport(): void {
        this.exportData = this.items.map(e => {
            return {
                 'Reference': e.reference ,
                'Purchase start date': this.datePipe.transform(e.purchaseStartDate , 'dd/MM/yyyy hh:mm'),
                'Purchase end date': this.datePipe.transform(e.purchaseEndDate , 'dd/MM/yyyy hh:mm'),
                 'Image': e.image ,
                'Purchase etat': e.purchaseEtat?.reference ,
                 'Total': e.total ,
                 'Description': e.description ,
                'Client': e.client?.fullName ,
            }
        });

        this.criteriaData = [{
            'Reference': this.criteria.reference ? this.criteria.reference : environment.emptyForExport ,
            'Purchase start date Min': this.criteria.purchaseStartDateFrom ? this.datePipe.transform(this.criteria.purchaseStartDateFrom , this.dateFormat) : environment.emptyForExport ,
            'Purchase start date Max': this.criteria.purchaseStartDateTo ? this.datePipe.transform(this.criteria.purchaseStartDateTo , this.dateFormat) : environment.emptyForExport ,
            'Purchase end date Min': this.criteria.purchaseEndDateFrom ? this.datePipe.transform(this.criteria.purchaseEndDateFrom , this.dateFormat) : environment.emptyForExport ,
            'Purchase end date Max': this.criteria.purchaseEndDateTo ? this.datePipe.transform(this.criteria.purchaseEndDateTo , this.dateFormat) : environment.emptyForExport ,
            'Image': this.criteria.image ? this.criteria.image : environment.emptyForExport ,
        //'Purchase etat': this.criteria.purchaseEtat?.reference ? this.criteria.purchaseEtat?.reference : environment.emptyForExport ,
            'Total Min': this.criteria.totalMin ? this.criteria.totalMin : environment.emptyForExport ,
            'Total Max': this.criteria.totalMax ? this.criteria.totalMax : environment.emptyForExport ,
            'Description': this.criteria.description ? this.criteria.description : environment.emptyForExport ,
        //'Client': this.criteria.client?.fullName ? this.criteria.client?.fullName : environment.emptyForExport ,
        }];
      }
}
