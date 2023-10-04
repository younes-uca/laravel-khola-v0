<?php

use App\Http\Controllers\admin\flos\PurchaseItemRestAdmin;
use App\Http\Controllers\admin\flos\PurchaseRestAdmin;
use App\Http\Controllers\admin\commun\PurchaseEtatRestAdmin;
use App\Http\Controllers\admin\commun\ProductRestAdmin;
use App\Http\Controllers\admin\commun\ClientCategoryRestAdmin;
use App\Http\Controllers\admin\commun\ClientRestAdmin;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider and all of them will
| be assigned to the "api" middleware group. Make something great!
|
*/

Route::middleware('auth:sanctum')->get('/user', function (Request $request) {
    return $request->user();
});

Route::get('/admin/purchaseItem/', [PurchaseItemRestAdmin::class, 'findAll']);
Route::post('/admin/purchaseItem/', [PurchaseItemRestAdmin::class, 'save']);
Route::delete('/admin/purchaseItem/id/{id}', [PurchaseItemRestAdmin::class, 'deleteById']);
Route::get('/admin/purchaseItem/id/{id}', [PurchaseItemRestAdmin::class, 'findById']);



Route::get('/admin/purchaseItem/product/id/{id}', [PurchaseItemRestAdmin::class, 'findByProductId']);
Route::delete('/admin/purchaseItem/product/id/{id}', [PurchaseItemRestAdmin::class, 'deleteByProductId']);
Route::get('/admin/purchaseItem/purchase/id/{id}', [PurchaseItemRestAdmin::class, 'findByPurchaseId']);
Route::delete('/admin/purchaseItem/purchase/id/{id}', [PurchaseItemRestAdmin::class, 'deleteByPurchaseId']);


Route::get('/admin/purchase/', [PurchaseRestAdmin::class, 'findAll']);
Route::post('/admin/purchase/', [PurchaseRestAdmin::class, 'save']);
Route::delete('/admin/purchase/id/{id}', [PurchaseRestAdmin::class, 'deleteById']);
Route::get('/admin/purchase/id/{id}', [PurchaseRestAdmin::class, 'findById']);

Route::get('/admin/purchase/detail/id/{id}', [PurchaseRestAdmin::class, 'findWithAssociatedLists']);


Route::get('/admin/purchase/purchaseEtat/id/{id}', [PurchaseRestAdmin::class, 'findByPurchaseEtatId']);
Route::delete('/admin/purchase/purchaseEtat/id/{id}', [PurchaseRestAdmin::class, 'deleteByPurchaseEtatId']);
Route::get('/admin/purchase/client/id/{id}', [PurchaseRestAdmin::class, 'findByClientId']);
Route::delete('/admin/purchase/client/id/{id}', [PurchaseRestAdmin::class, 'deleteByClientId']);


Route::get('/admin/purchaseEtat/', [PurchaseEtatRestAdmin::class, 'findAll']);
Route::post('/admin/purchaseEtat/', [PurchaseEtatRestAdmin::class, 'save']);
Route::delete('/admin/purchaseEtat/id/{id}', [PurchaseEtatRestAdmin::class, 'deleteById']);
Route::get('/admin/purchaseEtat/id/{id}', [PurchaseEtatRestAdmin::class, 'findById']);


Route::get('/admin/purchaseEtat/optimized', [PurchaseEtatRestAdmin::class, 'findAllOptimized']);



Route::get('/admin/product/', [ProductRestAdmin::class, 'findAll']);
Route::post('/admin/product/', [ProductRestAdmin::class, 'save']);
Route::delete('/admin/product/id/{id}', [ProductRestAdmin::class, 'deleteById']);
Route::get('/admin/product/id/{id}', [ProductRestAdmin::class, 'findById']);


Route::get('/admin/product/optimized', [ProductRestAdmin::class, 'findAllOptimized']);



Route::get('/admin/clientCategory/', [ClientCategoryRestAdmin::class, 'findAll']);
Route::post('/admin/clientCategory/', [ClientCategoryRestAdmin::class, 'save']);
Route::delete('/admin/clientCategory/id/{id}', [ClientCategoryRestAdmin::class, 'deleteById']);
Route::get('/admin/clientCategory/id/{id}', [ClientCategoryRestAdmin::class, 'findById']);


Route::get('/admin/clientCategory/optimized', [ClientCategoryRestAdmin::class, 'findAllOptimized']);



Route::get('/admin/client/', [ClientRestAdmin::class, 'findAll']);
Route::post('/admin/client/', [ClientRestAdmin::class, 'save']);
Route::delete('/admin/client/id/{id}', [ClientRestAdmin::class, 'deleteById']);
Route::get('/admin/client/id/{id}', [ClientRestAdmin::class, 'findById']);


Route::get('/admin/client/optimized', [ClientRestAdmin::class, 'findAllOptimized']);

Route::get('/admin/client/clientCategory/id/{id}', [ClientRestAdmin::class, 'findByClientCategoryId']);
Route::delete('/admin/client/clientCategory/id/{id}', [ClientRestAdmin::class, 'deleteByClientCategoryId']);



// UserController Routes
Route::get('/user', [UserController::class, 'index']); // List all user
Route::get('/user/{id}', [UserController::class, 'retrieveById']); // Get a user by ID
Route::post('/user/token', [UserController::class, 'retrieveByToken']); // Retrieve user by token
Route::put('/user/token', [UserController::class, 'updateRememberToken']); // Update user's remember token
Route::post('/user/credentials', [UserController::class, 'retrieveByCredentials']); // Retrieve user by credentials
Route::post('/user/validate-credentials', [UserController::class, 'validateCredentials']); // Validate user credentials
Route::post('/user', [UserController::class, 'save']); // Create a new user
Route::put('/user', [UserController::class, 'update']); // Update user
Route::delete('/user/{id}', [UserController::class, 'delete']); // Delete user by ID


// RoleController Routes
Route::get('/role', [RoleController::class, 'findAll']); // List all roles
Route::get('/role/authority', [RoleController::class, 'findByAuthority']); // Find role by authority
Route::delete('/role/authority', [RoleController::class, 'deleteByAuthority']); // Delete role by authority
Route::get('/role/{id}', [RoleController::class, 'findById']); // Find role by ID
Route::delete('/role/{id}', [RoleController::class, 'deleteById']); // Delete role by ID
Route::post('/role/create', [RoleController::class, 'create']); // Create multiple roles
Route::put('/role/{id}', [RoleController::class, 'update']); // Update role by ID
Route::delete('/role/{id}', [RoleController::class, 'delete']); // Delete role by ID
Route::post('/role/username', [RoleController::class, 'findByUserName']); // Find role by username
