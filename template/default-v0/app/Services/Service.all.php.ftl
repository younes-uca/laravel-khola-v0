<?php

namespace App\Services\${role.name}\${pojo.subModule.folder};

use Illuminate\Support\Facades\DB;
use App\Models<#if pojo.subModule.folder??>\${pojo.subModule.folder}</#if>\${pojo.name};
<#if pojo.dependencies??>
    <#list pojo.dependencies as dependency>
        <#if dependency?? && dependency.name?? && dependency.subModule.folder != pojo.subModule.folder>
use App\Models<#if dependency.subModule.folder??>\${dependency.subModule.folder}</#if>\${dependency.name};
        </#if>
    </#list>
</#if>

class ${pojo.name}${role.name?cap_first}Service
{

    public function save($item,   <#list pojo.fields as field> <#if field.list>$${field.name?uncap_first}, </#if></#list>) {
        return DB::transaction(function () use ($item, <#list pojo.fields as field> <#if field.list>$${field.name?uncap_first}, </#if></#list>) {
            $savedItem = new ${pojo.name}($item);
            $savedItem->save();

    <#list pojo.fields as field>
        <#if field.list>
            $saved${field.name?cap_first} = [];
            foreach ($${field.name?uncap_first} as $element) {
                $${field.type.simpleName?uncap_first} = new ${field.type.simpleName}($element);
                $saved${field.name?cap_first}[] = $${field.type.simpleName?uncap_first};
            }
            $savedItem->${field.name?uncap_first}()->saveMany($saved${field.name?cap_first});
        </#if>
    </#list>

            return $savedItem;
        });
    }

    public function deleteById($id) {
        return DB::transaction(function () use ($id) {
            $item = ${pojo.name}::findOrFail($id);

    <#list pojo.fields as field>
        <#if field.list>
            $item->${field.name?uncap_first}()->delete();
        </#if>
    </#list>

            $item->delete();
            return true;
        });
    }

    public function findAll() {
        return ${pojo.name}::all();
    }

}
