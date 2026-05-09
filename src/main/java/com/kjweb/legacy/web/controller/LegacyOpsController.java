package com.kjweb.legacy.web.controller;
import com.kjweb.legacy.web.service.LegacyOpsService; import org.springframework.stereotype.Controller; import org.springframework.ui.Model; import org.springframework.web.bind.annotation.*;
@Controller @RequestMapping("/ops")
public class LegacyOpsController {
    private final LegacyOpsService service;
    public LegacyOpsController(LegacyOpsService service){this.service=service;}
    @GetMapping public String dashboard(@RequestParam(value="keyword",required=false) String keyword,@RequestParam(value="sortColumn",required=false) String sortColumn,Model model){model.addAttribute("vendors",service.findVendors());model.addAttribute("inventory",service.findInventory(keyword,sortColumn));model.addAttribute("jobs",service.findJobs());model.addAttribute("keyword",keyword);model.addAttribute("sortColumn",sortColumn);return "ops/dashboard";}
    @PostMapping("/vendors") public String createVendor(@RequestParam String code,@RequestParam String name,@RequestParam String creditLimit){service.createVendor(code,name,creditLimit);return "redirect:/ops";}
    @PostMapping("/inventory") public String createInventory(@RequestParam String sku,@RequestParam String name,@RequestParam String quantity){service.createInventory(sku,name,quantity);return "redirect:/ops";}
    @PostMapping("/jobs") public String createJob(@RequestParam String jobType,@RequestParam String payload,@RequestParam String forceErrorCode){service.createJob(jobType,payload,forceErrorCode);return "redirect:/ops";}
    @PostMapping("/jobs/{id}/run") public String runJob(@PathVariable String id){service.runJob(id);return "redirect:/ops";}
}