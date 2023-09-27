<?php

namespace App\Http\Controllers\admin\commun;

use App\Http\Controllers\Controller;
use App\Services\admin\commun\ProductAdminService;
use Illuminate\Http\Request;

class ProductRestAdmin  extends Controller
{

    private ProductAdminService $service;

    public function __construct(ProductAdminService $service)
    {
        $this->service = $service;
    }

    public function save(Request $request)
    {
        $validated = $request->validate([

            'code' => 'required|string',
            'reference' => 'required|string',

        ]);


        return $this->service->save($validated,   );

    }

    public function deleteById($id) {
        return $this->service->deleteById($id);
    }

    public function findAll() {
        $items = $this->service->findAll();

        return  $items;
    }




}
