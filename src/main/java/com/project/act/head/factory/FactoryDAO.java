package com.project.act.head.factory;

import java.sql.SQLException;
import java.util.List;

import com.project.act.models_dto.FactoryDTO;
import com.project.act.models_dto.PageDTO;

public interface FactoryDAO {

	List<FactoryDTO> getFactoryList(PageDTO pageDTO)throws SQLException;

	void addFactory(FactoryDTO factoryDTO)throws SQLException;

	void deleteFactory(FactoryDTO factoryDTO)throws SQLException;

	void editFactory(FactoryDTO factoryDTO)throws SQLException;

	long get_total_count() throws SQLException;

}
