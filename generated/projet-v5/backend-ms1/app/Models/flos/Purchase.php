<?php

namespace App\Models\flos;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;

class Purchase extends Model
{
    protected $table = 'purchase';
    protected $fillable = [
        'reference',
        'purchaseStartDate',
        'purchaseEndDate',
        'image',
        'total',
        'description',
        'purchaseEtat_id',
        'client_id',
    ];

    public function purchaseEtat(): BelongsTo {
        return $this->belongsTo(PurchaseEtat::class);
    }
    public function client(): BelongsTo {
        return $this->belongsTo(Client::class);
    }

    public function purchaseItems(): HasMany {
        return $this->hasMany(PurchaseItem::class);
    }

}


