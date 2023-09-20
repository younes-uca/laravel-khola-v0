package ${config.domain}.${config.groupId}.${config.projectName}.zynerator.dto;

import ${config.domain}.${config.groupId}.${config.projectName}.zynerator.audit.Log;
import ${config.domain}.${config.groupId}.${config.projectName}.zynerator.dto.AuditBaseDto;
import com.fasterxml.jackson.annotation.JsonInclude;



@JsonInclude(JsonInclude.Include.NON_NULL)
public class EtablissementDto  extends AuditBaseDto {

    private String libelle  ;
    private String code  ;

    public EtablissementDto(){
        super();
    }

    @Log
    public String getLibelle(){
        return this.libelle;
    }
    public void setLibelle(String libelle){
        this.libelle = libelle;
    }

    @Log
    public String getCode(){
        return this.code;
    }
    public void setCode(String code){
        this.code = code;
    }

}
