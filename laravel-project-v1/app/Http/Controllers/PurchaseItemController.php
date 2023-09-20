<?php

namespace App\Http\Controllers;

use App\Models\PurchaseItem;
use App\Services\admin\PurchaseItemAdminService;
use Illuminate\Http\Request;

class PurchaseItemController extends Controller
{
    private PurchaseItemAdminService $service;

    public function __construct(PurchaseItemAdminService $service)
    {
        $this->service = $service;
    }

    public function save (Request $request): PurchaseItem
    {
        $validated = $request->validate([
            'product_id' => 'required|exists:products,id',
            'price' => 'required|numeric',
            'quantity' => 'required|numeric',
            'purchase_id' => 'required|exists:purchases,id',
        ]);

        return $this->service->save($validated);

    }
}
