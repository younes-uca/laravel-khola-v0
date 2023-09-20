package ${config.domain}.${config.groupId}.${config.projectName}.${config.dao}.facade.core<#if pojo.subModule.folder??>.${pojo.subModule.folder}</#if>;

<#if pojo.labelOrReference??>
import org.springframework.data.jpa.repository.Query;
</#if>
<#if !pojo.subEntity>
import ${config.domain}.${config.groupId}.${config.projectName}.zynerator.repository.AbstractRepository;
</#if>
import ${config.domain}.${config.groupId}.${config.projectName}.${config.bean}.core<#if pojo.subModule.folder??>.${pojo.subModule.folder}</#if>.${pojo.name};
<#if !pojo.baseEntityNoTable>
import org.springframework.stereotype.Repository;
<#else>
import org.springframework.data.repository.NoRepositoryBean;
</#if>
<#if pojo.reference??>
import ${config.domain}.${config.groupId}.${config.projectName}.bean.core<#if pojo.subModule.folder??>.${pojo.subModule.folder}</#if>.${pojo.name};
</#if>
<#if pojo.enhanced>
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
</#if>
<#if true || pojo.hasFindByInclusion==true >
import java.util.List;
</#if>

<#if pojo.calendar>
import org.springframework.data.repository.query.Param;
import org.springframework.data.jpa.repository.Query;
import ${config.domain}.${config.groupId}.${config.projectName}.zynerator.dto.ScheduleDto;
</#if>

<#if !pojo.baseEntityNoTable>
@Repository
<#else>
@NoRepositoryBean
</#if>
public interface ${pojo.name}Dao extends <#if !pojo.subEntity>AbstractRepository<${pojo.name},${pojo.id.type.simpleName}> <#else> ${pojo.superEntity.name}Dao</#if> {
<#if pojo.reference??>
    ${pojo.name} findBy${pojo.reference.name?cap_first}(${pojo.reference.type.simpleName} ${pojo.reference.name});
    int deleteBy${pojo.reference.name?cap_first}(${pojo.reference.type.simpleName} ${pojo.reference.name});
</#if>

<#list pojo.fieldsGeneric as fieldGeneric>
    <#if (fieldGeneric.pojo.id)??>
        <#if (true || fieldGeneric.findByInclusion) && fieldGeneric.pojo.msExterne ==false>
            <#if fieldGeneric.typeAsPojo.state == false>
    List<${pojo.name}> findBy${fieldGeneric.name?cap_first}${fieldGeneric.pojo.id.name?cap_first}(${fieldGeneric.pojo.id.type.simpleName} ${fieldGeneric.pojo.id.name});
            <#else>
    List<${pojo.name}> findBy${fieldGeneric.name?cap_first}${fieldGeneric.pojo.referenceOrId.name?cap_first}(${fieldGeneric.pojo.referenceOrId.type.simpleName} ${fieldGeneric.pojo.referenceOrId.name});
            </#if>
        </#if>
        <#if  (true || fieldGeneric.deleteByInclusion)  && fieldGeneric.pojo.msExterne ==false>
            <#if fieldGeneric.typeAsPojo.state == false>
    int deleteBy${fieldGeneric.name?cap_first}${fieldGeneric.pojo.id.name?cap_first}(${fieldGeneric.pojo.id.type.simpleName} ${fieldGeneric.pojo.id.name});
             <#else>
    int deleteBy${fieldGeneric.name?cap_first}${fieldGeneric.pojo.referenceOrId.name?cap_first}(${fieldGeneric.pojo.referenceOrId.type.simpleName} ${fieldGeneric.pojo.referenceOrId.name});
             </#if>
        </#if>
    </#if>
</#list>
<#if pojo.actor>
    ${pojo.name?cap_first} findByUsername(String username);
</#if>
<#if pojo.mustValidate>
    List<${pojo.name}> findByUsername(String username);
</#if>

<#if pojo.labelOrReference??>
    @Query("SELECT NEW ${pojo.name}(item.id,item.${pojo.labelOrReference.name}) FROM ${pojo.name} item")
    List<${pojo.name}> findAllOptimized();
 </#if>
<#if pojo.enhanced>
    @Query(value = "SELECT MAX(item.ordre) FROM ${pojo.name} item where item.etablissementId = :etablissementId")
    Long findMaxOrdreByEtablissementIdOrder(@Param("etablissementId") Long etablissementId);
</#if>

<#if pojo.calendar>
    @Query("SELECT item.id,item.${pojo.calendarLabel.name} ,DATE_FORMAT(item.${pojo.calendarStart.name}, '%m/%d/%Y %H:%i'),DATE_FORMAT(item.${pojo.calendarEnd.name}, '%m/%d/%Y %H:%i') FROM ${pojo.name} item WHERE EXTRACT(MONTH from item.${pojo.calendarStart.name}) = :month")
    List<Object[]> findByMonth(@Param("month") int month);
</#if>
}
