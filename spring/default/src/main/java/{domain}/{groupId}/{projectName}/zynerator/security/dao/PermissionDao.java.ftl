package ${config.domain}.${config.groupId}.${config.projectName}.zynerator.security.${config.dao};

import org.springframework.data.jpa.repository.JpaRepository;
import ${config.domain}.${config.groupId}.${config.projectName}.zynerator.security.${config.bean}.Permission;

public interface PermissionDao extends JpaRepository<Permission, Long> {
    public Permission findByName(String name);
}
