<?php

namespace App\Services\${role.name}\${pojo.subModule.folder};

use Illuminate\Support\Facades\DB;
use App\Models<#if pojo.subModule.folder??>\${pojo.subModule.folder}</#if>\${pojo.name};
<#if pojo.dependencies??>
    <#list pojo.dependencies as dependency>
        <#if dependency?? && dependency.name??>
use App\Models<#if dependency.subModule.folder??>\${dependency.subModule.folder}</#if>\${dependency.name};
        </#if>
    </#list>
</#if>

class ${pojo.name}${role.name?cap_first}Service
{

    public function save($item,<#list pojo.fields as field> <#if field.list>$${field.name?uncap_first}, </#if></#list>) {
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

    <#list pojo.fieldsGeneric as fieldGeneric>
        <#if  (true || fieldGeneric.deleteByInclusion)  && fieldGeneric.pojo.msExterne ==false>
            <#if (fieldGeneric.typeAsPojo.state == false)>
    public function findBy${fieldGeneric.name?cap_first}Id($id) {
        return ${pojo.name}::where('${fieldGeneric.name?uncap_first}', $id)->get();
    }

    public function deleteBy${fieldGeneric.name?cap_first}Id($id) {
        $items = ${pojo.name}::where('${fieldGeneric.name?uncap_first}_id', $id)->get();
        $count = 0;
        foreach ($items as $element ){
    <#list pojo.fields as field>
        <#if field.list>
            $element->${field.name?uncap_first}->each(function ($elementItem) {
                $elementItem->delete();
            });
        </#if>
    </#list>
            $element->delete();
            $count++;
        }
        return $count;
    }
            </#if>
        </#if>
    </#list>


    <#if pojo.hasList == true>
    public function findWithAssociatedLists($id) {
        return ${pojo.name}::with([<#list pojo.fields as field>'${field.name?uncap_first}',</#list>])->find($id);
    }
    </#if>

}
