<?php

namespace App\zynerator\service;

use App\Services\Str;
use App\zynerator\model\Role;
use App\zynerator\model\User;
use Illuminate\Contracts\Auth\Authenticatable;
use Illuminate\Contracts\Auth\UserProvider;
use Illuminate\Support\Facades\Hash;

class UserService implements UserProvider
{
    public function retrieveById($identifier)
    {
        return User::find($identifier);
    }

    public function retrieveByToken($identifier, $token)
    {
        return User::where($identifier, $token)->first();
    }

    public function updateRememberToken(Authenticatable $user, $token)
    {
        $user->setRememberToken($token);
        $user->save();
    }

    public function retrieveByCredentials(array $credentials)
    {
        $query = User::query();

        foreach ($credentials as $key => $value) {
            if (!Str::contains($key, 'password')) {
                $query->where($key, $value);
            }
        }

        return $query->first();
    }

    public function validateCredentials(Authenticatable $user, array $credentials)
    {
        $plain = $credentials['password'];
        return Hash::check($plain, $user->getAuthPassword());
    }

    public function save(array $data)
    {
        $user = new User();
        $user->username = $data['username'];
        $user->password = Hash::make('password'); // You can change this password
        $user->prenom = $data['prenom'];
        $user->nom = $data['nom'];
        $user->email = $data['email'];
        $user->credentialsNonExpired = true;
        $user->accountNonLocked = true;
        $user->accountNonExpired = true;
        $user->enabled = true;
        $user->passwordChanged = false;
        $user->created_at = now();
        $user->save();

        if (isset($data['roles'])) {
            $roleIds = [];
            foreach ($data['roles'] as $roleData) {
                $role = Role::where('authority', $roleData['authority'])->first();
                if (!$role) {
                    $role = new Role();
                    $role->authority = $roleData['authority'];
                    $role->save();
                }
                $roleIds[] = $role->id;
            }
            $user->roles()->sync($roleIds);
        }

        return $user;
    }

    public function update(User $user, array $data)
    {
        $user->email = $data['email'];
        $user->username = $data['username'];
        $user->prenom = $data['prenom'];
        $user->nom = $data['nom'];
        $user->enabled = $data['enabled'];
        $user->credentialsNonExpired = $data['credentialsNonExpired'];
        $user->accountNonLocked = $data['accountNonLocked'];
        $user->accountNonExpired = $data['accountNonExpired'];
        $user->roles()->detach();

        if (isset($data['roles'])) {
            $roleIds = [];
            foreach ($data['roles'] as $roleData) {
                $role = Role::where('authority', $roleData['authority'])->first();
                if (!$role) {
                    $role = new Role();
                    $role->authority = $roleData['authority'];
                    $role->save();
                }
                $roleIds[] = $role->id;
            }
            $user->roles()->sync($roleIds);
        }

        $user->save();

        return $user;
    }

    public function delete($id)
    {
        $user = User::find($id);
        if ($user) {
            $user->roles()->detach();
            $user->delete();
        }
    }
}
