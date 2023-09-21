<?php

namespace App\Services\admin\achat;

use App\Models\achat\PurchaseItem;
use Illuminate\Support\Facades\DB;

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


    public function deleteById($id): bool
    {
        return DB::transaction(function () use ($id) {
            $item = PurchaseItem::findOrFail($id);
            $item->delete();
            return true;
        });
    }



}
