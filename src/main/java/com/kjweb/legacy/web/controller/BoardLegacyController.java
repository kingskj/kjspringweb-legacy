package com.kjweb.legacy.web.controller;

import com.kjweb.legacy.web.service.BoardLegacyService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/legacy/boards")
public class BoardLegacyController {
    private final BoardLegacyService boardLegacyService;

    public BoardLegacyController(BoardLegacyService boardLegacyService) {
        this.boardLegacyService = boardLegacyService;
    }

    @GetMapping
    public String list(Model model) {
        model.addAttribute("boards", boardLegacyService.findRecentBoards());
        return "home/index";
    }

    @GetMapping("/{id}")
    public String detail(@PathVariable Long id, Model model) {
        model.addAttribute("board", boardLegacyService.findBoard(id));
        return "home/detail";
    }
}
