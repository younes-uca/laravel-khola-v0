<?php

namespace App\Services\admin;

use App\Models\PurchaseItem;

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
