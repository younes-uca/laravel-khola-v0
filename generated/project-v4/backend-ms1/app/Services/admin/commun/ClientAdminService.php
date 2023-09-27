<?php

namespace App\Services\admin\commun;

use Illuminate\Support\Facades\DB;
use App\Models\commun\Client;
use App\Models\commun\ClientCategory;

class ClientAdminService
{

    public function save($item,   ) {
        return DB::transaction(function () use ($item,    ) {
            $savedItem = new Client($item);
            $savedItem->save();


            return $savedItem;
        });
    }

    public function deleteById($id) {
        return DB::transaction(function () use ($id) {
            $item = Client::findOrFail($id);


            $item->delete();
            return true;
        });
    }

    public function findAll() {
        return Client::all();
    }

    public function findByClientCategoryId($id) {
        return Client::where('clientCategory', $id)->get();
    }

    public function deleteByClientCategoryId($id) {
        $items = Client::where('clientCategory_id', $id)->get();
        $count = 0;
        foreach ($items as $element ){
            $element->delete();
            $count++;
        }
        return $count;
    }



}
