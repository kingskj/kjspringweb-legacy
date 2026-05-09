package com.kjweb.legacy.web.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;

@ControllerAdvice
@Controller
public class LegacyErrorController {
    private static final Logger log = LoggerFactory.getLogger(LegacyErrorController.class);

    @ExceptionHandler(Exception.class)
    public String handle(Exception exception, Model model) {
        log.error("legacy error observed", exception);
        model.addAttribute("exceptionClass", exception.getClass().getName());
        model.addAttribute("exceptionMessage", exception.getMessage());
        return "error/legacy-error";
    }
}