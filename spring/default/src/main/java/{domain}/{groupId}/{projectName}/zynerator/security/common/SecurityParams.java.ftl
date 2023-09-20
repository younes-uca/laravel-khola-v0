package ${config.domain}.${config.groupId}.${config.projectName}.zynerator.security.${config.common};

public interface SecurityParams {
    public static final String JWT_HEADER_NAME="Authorization";
    public static final String SECRET="${config.getSecret()}";
    public static final long EXPIRATION=86400000;
    public static final String HEADER_PREFIX="Bearer ";
}
