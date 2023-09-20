package  ${config.domain}.${config.groupId}.${config.projectName}.${config.ws}.dto<#if pojo.subModule.folder??>.${pojo.subModule.folder}</#if>;

import ${config.domain}.${config.groupId}.${config.projectName}.zynerator.audit.Log;
import ${config.domain}.${config.groupId}.${config.projectName}.zynerator.dto.AuditBaseDto<#if pojo.enhanced>Enhanced</#if>;
import com.fasterxml.jackson.annotation.JsonInclude;

<#if pojo.actor>
import ${config.domain}.${config.groupId}.${config.projectName}.zynerator.security.bean.Role;
import java.util.Collection;
</#if>
<#if pojo.hasList>
import java.util.List;
</#if>
<#if pojo.hasDateTime || pojo.hasDate || pojo.hasLocalDate>
import java.util.Date;
import jakarta.persistence.Temporal;
import jakarta.persistence.TemporalType;
import com.fasterxml.jackson.annotation.JsonFormat;
</#if>
<#if pojo.hasBigDecimal>
import java.math.BigDecimal;
</#if>


<#if pojo.dependencies??>
    <#list pojo.dependencies as dependency>
        <#if dependency?? && dependency.name?? && dependency.subModule.folder != pojo.subModule.folder>
import ${config.domain}.${config.groupId}.${config.projectName}.${config.ws}.dto.${dependency.subModule.folder}.${dependency.name}Dto;
        </#if>
    </#list>
</#if>


@JsonInclude(JsonInclude.Include.NON_NULL)
public class ${pojo.name}Dto  extends <#if pojo.subEntity>${pojo.superEntity.name}Dto<#else>AuditBaseDto<#if pojo.enhanced>Enhanced</#if></#if> {

<#list pojo.fieldsSimple as fieldSimple>
    <#if  fieldSimple.dateTime || fieldSimple.date>
    ${pojo.attributeVisibility} String ${fieldSimple.name} ;
    <#elseif !fieldSimple.id>
    ${pojo.attributeVisibility} ${fieldSimple.type.name} ${fieldSimple.name} <#if  fieldSimple.integerNumber> = 0</#if> ;
    </#if>
</#list>

<#list pojo.fieldsGeneric as fieldGeneric>
    <#if fieldGeneric.typeAsPojo??>
    ${pojo.attributeVisibility} ${fieldGeneric.typeAsPojo.name}Dto ${fieldGeneric.name?uncap_first} ;
    </#if>
</#list>

<#list pojo.fields as field>
<#if field.list>
    ${pojo.attributeVisibility} List<${field.type.simpleName}Dto> ${field.name} ;
    </#if>
</#list>

<#if config.groupId == "enova">
<#list pojo.fields as field>
    <#if field.list && field.association>
    ${pojo.attributeVisibility} List<${field.fieldOfAssociation.typeAsPojo.name}Dto> ${field.fieldOfAssociation.name} ;
    </#if>
</#list>
</#if>

<#if pojo.actor>
    private Collection<Role> roles;
</#if>
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

    public void set${fieldGeneric.name?cap_first}(${fieldGeneric.type.simpleName}Dto ${fieldGeneric.name}){
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

<#if config.groupId == "enova">
<#list pojo.fields as field>
<#if field.list && field.association>
    public List<${field.fieldOfAssociation.type.simpleName}Dto> get${field.fieldOfAssociation.name?cap_first}(){
        return this.${field.fieldOfAssociation.name};
    }

    public void set${field.fieldOfAssociation.name?cap_first}(List<${field.fieldOfAssociation.type.simpleName}Dto> ${field.fieldOfAssociation.name}){
        this.${field.fieldOfAssociation.name} = ${field.fieldOfAssociation.name};
    }
</#if>
</#list>
</#if>


<#if pojo.actor>

    public Collection<Role> getRoles() {
        return roles;
    }

    public void setRoles(Collection<Role> roles) {
        this.roles = roles;
    }
</#if>
}
