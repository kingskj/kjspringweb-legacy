package com.kjweb.legacy.web.controller;

import com.kjweb.legacy.batch.LegacyErrorPatternBatch;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequestMapping("/batch-lab")
public class BatchLabController {
    private final LegacyErrorPatternBatch batch;

    public BatchLabController(LegacyErrorPatternBatch batch) {
        this.batch = batch;
    }

    @PostMapping("/run")
    public String run(@RequestParam String pattern) {
        if ("duplicate".equals(pattern)) {
            batch.runDuplicateVendorNow();
        } else if ("inventory".equals(pattern)) {
            batch.runNegativeInventoryNow();
        } else if ("status".equals(pattern)) {
            batch.runBrokenStatusNow();
        } else if ("number".equals(pattern)) {
            batch.runNumberFormatNow();
        } else if ("npe".equals(pattern)) {
            batch.runNullPointerNow();
        } else {
            batch.runDailyPattern();
        }
        return "redirect:/ops";
    }
}