package  ${config.domain}.${config.groupId}.${config.projectName}.required.criteria.${pojo.msPackaging};

import ${config.domain}.${config.groupId}.${config.projectName}.zynerator.criteria.BaseCriteria;
<#if true || pojo.hasGeneric>
    import java.util.List;
</#if>
<#if pojo.hasDateTime>
    import com.fasterxml.jackson.annotation.JsonFormat;
    import ${config.domain}.${config.groupId}.${config.projectName}.zynerator.criteria.BaseCriteria;
    import java.time.LocalDateTime;
</#if>



public class ${pojo.name}Criteria extends BaseCriteria {

<#list pojo.fieldsSimple as fieldSimple>
    <#if  !fieldSimple.id>
        <#if  fieldSimple.dateTime>
    private LocalDateTime ${fieldSimple.name};
    private LocalDateTime ${fieldSimple.name}From;
    private LocalDateTime ${fieldSimple.name}To;
        <#elseif fieldSimple.nombre>
    private String ${fieldSimple.name};
    private String ${fieldSimple.name}Min;
    private String ${fieldSimple.name}Max;
        <#elseif fieldSimple.bool>
    private ${fieldSimple.type.name} ${fieldSimple.name};
        <#elseif !fieldSimple.large>
    private String ${fieldSimple.name};
    private String ${fieldSimple.name}Like;
        </#if>
    </#if>
</#list>

<#list pojo.fieldsGeneric as fieldGeneric>
<#if fieldGeneric.typeAsPojo??>
    private ${fieldGeneric.typeAsPojo.name}Criteria ${fieldGeneric.name} ;
    private List<${fieldGeneric.typeAsPojo.name}Criteria> ${fieldGeneric.name}s ;
    </#if>
    </#list>

    <#list pojo.fields as field>
        <#if field.list>
        </#if>
    </#list>

    public ${pojo.name}Criteria(){}

    <#list pojo.fieldsSimple as fieldSimple>
        <#if  !fieldSimple.id>
            <#if  fieldSimple.dateTime>
    public LocalDateTime get${fieldSimple.name?cap_first}(){
        return this.${fieldSimple.name};
    }
    public void set${fieldSimple.name?cap_first}(LocalDateTime ${fieldSimple.name}){
        this.${fieldSimple.name} = ${fieldSimple.name};
    }
    public LocalDateTime get${fieldSimple.name?cap_first}From(){
        return this.${fieldSimple.name}From;
    }
    public void set${fieldSimple.name?cap_first}From(LocalDateTime ${fieldSimple.name}From){
        this.${fieldSimple.name}From = ${fieldSimple.name}From;
    }
    public LocalDateTime get${fieldSimple.name?cap_first}To(){
        return this.${fieldSimple.name}To;
    }
    public void set${fieldSimple.name?cap_first}To(LocalDateTime ${fieldSimple.name}To){
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
<#elseif !fieldSimple.large>
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
    </#list>
    <#list pojo.fields as field>
        <#if field.list>
        </#if>
    </#list>
}
