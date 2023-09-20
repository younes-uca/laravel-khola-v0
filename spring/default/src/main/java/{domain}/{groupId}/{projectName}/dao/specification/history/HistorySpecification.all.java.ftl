package  ${config.domain}.${config.groupId}.${config.projectName}.${config.dao}.specification.history<#if pojo.subModule.folder??>.${pojo.subModule.folder}</#if>;

import ${config.domain}.${config.groupId}.${config.projectName}.zynerator.specification.AbstractHistorySpecification;
import ${config.domain}.${config.groupId}.${config.projectName}.${config.dao}.criteria.history.${pojo.subModule.folder}.${pojo.name}HistoryCriteria;
import ${config.domain}.${config.groupId}.${config.projectName}.${config.bean}.history.${pojo.subModule.folder}.${pojo.name}History;


public class ${pojo.name}HistorySpecification extends AbstractHistorySpecification<${pojo.name}HistoryCriteria, ${pojo.name}History> {

    public ${pojo.name}HistorySpecification(${pojo.name}HistoryCriteria criteria) {
        super(criteria);
    }

    public ${pojo.name}HistorySpecification(${pojo.name}HistoryCriteria criteria, boolean distinct) {
        super(criteria, distinct);
    }

}
