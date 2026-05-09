package com.kjweb.legacy.web.controller;

import com.kjweb.legacy.web.service.BoardLegacyService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class HomeController {
    private static final Logger log = LoggerFactory.getLogger(HomeController.class);
    private final BoardLegacyService boardLegacyService;

    public HomeController(BoardLegacyService boardLegacyService) {
        this.boardLegacyService = boardLegacyService;
    }

    @GetMapping("/")
    public String home(Model model) {
        log.info("legacy home requested");
        model.addAttribute("boards", boardLegacyService.findRecentBoards());
        return "home/index";
    }

    @GetMapping("/login")
    public String login() {
        log.info("legacy login page requested");
        return "home/login";
    }
}