package com.kjweb.legacy.batch;

import com.kjweb.legacy.domain.mapper.LegacyOpsMapper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import java.util.Calendar;

@Component
public class LegacyErrorPatternBatch {
    private static final Logger log = LoggerFactory.getLogger(LegacyErrorPatternBatch.class);

    private final LegacyOpsMapper mapper;

    public LegacyErrorPatternBatch(LegacyOpsMapper mapper) {
        this.mapper = mapper;
    }

    @Transactional
    public void runDailyPattern() {
        int day = Calendar.getInstance().get(Calendar.DAY_OF_MONTH);
        int pattern = day % 5;
        log.info("legacy daily error pattern started day={} pattern={}", day, pattern);

        if (pattern == 0) {
            duplicateVendorError(day);
        } else if (pattern == 1) {
            negativeInventoryError();
        } else if (pattern == 2) {
            brokenStatusError(day);
        } else if (pattern == 3) {
            numberFormatError(day);
        } else {
            nullPointerError();
        }
    }

    public void runDuplicateVendorNow() {
        duplicateVendorError(999);
    }

    public void runNegativeInventoryNow() {
        negativeInventoryError();
    }

    public void runBrokenStatusNow() {
        brokenStatusError(999);
    }

    public void runNumberFormatNow() {
        numberFormatError(999);
    }

    public void runNullPointerNow() {
        nullPointerError();
    }

    private void duplicateVendorError(int day) {
        log.info("legacy batch pattern duplicate vendor");
        mapper.insertVendor("BATCH-DUP", "Batch Duplicate " + day, 1000L);
        mapper.insertVendor("BATCH-DUP", "Batch Duplicate Again " + day, 1000L);
    }

    private void negativeInventoryError() {
        log.info("legacy batch pattern negative inventory");
        mapper.adjustInventory("SKU-BASE", -999999L);
    }

    private void brokenStatusError(int day) {
        log.info("legacy batch pattern broken status");
        mapper.insertJob("DAILY", "SKU-BASE", "");
        mapper.updateJobStatus(Long.valueOf(day), "BROKEN_STATUS");
    }

    private void numberFormatError(int day) {
        log.info("legacy batch pattern number format");
        Long.valueOf("daily-" + day);
    }

    private void nullPointerError() {
        log.info("legacy batch pattern null pointer");
        String value = null;
        value.trim();
    }
}