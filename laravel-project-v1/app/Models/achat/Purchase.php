<?php

namespace App\Models\achat;

use App\Models\commun\Client;
use Illuminate\Database\Eloquent\Model;

class Purchase extends Model
{
    protected $table = 'purchase';
    protected $fillable = [
        'reference',
        'purchaseDate',
        'total',
        'description',
        'client_id',
    ];

    public function client()
    {
        return $this->belongsTo(Client::class);
    }

    public function purchaseItems()
    {
        return $this->hasMany(PurchaseItem::class);
    }
}
