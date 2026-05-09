package com.kjweb.legacy.domain.mapper;
import com.kjweb.legacy.domain.model.*; import org.apache.ibatis.annotations.Param; import java.util.List;
public interface LegacyOpsMapper {
    List<VendorLegacy> findVendors(); void insertVendor(@Param("code") String code,@Param("name") String name,@Param("creditLimit") Long creditLimit);
    List<InventoryLegacy> findInventory(@Param("keyword") String keyword,@Param("sortColumn") String sortColumn); void insertInventory(@Param("sku") String sku,@Param("name") String name,@Param("quantity") Long quantity); void adjustInventory(@Param("sku") String sku,@Param("delta") Long delta);
    List<JobQueueLegacy> findJobs(); JobQueueLegacy findJob(@Param("id") Long id); void insertJob(@Param("jobType") String jobType,@Param("payload") String payload,@Param("forceErrorCode") String forceErrorCode); void updateJobStatus(@Param("id") Long id,@Param("status") String status); void incrementAttempt(@Param("id") Long id);
    List<SettlementLegacy> findSettlements(); void insertSettlement(@Param("vendorCode") String vendorCode,@Param("amount") Long amount,@Param("businessDate") String businessDate,@Param("status") String status);
    List<FileManifestLegacy> findManifests(); FileManifestLegacy findManifest(@Param("id") Long id); void insertManifest(@Param("fileName") String fileName,@Param("expectedRows") Integer expectedRows); void updateManifestStatus(@Param("id") Long id,@Param("status") String status);
}