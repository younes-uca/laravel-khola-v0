package ${config.domain}.${config.groupId}.${config.projectName}.zynerator.service;

import ${config.domain}.${config.groupId}.${config.projectName}.zynerator.audit.AuditBusinessObjectEnhanced;
import ${config.domain}.${config.groupId}.${config.projectName}.zynerator.criteria.BaseCriteria;
import ${config.domain}.${config.groupId}.${config.projectName}.zynerator.history.HistBusinessObject;
import ${config.domain}.${config.groupId}.${config.projectName}.zynerator.history.HistCriteria;
import ${config.domain}.${config.groupId}.${config.projectName}.zynerator.repository.AbstractHistoryRepository;
import ${config.domain}.${config.groupId}.${config.projectName}.zynerator.repository.AbstractRepository;

public abstract class AbstractReferentielServiceImpl<T extends AuditBusinessObjectEnhanced, H extends HistBusinessObject, CRITERIA extends BaseCriteria, HC extends HistCriteria, REPO extends AbstractRepository<T, Long>, HISTREPO extends AbstractHistoryRepository<H, Long>> extends AbstractServiceImpl<T, H, CRITERIA, HC, REPO, HISTREPO> {

    public AbstractReferentielServiceImpl(REPO dao, HISTREPO historyRepository) {
    super(dao, historyRepository);
    }

}