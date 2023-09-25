<?php

namespace App\Models\commun;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;

class Client extends Model
{
    protected $table = 'client';
    protected $fillable = [
        'fullName',
        'clientCategory_id',
    ];

    public function clientCategory(): BelongsTo {
        return $this->belongsTo(ClientCategory::class);
    }


}


