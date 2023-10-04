<?php

namespace App\Services\admin\flos;

use Illuminate\Support\Facades\DB;
use App\Models\flos\Purchase;
use App\Models\flos\PurchaseItem;
use App\Models\commun\Product;
use App\Models\commun\Client;
use App\Models\commun\PurchaseEtat;

class PurchaseAdminService
{

    public function save($item,$purchaseItems, ) {
        return DB::transaction(function () use ($item,$purchaseItems, ) {
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

    public function findByPurchaseEtatId($id) {
        return Purchase::where('purchaseEtat_id', $id)->get();
    }

    public function deleteByPurchaseEtatId($id) {
        $items = Purchase::where('purchaseEtat_id', $id)->get();
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
    public function findByClientId($id) {
        return Purchase::where('client_id', $id)->get();
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
        return Purchase::with(['purchaseItems',])->find($id);
    }


    public function findById($id) {
        return Purchase::find($id);
    }
}
