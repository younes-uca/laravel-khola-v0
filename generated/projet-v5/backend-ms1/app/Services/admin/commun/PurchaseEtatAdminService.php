<?php

namespace App\Services\admin\commun;

use Illuminate\Support\Facades\DB;
use App\Models\commun\PurchaseEtat;

class PurchaseEtatAdminService
{

    public function save($item,) {
        return DB::transaction(function () use ($item,) {
            $savedItem = new PurchaseEtat($item);
            $savedItem->save();


            return $savedItem;
        });
    }

    public function deleteById($id) {
        return DB::transaction(function () use ($id) {
            $item = PurchaseEtat::findOrFail($id);


            $item->delete();
            return true;
        });
    }

    public function findAll() {
        return PurchaseEtat::all();
    }




    public function findAllOptimized() {
        return PurchaseEtat::select('id', 'reference')->get();
    }

    public function findById($id) {
        return PurchaseEtat::find($id);
    }
}
