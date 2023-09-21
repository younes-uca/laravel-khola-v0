<?php

namespace App\Services\admin\commun;

use App\Models\commun\Client;
use Illuminate\Support\Facades\DB;

class ClientAdminService
{


    public function save($item)
    {
        return DB::transaction(function () use ($item) {
            $savedItem = new Client($item);

            $savedItem->save();

            return $savedItem;
        });
    }



    public function findAll()
    {
        return Client::all();
    }

    public function deleteById($id): bool
    {
        return DB::transaction(function () use ($id) {
            $item = Client::findOrFail($id);
            $item->delete();
            return true;
        });
    }





}
