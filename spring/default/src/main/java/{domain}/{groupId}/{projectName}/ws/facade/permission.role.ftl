package  ${config.domain}.${config.groupId}.${config.projectName}.${config.ws}.facade.${roleName}<#if permissions[0].pojo.subModule.folder??>.${permissions[0].pojo.subModule.folder}</#if>;

import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.media.Content;
import io.swagger.v3.oas.annotations.media.Schema;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;

import ${config.domain}.${config.groupId}.${config.projectName}.bean.core<#if permissions[0].pojo.subModule.folder??>.${permissions[0].pojo.subModule.folder}</#if>.${permissions[0].pojo.name};
import ${config.domain}.${config.groupId}.${config.projectName}.bean.history<#if permissions[0].pojo.subModule.folder??>.${permissions[0].pojo.subModule.folder}</#if>.${permissions[0].pojo.name}History;
import ${config.domain}.${config.groupId}.${config.projectName}.dao.criteria.core<#if permissions[0].pojo.subModule.folder??>.${permissions[0].pojo.subModule.folder}</#if>.${permissions[0].pojo.name}Criteria;
import ${config.domain}.${config.groupId}.${config.projectName}.dao.criteria.history<#if permissions[0].pojo.subModule.folder??>.${permissions[0].pojo.subModule.folder}</#if>.${permissions[0].pojo.name}HistoryCriteria;
import ${config.domain}.${config.groupId}.${config.projectName}.service.facade.${roleName}<#if permissions[0].pojo.subModule.folder??>.${permissions[0].pojo.subModule.folder}</#if>.${permissions[0].pojo.name}${roleName?cap_first}Service;
import ${config.domain}.${config.groupId}.${config.projectName}.ws.converter<#if permissions[0].pojo.subModule.folder??>.${permissions[0].pojo.subModule.folder}</#if>.${permissions[0].pojo.name}Converter;
import ${config.domain}.${config.groupId}.${config.projectName}.ws.dto<#if permissions[0].pojo.subModule.folder??>.${permissions[0].pojo.subModule.folder}</#if>.${permissions[0].pojo.name}Dto;
import ${config.domain}.${config.groupId}.${config.projectName}.zynerator.controller.AbstractController;
import ${config.domain}.${config.groupId}.${config.projectName}.zynerator.dto.AuditEntityDto;
import ${config.domain}.${config.groupId}.${config.projectName}.zynerator.util.PaginatedList;

<#if permissions[0].pojo.calendar>
import ${config.domain}.${config.groupId}.${config.projectName}.zynerator.dto.ScheduleDto;
</#if>
<#if permissions[0].pojo.actor>
import ${config.domain}.${config.groupId}.${config.projectName}.zynerator.security.bean.User;
</#if>
import org.springframework.core.io.InputStreamResource;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;



<#if permissions[0].pojo.enhanced>
import org.springframework.http.HttpStatus;
</#if>
import java.util.List;
<#if permissions[0].pojo.domainProcesses??>
import org.springframework.beans.factory.annotation.Autowired;
import ${config.domain}.${config.groupId}.${config.projectName}.zynerator.process.Result;
<#list permissions[0].pojo.domainProcesses as process>
<#if (process.roles?size== 0 || process.roles?seq_index_of(roleName?lower_case)!= -1)>
import ${config.domain}.${config.groupId}.${config.projectName}.workflow.${roleName?lower_case}.process.${permissions[0].pojo.name?lower_case}.${process.name?lower_case}.${permissions[0].pojo.name?cap_first}${process.name?cap_first}${roleName?cap_first}Process ;
import ${config.domain}.${config.groupId}.${config.projectName}.workflow.${roleName?lower_case}.process.${permissions[0].pojo.name?lower_case}.${process.name?lower_case}.${permissions[0].pojo.name?cap_first}${process.name?cap_first}${roleName?cap_first}Input ;
import ${config.domain}.${config.groupId}.${config.projectName}.workflow.${roleName?lower_case}.process.${permissions[0].pojo.name?lower_case}.${process.name?lower_case}.${permissions[0].pojo.name?cap_first}${process.name?cap_first}${roleName?cap_first}Output ;
</#if>
</#list>
</#if>

<#if permissions[0].pojo.exportable == true>
import org.springframework.http.HttpEntity;
</#if>

import org.springframework.web.multipart.MultipartFile;
import ${config.domain}.${config.groupId}.${config.projectName}.zynerator.dto.FileTempDto;

@RestController
<#if true && config.groupId == "enova">
@RequestMapping("/api/${permissions[0].pojo.name?uncap_first}/")
<#else>
@RequestMapping("/api/${roleName}/${permissions[0].pojo.name?uncap_first}/")
</#if>
public class ${permissions[0].pojo.name?cap_first}Rest${roleName?cap_first}  extends AbstractController<${permissions[0].pojo.name?cap_first}, ${permissions[0].pojo.name?cap_first}Dto, ${permissions[0].pojo.name?cap_first}History, ${permissions[0].pojo.name?cap_first}Criteria, ${permissions[0].pojo.name?cap_first}HistoryCriteria, ${permissions[0].pojo.name?cap_first}${roleName?cap_first}Service, ${permissions[0].pojo.name?cap_first}Converter> {

<#if permissions[0].pojo.domainProcesses??>
<#list permissions[0].pojo.domainProcesses as process>
    <#if (process.roles?size== 0 || process.roles?seq_index_of(roleName?lower_case)!= -1)>
    @Operation(summary = "${process.name} a ${permissions[0].pojo.name?uncap_first}")
    @PostMapping("process/${process.name?lower_case}")
    public ResponseEntity<Result<${permissions[0].pojo.name?cap_first}${process.name?cap_first}${roleName?cap_first}Input,${permissions[0].pojo.name?cap_first}${process.name?cap_first}${roleName?cap_first}Output, ${permissions[0].pojo.name}>> ${process.name}Process(@RequestBody ${permissions[0].pojo.name?cap_first}${process.name?cap_first}${roleName?cap_first}Input input) throws Exception {
        Result<${permissions[0].pojo.name?cap_first}${process.name?cap_first}${roleName?cap_first}Input, ${permissions[0].pojo.name?cap_first}${process.name?cap_first}${roleName?cap_first}Output, ${permissions[0].pojo.name}> result = ${permissions[0].pojo.name?uncap_first}${process.name?cap_first}${roleName?cap_first}Process.execute(input);
        return new ResponseEntity<>(result, result.getStatus());
    }
    </#if>
</#list>
</#if>

<#if permissions[0].pojo.importable == true>
    @Operation(summary = "Import excel")
    @PostMapping("import-excel")
    public ResponseEntity<List<${permissions[0].pojo.name}>> importExcel(@RequestParam("file") MultipartFile file){
        return super.importExcel(file);
    }
</#if>

<#if permissions[0].pojo.exportable == true>
    @Operation(summary = "Exporte pdf")
    @PostMapping("exportPdf/")
    public HttpEntity<byte[]> createPdf(@RequestBody ${permissions[0].pojo.name}Dto dto) throws Exception{
        return service.createPdf(dto);
    }
</#if>
    @Operation(summary = "upload one ${permissions[0].pojo.name?uncap_first}")
    @RequestMapping(value = "upload", method = RequestMethod.POST, consumes = "multipart/form-data")
    public ResponseEntity<FileTempDto> uploadFileAndGetChecksum(@RequestBody MultipartFile file) throws Exception {
        return super.uploadFileAndGetChecksum(file);
    }
    @Operation(summary = "upload multiple ${permissions[0].pojo.name?uncap_first}s")
    @RequestMapping(value = "upload-multiple", method = RequestMethod.POST, consumes = "multipart/form-data")
    public ResponseEntity<List<FileTempDto>> uploadMultipleFileAndGetChecksum(@RequestBody MultipartFile[] files) throws Exception {
        return super.uploadMultipleFileAndGetChecksum(files);
    }

    @Operation(summary = "Finds a list of all ${permissions[0].pojo.name?uncap_first}s")
    @GetMapping("")
    public ResponseEntity<List<${permissions[0].pojo.name?cap_first}Dto>> findAll() throws Exception {
        return super.findAll();
    }

    <#if permissions[0].pojo.labelOrReference??>
    @Operation(summary = "Finds an optimized list of all ${permissions[0].pojo.name?uncap_first}s")
    @GetMapping("optimized")
    public ResponseEntity<List<${permissions[0].pojo.name?cap_first}Dto>> findAllOptimized() throws Exception {
        return super.findAllOptimized();
    }
    </#if>

    @Operation(summary = "Finds a ${permissions[0].pojo.name?uncap_first} by ${permissions[0].pojo.id.name}")
    <#if config.groupId == "enova">
    @GetMapping("{${permissions[0].pojo.id.name}}")
    <#else>
    @GetMapping("${permissions[0].pojo.id.name}/{${permissions[0].pojo.id.name}}")
    </#if>
    public ResponseEntity<${permissions[0].pojo.name?cap_first}Dto> findById(@PathVariable Long id, String[] includes, String[] excludes) throws Exception {
        return super.findById(id, includes, excludes);
    }
    @Operation(summary = "Saves the specified  ${permissions[0].pojo.name?uncap_first}")
    @PostMapping("")
    public ResponseEntity<${permissions[0].pojo.name?cap_first}Dto> save(@RequestBody ${permissions[0].pojo.name?cap_first}Dto dto) throws Exception {
        return super.save(dto);
    }

    @Operation(summary = "Updates the specified  ${permissions[0].pojo.name?uncap_first}")
    @PutMapping("")
    public ResponseEntity<${permissions[0].pojo.name?cap_first}Dto> update(@RequestBody ${permissions[0].pojo.name?cap_first}Dto dto) throws Exception {
        return super.update(dto);
    }

    @Operation(summary = "Delete list of ${permissions[0].pojo.name?uncap_first}")
<#if config.groupId == "enova">
    @DeleteMapping("/delete")
<#else>
    @PostMapping("multiple")
</#if>
    public ResponseEntity<List<${permissions[0].pojo.name}Dto>> delete(@RequestBody List<${permissions[0].pojo.name}Dto> listToDelete) throws Exception {
        return super.delete(listToDelete);
    }
    @Operation(summary = "Delete the specified ${permissions[0].pojo.name?uncap_first}")
    @DeleteMapping("")
    public ResponseEntity<${permissions[0].pojo.name}Dto> delete(@RequestBody ${permissions[0].pojo.name}Dto dto) throws Exception {
            return super.delete(dto);
    }

    @Operation(summary = "Delete the specified ${permissions[0].pojo.name?uncap_first}")
    @DeleteMapping("id/{id}")
    public ResponseEntity<Long> deleteById(@PathVariable Long id) throws Exception {
        return super.deleteById(id);
    }
    @Operation(summary = "Delete multiple ${permissions[0].pojo.name?uncap_first}s by ids")
    @DeleteMapping("multiple/id")
    public ResponseEntity<List<Long>> deleteByIdIn(@RequestBody List<Long> ids) throws Exception {
            return super.deleteByIdIn(ids);
     }


<#list permissions[0].pojo.fieldsGeneric as fieldGeneric>
    <#if (fieldGeneric.findByInclusion || true) && (fieldGeneric.pojo.id)?? && fieldGeneric.typeAsPojo.msExterne ==false>
        <#if fieldGeneric.typeAsPojo.state == false>
    @Operation(summary = "find by ${fieldGeneric.name} ${fieldGeneric.typeAsPojo.id.name?uncap_first}")
    @GetMapping("${fieldGeneric.name?uncap_first}/${fieldGeneric.typeAsPojo.id.name?uncap_first}/{${fieldGeneric.typeAsPojo.id.name?uncap_first}}")
    public List<${permissions[0].pojo.name}> findBy${fieldGeneric.name?cap_first}${fieldGeneric.typeAsPojo.id.name?cap_first}(@PathVariable ${fieldGeneric.typeAsPojo.id.type.simpleName} ${fieldGeneric.typeAsPojo.id.name}){
        return service.findBy${fieldGeneric.name?cap_first}${fieldGeneric.typeAsPojo.id.name?cap_first}(${fieldGeneric.typeAsPojo.id.name});
    }
         <#else>
    @Operation(summary = "find by ${fieldGeneric.name} ${fieldGeneric.typeAsPojo.referenceOrId.name?uncap_first}")
    @GetMapping("${fieldGeneric.name?uncap_first}/${fieldGeneric.typeAsPojo.referenceOrId.name?uncap_first}/{${fieldGeneric.typeAsPojo.referenceOrId.name?uncap_first}}")
    public List<${permissions[0].pojo.name}> findBy${fieldGeneric.name?cap_first}${fieldGeneric.typeAsPojo.referenceOrId.name?cap_first}(@PathVariable ${fieldGeneric.typeAsPojo.referenceOrId.type.simpleName} ${fieldGeneric.typeAsPojo.referenceOrId.name}){
        return service.findBy${fieldGeneric.name?cap_first}${fieldGeneric.typeAsPojo.referenceOrId.name?cap_first}(${fieldGeneric.typeAsPojo.referenceOrId.name});
    }
        </#if>
    </#if>
    <#if (fieldGeneric.deleteByInclusion || true) && (fieldGeneric.pojo.id)?? && fieldGeneric.typeAsPojo.msExterne ==false>
            <#if fieldGeneric.typeAsPojo.state == false>
    @Operation(summary = "delete by ${fieldGeneric.name} ${fieldGeneric.typeAsPojo.id.name?uncap_first}")
    @DeleteMapping("${fieldGeneric.name?uncap_first}/${fieldGeneric.typeAsPojo.id.name?uncap_first}/{${fieldGeneric.typeAsPojo.id.name?uncap_first}}")
    public int deleteBy${fieldGeneric.name?cap_first}${fieldGeneric.typeAsPojo.id.name?cap_first}(@PathVariable ${fieldGeneric.typeAsPojo.id.type.simpleName} ${fieldGeneric.typeAsPojo.id.name}){
        return service.deleteBy${fieldGeneric.name?cap_first}${fieldGeneric.typeAsPojo.id.name?cap_first}(${fieldGeneric.typeAsPojo.id.name});
    }
            <#else>
    @Operation(summary = "delete by ${fieldGeneric.name} ${fieldGeneric.typeAsPojo.referenceOrId.name?uncap_first}")
    @DeleteMapping("${fieldGeneric.name?uncap_first}/${fieldGeneric.typeAsPojo.referenceOrId.name?uncap_first}/{${fieldGeneric.typeAsPojo.referenceOrId.name?uncap_first}}")
    public int deleteBy${fieldGeneric.name?cap_first}${fieldGeneric.typeAsPojo.referenceOrId.name?cap_first}(@PathVariable ${fieldGeneric.typeAsPojo.referenceOrId.type.simpleName} ${fieldGeneric.typeAsPojo.referenceOrId.name}){
        return service.deleteBy${fieldGeneric.name?cap_first}${fieldGeneric.typeAsPojo.referenceOrId.name?cap_first}(${fieldGeneric.typeAsPojo.referenceOrId.name});
    }
            </#if>
    </#if>
</#list>
<#if permissions[0].pojo.hasList == true>
    @Operation(summary = "Finds a ${permissions[0].pojo.name?uncap_first} and associated list by ${permissions[0].pojo.id.name}")
    @GetMapping("detail/id/{id}")
    public ResponseEntity<${permissions[0].pojo.name?cap_first}Dto> findWithAssociatedLists(@PathVariable Long id) {
        return super.findWithAssociatedLists(id);
    }

</#if>
    @Operation(summary = "Finds ${permissions[0].pojo.name?uncap_first}s by criteria")
<#if true && config.groupId == "enova">
    @PostMapping("listByCriteria")
<#else>
    @PostMapping("find-by-criteria")
</#if>
    public ResponseEntity<List<${permissions[0].pojo.name?cap_first}Dto>> findByCriteria(@RequestBody ${permissions[0].pojo.name?cap_first}Criteria criteria) throws Exception {
        return super.findByCriteria(criteria);
    }

    @Operation(summary = "Finds paginated ${permissions[0].pojo.name?uncap_first}s by criteria")
<#if true && config.groupId == "enova">
    @PostMapping("paginatedListByCriteria")
<#else>
    @PostMapping("find-paginated-by-criteria")
</#if>
    public ResponseEntity<PaginatedList> findPaginatedByCriteria(@RequestBody ${permissions[0].pojo.name?cap_first}Criteria criteria) throws Exception {
        return super.findPaginatedByCriteria(criteria);
    }

    @Operation(summary = "Exports ${permissions[0].pojo.name?uncap_first}s by criteria")
    <#if true && config.groupId == "enova">
    @PostMapping("export${permissions[0].pojo.name?cap_first}s")
    <#else>
    @PostMapping("export")
    </#if>
    public ResponseEntity<InputStreamResource> export(@RequestBody ${permissions[0].pojo.name?cap_first}Criteria criteria) throws Exception {
        return super.export(criteria);
    }

    @Operation(summary = "Gets ${permissions[0].pojo.name?uncap_first} data size by criteria")
<#if true && config.groupId == "enova">
    @PostMapping("get${permissions[0].pojo.name?cap_first}sDataSize")
<#else>
    @PostMapping("data-size-by-criteria")
</#if>
    public ResponseEntity<Integer> getDataSize(@RequestBody ${permissions[0].pojo.name?cap_first}Criteria criteria) throws Exception {
        return super.getDataSize(criteria);
    }

    @Operation(summary = "Gets ${permissions[0].pojo.name?uncap_first} history by id")
    <#if true && config.groupId == "enova">
    @GetMapping("hist${permissions[0].pojo.name?cap_first}/{id}")
    <#else>
    @GetMapping("history/id/{id}")
    </#if>
    public ResponseEntity<AuditEntityDto> findHistoryById(@PathVariable("id") Long id) throws Exception {
        return super.findHistoryById(id);
    }

    @Operation(summary = "Gets ${permissions[0].pojo.name?uncap_first} paginated history by criteria")
<#if true && config.groupId == "enova">
    @PostMapping("paginatedListHistByCriteria")
<#else>
    @PostMapping("history-paginated-by-criteria")
</#if>
    public ResponseEntity<PaginatedList> findHistoryPaginatedByCriteria(@RequestBody ${permissions[0].pojo.name?cap_first}HistoryCriteria criteria) throws Exception {
        return super.findHistoryPaginatedByCriteria(criteria);
    }

    @Operation(summary = "Exports ${permissions[0].pojo.name?uncap_first} history by criteria")
<#if true && config.groupId == "enova">
    @PostMapping("export${permissions[0].pojo.name?cap_first}sHist")
<#else>
    @PostMapping("export-history")
</#if>
    public ResponseEntity<InputStreamResource> exportHistory(@RequestBody ${permissions[0].pojo.name?cap_first}HistoryCriteria criteria) throws Exception {
        return super.exportHistory(criteria);
    }

    @Operation(summary = "Gets ${permissions[0].pojo.name?uncap_first} history data size by criteria")
<#if true && config.groupId == "enova">
    @PostMapping("getHist${permissions[0].pojo.name?cap_first}sDataSize")
<#else>
    @PostMapping("history-data-size")
</#if>
    public ResponseEntity<Integer> getHistoryDataSize(@RequestBody ${permissions[0].pojo.name?cap_first}HistoryCriteria criteria) throws Exception {
        return super.getHistoryDataSize(criteria);
    }
<#if permissions[0].pojo.enhanced>
    @Operation(summary = "Gets ${permissions[0].pojo.name?uncap_first} next ordre value")
    @GetMapping(value = "/getNextOrdre")
    public ResponseEntity<Long> getNextOrdre() {
        Long nextOrdre = service.getNextOrdre();
        return new ResponseEntity<>(nextOrdre, HttpStatus.OK);
    }
</#if>

<#if permissions[0].pojo.actor>
    @Operation(summary = "Change password to the specified  utilisateur")
    @PutMapping("changePassword")
    public boolean changePassword(@RequestBody User dto) throws Exception {
        return service.changePassword(dto.getUsername(),dto.getPassword());
    }
</#if>
<#if permissions[0].pojo.calendar>
    @GetMapping("month/{month}")
    public List<ScheduleDto> findByMonth(@PathVariable int month) {
        return service.findByMonth(month);
    }

</#if>
    public ${permissions[0].pojo.name?cap_first}Rest${roleName?cap_first} (${permissions[0].pojo.name?cap_first}${roleName?cap_first}Service service, ${permissions[0].pojo.name?cap_first}Converter converter) {
        super(service, converter);
    }

<#if permissions[0].pojo.domainProcesses??>
<#list permissions[0].pojo.domainProcesses as process>
<#if (process.roles?size== 0 || process.roles?seq_index_of(roleName?lower_case)!= -1)>
    @Autowired
    private ${permissions[0].pojo.name?cap_first}${process.name?cap_first}${roleName?cap_first}Process ${permissions[0].pojo.name?uncap_first}${process.name?cap_first}${roleName?cap_first}Process;
</#if>
</#list>
</#if>



}