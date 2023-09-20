<?php

use App\Http\Controllers\admin\achat\PurchaseAdminController;
use App\Http\Controllers\admin\commun\ClientAdminController;
use App\Http\Controllers\admin\commun\ProductAdminController;
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

Route::get('/product/', [ProductAdminController::class, 'findAll']);
Route::post('/product/', [ProductAdminController::class, 'save']);
Route::delete('/product/{id}', [ProductAdminController::class, 'deleteById']);

Route::get('/client/', [ClientAdminController::class, 'findAll']);
Route::post('/client/', [ClientAdminController::class, 'save']);
Route::delete('/client/{id}', [ClientAdminController::class, 'deleteById']);


Route::get('/purchase/', [PurchaseAdminController::class, 'findAll']);
Route::post('/purchase/', [PurchaseAdminController::class, 'save']);
Route::delete('/purchase/{id}', [PurchaseAdminController::class, 'deleteById']);





