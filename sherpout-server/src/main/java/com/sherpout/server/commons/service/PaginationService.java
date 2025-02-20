package com.sherpout.server.commons.service;

import com.sherpout.server.commons.dto.pagination.PageResponseDTO;
import com.sherpout.server.commons.dto.pagination.PaginationDTO;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Service;

import java.util.stream.Stream;

@Service
public class PaginationService {
    public PageRequest getPageRequest(PaginationDTO pagination) {
        int page = pagination.getPage() == null ? 0 : pagination.getPage();
        int size = pagination.getSize() == null ? 10 : pagination.getSize();
        return PageRequest.of(page, size);
    }

    public <T> PageResponseDTO<T> mapToPage(Stream<T> stream, Page<?> page) {
        Page<T> mappedPage = new PageImpl<>(stream.toList(), page.getPageable(), page.getTotalElements());
        return new PageResponseDTO<>(mappedPage);
    }
}
