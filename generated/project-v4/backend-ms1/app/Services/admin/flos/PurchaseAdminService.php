<?php

namespace App\Services\admin\flos;

use Illuminate\Support\Facades\DB;
use App\Models\flos\Purchase;
use App\Models\flos\PurchaseItem;
use App\Models\commun\Client;
use App\Models\commun\Product;

class PurchaseAdminService
{

    public function save($item,          $purchaseItems, ) {
        return DB::transaction(function () use ($item,           $purchaseItems, ) {
            $savedItem = new Purchase($item);
            $savedItem->save();

            $savedPurchaseItems = [];
            foreach ($purchaseItems as $element) {
                $purchaseItem = new PurchaseItem($element);
                $savedPurchaseItems[] = $purchaseItem;
            }
            $savedItem->purchaseItems()->saveMany($savedPurchaseItems);

            return $savedItem;
        });
    }

    public function deleteById($id) {
        return DB::transaction(function () use ($id) {
            $item = Purchase::findOrFail($id);

            $item->purchaseItems()->delete();

            $item->delete();
            return true;
        });
    }

    public function findAll() {
        return Purchase::all();
    }

    public function findByClientId($id) {
        return Purchase::where('client', $id)->get();
    }

    public function deleteByClientId($id) {
        $items = Purchase::where('client_id', $id)->get();
        $count = 0;
        foreach ($items as $element ){
            $element->purchaseItems->each(function ($elementItem) {
                $elementItem->delete();
            });
            $element->delete();
            $count++;
        }
        return $count;
    }


    public function findWithAssociatedLists($id) {
        return Purchase::with(['id','reference','purchaseStartDate','purchaseEndDate','image','etat','total','description','client','purchaseItems',])->find($id);
    }

}
