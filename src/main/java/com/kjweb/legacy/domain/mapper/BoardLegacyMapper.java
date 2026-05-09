package com.kjweb.legacy.domain.mapper;

import com.kjweb.legacy.domain.model.BoardLegacy;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface BoardLegacyMapper {
    List<BoardLegacy> findRecentBoards();

    BoardLegacy findById(@Param("id") Long id);
}
