<?php

use App\Http\Controllers\ClientController;
use App\Http\Controllers\ProductController;
use App\Http\Controllers\PurchaseController;
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

Route::get('/product/', [ProductController::class, 'findAll']);
Route::post('/product/', [ProductController::class, 'save']);
Route::delete('/product/{id}', [ProductController::class, 'deleteById']);

Route::get('/client/', [ClientController::class, 'findAll']);
Route::post('/client/', [ClientController::class, 'save']);
Route::delete('/client/{id}', [ClientController::class, 'deleteById']);


Route::get('/purchase/', [PurchaseController::class, 'findAll']);
Route::post('/purchase/', [PurchaseController::class, 'save']);
Route::delete('/purchase/{id}', [PurchaseController::class, 'deleteById']);



Route::get('/product/{id}', [ProductController::class, 'show']);
Route::put('/product/{id}', [ProductController::class, 'update']);

