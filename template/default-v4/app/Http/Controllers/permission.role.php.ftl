<?php

namespace App\Http\Controllers\${roleName?uncap_first}<#if permissions[0].pojo.subModule.folder??>\${permissions[0].pojo.subModule.folder}</#if>;

use App\Http\Controllers\Controller;
use App\Services\${roleName?uncap_first}<#if permissions[0].pojo.subModule.folder??>\${permissions[0].pojo.subModule.folder}</#if>\${permissions[0].pojo.name?cap_first}${roleName?cap_first}Service;
use Illuminate\Http\Request;

class ${permissions[0].pojo.name?cap_first}Rest${roleName?cap_first}  extends Controller
{

    private ${permissions[0].pojo.name?cap_first}${roleName?cap_first}Service $service;

    public function __construct(${permissions[0].pojo.name?cap_first}${roleName?cap_first}Service $service)
    {
        $this->service = $service;
    }

    public function save(Request $request)
    {
        $validated = $request->validate([

<#list permissions[0].pojo.fieldsSimple as fieldSimple>
    <#if permissions[0].pojo.id.name != fieldSimple.name>
        <#if fieldSimple.id == false>
            <#if fieldSimple.pureString>
            '${fieldSimple.name?uncap_first}' => 'required|string',
            </#if>
            <#if fieldSimple.nombre>
            '${fieldSimple.name?uncap_first}' => 'required|numeric',
            </#if>
            <#if fieldSimple.bool>
            '${fieldSimple.name?uncap_first}' => 'required|boolean',
            </#if>
            <#if fieldSimple.type.simpleName == "Date" ||  fieldSimple.dateTime>
            '${fieldSimple.name?uncap_first}' => 'required|date',
            </#if>
        </#if>
    </#if>
</#list>

<#list permissions[0].pojo.fieldsGeneric as fieldGeneric>
    <#if fieldGeneric.pojo??>
            '${fieldGeneric.name?uncap_first}_id' => 'required|exists:${fieldGeneric.typeAsPojo.formatedDataBase},id',
    </#if>
</#list>
        ]);

<#list permissions[0].pojo.fields as field>
    <#if field.list && (field.associationComplex || field.fakeAssociation)>
        $validated${field.name?cap_first} = $request->validate([
        <#list field.typeAsPojo.fields as innerField>
        <#if innerField.id == false>
            <#if innerField.pureString>
            '${field.name?uncap_first}.*.${innerField.name?uncap_first}' => 'required|string',
            </#if>
            <#if innerField.nombre>
            '${field.name?uncap_first}.*.${innerField.name?uncap_first}' => 'required|numeric',
            </#if>
            <#if innerField.bool>
            '${field.name?uncap_first}.*.${innerField.name?uncap_first}' => 'required|boolean',
            </#if>
            <#if innerField.type.simpleName == "Date" ||  innerField.dateTime>
            '${field.name?uncap_first}.*.${innerField.name?uncap_first}' => 'required|date',
            </#if>
        </#if>
        <#if innerField.generic && innerField.typeAsPojo.name != permissions[0].pojo.name>
            '${field.name?uncap_first}.*.product_id' => 'required|exists:${innerField.formatedUrl},id',
        </#if>
        </#list>
        ]);
    </#if>
</#list>

        return $this->service->save($validated,<#list permissions[0].pojo.fields as field> <#if field.list>$validated${field.name?cap_first}['${field.name?uncap_first}'], </#if></#list>);

    }

    public function deleteById($id) {
        return $this->service->deleteById($id);
    }

    public function findAll() {
        $items = $this->service->findAll();

        return  $items;
    }

<#list permissions[0].pojo.fieldsGeneric as fieldGeneric>
    <#if  (true || fieldGeneric.deleteByInclusion)  && fieldGeneric.pojo.msExterne ==false>
        <#if (fieldGeneric.typeAsPojo.state == false)>
    public function findBy${fieldGeneric.name?cap_first}Id($id) {
        return $this->service->findBy${fieldGeneric.name?cap_first}Id($id);
    }

    public function deleteBy${fieldGeneric.name?cap_first}Id($id) {
        return  $this->service->deleteBy${fieldGeneric.name?cap_first}Id($id);
    }

        </#if>
    </#if>
</#list>

<#if permissions[0].pojo.hasList == true>
    public function findWithAssociatedLists($id) {
        return  $this->service->findWithAssociatedLists($id);
    }
</#if>

<#if permissions[0].pojo.labelOrReference??>
    public function findAllOptimized() {
        return $this->service->findAllOptimized();
    }
</#if>

    public function findById($id) {
        return $this->service->findById($id);
    }
}
