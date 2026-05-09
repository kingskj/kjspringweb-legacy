package com.kjweb.legacy.web.service;
import com.kjweb.legacy.domain.mapper.LegacyOpsMapper; import com.kjweb.legacy.domain.model.*; import org.springframework.stereotype.Service; import org.springframework.transaction.annotation.Transactional; import java.util.List;
@Service
public class LegacyOpsService {
    private final LegacyOpsMapper mapper;
    public LegacyOpsService(LegacyOpsMapper mapper){this.mapper=mapper;}
    public List<VendorLegacy> findVendors(){return mapper.findVendors();}
    public List<InventoryLegacy> findInventory(String keyword,String sortColumn){return mapper.findInventory(keyword,sortColumn);}
    public List<JobQueueLegacy> findJobs(){return mapper.findJobs();}
    public void createVendor(String code,String name,String creditLimit){mapper.insertVendor(code,name,Long.valueOf(creditLimit));}
    public void createInventory(String sku,String name,String quantity){mapper.insertInventory(sku,name,Long.valueOf(quantity));}
    public void createJob(String jobType,String payload,String forceErrorCode){mapper.insertJob(jobType,payload,forceErrorCode);}
    @Transactional public void runJob(String id){Long jobId=Long.valueOf(id); JobQueueLegacy job=mapper.findJob(jobId); mapper.incrementAttempt(jobId); if(job==null){throw new IllegalStateException("job not found: "+id);} if("NPE".equals(job.getForceErrorCode())){String v=null; v.length();} if("SQL".equals(job.getForceErrorCode())){mapper.updateJobStatus(jobId,"BROKEN_STATUS"); return;} if("NEGATIVE_STOCK".equals(job.getForceErrorCode())){mapper.adjustInventory(job.getPayload(),-999999L); mapper.updateJobStatus(jobId,"DONE"); return;} mapper.updateJobStatus(jobId,"DONE");}
}