<?php

<#list roles as role>
    <#list role.subModules as subModule>
        <#list subModule.pojos as pojo>
use App\Http\Controllers\${role.name?uncap_first}<#if pojo.subModule.folder??>\${pojo.subModule.folder}</#if>\${pojo.name}Rest${role.name?cap_first};
        </#list>
    </#list>
</#list>

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

<#list roles as role>
    <#list role.subModules as subModule>
        <#list subModule.pojos as pojo>
Route::get('/${role.name?uncap_first}/${pojo.name?uncap_first}/', [${pojo.name}Rest${role.name?cap_first}::class, 'findAll']);
Route::post('/${role.name?uncap_first}/${pojo.name?uncap_first}/', [${pojo.name}Rest${role.name?cap_first}::class, 'save']);
Route::delete('/${role.name?uncap_first}/${pojo.name?uncap_first}/id/{id}', [${pojo.name}Rest${role.name?cap_first}::class, 'deleteById']);
Route::get('/${role.name?uncap_first}/${pojo.name?uncap_first}/id/{id}', [${pojo.name}Rest${role.name?cap_first}::class, 'findById']);

            <#if pojo.hasList == true>
Route::get('/${role.name?uncap_first}/${pojo.name?uncap_first}/detail/id/{id}', [${pojo.name}Rest${role.name?cap_first}::class, 'findWithAssociatedLists']);
            </#if>

            <#if pojo.labelOrReference??>
Route::get('/${role.name?uncap_first}/${pojo.name?uncap_first}/optimized', [${pojo.name}Rest${role.name?cap_first}::class, 'findAllOptimized']);
            </#if>

            <#list pojo.fieldsGeneric as fieldGeneric>
                <#if  (true || fieldGeneric.deleteByInclusion)  && fieldGeneric.pojo.msExterne ==false>
                    <#if (fieldGeneric.typeAsPojo.state == false)>
Route::get('/${role.name?uncap_first}/${pojo.name?uncap_first}/${fieldGeneric.name?uncap_first}/id/{id}', [${pojo.name}Rest${role.name?cap_first}::class, 'findBy${fieldGeneric.name?cap_first}Id']);
Route::delete('/${role.name?uncap_first}/${pojo.name?uncap_first}/${fieldGeneric.name?uncap_first}/id/{id}', [${pojo.name}Rest${role.name?cap_first}::class, 'deleteBy${fieldGeneric.name?cap_first}Id']);
                    </#if>
                </#if>
            </#list>


        </#list>
    </#list>
</#list>

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
