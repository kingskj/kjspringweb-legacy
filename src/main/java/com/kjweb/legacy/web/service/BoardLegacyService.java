package com.kjweb.legacy.web.service;

import com.kjweb.legacy.domain.mapper.BoardLegacyMapper;
import com.kjweb.legacy.domain.model.BoardLegacy;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class BoardLegacyService {
    private final BoardLegacyMapper boardLegacyMapper;

    public BoardLegacyService(BoardLegacyMapper boardLegacyMapper) {
        this.boardLegacyMapper = boardLegacyMapper;
    }

    public List<BoardLegacy> findRecentBoards() {
        return boardLegacyMapper.findRecentBoards();
    }

    public BoardLegacy findBoard(Long id) {
        return boardLegacyMapper.findById(id);
    }
}
