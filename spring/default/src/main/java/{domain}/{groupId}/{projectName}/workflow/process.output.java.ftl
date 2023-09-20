package ${config.domain}.${config.groupId}.${config.projectName}.workflow.${role.name}.process.${pojo.name?lower_case}.${process.name?lower_case};

<#if pojo.hasList>
import java.util.List;
</#if>
<#if pojo.hasDateTime>
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
        <#if dependency?? && dependency.name??>
            <#if dependency.msExterne == false>
import ${config.domain}.${config.groupId}.${config.projectName}.ws.dto.${dependency.subModule.folder}.${dependency.name?cap_first}Dto;
            <#else>
import ${config.domain}.${config.groupId}.${config.projectName}.required.dto.${dependency.msPackaging}.${dependency.name?cap_first}Dto;
            </#if>
        </#if>
    </#list>
</#if>
import ${config.domain}.${config.groupId}.${config.projectName}.zynerator.audit.Log;
import ${config.domain}.${config.groupId}.${config.projectName}.zynerator.dto.AuditBaseDto;
import com.fasterxml.jackson.annotation.JsonInclude;
import ${config.domain}.${config.groupId}.${config.projectName}.zynerator.process.AbstractProcessOutput;


@JsonInclude(JsonInclude.Include.NON_NULL)
public class ${pojo.name}${process.name?cap_first}${role.name?cap_first}Output  extends AbstractProcessOutput {

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
}
