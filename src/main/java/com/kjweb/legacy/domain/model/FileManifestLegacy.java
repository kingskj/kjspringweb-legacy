package com.kjweb.legacy.domain.model;
public class FileManifestLegacy {
    private Long id; private String fileName; private Integer expectedRows; private String status;
    public Long getId(){return id;} public void setId(Long id){this.id=id;}
    public String getFileName(){return fileName;} public void setFileName(String fileName){this.fileName=fileName;}
    public Integer getExpectedRows(){return expectedRows;} public void setExpectedRows(Integer expectedRows){this.expectedRows=expectedRows;}
    public String getStatus(){return status;} public void setStatus(String status){this.status=status;}
}