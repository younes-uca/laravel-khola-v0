<?php

namespace App\Services\admin;

use App\Models\Client;

class ClientAdminService
{

    public function save(Client $item): Client
    {
        $item->save();
        return $item;
    }



    public function findAll()
    {
        return Client::all();
    }

    public function deleteById($clientId): bool
    {
        $client = Client::find($clientId);

        if (!$client) {
            return false;
        }

        $client->delete();
        return true;
    }





}
