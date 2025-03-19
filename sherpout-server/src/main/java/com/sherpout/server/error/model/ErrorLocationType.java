package com.sherpout.server.error.model;

import lombok.Getter;
import lombok.RequiredArgsConstructor;

@Getter
@RequiredArgsConstructor
public enum ErrorLocationType {

    PATH_PARAM("Path Parameter"),
    QUERY_PARAM("Query Parameter"),
    HEADER_PARAM("Header Parameter"),
    BODY("Body"),
    FILE("File");

    private final String name;
}
