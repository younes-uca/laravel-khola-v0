package ${config.domain}.${config.groupId}.${config.projectName}.${config.bean}.history<#if pojo.subModule.folder??>.${pojo.subModule.folder}</#if>;

import com.fasterxml.jackson.annotation.JsonInclude;
import ${config.domain}.${config.groupId}.${config.projectName}.zynerator.history.HistBusinessObject;
import jakarta.persistence.*;


@Entity
@Table(name = "${pojo.formatedDataBase}")
@JsonInclude(JsonInclude.Include.NON_NULL)
<#if true || !pojo.idString>
@SequenceGenerator(name="${pojo.formatedDataBase}_seq",sequenceName="${pojo.formatedDataBase}_seq",allocationSize=1, initialValue = 1)
</#if>
public class ${pojo.name}History extends HistBusinessObject  {


    public ${pojo.name}History() {
    super();
    }

    public ${pojo.name}History (Long id) {
    super(id);
    }

    @Id
    @Column(name = "id")
    @GeneratedValue(strategy = GenerationType.SEQUENCE,generator="${pojo.formatedDataBase}_seq")
    public Long getId() {
    return id;
    }
}

