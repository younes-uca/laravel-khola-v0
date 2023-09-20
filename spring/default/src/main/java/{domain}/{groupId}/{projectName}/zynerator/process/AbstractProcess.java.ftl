package ${config.domain}.${config.groupId}.${config.projectName}.zynerator.process;

import ${config.domain}.${config.groupId}.${config.projectName}.zynerator.audit.AuditBusinessObject;

public interface AbstractProcess<I extends AbstractProcessInput, K extends AbstractProcessOutput, T extends AuditBusinessObject> {
    Result<I, K, T> execute(I input);
}
