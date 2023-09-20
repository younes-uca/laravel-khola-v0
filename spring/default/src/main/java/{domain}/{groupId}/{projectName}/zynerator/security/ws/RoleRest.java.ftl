package ${config.domain}.${config.groupId}.${config.projectName}.zynerator.security.ws;

import java.util.List;

import org.springframework.web.bind.annotation.RestController;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.GetMapping;

import ${config.domain}.${config.groupId}.${config.projectName}.zynerator.security.${config.bean}.Role;
import ${config.domain}.${config.groupId}.${config.projectName}.zynerator.security.${config.service}.${config.serviceFacade}.RoleService;

@RequestMapping("/api/roles")
@RestController
// @PreAuthorize("hasRole(AuthoritiesConstants.super_admin)")
public class RoleRest {
    @Autowired
    private RoleService roleService;

    // @PreAuthorize("hasRole(AuthoritiesConstants.super_admin)")
    @GetMapping("/")
    public List<Role> findAll(){
        return this.roleService.findAll();
    }
}
