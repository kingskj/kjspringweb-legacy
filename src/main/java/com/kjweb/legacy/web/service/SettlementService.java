package com.kjweb.legacy.web.service;
import com.kjweb.legacy.domain.mapper.LegacyOpsMapper; import com.kjweb.legacy.domain.model.*; import org.springframework.stereotype.Service; import org.springframework.transaction.annotation.Transactional; import java.util.List;
@Service
public class SettlementService {
    private final LegacyOpsMapper mapper;
    public SettlementService(LegacyOpsMapper mapper){this.mapper=mapper;}
    public List<SettlementLegacy> findSettlements(){return mapper.findSettlements();}
    public WorkItem newWorkItem(String vendorCode,String amount,String businessDate){return new WorkItem(vendorCode,amount,businessDate);}
    public void insertDirect(String vendorCode,String amount,String businessDate){mapper.insertSettlement(vendorCode,Long.valueOf(amount),businessDate,"REQUESTED");}
    @Transactional public void commitSessionItems(List<WorkItem> items){if(items==null){throw new IllegalStateException("session work items missing");} for(WorkItem item:items){mapper.insertSettlement(item.getVendorCode(),Long.valueOf(item.getAmount()),item.getBusinessDate(),"REQUESTED");}}
}