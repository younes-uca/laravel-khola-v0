package  ${config.domain}.${config.groupId}.${config.projectName}.${config.dao}.criteria.core<#if pojo.subModule.folder??>.${pojo.subModule.folder}</#if>;


<#if pojo.dependenciesImportationGeneric??>
    <#list pojo.dependenciesImportationGeneric as dependency>
        <#if dependency?? && dependency.name?? && dependency.subModule.folder != pojo.subModule.folder>
import ${config.domain}.${config.groupId}.${config.projectName}.${config.dao}.criteria.core.${dependency.subModule.folder}.${dependency.name}Criteria;
        </#if>
    </#list>
</#if>

<#if !pojo.subEntity>
import ${config.domain}.${config.groupId}.${config.projectName}.zynerator.criteria.BaseCriteria<#if pojo.enhanced>Enhanced</#if>;
</#if>
<#if true || pojo.hasGeneric>
import java.util.List;
</#if>
<#if pojo.hasDateTime>
import java.time.LocalDateTime;
</#if>
<#if pojo.hasDateTime>
import java.time.LocalDate;
</#if>

public class ${pojo.name}Criteria extends <#if !pojo.subEntity> BaseCriteria<#if pojo.enhanced>Enhanced</#if> <#else> ${pojo.superEntity.name}Criteria</#if> {

<#list pojo.fieldsSimple as fieldSimple>
     <#if  !fieldSimple.id>
        <#if  fieldSimple.dateTime || fieldSimple.localDate>
    ${pojo.attributeVisibility} ${fieldSimple.type.name} ${fieldSimple.name};
    ${pojo.attributeVisibility} ${fieldSimple.type.name} ${fieldSimple.name}From;
    ${pojo.attributeVisibility} ${fieldSimple.type.name} ${fieldSimple.name}To;
         <#elseif fieldSimple.nombre>
    ${pojo.attributeVisibility} String ${fieldSimple.name};
    ${pojo.attributeVisibility} String ${fieldSimple.name}Min;
    ${pojo.attributeVisibility} String ${fieldSimple.name}Max;
        <#elseif fieldSimple.bool>
    ${pojo.attributeVisibility} ${fieldSimple.type.name} ${fieldSimple.name};
        <#elseif true || !fieldSimple.large>
    ${pojo.attributeVisibility} String ${fieldSimple.name};
    ${pojo.attributeVisibility} String ${fieldSimple.name}Like;
        </#if>
    </#if>
</#list>

<#list pojo.fieldsGeneric as fieldGeneric>
    <#if fieldGeneric.typeAsPojo?? && (true || (fieldGeneric.typeAsPojo.msExterne && fieldGeneric.typeAsPojo.msPackaging != pojo.msPackaging))>
    ${pojo.attributeVisibility} ${fieldGeneric.typeAsPojo.name}Criteria ${fieldGeneric.name} ;
    ${pojo.attributeVisibility} List<${fieldGeneric.typeAsPojo.name}Criteria> ${fieldGeneric.name}s ;
    </#if>
</#list>

<#list pojo.fields as field>
    <#if field.list>
    </#if>
</#list>

    public ${pojo.name}Criteria(){}

<#list pojo.fieldsSimple as fieldSimple>
    <#if  !fieldSimple.id>
     <#if  fieldSimple.dateTime || fieldSimple.localDate >
    public ${fieldSimple.type.name} get${fieldSimple.name?cap_first}(){
        return this.${fieldSimple.name};
    }
    public void set${fieldSimple.name?cap_first}(${fieldSimple.type.name} ${fieldSimple.name}){
        this.${fieldSimple.name} = ${fieldSimple.name};
    }
    public ${fieldSimple.type.name} get${fieldSimple.name?cap_first}From(){
        return this.${fieldSimple.name}From;
    }
    public void set${fieldSimple.name?cap_first}From(${fieldSimple.type.name} ${fieldSimple.name}From){
        this.${fieldSimple.name}From = ${fieldSimple.name}From;
    }
    public ${fieldSimple.type.name} get${fieldSimple.name?cap_first}To(){
        return this.${fieldSimple.name}To;
    }
    public void set${fieldSimple.name?cap_first}To(${fieldSimple.type.name} ${fieldSimple.name}To){
        this.${fieldSimple.name}To = ${fieldSimple.name}To;
    }
  <#elseif fieldSimple.nombre>
    public String get${fieldSimple.name?cap_first}(){
        return this.${fieldSimple.name};
    }
    public void set${fieldSimple.name?cap_first}(String ${fieldSimple.name}){
        this.${fieldSimple.name} = ${fieldSimple.name};
    }   
    public String get${fieldSimple.name?cap_first}Min(){
        return this.${fieldSimple.name}Min;
    }
    public void set${fieldSimple.name?cap_first}Min(String ${fieldSimple.name}Min){
        this.${fieldSimple.name}Min = ${fieldSimple.name}Min;
    }
    public String get${fieldSimple.name?cap_first}Max(){
        return this.${fieldSimple.name}Max;
    }
    public void set${fieldSimple.name?cap_first}Max(String ${fieldSimple.name}Max){
        this.${fieldSimple.name}Max = ${fieldSimple.name}Max;
    }
      
  <#elseif fieldSimple.bool>
    public Boolean get${fieldSimple.name?cap_first}(){
        return this.${fieldSimple.name};
    }
    public void set${fieldSimple.name?cap_first}(Boolean ${fieldSimple.name}){
        this.${fieldSimple.name} = ${fieldSimple.name};
    }
 <#elseif true || (fieldSimple.string &&  fieldSimple.pureString )>
    public String get${fieldSimple.name?cap_first}(){
        return this.${fieldSimple.name};
    }
    public void set${fieldSimple.name?cap_first}(String ${fieldSimple.name}){
        this.${fieldSimple.name} = ${fieldSimple.name};
    }
    public String get${fieldSimple.name?cap_first}Like(){
        return this.${fieldSimple.name}Like;
    }
    public void set${fieldSimple.name?cap_first}Like(String ${fieldSimple.name}Like){
        this.${fieldSimple.name}Like = ${fieldSimple.name}Like;
    }

        </#if>
    </#if>
</#list>

<#list pojo.fieldsGeneric as fieldGeneric>
    <#if fieldGeneric.typeAsPojo?? && (true || (fieldGeneric.typeAsPojo.msExterne && fieldGeneric.typeAsPojo.msPackaging != pojo.msPackaging))>
    public ${fieldGeneric.typeAsPojo.name}Criteria get${fieldGeneric.name?cap_first}(){
        return this.${fieldGeneric.name};
    }

    public void set${fieldGeneric.name?cap_first}(${fieldGeneric.typeAsPojo.name}Criteria ${fieldGeneric.name}){
        this.${fieldGeneric.name} = ${fieldGeneric.name};
    }
    public List<${fieldGeneric.typeAsPojo.name}Criteria> get${fieldGeneric.name?cap_first}s(){
        return this.${fieldGeneric.name}s;
    }

    public void set${fieldGeneric.name?cap_first}s(List<${fieldGeneric.typeAsPojo.name}Criteria> ${fieldGeneric.name}s){
        this.${fieldGeneric.name}s = ${fieldGeneric.name}s;
    }
    </#if>
</#list>
}
