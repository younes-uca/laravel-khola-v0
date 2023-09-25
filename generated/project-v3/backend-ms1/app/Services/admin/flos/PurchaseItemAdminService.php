<?php

namespace App\Services\admin\flos;

use Illuminate\Support\Facades\DB;
use App\Models\flos\PurchaseItem;
use App\Models\commun\Product;
use App\Models\flos\Purchase;

class PurchaseItemAdminService
{

    public function save($item,        ) {
        return DB::transaction(function () use ($item,      ) {
            $savedItem = new PurchaseItem($item);
            $savedItem->save();


            return $savedItem;
        });
    }

    public function deleteById($id) {
        return DB::transaction(function () use ($id) {
            $item = PurchaseItem::findOrFail($id);


            $item->delete();
            return true;
        });
    }

    public function findAll() {
        return PurchaseItem::all();
    }

}
