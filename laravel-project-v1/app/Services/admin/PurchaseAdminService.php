<?php

namespace App\Services\admin;

use App\Models\Purchase;
use App\Models\PurchaseItem;
use Illuminate\Support\Facades\DB;

class PurchaseAdminService
{

    public function save($purchaseData, $purchaseItemsData)
    {
        return DB::transaction(function () use ($purchaseData, $purchaseItemsData) {
            $purchase = new Purchase($purchaseData);

            $purchase->save();

            $purchaseItems = [];
            foreach ($purchaseItemsData as $itemData) {
                $purchaseItem = new PurchaseItem($itemData);
                $purchaseItems[] = $purchaseItem;
            }

            $purchase->purchaseItems()->saveMany($purchaseItems);

            return $purchase;
        });
    }



    public function findAll()
    {
        return Purchase::all();
    }

    public function deleteById($productId): bool
    {
        $product = Purchase::find($productId);

        if (!$product) {
            return false;
        }

        $product->delete();
        return true;
    }






}
