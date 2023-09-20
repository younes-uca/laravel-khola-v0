package ${config.domain}.${config.groupId}.${config.projectName}.workflow.${role.name}.process.${pojo.name?lower_case}.${process.name?lower_case};

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
<#if pojo.hasList>
import ${config.domain}.${config.groupId}.${config.projectName}.zynerator.util.ListUtil;
</#if>

<#list pojo.fieldsGeneric as fieldGeneric>
    <#if (fieldGeneric.pojo.name)?? && pojo.name != fieldGeneric.pojo.name>
        <#if fieldGeneric.pojo.msExterne == false && fieldGeneric.eligibleForStackOverFlow == true>
import ${config.domain}.${config.groupId}.${config.projectName}.bean.core.${fieldGeneric.typeAsPojo.subModule.folder}.${fieldGeneric.pojo.name};
        </#if>
    </#if>
</#list>

<#if pojo.dependencies??>
    <#list pojo.dependencies as dependency>
        <#if dependency?? && dependency.name?? && dependency.msExterne == false>
import ${config.domain}.${config.groupId}.${config.projectName}.ws.converter.${dependency.subModule.folder}.${dependency.name}Converter;
        </#if>
    </#list>
</#if>
import ${config.domain}.${config.groupId}.${config.projectName}.zynerator.util.StringUtil;
import ${config.domain}.${config.groupId}.${config.projectName}.zynerator.process.AbstractProcessConverter;
import ${config.domain}.${config.groupId}.${config.projectName}.zynerator.util.DateUtil;
import ${config.domain}.${config.groupId}.${config.projectName}.${config.bean}.core.${pojo.subModule.folder}.${pojo.name};

@Component
public class ${pojo.name}${process.name?cap_first}${role.name?cap_first}Converter extends AbstractProcessConverter<${pojo.name}${process.name?cap_first}${role.name?cap_first}Input,${pojo.name}${process.name?cap_first}${role.name?cap_first}Output,${pojo.name}> {

<#if pojo.dependencies??>
    <#list pojo.dependencies as dependency>
        <#if dependency?? && dependency.name?? && dependency.msExterne == false>
    @Autowired
    private ${dependency.name}Converter ${dependency.name?uncap_first}Converter ;
        </#if>
    </#list>
</#if>
<#list pojo.fieldsGeneric as fieldGeneric>
    private boolean ${fieldGeneric.name};
</#list>
<#list pojo.fields as fieldList>
    <#if fieldList.list == true>
    private boolean ${fieldList.name};
    </#if>
</#list>

    public ${pojo.name}${process.name?cap_first}${role.name?cap_first}Converter(){
        super(${pojo.name}.class, ${pojo.name}${process.name?cap_first}${role.name?cap_first}Input.class, ${pojo.name}${process.name?cap_first}${role.name?cap_first}Output.class);
    }

    @Override
    public ${pojo.name} toItem(${pojo.name}${process.name?cap_first}${role.name?cap_first}Input input) {
        if (input == null) {
            return null;
        } else {
            ${pojo.name} item = new ${pojo.name}();
<#list pojo.fieldsSimple as fieldSimple>
    <#if fieldSimple.dateTime>
            if(StringUtil.isNotEmpty(input.get${fieldSimple.name?cap_first}()))
                item.set${fieldSimple.name?cap_first}(DateUtil.stringEnToDate(input.get${fieldSimple.name?cap_first}()));
    <#elseif fieldSimple.bool && pojo.actor && fieldSimple.boolFrameWork>
            item.set${fieldSimple.name?cap_first}(input.get${fieldSimple.name?cap_first}());
    <#elseif fieldSimple.bool>
            if(input.get${fieldSimple.name?cap_first}() != null)
                item.set${fieldSimple.name?cap_first}(input.get${fieldSimple.name?cap_first}());
    <#else>
            if(StringUtil.isNotEmpty(input.get${fieldSimple.name?cap_first}()))
                item.set${fieldSimple.name?cap_first}(input.get${fieldSimple.name?cap_first}());
    </#if>
</#list>
<#list pojo.fieldsGeneric as fieldGeneric>
    <#if (fieldGeneric.pojo.name)?? && pojo.name != fieldGeneric.pojo.name>
        <#if fieldGeneric.pojo.msExterne == false && fieldGeneric.eligibleForStackOverFlow == true>
            if(input.get${fieldGeneric.name?cap_first}() != null && input.get${fieldGeneric.name?cap_first}().get${fieldGeneric.pojo.id.name?cap_first}() != null){
                item.set${fieldGeneric.name?cap_first}(new ${fieldGeneric.typeAsPojo.name}());
                item.get${fieldGeneric.name?cap_first}().set${fieldGeneric.pojo.id.name?cap_first}(input.get${fieldGeneric.name?cap_first}().get${fieldGeneric.pojo.id.name?cap_first}());
            }
        <#elseif fieldGeneric.pojo.msExterne == false && fieldGeneric.eligibleForStackOverFlow == false>
            if(this.${fieldGeneric.name} && input.get${fieldGeneric.name?cap_first}()!=null)
                item.set${fieldGeneric.name?cap_first}(${fieldGeneric.type.simpleName?uncap_first}Converter.toItem(input.get${fieldGeneric.name?cap_first}())) ;
        <#else>
            if(this.${fieldGeneric.name} && input.get${fieldGeneric.name?cap_first}()!=null)
                item.set${fieldGeneric.name?cap_first}(input.get${fieldGeneric.name?cap_first}()) ;
        </#if>
    <#else>
            if(this.${fieldGeneric.name} && input.get${fieldGeneric.name?cap_first}()!=null)
                item.set${fieldGeneric.name?cap_first}(toItem(input.get${fieldGeneric.name?cap_first}())) ;
    </#if>

</#list>

<#list pojo.fields as fieldList>
    <#if fieldList.list>
            if(this.${fieldList.name} && ListUtil.isNotEmpty(input.get${fieldList.name?cap_first}()))
        <#if pojo.name != fieldList.pojo.name>
                item.set${fieldList.name?cap_first}(${fieldList.type.simpleName?uncap_first}Converter.toItem(input.get${fieldList.name?cap_first}()));
        <#else>
                item.set${fieldList.name?cap_first}(toItem(input.get${fieldList.name?cap_first}()));
        </#if>
    </#if>
</#list>

        return item;
        }
    }

    @Override
    public ${pojo.name}${process.name?cap_first}${role.name?cap_first}Output toOutput(${pojo.name} item) {
        if (item == null) {
            return null;
        } else {
            ${pojo.name}${process.name?cap_first}${role.name?cap_first}Output output = new ${pojo.name}${process.name?cap_first}${role.name?cap_first}Output();
<#list pojo.fieldsSimple as fieldSimple>
    <#if fieldSimple.dateTime >
            if(item.get${fieldSimple.name?cap_first}()!=null)
                output.set${fieldSimple.name?cap_first}(DateUtil.dateTimeToString(item.get${fieldSimple.name?cap_first}()));
    <#elseif fieldSimple.bool && !fieldSimple.boolFrameWork>
                output.set${fieldSimple.name?cap_first}(item.get${fieldSimple.name?cap_first}());
    <#else>
            if(StringUtil.isNotEmpty(item.get${fieldSimple.name?cap_first}()))
                output.set${fieldSimple.name?cap_first}(item.get${fieldSimple.name?cap_first}());
    </#if>
</#list>
<#list pojo.fieldsGeneric as fieldGeneric>
            if(this.${fieldGeneric.name} && item.get${fieldGeneric.name?cap_first}()!=null) {
    <#if (fieldGeneric.pojo.name)?? && pojo.name != fieldGeneric.pojo.name>
        <#list fieldGeneric.typeAsPojo.fields as fieldsGenericOfThisField>
            <#if fieldsGenericOfThisField.generic && fieldsGenericOfThisField.typeAsPojo.name == pojo.name && fieldGeneric.pojo.msExterne == false>
            ${fieldGeneric.type.simpleName?uncap_first}Converter.set${fieldsGenericOfThisField.name?cap_first}(false);
            </#if>
        </#list>
        <#if fieldGeneric.pojo.msExterne == false>
                output.set${fieldGeneric.name?cap_first}(${fieldGeneric.type.simpleName?uncap_first}Converter.toDto(item.get${fieldGeneric.name?cap_first}())) ;
        <#else>
                output.set${fieldGeneric.name?cap_first}(item.get${fieldGeneric.name?cap_first}()) ;
        </#if>
        <#list fieldGeneric.typeAsPojo.fields as fieldsGenericOfThisField>
            <#if fieldsGenericOfThisField.generic && fieldsGenericOfThisField.typeAsPojo.name == pojo.name  && fieldGeneric.pojo.msExterne == false>
                ${fieldGeneric.type.simpleName?uncap_first}Converter.set${fieldsGenericOfThisField.name?cap_first}(true);
            </#if>
        </#list>
    <#elseif (fieldGeneric.pojo.fields)??>
        <#list fieldGeneric.typeAsPojo.fields as fieldsGenericOfThisField>
            <#if fieldsGenericOfThisField.generic && fieldsGenericOfThisField.typeAsPojo.name == pojo.name>
            this.set${fieldsGenericOfThisField.name?cap_first}(false);
            </#if>
        </#list>
            output.set${fieldGeneric.name?cap_first}(toDto(item.get${fieldGeneric.name?cap_first}())) ;
        <#list fieldGeneric.typeAsPojo.fields as fieldsGenericOfThisField>
            <#if fieldsGenericOfThisField.generic && fieldsGenericOfThisField.typeAsPojo.name == pojo.name>
            this.set${fieldsGenericOfThisField.name?cap_first}(true);
            </#if>
        </#list>
    </#if>
    }
</#list>
<#list pojo.fields as fieldList>
    <#if fieldList.list == true>
        if(this.${fieldList.name} && ListUtil.isNotEmpty(item.get${fieldList.name?cap_first}())){
        <#if (pojo.hasList || pojo.hasGeneric)  && pojo.msExterne == false>
            ${fieldList.type.simpleName?uncap_first}Converter.init(true);
        </#if>
        <#if  pojo.msExterne == false>
            ${fieldList.type.simpleName?uncap_first}Converter.set${pojo.name?cap_first}(false);
            output.set${fieldList.name?cap_first}(${fieldList.type.simpleName?uncap_first}Converter.toDto(item.get${fieldList.name?cap_first}()));
            ${fieldList.type.simpleName?uncap_first}Converter.set${pojo.name?cap_first}(true);
        <#else>
            output.set${fieldList.name?cap_first}(item.get${fieldList.name?cap_first}());
        </#if>

        }
    </#if>
</#list>
        return output;
    }
}



<#if pojo.dependencies??>
    <#list pojo.dependencies as dependency>
        <#if dependency?? && dependency.name?? && dependency.msExterne == false>
    public ${dependency.name}Converter get${dependency.name}Converter(){
        return this.${dependency.name?uncap_first}Converter;
    }
    public void set${dependency.name}Converter(${dependency.name}Converter ${dependency.name?uncap_first}Converter ){
        this.${dependency.name?uncap_first}Converter = ${dependency.name?uncap_first}Converter;
    }
        </#if>
    </#list>
</#if>


<#list pojo.fieldsGeneric as fieldGeneric>
    public boolean  is${fieldGeneric.name?cap_first}(){
        return this.${fieldGeneric.name};
    }
    public void  set${fieldGeneric.name?cap_first}(boolean ${fieldGeneric.name}){
        this.${fieldGeneric.name} = ${fieldGeneric.name};
    }
</#list>
<#list pojo.fields as fieldList>
    <#if fieldList.list == true>
    public boolean  is${fieldList.name?cap_first}(){
        return this.${fieldList.name} ;
    }
    public void  set${fieldList.name?cap_first}(boolean ${fieldList.name} ){
        this.${fieldList.name}  = ${fieldList.name} ;
    }
    </#if>
</#list>
}
