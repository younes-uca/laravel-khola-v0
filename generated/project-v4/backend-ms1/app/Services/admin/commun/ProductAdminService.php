<?php

namespace App\Services\admin\commun;

use Illuminate\Support\Facades\DB;
use App\Models\commun\Product;

class ProductAdminService
{

    public function save($item,   ) {
        return DB::transaction(function () use ($item,    ) {
            $savedItem = new Product($item);
            $savedItem->save();


            return $savedItem;
        });
    }

    public function deleteById($id) {
        return DB::transaction(function () use ($id) {
            $item = Product::findOrFail($id);


            $item->delete();
            return true;
        });
    }

    public function findAll() {
        return Product::all();
    }




}
