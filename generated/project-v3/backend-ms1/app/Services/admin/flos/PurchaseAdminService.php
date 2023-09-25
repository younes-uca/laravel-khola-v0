<?php

namespace App\Services\admin\flos;

use Illuminate\Support\Facades\DB;
use App\Models\flos\Purchase;
use App\Models\commun\Client;
use App\Models\commun\Product;
use App\Models\flos\PurchaseItem;

class PurchaseAdminService
{

    public function save($item,             $purchaseItems, ) {
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

}
