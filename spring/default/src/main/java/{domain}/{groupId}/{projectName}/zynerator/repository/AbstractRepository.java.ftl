package ${config.domain}.${config.groupId}.${config.projectName}.zynerator.repository;

import ${config.domain}.${config.groupId}.${config.projectName}.zynerator.audit.AuditBusinessObject;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.repository.NoRepositoryBean;

@NoRepositoryBean
public interface AbstractRepository<T extends AuditBusinessObject, ID> extends JpaRepository<T, ID>, JpaSpecificationExecutor<T> {
}
