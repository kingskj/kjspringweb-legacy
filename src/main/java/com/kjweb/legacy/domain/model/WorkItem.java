package com.kjweb.legacy.domain.model;
public class WorkItem {
    private String vendorCode; private String amount; private String businessDate;
    public WorkItem(String vendorCode,String amount,String businessDate){this.vendorCode=vendorCode;this.amount=amount;this.businessDate=businessDate;}
    public String getVendorCode(){return vendorCode;} public String getAmount(){return amount;} public String getBusinessDate(){return businessDate;}
}