package ${config.domain}.${config.groupId}.${config.projectName}.workflow.${role.name}.process.${pojo.name?lower_case}.${process.name?lower_case};
import ${config.domain}.${config.groupId}.${config.projectName}.service.facade.${role.name}.${pojo.subModule.folder}.${pojo.name}${role.name?cap_first}Service;

import ${config.domain}.${config.groupId}.${config.projectName}.zynerator.process.AbstractProcessImpl;
import ${config.domain}.${config.groupId}.${config.projectName}.zynerator.process.Result;
import ${config.domain}.${config.groupId}.${config.projectName}.bean.core.${pojo.subModule.folder}.${pojo.name};

public class ${pojo.name}${process.name?cap_first}${role.name?cap_first}ProcessImpl extends AbstractProcessImpl<${pojo.name}${process.name?cap_first}${role.name?cap_first}Input, ${pojo.name}${process.name?cap_first}${role.name?cap_first}Output,  ${pojo.name},  ${pojo.name}${process.name?cap_first}${role.name?cap_first}Converter> implements ${pojo.name}${process.name?cap_first}${role.name?cap_first}Process {

    @Override
    public void init(${pojo.name}${process.name?cap_first}${role.name?cap_first}Input input, ${pojo.name} item) {

    }

    @Override
    public void validate(${pojo.name}${process.name?cap_first}${role.name?cap_first}Input input, ${pojo.name} item, Result<${pojo.name}${process.name?cap_first}${role.name?cap_first}Input, ${pojo.name}${process.name?cap_first}${role.name?cap_first}Output, ${pojo.name}> result) {
        
    }

    @Override
    public void run(${pojo.name}${process.name?cap_first}${role.name?cap_first}Input input, ${pojo.name} t, Result<${pojo.name}${process.name?cap_first}${role.name?cap_first}Input, ${pojo.name}${process.name?cap_first}${role.name?cap_first}Output, ${pojo.name}> result) {
        
    }
    


    private ${pojo.name}${role.name?cap_first}Service service;
    public ${pojo.name}${process.name?cap_first}${role.name?cap_first}ProcessImpl(${pojo.name}${role.name?cap_first}Service service, ${pojo.name}${process.name?cap_first}${role.name?cap_first}Converter converter) {
        super(converter);
        this.service = service;
    }

}
