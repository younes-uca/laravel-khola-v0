package ${config.domain}.${config.groupId}.${config.projectName}.workflow.${role.name}.process.${pojo.name?lower_case}.${process.name?lower_case};
import ${config.domain}.${config.groupId}.${config.projectName}.service.facade.${role.name}.${pojo.subModule.folder}.${pojo.name}${role.name?cap_first}Service;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class ${pojo.name}${process.name?cap_first}${role.name?cap_first}Injector{

    @Bean
    public ${pojo.name}${process.name?cap_first}${role.name?cap_first}Process ${pojo.name?uncap_first}${process.name?cap_first}${role.name?cap_first}(${pojo.name}${role.name?cap_first}Service service, ${pojo.name}${process.name?cap_first}${role.name?cap_first}Converter converter) {
        return new ${pojo.name}${process.name?cap_first}${role.name?cap_first}ProcessImpl(service,converter);
    }

}
