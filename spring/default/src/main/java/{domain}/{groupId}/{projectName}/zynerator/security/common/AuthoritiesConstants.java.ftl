package ${config.domain}.${config.groupId}.${config.projectName}.zynerator.security.${config.common};
public final class AuthoritiesConstants {
<#list roles as role>
public static final String ${role.name?upper_case} = "ROLE_${role.name?upper_case}";
</#list>
public static final String ANONYMOUS = "ROLE_ANONYMOUS";

private AuthoritiesConstants(){}

}
