package ru.rosbank.javaschool.util;

import java.sql.ResultSet;
import java.sql.SQLException;

@FunctionalInterface
public interface Executable<T> {
    T execute(ResultSet resultSet) throws SQLException;
}
