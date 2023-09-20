package ${config.domain}.${config.groupId}.${config.projectName}.${config.service}.impl.${role.name}.${pojo.subModule.folder};


import ${config.domain}.${config.groupId}.${config.projectName}.bean.core.${pojo.subModule.folder}.${pojo.name};
import ${config.domain}.${config.groupId}.${config.projectName}.bean.history.${pojo.subModule.folder}.${pojo.name}History;
import ${config.domain}.${config.groupId}.${config.projectName}.dao.criteria.core.${pojo.subModule.folder}.${pojo.name}Criteria;
import ${config.domain}.${config.groupId}.${config.projectName}.dao.criteria.history.${pojo.subModule.folder}.${pojo.name}HistoryCriteria;
import ${config.domain}.${config.groupId}.${config.projectName}.dao.facade.core.${pojo.subModule.folder}.${pojo.name}Dao;
import ${config.domain}.${config.groupId}.${config.projectName}.dao.facade.history.${pojo.subModule.folder}.${pojo.name}HistoryDao;
import ${config.domain}.${config.groupId}.${config.projectName}.dao.specification.core.${pojo.subModule.folder}.${pojo.name}Specification;
import ${config.domain}.${config.groupId}.${config.projectName}.service.facade.${role.name}.${pojo.subModule.folder}.${pojo.name}${role.name?cap_first}Service;
<#if !pojo.subEntity>
import ${config.domain}.${config.groupId}.${config.projectName}.zynerator.service.AbstractServiceImpl;
</#if>
<#if pojo.importable == true>
import ${config.domain}.${config.groupId}.${config.projectName}.zynerator.service.Attribute;
</#if>
import ${config.domain}.${config.groupId}.${config.projectName}.zynerator.util.ListUtil;
import org.springframework.stereotype.Service;
import java.util.List;
import java.util.ArrayList;

<#if pojo.calendar>
import ${config.domain}.${config.groupId}.${config.projectName}.zynerator.dto.ScheduleDto;
</#if>

<#if pojo.exportable == true>
import ${config.domain}.${config.groupId}.${config.projectName}.zynerator.util.VelocityPdf;
import ${config.domain}.${config.groupId}.${config.projectName}.ws.dto.${pojo.subModule.folder}.${pojo.name}Dto;
import org.springframework.http.HttpEntity;
</#if>
<#if pojo.enhanced || pojo.cacheable>
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.cache.annotation.CachePut;
import org.springframework.cache.annotation.Cacheable;
</#if>

<#if true || pojo.exportable == true || pojo.hasGeneric>
import org.springframework.beans.factory.annotation.Autowired;
</#if>
<#if pojo.hasList == true>
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
</#if>

<#if pojo.dependenciesImportation??>
    <#list pojo.dependenciesImportation as dependency>
        <#if dependency?? && dependency.name?? && (dependency.roles?size== 0 || dependency.roles?seq_index_of(role.name)!= -1)>
import ${config.domain}.${config.groupId}.${config.projectName}.service.facade.${role.name}.${dependency.subModule.folder}.${dependency.name}${role.name?cap_first}Service ;
import ${config.domain}.${config.groupId}.${config.projectName}.bean.core.${dependency.subModule.folder}.${dependency.name} ;
        </#if>
    </#list>
</#if>

<#if pojo.actor>
import ${config.domain}.${config.groupId}.${config.projectName}.zynerator.security.service.facade.UserService;
import ${config.domain}.${config.groupId}.${config.projectName}.zynerator.security.service.facade.RoleService;
import ${config.domain}.${config.groupId}.${config.projectName}.zynerator.security.bean.Role;
import java.util.Collection;
</#if>

<#if true || pojo.hasFindByInclusion==true >
import java.util.List;
</#if>
<#if !pojo.baseEntityNoTable>
@Service
</#if>
public class ${pojo.name}${role.name?cap_first}ServiceImpl extends <#if pojo.subEntity>${pojo.superEntity.name}ServiceImpl<#else>AbstractServiceImpl<${pojo.name?cap_first},${pojo.name}History, ${pojo.name}Criteria, ${pojo.name}HistoryCriteria, ${pojo.name}Dao,
${pojo.name?cap_first}HistoryDao></#if> implements ${pojo.name?cap_first}${role.name?cap_first}Service {
<#if pojo.exportable == true>
    public static final String TEMPLATE = "template/${pojo.name?uncap_first}.vm";
    public static final String FILE_NAME = "${pojo.name?uncap_first}.pdf";
</#if>
<#if pojo.importable == true>
public static final List<Attribute> ATTRIBUTES = new ArrayList();
    static{
    <#list pojo.fields as field>

        <#if field.id == false>
            <#if field.pureString>
    ATTRIBUTES.add(new Attribute("${field.name}"));
            <#elseif field.bool || field.nombre >
    ATTRIBUTES.add(new Attribute("${field.name}","${field.type.name}"));
            <#elseif field.generic >
            </#if>
        </#if>
    </#list>
    }
</#if>

<#if pojo.exportable == true>
    @Override
    public HttpEntity<byte[]> createPdf(${pojo.name}Dto dto) throws Exception{
        return velocityPdf.createPdf(FILE_NAME, TEMPLATE, dto);
    }
</#if>

<#if pojo.hasList == true && !pojo.actor>
    @Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class, readOnly = false)
    public ${pojo.name} create(${pojo.name} t) {
        super.create(t);
    <#list pojo.fields as field>
    <#if field.list==true>
        if (t.get${field.name?cap_first}() != null) {
                t.get${field.name?cap_first}().forEach(element-> {
                    element.set${pojo.name}(t);
                    ${field.typeAsPojo.name?uncap_first}Service.create(element);
            });
        }
    </#if>
    </#list>
        return t;
    }

    public ${pojo.name} findWithAssociatedLists(${pojo.id.type.name?cap_first} id){
        ${pojo.name} result = dao.findById(id).orElse(null);
        if(result!=null && result.get${pojo.id.name?cap_first}() != null) {
    <#list pojo.fields as field>
        <#if field.list==true >
            result.set${field.name?cap_first}(<#if field.typeAsPojo.name != pojo.name>${field.typeAsPojo.name?uncap_first}Service.</#if>findBy${pojo.name?cap_first}${pojo.id.name?cap_first}(id));
        </#if>
    </#list>
        }
        return result;
    }
    <#if pojo.hasList == true>
    @Transactional
    public void deleteAssociatedLists(Long id) {
    <#list pojo.fields as field>
        <#if field.list==true >
            <#if field.typeAsPojo.name != pojo.name>
        ${field.typeAsPojo.name?uncap_first}Service.</#if>deleteBy${pojo.name?cap_first}${pojo.id.name?cap_first}(id);
        </#if>
    </#list>
    }
    </#if>


    public void updateWithAssociatedLists(${pojo.name} ${pojo.name?uncap_first}){
    if(${pojo.name?uncap_first} !=null && ${pojo.name?uncap_first}.get${pojo.id.name?cap_first}() != null){
    <#list pojo.fields as field>
        <#if field.list==true >
            List<List<${field.typeAsPojo.name}>> result${field.name?cap_first}= ${field.typeAsPojo.name?uncap_first}Service.getToBeSavedAndToBeDeleted(${field.typeAsPojo.name?uncap_first}Service.findBy${pojo.name?cap_first}${pojo.id.name?cap_first}(${pojo.name?uncap_first}.get${pojo.id.name?cap_first}()),${pojo.name?uncap_first}.get${field.name?cap_first}());
            <#if field.typeAsPojo.name != pojo.name>${field.typeAsPojo.name?uncap_first}Service.</#if>delete(result${field.name?cap_first}.get(1));
            ListUtil.emptyIfNull(result${field.name?cap_first}.get(0)).forEach(e -> e.set${pojo.name}(${pojo.name?uncap_first}));
            ${field.typeAsPojo.name?uncap_first}Service.update(result${field.name?cap_first}.get(0),true);
        </#if>
    </#list>
    }
    }
</#if>
<#if pojo.enhanced>
    public Long getNextOrdre() {
    Long max = dao.findMaxOrdreByEtablissementIdOrder(getEtablissementId());
    return max != null ? max + 1 : 1;
    }
</#if>


<#if pojo.enhanced || pojo.cacheable>

    @Cacheable(cacheNames = "${pojo.name?uncap_first}s")
    public List<${pojo.name}> findAll() {
        return super.findAll();
    }

    @CachePut(cacheNames = "${pojo.name?uncap_first}s", key = "#t.id")
    public ${pojo.name} update(${pojo.name} t) {
        return super.update(t);
    }

    @Cacheable(cacheNames = "${pojo.name?uncap_first}s", key = "#id")
    public ${pojo.name} findById(Long id) {
        return super.findById(id);
    }

    @CacheEvict(cacheNames = "${pojo.name?uncap_first}s", key = "#id")
    public void deleteById(Long id) {
        super.deleteById(id);
    }
</#if>

<#if pojo.importData>
    <#if pojo.reference?? && pojo.reference.name??>
    public ${pojo.name} findByReferenceEntity(${pojo.name} t){
        return  dao.findBy${pojo.reference.name?cap_first}(t.get${pojo.reference.name?cap_first}());
    }
    </#if>
    <#if pojo.hasGeneric == true>
    public void findOrSaveAssociatedObject(${pojo.name} t){
        if( t != null) {
    <#list pojo.fieldsGeneric as fieldGeneric>
        <#if (fieldGeneric.findByInclusion || true) && fieldGeneric.typeAsPojo.msExterne == false && fieldGeneric.typeAsPojo.importData == true>
            t.set${fieldGeneric.name?cap_first}(${fieldGeneric.typeAsPojo.name?uncap_first}Service.findOrSave(t.get${fieldGeneric.name?cap_first}()));
        </#if>
    </#list>
        }
    }
    </#if>
</#if>

<#list pojo.fieldsGeneric as fieldGeneric>
        <#if  (true || fieldGeneric.deleteByInclusion)  && fieldGeneric.pojo.msExterne ==false>
            <#if (fieldGeneric.typeAsPojo.state == false)>
    public List<${pojo.name}> findBy${fieldGeneric.name?cap_first}${fieldGeneric.pojo.id.name?cap_first}(${fieldGeneric.pojo.id.type.simpleName} ${fieldGeneric.pojo.id.name}){
        return dao.findBy${fieldGeneric.name?cap_first}${fieldGeneric.pojo.id.name?cap_first}(${fieldGeneric.pojo.id.name});
    }
            <#else>
    public List<${pojo.name}> findBy${fieldGeneric.name?cap_first}${fieldGeneric.pojo.referenceOrId.name?cap_first}(${fieldGeneric.pojo.referenceOrId.type.simpleName} ${fieldGeneric.pojo.referenceOrId.name}){
        return dao.findBy${fieldGeneric.name?cap_first}${fieldGeneric.pojo.referenceOrId.name?cap_first}(${fieldGeneric.pojo.referenceOrId.name});
    }
            </#if>
         </#if>
        <#if  (true || fieldGeneric.deleteByInclusion)  && fieldGeneric.pojo.msExterne ==false>
                <#if (fieldGeneric.typeAsPojo.state == false)>
    public int deleteBy${fieldGeneric.name?cap_first}${fieldGeneric.pojo.id.name?cap_first}(${fieldGeneric.pojo.id.type.simpleName} ${fieldGeneric.pojo.id.name}){
        return dao.deleteBy${fieldGeneric.name?cap_first}${fieldGeneric.pojo.id.name?cap_first}(${fieldGeneric.pojo.id.name});
    }
                <#else>
     public int deleteBy${fieldGeneric.name?cap_first}${fieldGeneric.pojo.referenceOrId.name?cap_first}(${fieldGeneric.pojo.referenceOrId.type.simpleName} ${fieldGeneric.pojo.referenceOrId.name}){
        return dao.deleteBy${fieldGeneric.name?cap_first}${fieldGeneric.pojo.referenceOrId.name?cap_first}(${fieldGeneric.pojo.referenceOrId.name});
    }
                </#if>
        </#if>
</#list>



<#if pojo.importable == true>
    @Override
    protected List<Attribute> getAttributes() {
        return ATTRIBUTES;
    }
</#if>


<#if pojo.actor>
<#if pojo.enhanced || pojo.cacheable>
    @CachePut(cacheNames = "${pojo.name?uncap_first}s", key = "#t.id")
</#if>
    @Override
    public ${pojo.name} create(${pojo.name} t) {
        if (findByUsername(t.getUsername()) != null || t.getPassword() == null) return null;
        t.setPassword(userService.cryptPassword(t.getPassword()));
        t.setEnabled(true);
        t.setAccountNonExpired(true);
        t.setAccountNonLocked(true);
        t.setCredentialsNonExpired(true);
        t.setPasswordChanged(false);
        if (t.getRoles() != null) {
            Collection<Role> roles = new ArrayList<Role>();
            for (Role role : t.getRoles()) {
                roles.add(roleService.save(role));
            }
            t.setRoles(roles);
        }
        ${pojo.name} mySaved = super.create(t);

<#list pojo.fields as field>
    <#if field.list==true>
        if (t.get${field.name?cap_first}() != null) {
        t.get${field.name?cap_first}().forEach(element-> {
            element.set${pojo.name}(mySaved);
            ${field.typeAsPojo.name?uncap_first}Service.create(element);
        });
        }
    </#if>
</#list>
        return mySaved;
     }

    public ${pojo.name} findByUsername(String username){
    return dao.findByUsername(username);
    }

    public boolean changePassword(String username, String newPassword) {
    return userService.changePassword(username, newPassword);
    }
</#if>

<#if pojo.calendar>
    public List<ScheduleDto> findByMonth(int month){
        List<ScheduleDto> res  = new ArrayList<>();
        List<Object[]> results  = dao.findByMonth(month);
        for(Object[] result : results){
            long id = (long) result[0];
            String subject = (String) result[1];
            String startTime = (String) result[2];
            String endTime = (String) result[3];
            res.add(new ScheduleDto(id,subject,startTime,endTime));
        }
        return res;
    }
</#if>
    public void configure() {
        super.configure(${pojo.name}.class,${pojo.name}History.class, ${pojo.name}HistoryCriteria.class, ${pojo.name}Specification.class);
    }

<#if pojo.actor>
    @Autowired
    private UserService userService;


    @Autowired
    private RoleService roleService;
</#if>

<#list pojo.dependenciesImportation as dependency>
    <#if (dependency.roles?size== 0 || dependency.roles?seq_index_of(role.name)!= -1) >
    @Autowired
    private ${dependency.name}${role.name?cap_first}Service ${dependency.name?uncap_first}Service ;
    </#if>
</#list>
<#if pojo.exportable == true>
    @Autowired
    private VelocityPdf velocityPdf;
</#if>

    public ${pojo.name}${role.name?cap_first}ServiceImpl(${pojo.name}Dao dao, ${pojo.name}HistoryDao historyDao) {
        super(dao, historyDao);
    }

}
