package ${config.domain}.${config.groupId}.${config.projectName}.workflow.${role.name}.process.${pojo.name?lower_case}.${process.name?lower_case};

import ${config.domain}.${config.groupId}.${config.projectName}.zynerator.process.AbstractProcess;
import ${config.domain}.${config.groupId}.${config.projectName}.bean.core.${pojo.subModule.folder}.${pojo.name};

public interface ${pojo.name}${process.name?cap_first}${role.name?cap_first}Process extends AbstractProcess<${pojo.name}${process.name?cap_first}${role.name?cap_first}Input, ${pojo.name}${process.name?cap_first}${role.name?cap_first}Output, ${pojo.name}> {
}
