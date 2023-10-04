<?php

namespace App\Services\admin\commun;

use Illuminate\Support\Facades\DB;
use App\Models\commun\ClientCategory;

class ClientCategoryAdminService
{

    public function save($item,) {
        return DB::transaction(function () use ($item,) {
            $savedItem = new ClientCategory($item);
            $savedItem->save();


            return $savedItem;
        });
    }

    public function deleteById($id) {
        return DB::transaction(function () use ($id) {
            $item = ClientCategory::findOrFail($id);


            $item->delete();
            return true;
        });
    }

    public function findAll() {
        return ClientCategory::all();
    }




    public function findAllOptimized() {
        return ClientCategory::select('id', 'reference')->get();
    }

    public function findById($id) {
        return ClientCategory::find($id);
    }
}
