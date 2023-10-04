<?php

namespace App\Http\Controllers\admin\commun;

use App\Http\Controllers\Controller;
use App\Services\admin\commun\PurchaseEtatAdminService;
use Illuminate\Http\Request;

class PurchaseEtatRestAdmin  extends Controller
{

    private PurchaseEtatAdminService $service;

    public function __construct(PurchaseEtatAdminService $service)
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



    public function findAllOptimized() {
        return $this->service->findAllOptimized();
    }

    public function findById($id) {
        return $this->service->findById($id);
    }
}
