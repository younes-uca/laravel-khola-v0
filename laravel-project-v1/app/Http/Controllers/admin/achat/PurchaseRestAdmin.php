<?php

namespace App\Http\Controllers\admin\achat;

use App\Http\Controllers\Controller;
use App\Services\admin\achat\PurchaseAdminService;
use Illuminate\Http\Request;

class PurchaseRestAdmin extends Controller
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
            'purchaseDate' => 'required|date',
            'total' => 'required|numeric',
            'description' => 'nullable|string',
            'client_id' => 'required|exists:client,id',
        ]);

        $validatedPurchaseItems = $request->validate([
            'purchaseItems.*.product_id' => 'required|exists:product,id',
            'purchaseItems.*.price' => 'required|numeric',
            'purchaseItems.*.quantity' => 'required|numeric',
        ]);

        return $this->service->save($validated, $validatedPurchaseItems['purchaseItems']);

    }


    public function deleteById($id)
    {
        return $this->service->deleteById($id);

    }


    public function findAll()
    {
        $items = $this->service->findAll();

        return  $items;
    }

}
