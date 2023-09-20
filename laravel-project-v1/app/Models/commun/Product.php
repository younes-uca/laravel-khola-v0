<?php

namespace App\Models\commun;

use Illuminate\Database\Eloquent\Model;

class Product extends Model
{

    protected $table = 'product';
    protected $fillable = [
        'reference',
        'label',
    ];
}
