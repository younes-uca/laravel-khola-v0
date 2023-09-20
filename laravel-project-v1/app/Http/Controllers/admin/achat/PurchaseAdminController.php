<?php

namespace App\Http\Controllers\admin\achat;

use App\Http\Controllers\Controller;
use App\Services\admin\achat\PurchaseAdminService;
use Illuminate\Http\Request;

class PurchaseAdminController extends Controller
{

    private PurchaseAdminService $service;

    public function __construct(PurchaseAdminService $service)
    {
        $this->service = $service;
    }

    public function save(Request $request)
    {
        $validatedPurchaseData = $request->validate([
            'reference' => 'required|string|max:255',
            'purchaseDate' => 'required|date',
            'total' => 'required|numeric',
            'description' => 'nullable|string',
            'client_id' => 'required|exists:client,id',
        ]);

        $validatedPurchaseItemsData = $request->validate([
            'purchaseItems.*.product_id' => 'required|exists:product,id',
            'purchaseItems.*.price' => 'required|numeric',
            'purchaseItems.*.quantity' => 'required|numeric',
        ]);

        return $this->service->save($validatedPurchaseData, $validatedPurchaseItemsData['purchaseItems']);

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
