<?php

namespace App\Http\Controllers\admin\flos;

use App\Http\Controllers\Controller;
use App\Services\admin\flos\PurchaseItemAdminService;
use Illuminate\Http\Request;

class PurchaseItemRestAdmin  extends Controller
{

    private PurchaseItemAdminService $service;

    public function __construct(PurchaseItemAdminService $service)
    {
        $this->service = $service;
    }

    public function save(Request $request)
    {
        $validated = $request->validate([

            'price' => 'required|numeric',
            'quantity' => 'required|numeric',

            'product_id' => 'required|exists:product,id',
            'purchase_id' => 'required|exists:purchase,id',
        ]);


        return $this->service->save($validated,     );

    }

    public function deleteById($id) {
        return $this->service->deleteById($id);
    }

    public function findAll() {
        $items = $this->service->findAll();

        return  $items;
    }

    public function findByProductId($id) {
        return $this->service->findByProductId($id);
    }

    public function deleteByProductId($id) {
        return  $this->service->deleteByProductId($id);
    }

    public function findByPurchaseId($id) {
        return $this->service->findByPurchaseId($id);
    }

    public function deleteByPurchaseId($id) {
        return  $this->service->deleteByPurchaseId($id);
    }




}
