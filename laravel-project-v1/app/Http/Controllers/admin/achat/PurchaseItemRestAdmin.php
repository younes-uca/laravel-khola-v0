<?php

namespace App\Http\Controllers\admin\achat;

use App\Http\Controllers\Controller;
use App\Models\achat\PurchaseItem;
use App\Services\admin\achat\PurchaseItemAdminService;
use Illuminate\Http\Request;

class PurchaseItemRestAdmin extends Controller
{
    private PurchaseItemAdminService $service;

    public function __construct(PurchaseItemAdminService $service)
    {
        $this->service = $service;
    }

    public function save (Request $request): PurchaseItem
    {
        $validated = $request->validate([
            'product_id' => 'required|exists:product,id',
            'price' => 'required|numeric',
            'quantity' => 'required|numeric',
            'purchase_id' => 'required|exists:purchase,id',
        ]);

        return $this->service->save($validated);

    }
}
