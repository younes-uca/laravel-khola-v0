<?php

namespace App\Http\Controllers\admin\commun;

use App\Http\Controllers\Controller;
use App\Services\admin\commun\ClientCategoryAdminService;
use Illuminate\Http\Request;

class ClientCategoryRestAdmin  extends Controller
{

    private ClientCategoryAdminService $service;

    public function __construct(ClientCategoryAdminService $service)
    {
        $this->service = $service;
    }

    public function save(Request $request)
    {
        $validated = $request->validate([
            'reference' => 'required|string',
            'code' => 'required|string',
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
