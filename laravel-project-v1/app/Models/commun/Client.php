<?php

namespace App\Models\commun;

use Illuminate\Database\Eloquent\Model;

class Client extends Model
{
    protected $table = 'client';
    protected $fillable = [
        'fullName',
        'email',
    ];
}
