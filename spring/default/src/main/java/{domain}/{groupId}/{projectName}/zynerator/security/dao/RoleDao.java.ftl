package ${config.domain}.${config.groupId}.${config.projectName}.zynerator.security.${config.dao};

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import ${config.domain}.${config.groupId}.${config.projectName}.zynerator.security.${config.bean}.Role;

@Repository
public interface RoleDao extends JpaRepository<Role,Long> {
    Role findByAuthority(String authority);
    int deleteByAuthority(String authority);
    List<Role> findAllByUsersUsername(String username);
}
