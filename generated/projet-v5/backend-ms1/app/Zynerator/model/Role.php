<?php

namespace App\zynerator\model;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsToMany;
use Illuminate\Foundation\Auth\Access\Authorizable;

class Role extends Model
{
    use Authorizable;

    protected $table = 'role_app';

    protected $fillable = [
        'authority',
    ];

    protected $dates = [
        'createdAt', 'updatedAt',
    ];


    public function users(): BelongsToMany
    {
        return $this->belongsToMany(User::class, 'users_roles', 'ROLE_ID', 'USER_ID');
    }
}
