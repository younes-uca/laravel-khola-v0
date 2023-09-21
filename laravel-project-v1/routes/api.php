<?php

use App\Http\Controllers\admin\achat\PurchaseRestAdmin;
use App\Http\Controllers\admin\commun\ClientRestAdmin;
use App\Http\Controllers\admin\commun\ProductRestAdmin;
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

Route::get('/product/', [ProductRestAdmin::class, 'findAll']);
Route::post('/product/', [ProductRestAdmin::class, 'save']);
Route::delete('/product/{id}', [ProductRestAdmin::class, 'deleteById']);

Route::get('/client/', [ClientRestAdmin::class, 'findAll']);
Route::post('/client/', [ClientRestAdmin::class, 'save']);
Route::delete('/client/{id}', [ClientRestAdmin::class, 'deleteById']);


Route::get('/purchase/', [PurchaseRestAdmin::class, 'findAll']);
Route::post('/purchase/', [PurchaseRestAdmin::class, 'save']);
Route::delete('/purchase/{id}', [PurchaseRestAdmin::class, 'deleteById']);





