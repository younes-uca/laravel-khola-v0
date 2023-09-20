<?php

namespace App\Http\Controllers;

use App\Services\admin\PurchaseAdminService;
use Illuminate\Http\Request;

class PurchaseController extends Controller
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
}
