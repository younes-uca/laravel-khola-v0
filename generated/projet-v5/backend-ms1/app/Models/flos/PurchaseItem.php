<?php

namespace App\Models\flos;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;

class PurchaseItem extends Model
{
    protected $table = 'purchase_item';
    protected $fillable = [
        'price',
        'quantity',
        'product_id',
        'purchase_id',
    ];

    public function product(): BelongsTo {
        return $this->belongsTo(Product::class);
    }
    public function purchase(): BelongsTo {
        return $this->belongsTo(Purchase::class);
    }


}


