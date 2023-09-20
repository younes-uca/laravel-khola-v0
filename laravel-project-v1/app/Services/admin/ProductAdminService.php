<?php

namespace App\Services\admin;

use App\Models\Product;

class ProductAdminService
{

    public function save(Product $item): Product
    {
        $item->save();
        return $item;
    }

    public function findAll()
    {
        return Product::all();
    }

    public function deleteById($productId): bool
    {
        $product = Product::find($productId);

        if (!$product) {
            return false;
        }

        $product->delete();
        return true;
    }


}
