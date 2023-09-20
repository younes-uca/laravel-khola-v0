<?php

namespace App\Http\Controllers\admin\commun;

use App\Http\Controllers\Controller;
use App\Models\commun\Client;
use App\Services\admin\commun\ClientAdminService;
use Illuminate\Http\Request;

class ClientAdminController extends Controller
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

        $client = new Client();
        $client->fullName = $validated['fullName'];
        $client->email = $validated['email'];

        return  $this->service->save($client);
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
