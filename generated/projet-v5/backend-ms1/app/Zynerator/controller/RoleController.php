<?php

namespace App\zynerator\controller;

use App\Http\Controllers\Controller;
use App\zynerator\service\RoleService;
use Illuminate\Http\Request;

class RoleController extends Controller
{
    protected $roleService;

    public function __construct(RoleService $roleService)
    {
        $this->roleService = $roleService;
    }

    public function findAll() {
        return $this->roleService->findAll();
    }

    public function findByAuthority(Request $request) {
        $authority = $request->input('authority');
        return $this->roleService->findByAuthority($authority);
    }

    public function deleteByAuthority(Request $request)
    {
        $authority = $request->input('authority');
        return $this->roleService->deleteByAuthority($authority);
    }

    public function findById($id)
    {
        return $this->roleService->findById($id);
    }

    public function deleteById($id)
    {
        $this->roleService->deleteById($id);
        return response()->json(['message' => 'Role deleted']);
    }

    public function create(Request $request)
    {
        $roles = collect($request->all());
        return $this->roleService->create($roles);
    }

    public function update(Request $request, $id)
    {
        $role = $this->roleService->findById($id);
        if (!$role) {
            return response()->json(['message' => 'Role not found'], 404);
        }
        $updatedRole = $this->roleService->update($role, $request->all());
        return response()->json($updatedRole);
    }

    public function delete($id)
    {
        $result = $this->roleService->delete($id);
        if ($result === -1) {
            return response()->json(['message' => 'Role not found'], 404);
        }
        return response()->json(['message' => 'Role deleted']);
    }

    public function findByUserName(Request $request)
    {
        $username = $request->input('username');
        return $this->roleService->findByUserName($username);
    }
}
