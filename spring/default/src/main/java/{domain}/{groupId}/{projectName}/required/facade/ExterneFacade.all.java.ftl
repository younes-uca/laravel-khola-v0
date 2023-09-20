package  ${config.domain}.${config.groupId}.${config.projectName}.required.facade.${pojo.msPackaging};

import ${config.domain}.${config.groupId}.${config.projectName}.required.dto.${pojo.msPackaging}.${pojo.name}Dto;
import ${config.domain}.${config.groupId}.${config.projectName}.required.criteria.${pojo.msPackaging}.${pojo.name}Criteria;
import ${config.domain}.${config.groupId}.${config.projectName}.zynerator.required.AbstractRequired;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.client.RestTemplate;

import java.util.List;

@RestController
@RequestMapping("/api/admin/${pojo.name?uncap_first}")
public class ${pojo.name}Required extends AbstractRequired<${pojo.name}Dto,${pojo.name}Dto[]> {

    @Autowired
    RestTemplate restTemplate;

<#noparse>@Value("${ms.config.ms2.admin.url}")</#noparse>
    private String msUrl;
    private String localUrl = "${pojo.name?uncap_first}/";


    @GetMapping("")
    public List<${pojo.name}Dto> findAll() {
        return super.findAll();
    }

<#if config.groupId == "enova">
    @PostMapping("listByCriteria")
<#else>
    @PostMapping("find-by-criteria")
</#if>
    public List<${pojo.name}Dto> findByCriteria(@RequestBody ${pojo.name}Criteria criteria) {
        return super.findByCriteria(criteria);
    }

    public ${pojo.name}Required() {
        super(${pojo.name}Dto.class, ${pojo.name}Dto[].class);
    }

    @Override
    public RestTemplate getRestTemplate() {
        return restTemplate;
    }
    @Override
    public String getMsUrl() {
        return msUrl;
    }
    @Override
    public String getLocalUrl() {
        return localUrl;
    }
}
