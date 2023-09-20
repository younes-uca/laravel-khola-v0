package ${config.domain}.${config.groupId}.${config.projectName}.${config.bean}.core<#if pojo.subModule.folder??>.${pojo.subModule.folder}</#if>;

import java.util.Objects;
<#if pojo.hasList>
import java.util.List;
</#if>

<#if pojo.hasDateTime>
import java.time.LocalDateTime;
</#if>

<#if pojo.hasLocalDate>
import java.time.LocalDate;
</#if>

<#if pojo.hasDate>
import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;
</#if>


<#if pojo.dependencies??>
    <#list pojo.dependencies as dependency>
        <#if dependency?? && dependency.name?? && dependency.subModule.folder != pojo.subModule.folder>
import ${config.domain}.${config.groupId}.${config.projectName}.${config.bean}.core.${dependency.subModule.folder}.${dependency.name};
        </#if>
    </#list>
</#if>


import com.fasterxml.jackson.annotation.JsonInclude;
<#if !pojo.subEntity>
import ${config.domain}.${config.groupId}.${config.projectName}.zynerator.audit.AuditBusinessObject<#if pojo.enhanced>Enhanced</#if>;
</#if>
import jakarta.persistence.*;
import java.util.Objects;


<#if pojo.hasBigDecimal>
import java.math.BigDecimal;
</#if>

<#if pojo.actor>
import ${config.domain}.${config.groupId}.${config.projectName}.zynerator.${config.security}.${config.bean}.User;
</#if>
<#if pojo.baseEntityNoTable>
import jakarta.persistence.MappedSuperclass;
</#if>

@Entity
@Table(name = "${pojo.formatedDataBase}")
@JsonInclude(JsonInclude.Include.NON_NULL)
<#if !pojo.baseEntityNoTable>
@SequenceGenerator(name="${pojo.formatedDataBase}_seq",sequenceName="${pojo.formatedDataBase}_seq",allocationSize=1, initialValue = 1)
<#else>
@MappedSuperclass
</#if>
public class ${pojo.name} <#if pojo.actor> extends User <#elseif !pojo.subEntity>  extends AuditBusinessObject<#if pojo.enhanced>Enhanced</#if>  <#else> extends ${pojo.superEntity.name} </#if>  <#if pojo.archivable>  implements Archivable </#if> {

<#if !pojo.actor>
    ${pojo.attributeVisibility} ${pojo.id.type.simpleName} ${pojo.id.name};
</#if>

<#if pojo.actor>
    public ${pojo.name}(String username) {
        super(username);
    }
</#if>
<#if config.groupId == "enova" && pojo.fieldOfAssociation??>
    public ${pojo.name}(${pojo.fieldOfAssociation.typeAsPojo.name} ${pojo.fieldOfAssociation.typeAsPojo.name?uncap_first}) {
        this.${pojo.fieldOfAssociation.typeAsPojo.name?uncap_first} = ${pojo.fieldOfAssociation.typeAsPojo.name?uncap_first} ;
    }
</#if>
<#list pojo.fieldsSimple as fieldSimple>
    <#if pojo.id.name != fieldSimple.name>
        <#if fieldSimple.order && fieldSimple.nombre>
    @GeneratedValue(strategy = GenerationType.SEQUENCE)
        </#if>
        <#if  fieldSimple.notIncluded>
    @Transient
    ${pojo.attributeVisibility} ${fieldSimple.type.simpleName} ${fieldSimple.name};
        <#elseif fieldSimple.type.simpleName =="Date">
    @JsonFormat(pattern="yyyy-MM-dd")
    @Temporal(TemporalType.DATE)
    ${pojo.attributeVisibility} ${fieldSimple.type.simpleName} ${fieldSimple.name} ;
        <#elseif  fieldSimple.bool>
    @Column(columnDefinition = "boolean default false")
            <#if pojo.actor && fieldSimple.boolFrameWork>
    ${pojo.attributeVisibility} boolean ${fieldSimple.name} = false;
                <#else>
    ${pojo.attributeVisibility} Boolean ${fieldSimple.name} = false;
            </#if>
    <#elseif  fieldSimple.pureString>
    @Column(length = 500)
    ${pojo.attributeVisibility} String ${fieldSimple.name};
    <#elseif  fieldSimple.integerNumber>
    ${pojo.attributeVisibility} Integer ${fieldSimple.name} = 0;
    <#elseif  fieldSimple.bigDecimalNumber>
    ${pojo.attributeVisibility} BigDecimal ${fieldSimple.name} = BigDecimal.ZERO;
        <#elseif  fieldSimple.string && !fieldSimple.pureString>
    @Lob
    @Column(columnDefinition="TEXT")
    ${pojo.attributeVisibility} String ${fieldSimple.name};
        <#else>
    ${pojo.attributeVisibility} ${fieldSimple.type.simpleName} ${fieldSimple.name} ;
        </#if>
    </#if>
</#list>

<#list pojo.fieldsGeneric as fieldGeneric>
    ${pojo.attributeVisibility} ${fieldGeneric.type.simpleName} ${fieldGeneric.name} ;
</#list>

<#list pojo.fields as field>
   <#if field.list>
    ${pojo.attributeVisibility} List<${field.type.simpleName}> ${field.name} ;
   </#if>
</#list>

    public ${pojo.name}(){
        super();
    }

<#if pojo.labelOrReference??>
    public ${pojo.name}(Long id,${pojo.labelOrReference.type.name} ${pojo.labelOrReference.name}){
        this.id = id;
        this.${pojo.labelOrReference.name} = ${pojo.labelOrReference.name} ;
    }
</#if>
<#if pojo.state>
    public ${pojo.name}(String libelle,String code){
        this.libelle=libelle;
        this.code=code;
    }
</#if>




<#list pojo.fields as field>
    <#if !field.bool>
        <#if field.list>
    @OneToMany<#if field.mappedBy??>(mappedBy = "${field.mappedBy}")</#if>

    public List<${field.type.simpleName}> get${field.name?cap_first}(){
        return this.${field.name};
    }
    public void set${field.name?cap_first}(List<${field.type.simpleName}> ${field.name}){
        this.${field.name} = ${field.name};
    }
    <#else>
        <#if field.id && !pojo.baseEntityNoTable>
    @Id
    @Column(name = "${field.name}")
        @GeneratedValue(strategy = GenerationType.SEQUENCE,generator="${pojo.formatedDataBase}_seq")
    </#if>
    <#if field.generic>
    @ManyToOne(fetch = FetchType.LAZY)
    </#if>
    <#if field.generic || field.simple>
    public ${field.type.simpleName} get${field.name?cap_first}(){
        return this.${field.name};
    }
    public void set${field.name?cap_first}(${field.type.simpleName} ${field.name}){
        this.${field.name} = ${field.name};
    }
        </#if>
   </#if>
    <#else>
    public <#if field.boolFrameWork>boolean<#else>Boolean</#if>  get${field.name?cap_first}(){
        return this.${field.name};
    }
    public void set${field.name?cap_first}(<#if field.boolFrameWork>boolean<#else>Boolean</#if> ${field.name}){
        this.${field.name} = ${field.name};
    }
    </#if>
</#list>

   <#if pojo.labelOrReferenceOrId.name != pojo.id.name>
    @Transient
    public String getLabel() {
        label = ${pojo.labelOrReferenceOrId.name};
        return label;
    }
        </#if>

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        ${pojo.name?cap_first} ${pojo.name?uncap_first} = (${pojo.name?cap_first}) o;
        return ${pojo.id.name?uncap_first} != null && ${pojo.id.name?uncap_first}.equals(${pojo.name?uncap_first}.${pojo.id.name?uncap_first});
    }

    @Override
    public int hashCode() {
        return Objects.hash(${pojo.id.name?uncap_first});
    }

}

