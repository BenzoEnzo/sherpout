package com.sherpout.server.commons.enumerated;

import jakarta.persistence.AttributeConverter;
import jakarta.persistence.Converter;

@Converter
public class BaseEnumConverter<E extends Enum<E> & BaseEnum> implements AttributeConverter<E, Integer> {
    private final Class<E> enumClass;

    public BaseEnumConverter(Class<E> enumClass) {
        this.enumClass = enumClass;
    }

    @Override
    public Integer convertToDatabaseColumn(E enumValue) {
        return enumValue == null ? null : enumValue.getId();
    }

    @Override
    public E convertToEntityAttribute(Integer dbData) {
        if (dbData == null) {
            return null;
        }
        for (E enumConstant : enumClass.getEnumConstants()) {
            if (dbData.equals(enumConstant.getId())) {
                return enumConstant;
            }
        }
        throw new IllegalArgumentException("Unknown enum id: " + dbData);
    }
}
