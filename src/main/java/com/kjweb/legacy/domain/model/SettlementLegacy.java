package com.kjweb.legacy.domain.model;
public class SettlementLegacy {
    private Long id; private String vendorCode; private Long amount; private String businessDate; private String status;
    public Long getId(){return id;} public void setId(Long id){this.id=id;}
    public String getVendorCode(){return vendorCode;} public void setVendorCode(String vendorCode){this.vendorCode=vendorCode;}
    public Long getAmount(){return amount;} public void setAmount(Long amount){this.amount=amount;}
    public String getBusinessDate(){return businessDate;} public void setBusinessDate(String businessDate){this.businessDate=businessDate;}
    public String getStatus(){return status;} public void setStatus(String status){this.status=status;}
}