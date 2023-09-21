<?php

namespace App\Http\Controllers\admin\commun;

use App\Http\Controllers\Controller;
use App\Models\commun\Client;
use App\Services\admin\commun\ClientAdminService;
use Illuminate\Http\Request;

class ClientRestAdmin extends Controller
{
    private ClientAdminService $service;

    public function __construct(ClientAdminService $service)
    {
        $this->service = $service;
    }

    public function save(Request $request): Client
    {
        $validated = $request->validate([
            'fullName' => 'required|string',
            'email' => 'required|string',
        ]);


        return  $this->service->save($validated);
    }

    public function findAll()
    {
        $items = $this->service->findAll();

        return  $items;
    }


    public function deleteById($id): bool
    {
        $result = $this->service->deleteById($id);

        if ($result === false) {
            return false;
        }

        return $result;
    }

}
