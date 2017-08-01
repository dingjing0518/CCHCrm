package com.by.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.web.PageableDefault;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.by.json.ScoreHistoryJson;
import com.by.model.Member;
import com.by.service.ScoreHistoryService;

/**
 * Created by yagamai on 15-12-9.
 */
@Controller
@RequestMapping("/scoreHistory")
public class AdminScoreHistoryController {
    @Autowired
    private ScoreHistoryService service;

    @RequestMapping(value = "/member/{id}", method = RequestMethod.GET)
    @ResponseBody
    public Page<ScoreHistoryJson> list(@PathVariable("id") Long id,
                                       @PageableDefault(page = 0, size = 10, sort = "createdTime", direction = Sort.Direction.DESC)
                                       Pageable pageable) {
        return service.findByMemberJson(new Member(id), pageable);
    }
}
