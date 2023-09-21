<?php

namespace App\Models<#if pojo.subModule.folder??>\${pojo.subModule.folder}</#if>;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;

class ${pojo.name} extends Model
{
    protected $table = '${pojo.formatedDataBase}';
    protected $fillable = [
<#list pojo.fieldsSimple as fieldSimple>
    <#if pojo.id.name != fieldSimple.name>
        <#if fieldSimple.id == false>
        '${fieldSimple.name?uncap_first}',
        </#if>
    </#if>
</#list>
<#list pojo.fieldsGeneric as fieldGeneric>
    <#if fieldGeneric.pojo??>
        '${fieldSimple.name?uncap_first}_id',
    </#if>
</#list>
    ];

<#list pojo.fieldsGeneric as fieldGeneric>
    <#if fieldGeneric.pojo??>
    public function ${fieldGeneric.name?uncap_first}(): BelongsTo {
        return $this->belongsTo(${fieldGeneric.pojo.name}::class);
    }
    </#if>
</#list>

<#list pojo.fields as field>
    <#if field.list>
    public function ${field.name?uncap_first}(): HasMany {
        return $this->hasMany(${field.typeAsPojo.name}::class);
    }
    </#if>
</#list>

}


