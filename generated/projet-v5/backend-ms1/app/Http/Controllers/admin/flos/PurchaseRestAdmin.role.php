<?php

namespace App\Http\Controllers\admin\flos;

use App\Http\Controllers\Controller;
use App\Services\admin\flos\PurchaseAdminService;
use Illuminate\Http\Request;

class PurchaseRestAdmin  extends Controller
{

    private PurchaseAdminService $service;

    public function __construct(PurchaseAdminService $service)
    {
        $this->service = $service;
    }

    public function save(Request $request)
    {
        $validated = $request->validate([

            'reference' => 'required|string',
            'purchaseStartDate' => 'required|date',
            'purchaseEndDate' => 'required|date',
            'image' => 'required|string',
            'total' => 'required|numeric',
            'description' => 'required|string',

            'purchaseEtat_id' => 'required|exists:purchase_etat,id',
            'client_id' => 'required|exists:client,id',
        ]);

        $validatedPurchaseItems = $request->validate([
            'purchaseItems.*.product_id' => 'required|exists:product,id',
            'purchaseItems.*.price' => 'required|numeric',
            'purchaseItems.*.quantity' => 'required|numeric',
        ]);

        return $this->service->save($validated,          $validatedPurchaseItems['purchaseItems'], );

    }

    public function deleteById($id) {
        return $this->service->deleteById($id);
    }

    public function findAll() {
        $items = $this->service->findAll();

        return  $items;
    }

    public function findByPurchaseEtatId($id) {
        return $this->service->findByPurchaseEtatId($id);
    }

    public function deleteByPurchaseEtatId($id) {
        return  $this->service->deleteByPurchaseEtatId($id);
    }

    public function findByClientId($id) {
        return $this->service->findByClientId($id);
    }

    public function deleteByClientId($id) {
        return  $this->service->deleteByClientId($id);
    }


    public function findWithAssociatedLists($id) {
        return  $this->service->findWithAssociatedLists($id);
    }


    public function findById($id) {
        return $this->service->findById($id);
    }
}
