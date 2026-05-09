package com.kjweb.legacy.domain.model;
public class InventoryLegacy {
    private Long id; private String sku; private String name; private Long quantity;
    public Long getId(){return id;} public void setId(Long id){this.id=id;}
    public String getSku(){return sku;} public void setSku(String sku){this.sku=sku;}
    public String getName(){return name;} public void setName(String name){this.name=name;}
    public Long getQuantity(){return quantity;} public void setQuantity(Long quantity){this.quantity=quantity;}
}