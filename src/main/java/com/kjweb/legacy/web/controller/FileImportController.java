package com.kjweb.legacy.web.controller;
import com.kjweb.legacy.web.service.FileImportService; import org.springframework.stereotype.Controller; import org.springframework.ui.Model; import org.springframework.web.bind.annotation.*;
@Controller @RequestMapping("/file-import")
public class FileImportController {
    private final FileImportService service;
    public FileImportController(FileImportService service){this.service=service;}
    @GetMapping public String page(Model model){model.addAttribute("manifests",service.findManifests());return "fileimport/index";}
    @PostMapping("/register") public String register(@RequestParam String fileName,@RequestParam String expectedRows){service.register(fileName,expectedRows);return "redirect:/file-import";}
    @PostMapping("/{id}/process") public String process(@PathVariable String id) throws Exception {service.process(id);return "redirect:/file-import";}
}