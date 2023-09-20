
package ${config.domain}.${config.groupId}.${config.projectName}.zynerator.security.${config.service}.${config.serviceFacade};

import java.util.List;

import ${config.domain}.${config.groupId}.${config.projectName}.zynerator.security.${config.bean}.Role;


public interface RoleService {
    List<Role> findAll();

    Role findByAuthority(String authority);

    Role findById(Long id);

    void deleteById(Long id);

    Role save(Role role);

    List<Role> create(List<Role> roles);

    public Role update(Role role);

    int delete(Role role);

    int deleteByAuthority(String authority);

    List<Role> findByUserName(String username);
}
