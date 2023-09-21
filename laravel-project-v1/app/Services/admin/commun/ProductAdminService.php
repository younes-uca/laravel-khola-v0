<?php

namespace App\Services\admin\commun;

use App\Models\commun\Product;
use Illuminate\Support\Facades\DB;

class ProductAdminService
{
    public function save($item)
    {
        return DB::transaction(function () use ($item) {
            $savedItem = new Product($item);

            $savedItem->save();

            return $savedItem;
        });
    }


    public function findAll()
    {
        return Product::all();
    }

    public function deleteById($id): bool
    {
        return DB::transaction(function () use ($id) {
            $item = Product::findOrFail($id);
            $item->delete();
            return true;
        });
    }


}
