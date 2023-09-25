<?php

namespace App\Http\Controllers\admin\commun;

use App\Http\Controllers\Controller;
use App\Services\admin\commun\ClientAdminService;
use Illuminate\Http\Request;

class ClientRestAdmin  extends Controller
{

    private ClientAdminService $service;

    public function __construct(ClientAdminService $service)
    {
        $this->service = $service;
    }

    public function save(Request $request)
    {
        $validated = $request->validate([

            'fullName' => 'required|string',

            'clientCategory_id' => 'required|exists:client_category,id',
        ]);


        return $this->service->save($validated,     );

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
