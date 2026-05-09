package com.kjweb.legacy.web.controller;

import java.util.concurrent.Callable;
import java.util.concurrent.Executors;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.TimeUnit;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.request.async.DeferredResult;

@Controller
public class AsyncLabController {

    private static final ScheduledExecutorService DEFERRED_EXECUTOR =
            Executors.newSingleThreadScheduledExecutor();

    @GetMapping("/async-lab/callable")
    @ResponseBody
    public Callable<String> callable() {
        return new Callable<String>() {
            @Override
            public String call() throws Exception {
                Thread.sleep(300L);
                return "legacy callable async ok";
            }
        };
    }

    @GetMapping("/async-lab/callable-error")
    @ResponseBody
    public Callable<String> callableError() {
        return new Callable<String>() {
            @Override
            public String call() {
                throw new IllegalStateException("legacy callable async failure");
            }
        };
    }

    @GetMapping("/async-lab/deferred")
    @ResponseBody
    public DeferredResult<String> deferred() {
        final DeferredResult<String> result = new DeferredResult<String>(3000L, "legacy deferred timeout");
        DEFERRED_EXECUTOR.schedule(new Runnable() {
            @Override
            public void run() {
                result.setResult("legacy deferred async ok");
            }
        }, 300L, TimeUnit.MILLISECONDS);
        return result;
    }

    @GetMapping("/async-lab/deferred-error")
    @ResponseBody
    public DeferredResult<String> deferredError() {
        final DeferredResult<String> result = new DeferredResult<String>(3000L);
        DEFERRED_EXECUTOR.schedule(new Runnable() {
            @Override
            public void run() {
                result.setErrorResult(new IllegalArgumentException("legacy deferred async failure"));
            }
        }, 300L, TimeUnit.MILLISECONDS);
        return result;
    }
}
