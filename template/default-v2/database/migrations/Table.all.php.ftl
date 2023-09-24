<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('${pojo.formatedDataBase}', function (Blueprint $table) {
            $table->id();
<#list pojo.fieldsSimple as fieldSimple>
    <#if pojo.id.name != fieldSimple.name>
        <#if fieldSimple.id == false>
            <#if fieldSimple.pureString>
            $table->string('${fieldSimple.name?uncap_first}')->required();
            </#if>
            <#if fieldSimple.nombre>
            $table->decimal('${fieldSimple.name?uncap_first}', 10, 2);
            </#if>
            <#if fieldSimple.bool>
             $table->boolean('${fieldSimple.name?uncap_first}')->default(false);
            </#if>
            <#if fieldSimple.type.simpleName == "Date" ||  fieldSimple.dateTime>
            $table->dateTime('${fieldSimple.name?uncap_first}');
            </#if>
        </#if>
    </#if>
</#list>

<#list pojo.fieldsGeneric as fieldGeneric>
    <#if fieldGeneric.pojo??>
            $table->unsignedBigInteger('${fieldGeneric.name?uncap_first}_id');
            $table->foreign('${fieldGeneric.name?uncap_first}_id')->references('id')->on('${fieldGeneric.typeAsPojo.formatedDataBase}');
    </#if>
</#list>
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('${pojo.formatedDataBase}');
    }
};
