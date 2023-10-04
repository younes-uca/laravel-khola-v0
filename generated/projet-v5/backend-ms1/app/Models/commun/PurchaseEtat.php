<?php

namespace App\Models\commun;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;

class PurchaseEtat extends Model
{
    protected $table = 'purchase_etat';
    protected $fillable = [
        'code',
        'reference',
    ];



}


