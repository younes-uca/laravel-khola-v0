<?php

namespace App\Services\admin\achat;

use App\Models\achat\Purchase;
use App\Models\achat\PurchaseItem;
use Illuminate\Support\Facades\DB;

class PurchaseAdminService
{

    public function save($item, $purchaseItems)
    {
        return DB::transaction(function () use ($item, $purchaseItems) {
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

    public function deleteById($id)
    {
        return DB::transaction(function () use ($id) {
            $item = Purchase::findOrFail($id);

            $item->purchaseItems()->delete();

            $item->delete();

            return true;
        });
    }

    public function findAll()
    {
        return Purchase::all();
    }








}
