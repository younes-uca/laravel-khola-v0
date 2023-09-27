<?php

use App\Http\Controllers\admin\flos\PurchaseItemRestAdmin;
use App\Http\Controllers\admin\flos\PurchaseRestAdmin;
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
Route::get('/admin/purchase/', [PurchaseRestAdmin::class, 'findAll']);
Route::post('/admin/purchase/', [PurchaseRestAdmin::class, 'save']);
Route::delete('/admin/purchase/id/{id}', [PurchaseRestAdmin::class, 'deleteById']);
Route::get('/admin/purchase/detail/id/{id}', [PurchaseRestAdmin::class, 'findWithAssociatedLists']);
Route::get('/admin/product/', [ProductRestAdmin::class, 'findAll']);
Route::post('/admin/product/', [ProductRestAdmin::class, 'save']);
Route::delete('/admin/product/id/{id}', [ProductRestAdmin::class, 'deleteById']);
Route::get('/admin/clientCategory/', [ClientCategoryRestAdmin::class, 'findAll']);
Route::post('/admin/clientCategory/', [ClientCategoryRestAdmin::class, 'save']);
Route::delete('/admin/clientCategory/id/{id}', [ClientCategoryRestAdmin::class, 'deleteById']);
Route::get('/admin/client/', [ClientRestAdmin::class, 'findAll']);
Route::post('/admin/client/', [ClientRestAdmin::class, 'save']);
Route::delete('/admin/client/id/{id}', [ClientRestAdmin::class, 'deleteById']);

