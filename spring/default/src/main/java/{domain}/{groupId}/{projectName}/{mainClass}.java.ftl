package  ${config.domain}.${config.groupId}.${config.projectName};

import com.fasterxml.jackson.datatype.jsr310.JavaTimeModule;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.ConfigurableApplicationContext;
import org.springframework.boot.CommandLineRunner;
import org.springframework.context.annotation.Bean;
import java.util.*;
import java.util.stream.Stream;
import org.springframework.beans.factory.annotation.Autowired;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import org.springframework.cache.annotation.EnableCaching;
import com.fasterxml.jackson.databind.SerializationFeature;


<#list pojos as pojo>
<#if pojo.initialisation>
import ${config.domain}.${config.groupId}.${config.projectName}.bean.core.${pojo.subModule.folder}.${pojo.name};
import ${config.domain}.${config.groupId}.${config.projectName}.service.facade.${roles[0].name}.${pojo.subModule.folder}.${pojo.name}${roles[0].name?cap_first}Service;
</#if>
</#list>
import ${config.domain}.${config.groupId}.${config.projectName}.zynerator.${config.security}.${config.common}.AuthoritiesConstants;
import ${config.domain}.${config.groupId}.${config.projectName}.zynerator.${config.security}.${config.bean}.User;
import ${config.domain}.${config.groupId}.${config.projectName}.zynerator.${config.security}.${config.bean}.Permission;
import ${config.domain}.${config.groupId}.${config.projectName}.zynerator.${config.security}.${config.bean}.Role;
import ${config.domain}.${config.groupId}.${config.projectName}.zynerator.${config.security}.${config.service}.${config.serviceFacade}.UserService;
import ${config.domain}.${config.groupId}.${config.projectName}.zynerator.${config.security}.${config.service}.${config.serviceFacade}.RoleService;

//import org.springframework.data.elasticsearch.repository.config.EnableElasticsearchRepositories;
import org.springframework.web.client.RestTemplate;

@SpringBootApplication
@EnableCaching
//@EnableElasticsearchRepositories("${config.domain}.${config.groupId}.${config.projectName}.${config.dao}")
//@EnableFeignClients("${config.domain}.${config.groupId}.${config.projectName}.required.facade")
public class ${config.mainClass} {
    public static ConfigurableApplicationContext ctx;

    public static void main(String[] args) {
        ctx=SpringApplication.run(${config.mainClass}.class, args);
    }

    @Bean
    RestTemplate restTemplate(){
        return new RestTemplate();
    }

    @Bean
    ObjectMapper objectMapper(){
        ObjectMapper objectMapper = new ObjectMapper();
        objectMapper.disable(SerializationFeature.FAIL_ON_EMPTY_BEANS);
        objectMapper.registerModule(new JavaTimeModule());
        return objectMapper;
    }

    public static ConfigurableApplicationContext getCtx() {
        return ctx;
    }

    @Bean
    public CommandLineRunner demo(UserService userService, RoleService roleService) {
    return (args) -> {
        if(true){

    <#list pojos as pojo>
        <#if pojo.initialisation>
            create${pojo.name}();
        </#if>
    </#list>
    <#list roles as role>


    // Role ${role.name}

        User userFor${role.name?cap_first} = new User("${role.name}");

        Role roleFor${role.name?cap_first} = new Role();
        roleFor${role.name?cap_first}.setAuthority(AuthoritiesConstants.${role.name?upper_case});
        List<Permission> permissionsFor${role.name?cap_first} = new ArrayList<>();
        addPermissionFor${role.name?cap_first}(permissionsFor${role.name?cap_first});
        roleFor${role.name?cap_first}.setPermissions(permissionsFor${role.name?cap_first});
        if(userFor${role.name?cap_first}.getRoles()==null)
            userFor${role.name?cap_first}.setRoles(new ArrayList<>());

        userFor${role.name?cap_first}.getRoles().add(roleFor${role.name?cap_first});
        userService.save(userFor${role.name?cap_first});
        </#list>
            }
        };
    }


    <#list pojos as pojo>
        <#if pojo.initialisation && pojo.blockInitialisationAsString??>
    private void create${pojo.name}(){
        List<String> dataAsString= Arrays.asList(${pojo.blockInitialisationAsString});
        for (String dataElement : dataAsString) {
        try {
                ${pojo.name} element = objectMapper.readValue(dataElement, ${pojo.name}.class);
                ${pojo.name?uncap_first}Service.create(element);
            } catch (JsonProcessingException e) {
                throw new RuntimeException(e);
            }
        }
    }
        </#if>
    </#list>

    <#list pojos as pojo>
    <#if pojo.initialisation && !pojo.blockInitialisationAsString??>
    private void create${pojo.name}(){
      <#list pojo.fieldsSimple as fieldSimple>
        <#if  fieldSimple.id>
        <#elseif  fieldSimple.dateTime || fieldSimple.localDate>
        String ${fieldSimple.name} = "${fieldSimple.name}";
        <#elseif fieldSimple.integerNumber>
         String ${fieldSimple.name} = "${fieldSimple.name}";
        <#elseif fieldSimple.longNumber>
         String ${fieldSimple.name} = "${fieldSimple.name}";
        <#elseif fieldSimple.doubleNumber>
         String ${fieldSimple.name} = "${fieldSimple.name}";
        <#elseif fieldSimple.bigDecimalNumber>
         String ${fieldSimple.name} = "${fieldSimple.name}";
        <#elseif fieldSimple.bool>
         String ${fieldSimple.name} = "${fieldSimple.name}";
        <#else>
        String ${fieldSimple.name} = "${fieldSimple.name}";
        </#if>
    </#list>
        for (int i = 1; i < 100; i++) {
            ${pojo.name} item = new ${pojo.name}();
    <#list pojo.fieldsSimple as fieldSimple>
        <#if  fieldSimple.id>
        <#else>
            item.set${fieldSimple.name?cap_first}(fake${fieldSimple.type.name?cap_first}(${fieldSimple.name}, i));
        </#if>
    </#list>
            ${pojo.name?uncap_first}Service.create(item);
        }
    }
    </#if>
</#list>

    private static String fakeString(String attributeName, int i) {
        return attributeName + i;
    }

    private static Long fakeLong(String attributeName, int i) {
        return  10L * i;
    }
    private static Integer fakeInteger(String attributeName, int i) {
        return  10 * i;
    }

    private static Double fakeDouble(String attributeName, int i) {
        return 10D * i;
    }

    private static BigDecimal fakeBigDecimal(String attributeName, int i) {
        return  BigDecimal.valueOf(i*1L*10);
    }

    private static Boolean fakeBoolean(String attributeName, int i) {
        return i % 2 == 0 ? true : false;
    }
    private static LocalDateTime fakeLocalDateTime(String attributeName, int i) {
        return LocalDateTime.now().plusDays(i);
    }
    <#list roles as role>
    private static void addPermissionFor${role.name?cap_first}(List<Permission> permissions){
            <#list role.permissions as permission>
        permissions.add(new Permission("${permission.name}"));
            </#list>
    }
            </#list>

    <#list pojos as pojo>
        <#if pojo.initialisation>
    @Autowired
    ${pojo.name?cap_first}${roles[0].name?cap_first}Service ${pojo.name?uncap_first}Service;
        </#if>
    </#list>
}


