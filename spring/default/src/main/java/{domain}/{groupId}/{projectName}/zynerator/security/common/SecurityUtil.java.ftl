package ${config.domain}.${config.groupId}.${config.projectName}.zynerator.security.${config.common};

import java.util.stream.Stream;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;

import ${config.domain}.${config.groupId}.${config.projectName}.${config.mainClass};
import ${config.domain}.${config.groupId}.${config.projectName}.zynerator.security.${config.bean}.User;
import ${config.domain}.${config.groupId}.${config.projectName}.zynerator.security.${config.service}.${config.restFacade}.${config.userService};


@Service
public class SecurityUtil {

    public static User getCurrentUser() {
        ${config.userService} userService= ${config.mainClass}.getCtx().getBean(${config.userService}.class);

        SecurityContext securityContext = SecurityContextHolder.getContext();
        Object user = securityContext.getAuthentication().getPrincipal();
        System.out.println(user);
        if (user instanceof String) {
            return userService.findByUsername((String) user);
        } else if (user instanceof User) {
            return (User) user;
        } else {
            return null;
        }
    }


    public static boolean isAuthenticated() {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        return authentication != null &&
        getAuthorities(authentication).noneMatch(AuthoritiesConstants.ANONYMOUS::equals);
    }


    public static boolean isCurrentUserInRole(String authority) {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        return authentication != null &&
        getAuthorities(authentication).anyMatch(authority::equals);
    }

    private static Stream<String> getAuthorities(Authentication authentication) {
        return authentication.getAuthorities().stream()
        .map(GrantedAuthority::getAuthority);
        }

}
