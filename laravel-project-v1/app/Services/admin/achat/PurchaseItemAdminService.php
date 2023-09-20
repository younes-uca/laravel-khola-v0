<?php

namespace App\Services\admin\achat;

use App\Models\achat\PurchaseItem;

class PurchaseItemAdminService
{

    public function save($data)
    {
        $purchaseItem = new PurchaseItem($data);
        $purchaseItem->save();

        return $purchaseItem;
    }



    public function findAll()
    {
        return PurchaseItem::all();
    }

    public function deleteById($purchaseItemId): bool
    {
        $purchaseItem = PurchaseItem::find($purchaseItemId);

        if (!$purchaseItem) {
            return false;
        }

        $purchaseItem->delete();
        return true;
    }





}
