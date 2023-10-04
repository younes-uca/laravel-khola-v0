<?php

namespace App\zynerator\controller;

use App\Http\Controllers\Controller;
use App\zynerator\service\UserService;
use Illuminate\Http\Request;

class UserController extends Controller
{
    protected $userService;

    public function __construct(UserService $userService)
    {
        $this->userService = $userService;
    }

    public function retrieveById($id)
    {
        return $this->userService->retrieveById($id);
    }

    public function retrieveByToken(Request $request)
    {
        $identifier = 'token'; // Replace with your actual identifier column name
        $token = $request->input('token');
        return $this->userService->retrieveByToken($identifier, $token);
    }

    public function updateRememberToken(Request $request)
    {
        $user = auth()->user();
        $token = $request->input('token');
        $this->userService->updateRememberToken($user, $token);
    }

    public function retrieveByCredentials(Request $request)
    {
        return $this->userService->retrieveByCredentials($request->all());
    }

    public function validateCredentials(Request $request)
    {
        $user = auth()->user();
        return $this->userService->validateCredentials($user, $request->all());
    }

    public function save(Request $request)
    {
        return $this->userService->save($request->all());
    }

    public function update(Request $request)
    {
        $user = auth()->user();
        return $this->userService->update($user, $request->all());
    }

    public function delete($id)
    {
        return $this->userService->delete($id);
    }
}

