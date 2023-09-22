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
Route::get('/${pojo.name?uncap_first}/', [${pojo.name}Rest${role.name?cap_first}::class, 'findAll']);
Route::post('/${pojo.name?uncap_first}/', [${pojo.name}Rest${role.name?cap_first}::class, 'save']);
Route::delete('/${pojo.name?uncap_first}/{id}', [${pojo.name}Rest${role.name?cap_first}::class, 'deleteById']);
        </#list>
    </#list>
</#list>

