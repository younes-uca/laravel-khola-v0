package ${config.domain}.${config.groupId}.${config.projectName}.zynerator.dto;

    public class ScheduleDto {
    public Long id ;
    public String subject  ;
    public String startTime ;
    public String endTime ;

    public ScheduleDto(Long id, String subject, String startTime, String endTime) {
        this.id = id;
        this.subject = subject;
        this.startTime = startTime;
        this.endTime = endTime;
    }

    public Long getId() {
    return id;
    }

    public void setId(Long id) {
    this.id = id;
    }

    public String getSubject() {
    return subject;
    }

    public void setSubject(String subject) {
    this.subject = subject;
    }

    public String getStartTime() {
    return startTime;
    }

    public void setStartTime(String startTime) {
    this.startTime = startTime;
    }

    public String getEndTime() {
    return endTime;
    }

    public void setEndTime(String endTime) {
    this.endTime = endTime;
    }
}