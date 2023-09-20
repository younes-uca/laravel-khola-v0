<?php


namespace App\Http\Controllers\admin\commun;

use App\Http\Controllers\Controller;
use App\Models\commun\Product;
use App\Services\admin\commun\ProductAdminService;
use Illuminate\Http\Request;

class ProductAdminController extends Controller
{
    private ProductAdminService $service;

    public function __construct(ProductAdminService $service)
    {
        $this->service = $service;
    }

    public function save(Request $request): Product
    {
        $validated = $request->validate([
            'reference' => 'required|string',
            'label' => 'required|string',
        ]);

        $product = new Product();
        $product->reference = $validated['reference'];
        $product->label = $validated['label'];

        return  $this->service->save($product);
    }

    public function findAll()
    {
        $items = $this->service->findAll();

        return  $items;
    }


    public function deleteById($id): bool
    {
        $result = $this->service->deleteById($id);

        if ($result === false) {
            return false;
        }

        return $result;
    }



}
