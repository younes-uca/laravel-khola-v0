package ${config.domain}.${config.groupId}.${config.projectName}.${config.service}.facade.${role.name}.${pojo.subModule.folder};

<#if true || pojo.importData || pojo.hasGeneric>
import java.util.List;
</#if>
import ${config.domain}.${config.groupId}.${config.projectName}.${config.bean}.core.${pojo.subModule.folder}.${pojo.name};
import ${config.domain}.${config.groupId}.${config.projectName}.dao.criteria.core.${pojo.subModule.folder}.${pojo.name}Criteria;
import ${config.domain}.${config.groupId}.${config.projectName}.dao.criteria.history.${pojo.subModule.folder}.${pojo.name}HistoryCriteria;
<#if !pojo.subEntity>
import ${config.domain}.${config.groupId}.${config.projectName}.zynerator.service.IService;
</#if>
<#if pojo.calendar>
import ${config.domain}.${config.groupId}.${config.projectName}.zynerator.dto.ScheduleDto;
</#if>

<#if pojo.exportable == true>
import ${config.domain}.${config.groupId}.${config.projectName}.ws.dto.${pojo.subModule.folder}.${pojo.name}Dto;
import org.springframework.http.HttpEntity;
</#if>

public interface ${pojo.name?cap_first}${role.name?cap_first}Service extends <#if !pojo.subEntity> IService<${pojo.name?cap_first},${pojo.name?cap_first}Criteria, ${pojo.name?cap_first}HistoryCriteria> <#else> ${pojo.superEntity.name}Service</#if> {
<#if pojo.actor>
    ${pojo.name?cap_first} findByUsername(String username);
    boolean changePassword(String username, String newPassword);
</#if>

<#list pojo.fieldsGeneric as fieldGeneric>
    <#if (fieldGeneric.pojo.id)??>
        <#if (true || fieldGeneric.findByInclusion) && fieldGeneric.pojo.msExterne ==false>
            <#if (fieldGeneric.typeAsPojo.state == true)>
    List<${pojo.name}> findBy${fieldGeneric.name?cap_first}${fieldGeneric.pojo.referenceOrId.name?cap_first}(${fieldGeneric.pojo.referenceOrId.type.simpleName} ${fieldGeneric.pojo.referenceOrId.name});
            <#else>
    List<${pojo.name}> findBy${fieldGeneric.name?cap_first}${fieldGeneric.pojo.id.name?cap_first}(${fieldGeneric.pojo.id.type.simpleName} ${fieldGeneric.pojo.id.name});
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
<#if pojo.enhanced>
    Long getNextOrdre();
</#if>

<#if pojo.calendar>
public List<ScheduleDto> findByMonth(int month);
</#if>

<#if pojo.exportable == true>
    HttpEntity<byte[]> createPdf(${pojo.name}Dto dto) throws Exception;
</#if>

}
