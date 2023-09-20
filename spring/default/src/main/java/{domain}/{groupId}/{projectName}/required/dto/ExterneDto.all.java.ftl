package  ${config.domain}.${config.groupId}.${config.projectName}.required.dto.${pojo.msPackaging};

import com.fasterxml.jackson.annotation.JsonInclude;
<#if pojo.hasDateTime || pojo.hasDate>
import com.fasterxml.jackson.annotation.JsonFormat;
</#if>

<#if pojo.hasList>
import java.util.List;
</#if>

<#if pojo.hasBigDecimal>
import java.math.BigDecimal;
</#if>

import ${config.domain}.${config.groupId}.${config.projectName}.zynerator.audit.Log;
import ${config.domain}.${config.groupId}.${config.projectName}.zynerator.dto.AuditBaseDto;

<#if pojo.dependencies??>
    <#list pojo.dependencies as dependency>
        <#if dependency?? && dependency.name?? && dependency.msPackaging != pojo.msPackaging>
            <#if dependency.msExterne == true>
import ${config.domain}.${config.groupId}.${config.projectName}.required.dto.${dependency.msPackaging}.${dependency.name}Dto;
            <#else>
import ${config.domain}.${config.groupId}.${config.projectName}.ws.dto.${dependency.name}Dto;
            </#if>        </#if>
    </#list>
</#if>

@JsonInclude(JsonInclude.Include.NON_NULL)
public class ${pojo.name}Dto extends AuditBaseDto {

<#list pojo.fieldsSimple as fieldSimple>
   <#if  fieldSimple.dateTime || fieldSimple.date>
    private String ${fieldSimple.name} ;
    <#elseif !fieldSimple.id>
    private ${fieldSimple.type.name} ${fieldSimple.name} <#if  fieldSimple.integerNumber> = 0</#if> ;
   </#if>
</#list>

<#list pojo.fieldsGeneric as fieldGeneric>
    <#if fieldGeneric.typeAsPojo??>
    private ${fieldGeneric.typeAsPojo.name}Dto ${fieldGeneric.name?uncap_first} ;
    </#if>
</#list>

<#list pojo.fields as field>
    <#if field.list>
    private List<${field.type.simpleName}Dto> ${field.name} ;
    </#if>
</#list>

    public ${pojo.name}Dto(){
        super();
    }


<#list pojo.fieldsSimple as fieldSimple>
    <#if  fieldSimple.dateTime || fieldSimple.date>
    @Log
    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "dd/MM/yyyy HH:mm")
    public String get${fieldSimple.name?cap_first}(){
        return this.${fieldSimple.name};
    }
    public void set${fieldSimple.name?cap_first}(String ${fieldSimple.name}){
        this.${fieldSimple.name} = ${fieldSimple.name};
    }
    <#elseif !fieldSimple.id>
    @Log
    public ${fieldSimple.type.name} get${fieldSimple.name?cap_first}(){
        return this.${fieldSimple.name};
    }
    public void set${fieldSimple.name?cap_first}(${fieldSimple.type.name} ${fieldSimple.name}){
         this.${fieldSimple.name} = ${fieldSimple.name};
    }
    </#if>

</#list>

<#list pojo.fieldsGeneric as fieldGeneric>
    public ${fieldGeneric.type.simpleName}Dto get${fieldGeneric.name?cap_first}(){
        return this.${fieldGeneric.name};
    }

    public void set${fieldGeneric.name?cap_first}Dto(${fieldGeneric.type.simpleName}Dto ${fieldGeneric.name}){
        this.${fieldGeneric.name} = ${fieldGeneric.name};
    }
</#list>

<#list pojo.fields as field>
    <#if field.list>
    public List<${field.type.simpleName}Dto> get${field.name?cap_first}(){
         return this.${field.name};
    }

    public void set${field.name?cap_first}(List<${field.type.simpleName}Dto> ${field.name}){
        this.${field.name} = ${field.name};
    }
    </#if>
</#list>

}
