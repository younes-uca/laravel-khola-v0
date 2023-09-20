package ${config.domain}.${config.groupId}.${config.projectName}.zynerator.security.${config.service}.${config.serviceImpl};

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import  ${config.domain}.${config.groupId}.${config.projectName}.zynerator.security.${config.bean}.Permission;
import ${config.domain}.${config.groupId}.${config.projectName}.zynerator.security.${config.dao}.PermissionDao;
import ${config.domain}.${config.groupId}.${config.projectName}.zynerator.security.${config.service}.${config.serviceFacade}.PermissionService;

@Service
public class PermissionServiceImpl implements PermissionService {
    @Autowired
    private PermissionDao permissionDao;

    @Override
    public Permission save(Permission permission) {
        Permission perm = permissionDao.findByName(permission.getName());
        return perm == null ? permissionDao.save(permission) : perm;
    }
}
