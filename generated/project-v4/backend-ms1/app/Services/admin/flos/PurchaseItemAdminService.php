<?php

namespace App\Services\admin\flos;

use Illuminate\Support\Facades\DB;
use App\Models\flos\PurchaseItem;
use App\Models\flos\Purchase;
use App\Models\commun\Product;

class PurchaseItemAdminService
{

    public function save($item,     ) {
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

    public function findByProductId($id) {
        return PurchaseItem::where('product', $id)->get();
    }

    public function deleteByProductId($id) {
        $items = PurchaseItem::where('product_id', $id)->get();
        $count = 0;
        foreach ($items as $element ){
            $element->delete();
            $count++;
        }
        return $count;
    }
    public function findByPurchaseId($id) {
        return PurchaseItem::where('purchase', $id)->get();
    }

    public function deleteByPurchaseId($id) {
        $items = PurchaseItem::where('purchase_id', $id)->get();
        $count = 0;
        foreach ($items as $element ){
            $element->delete();
            $count++;
        }
        return $count;
    }



}
