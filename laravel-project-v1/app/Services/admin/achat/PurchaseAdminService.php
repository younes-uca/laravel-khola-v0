<?php

namespace App\Services\admin\achat;

use App\Models\achat\Purchase;
use App\Models\achat\PurchaseItem;
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

    public function deleteById($purchaseId)
    {
        return DB::transaction(function () use ($purchaseId) {
            $purchase = Purchase::findOrFail($purchaseId);

            $purchase->purchaseItems()->delete();

            $purchase->delete();

            return true;
        });
    }

    public function findAll()
    {
        return Purchase::all();
    }








}
