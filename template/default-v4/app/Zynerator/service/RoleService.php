<?php

namespace App\zynerator\service;

use App\zynerator\model\Role;
use Illuminate\Support\Collection;

class RoleService
{
    public function findAll()
    {
        return Role::all();
    }

    public function findByAuthority($authority)
    {
        return Role::where('authority', $authority)->first();
    }

    public function deleteByAuthority($authority)
    {
        return Role::where('authority', $authority)->delete();
    }

    public function findById($id)
    {
        return Role::find($id);
    }

    public function deleteById($id)
    {
        Role::destroy($id);
    }

    public function create(Collection $roles)
    {
        $result = [];

        $roles->each(function ($role) use (&$result) {
            $result[] = $this->save($role);
        });

        return $result;
    }

    public function update(Role $role)
    {
        $foundedRole = $this->findById($role->id);

        if (!$foundedRole) {
            return null;
        }

        $foundedRole->update($role->toArray());
        return $foundedRole;
    }

    public function delete(Role $role)
    {
        if (!$role->authority) {
            return -1;
        }

        $foundedRole = $this->findByAuthority($role->authority);

        if (!$foundedRole) {
            return -1;
        }

        $foundedRole->delete();
        return 1;
    }

    public function save(Role $role)
    {
        $existingRole = $this->findByAuthority($role->authority);

        if ($existingRole) {
            return $existingRole;
        }

        $role->save();
        return $role;
    }

    public function findByUserName($username)
    {
        return Role::whereHas('users', function ($query) use ($username) {
            $query->where('username', $username);
        })->get();
    }
}

