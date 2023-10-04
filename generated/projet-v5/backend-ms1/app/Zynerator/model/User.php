<?php

namespace App\zynerator\model;

use Illuminate\Foundation\Auth\User as Authenticatable;
use Illuminate\Notifications\Notifiable;
use Illuminate\Support\Collection;

class User extends Authenticatable
{
    use Notifiable;

    protected $table = 'user_app';

    protected $fillable = [
        'username', 'password', 'prenom', 'nom', 'email',
    ];

    protected $hidden = [
        'password',
    ];

    protected $casts = [
        'credentialsNonExpired' => 'boolean',
        'enabled' => 'boolean',
        'accountNonExpired' => 'boolean',
        'accountNonLocked' => 'boolean',
        'passwordChanged' => 'boolean',
    ];

    protected $dates = [
        'createdAt', 'updatedAt',
    ];

    public function roles()
    {
        return $this->belongsToMany(Role::class, 'users_roles', 'USER_ID', 'ROLE_ID');
    }


    public function setRolesAttribute(Collection $roles)
    {
        $this->roles()->sync($roles->pluck('id')->all());
    }

    public function setEnabledAttribute($value)
    {
        $this->attributes['enabled'] = $value;
    }

    public function setEmailAttribute($value)
    {
        $this->attributes['email'] = $value;
    }

    public function setUsernameAttribute($value)
    {
        $this->attributes['username'] = $value;
    }

    public function getAuthoritiesAttribute()
    {
        if (is_null($this->attributes['authorities'])) {
            $this->attributes['authorities'] = $this->roles;
        }
        return $this->attributes['authorities'];
    }

    public function setPasswordAttribute($value)
    {
        $this->attributes['password'] = bcrypt($value);
    }
}
